# tensormd_demo.py
import torch
import torch.nn as nn

torch.set_default_dtype(torch.float64)  # 更高精度有助数值稳定性

# ---------- parameters ----------
N = 32
device = torch.device('cpu')  # 改为 'cuda' 若 GPU 可用

cmax = 8       # max neighbors to store
k_radial = 4   # number of radial kernels
cutoff = 3.0

# ---------- helper funcs ----------
def gaussian_radial(r, mu, sigma):
    return torch.exp(-0.5 * ((r - mu) / sigma) ** 2)

def cutoff_fn(r, rc=cutoff):
    # smooth cosine cutoff
    x = r / rc
    out = torch.zeros_like(r)
    mask = (r < rc)
    out[mask] = 0.5 * (torch.cos(torch.pi * x[mask]) + 1.0)
    return out

# random positions for N atoms in a box
torch.manual_seed(0)
pos = (torch.rand(N, 3, device=device) - 0.5) * 10.0  # spread out

# ---------- neighbor list (brute force, for demo) ----------
# compute pairwise vectors and distances
rij_vec = pos.unsqueeze(1) - pos.unsqueeze(0)   # (N, N, 3)
dist = torch.norm(rij_vec + 1e-12, dim=-1)      # (N, N)
# mask out self
dist.fill_diagonal_(9e9)
# find up to cmax neighbors within cutoff
neighbors_idx = torch.argsort(dist, dim=1)[:, :cmax]  # (N, cmax)
neighbors_dist = dist.gather(1, neighbors_idx)       # (N, cmax)
# build R_abc (we have only one pair-type b=1 so omit b dim)
R_abc = neighbors_dist  # shape (N, c)
# build D_abcx: vector components for each neighbor slot
idx_expand = neighbors_idx.unsqueeze(-1).expand(-1, -1, 3)  # (N, c, 3)
D_abcx = rij_vec.gather(1, idx_expand)   # (N, c, 3)  note: vector = r_a - r_j

# zero-pad neighbors farther than cutoff
mask_valid = (R_abc < cutoff).unsqueeze(-1)  # (N,c,1)
D_abcx = D_abcx * mask_valid
R_abc = R_abc * mask_valid.squeeze(-1)

# ---------- compute Habck: radial kernels applied on distances ----------
# choose radial kernel centers
mu = torch.linspace(0.5, cutoff - 0.3, k_radial, device=device)   # centers
sigma = 0.3
# compute h_k(r) = gaussian * cutoff
# R_abc: (N, c)
h = []
for k in range(k_radial):
    gk = gaussian_radial(R_abc, mu[k], sigma) * cutoff_fn(R_abc, rc=cutoff)
    h.append(gk)  # each (N,c)
Habck = torch.stack(h, dim=-1)  # (N, c, k)

# ---------- construct simple angular moments (s and p) ----------
# s-channel: G_s(a,k) = ( sum_c h(a,c,k) )^2  (per paper eqn for s-like)
G_s = torch.sum(Habck, dim=1) ** 2    # (N, k)

# p-channel approximation: for each Cartesian direction sum (r^w / r) * h, then square-sum
# D_abcx: (N,c,3), R_abc: (N,c)
r_norm = R_abc + 1e-12
unit = D_abcx / r_norm.unsqueeze(-1)  # (N,c,3)
# compute per direction sums for each radial kernel
G_p_components = []
for k in range(k_radial):
    sums_dir = torch.sum(unit * Habck[..., k].unsqueeze(-1), dim=1)  # (N,3)
    G_p_components.append(sums_dir**2)  # square per component
# sum over directions
G_p = torch.stack(G_p_components, dim=-1).sum(dim=2)  # (N, k)  sum over 3 dirs

# ---------- combine channels into per-atom feature vector Gabkm (here m=0(s),1(p)) ----------
# stack channels: result (N, k, m_channels)
G_stack = torch.stack([G_s, G_p], dim=-1)  # (N, k, 2)
# flatten per-atom feature to feed to NN
G_atom = G_stack.view(N, -1)  # (N, k*2)

# ---------- small neural network map to atomic energy ----------
class SmallNN(nn.Module):
    def __init__(self, in_dim):
        super().__init__()
        self.net = nn.Sequential(
            nn.Linear(in_dim, 64),
            nn.Tanh(),
            nn.Linear(64, 32),
            nn.Tanh(),
            nn.Linear(32, 1)
        )
    def forward(self, x):
        return self.net(x).squeeze(-1)

model = SmallNN(G_atom.shape[1])
# random init, for demo
model.double()

# Make positions require gradients to get forces
pos.requires_grad_(True)

# re-create neighbor geometry dependent tensors so they track autograd (a simple approach: recompute D and R from pos)
def forward_energy(positions):
    rij_vec = positions.unsqueeze(1) - positions.unsqueeze(0)   # (N,N,3)
    dist = torch.norm(rij_vec + 1e-12, dim=-1)
    dist.fill_diagonal_(9e9)
    neighbors_idx = torch.argsort(dist, dim=1)[:, :cmax]
    neighbors_dist = dist.gather(1, neighbors_idx)
    idx_expand = neighbors_idx.unsqueeze(-1).expand(-1, -1, 3)
    D_abcx = rij_vec.gather(1, idx_expand)
    mask_valid = (neighbors_dist < cutoff).unsqueeze(-1)
    D_abcx = D_abcx * mask_valid
    R_abc = neighbors_dist * mask_valid.squeeze(-1)

    # radial
    Habck = []
    for k in range(k_radial):
        gk = gaussian_radial(R_abc, mu[k], sigma) * cutoff_fn(R_abc, rc=cutoff)
        Habck.append(gk)
    Habck = torch.stack(Habck, dim=-1)  # (N,c,k)

    # s
    G_s = torch.sum(Habck, dim=1) ** 2  # (N,k)
    # p
    r_norm = R_abc + 1e-12
    unit = D_abcx / r_norm.unsqueeze(-1)
    G_p_components = []
    for k in range(k_radial):
        sums_dir = torch.sum(unit * Habck[..., k].unsqueeze(-1), dim=1)  # (N,3)
        G_p_components.append(sums_dir**2)
    G_p = torch.stack(G_p_components, dim=-1).sum(dim=2)  # (N,k)

    G_stack = torch.stack([G_s, G_p], dim=-1)
    G_atom = G_stack.view(N, -1)  # (N, k*2)

    Ea = model(G_atom)  # (N,)
    E_tot = Ea.sum()
    return E_tot, Ea

# compute energy and forces via autograd
E_tot, Ea = forward_energy(pos)
forces = -torch.autograd.grad(E_tot, pos, create_graph=False)[0]  # (N,3)

print("Total energy:", E_tot.item())
print("Atomic energies (first 5):", Ea[:5].detach().numpy())
print("Forces shape:", forces.shape)
print("First atom force:", forces[0].detach().numpy())