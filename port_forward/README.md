## Port Forward

Use `socat` to forward port.

* Install socat
```shell
apt install -y socat
```

If we want to forward traffic to machine `A`(local) to `B` (to_remote):

* Forward Port
```shell
socat TCP-LISTEN:local_port,fork TCP:to_remote_ip:to_remote_port
```
For example:
```shell
socat TCP-LISTEN:80,fork TCP:202.54.1.5:80
```

### Debug
First, we need to make sure that the remote ip and port is accessible:
```shell
telnet to_remote_ip to_remote_port
```

If we can connect it, then test whether the traffic can be forward on machine `A`.
```shell
telnet localhost local_port
```
If everything is ok, then test from another machine `C`:
```shell
telnet ip_A local_port
```

If we can not connect:
Check
1. Whether the cloud service blocks?

2. Whether the firewall blocks:
```shell
ufw status
```
3. Whether the `iptable` rules block:
Open the port:
```shell
iptables -I INPUT -p tcp --dport 25 -j ACCEPT
```
4. Then test from machine `C`

5. We can also open a simple HTTP server to test connection:
```shell
python3 -m http.server 9000
```
