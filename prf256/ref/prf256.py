from utils import *
from rc import rc256

N = 256
K = 256
R = 16

# 3-bit S-box
s3 = [ 0, 5, 3, 2, 6, 1, 4, 7 ]

# 4-bit S-box
s4 = [ 1, 0, 2, 4, 3, 8, 6, 13, 9, 10, 11, 14, 15, 12, 7, 5 ]

# 5-bit S-box
s5 = [ 
    0, 5, 10, 11, 20, 17, 22, 23, 9, 12, 3, 2, 13, 8, 15, 14,
    18, 21, 24, 27, 6, 1, 4, 7, 26, 29, 16, 19, 30, 25, 28, 31
]

def sbox_lookup(x, sbox, b):
    return int2bits(sbox[bits2int(x)], b)

def keyschedule(k, s):
    tk = k[:]
    rk = []
    for i in range(R+1):
        t = tk[:]
        tk = [ t[(s * j) % N] for j in range(N) ]
        rk.append(tk)
    return rk

def branch0(x, k, rc, last):
    # substitution
    u = [0] * N
    for i in range(N//8):
        j = 8 * i
        u[j : j + 3]     = sbox_lookup(x[j : j + 3], s3, 3)
        u[j + 3 : j + 8] = sbox_lookup(x[j + 3 : j + 8], s5, 5)
    
    if last:
        v = [ u[i] ^ k[i] ^ rc[i] for i in range(N) ]
        return v

    # theta
    v = [0] * N
    for i in range(N):
        v[i] = u[(i + 5) % N] ^ u[(i + 93) % N] ^ u[(i + 172) % N] 

    # pi
    w = [ v[(85 * i) % N] for i in range(N) ]

    # key addition
    t = [ w[i] ^ k[i] ^ rc[i] for i in range(N) ]
    return t

def branch1(x, k, rc, last):
    # pre perm
    p = [ x[(41 * i) % N] for i in range(N) ]

    # substitution
    u = [0] * N
    for i in range(N//8):
        j = 8 * i
        u[j : j + 3]     = sbox_lookup(p[j : j + 3], s3, 3)
        u[j + 3 : j + 8] = sbox_lookup(p[j + 3: j + 8], s5, 5)

    if last:
        v = [ u[i] ^ k[i] ^ rc[i] for i in range(N) ]
        return v

    # theta
    v = [0] * N
    for i in range(N):
        v[i] = u[(i + 2) % N] ^ u[(i + 90) % N] ^ u[(i + 179) % N] 

    # pi
    w = [ v[(85 * i) % N] for i in range(N) ]

    # key addition
    t = [ w[i] ^ k[i] ^ rc[i] for i in range(N) ]
    return t

def branch2(x, k, rc, last):
    # substitution
    u = [0] * N
    for i in range(N//4):
        j = 4 * i
        u[j : j + 4] = sbox_lookup(x[j : j + 4], s4, 4)
    
    if last:
        v = [ u[i] ^ k[i] ^ rc[i] for i in range(N) ]
        return v

    # theta
    v = [0] * N
    for i in range(N):
        v[i] = u[(i + 0) % N] ^ u[(i + 4) % N] ^ u[(i + 8) % N] 

    # pi
    w = [ v[(39 * i) % N] for i in range(N) ]

    # key addition
    t = [ w[i] ^ k[i] ^ rc[i] for i in range(N) ]
    return t

def prf256(x, k):
    rk0 = keyschedule(k, 57)
    rk1 = keyschedule(k, 177)
    rk2 = keyschedule(k, 239)

    # key whitening
    b0 = [ x[i] ^ rk0[0][i] for i in range(N) ]
    b1 = [ x[i] ^ rk1[0][i] for i in range(N) ]
    b2 = [ x[i] ^ rk2[0][i] for i in range(N) ]

    for i in range(1, R+1):
        last = i == R
        b0 = branch0(b0, rk0[i], rc256[0][i], last)
        b1 = branch1(b1, rk1[i], rc256[1][i], last)
        b2 = branch2(b2, rk2[i], rc256[2][i], last)
        
    x = [ b0[i] ^ b1[i] ^ b2[i] for i in range(N) ]
    return x

import random
random.seed(0)

for i in range(1000):
    x = random.randint(0, (2**N) - 1)
    k = random.randint(0, (2**K) - 1)
    y = prf256(int2bits(x, N), int2bits(k, K))
    print(i)
    print(bits2hex(int2bits(x, N)))
    print(bits2hex(int2bits(k, K)))
    print(bits2hex(y))
