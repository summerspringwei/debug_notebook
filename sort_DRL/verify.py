
from typing import List
def sort3(memory :List):
    A = memory[0]
    B = memory[1]
    C = memory[2]

    P = A # mov memory[0] P;
    Q = B # mov memory[1] Q;
    R = C # mov memory[2] R;

    S = R # mov S R;
    # Get greater between A and C
    R = max(A, C) # cmp P R; cmovg P R;
    # Get lesser between A and C
    S = min(A, C) # cmovl P S;
    P = min(A, C) # mov S P;

    # Get Lesser between Lesser A, C and B, so we get the minimum
    P = min(A, B, C) # cmp S, Q; cmovg Q, P
    # No matter A and C greater or lesser than B, Q will always be the intermedia one
    Q = max(min(A, C), B)
    

