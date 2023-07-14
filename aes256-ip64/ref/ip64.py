from aes import aes256
from utils import *

def xor64(x, y):
    return [ x[i] ^ y[i] for i in range(8) ]
def xor128(x, y):
    return [ x[i] ^ y[i] for i in range(16) ]

debug = False

def gf2_mul128(x, y):
    """
    >>> x = int2bytes(0x1E45CF4B59CF6263C7968BA04207AFAE, 128)
    >>> y = int2bytes(0x9648D6CECA549BBF561EC6DFADE4053D, 128)
    >>> z = gf_2_128_mul(x, y)
    >>> bytes2hex(z)
    '33B34D98BF84B86F292AE2E19E08A49A'
    >>> x = int2bytes(0x0BA70EF25E1980D637BB105261E14D25, 128)
    >>> y = int2bytes(0x7E896CD9EADCB83588BFA3BD3DC5F25A, 128)
    >>> z = gf_2_128_mul(x, y)
    >>> bytes2hex(z)
    '39CD230EF0E5A039465E0A254BD9BFE7'
    """
    x = bytes2int(x)
    y = bytes2int(y)
    
    res = 0
    for i in range(127, -1, -1):
        res ^= x * ((y >> i) & 1)  # branchless
        x = (x >> 1) ^ ((x & 1) * 0xE1000000000000000000000000000000)
    return int2bytes(res, 128)

def gf2_mul64(x, y):
    x = bytes2int(x)
    y = bytes2int(y)
        
    res = 0
    for i in range(63, -1, -1):
        res ^= x * ((y >> i) & 1)  # branchless
        x = (x >> 1) ^ ((x & 1) * 0xD800000000000000)
    return int2bytes(res, 64)

def ip64_128(msg, key, hk0, hk1, nonce):
    m  = [ msg[16*i:16*(i+1)] for i in range(1) ]
    h0 = [ hk0[8*i:8*(i+1)] for i in range(2) ]
    h1 = [ hk1[8*i:8*(i+1)] for i in range(2) ]

    c = xor128(aes256(nonce + int2bytes(0x1, 32), key), m[0])

    l0, r0 = c[0:8], c[8:16]
    
    s0 = gf2_mul64(l0, h0[0])
    s1 = gf2_mul64(r0, h0[1])
    s = xor64(s0, s1) 
    
    t0 = gf2_mul64(l0, h1[0])
    t1 = gf2_mul64(r0, h1[1])
    t = xor64(t0, t1) 
    
    tag = xor128(aes256(nonce + int2bytes(0x0, 32), key), s + t)

    return c, tag

def ip64_256(msg, key, hk0, hk1, nonce):
    m  = [ msg[16*i:16*(i+1)] for i in range(2) ]
    h0 = [ hk0[8*i:8*(i+1)] for i in range(4) ]
    h1 = [ hk1[8*i:8*(i+1)] for i in range(4) ]

    c0 = xor128(aes256(nonce + int2bytes(0x1, 32), key), m[0])
    c1 = xor128(aes256(nonce + int2bytes(0x2, 32), key), m[1])

    l0, r0 = c0[0:8], c0[8:16]
    l1, r1 = c1[0:8], c1[8:16]
    
    s0 = gf2_mul64(l0, h0[0])
    s1 = gf2_mul64(r0, h0[1])
    s2 = gf2_mul64(l1, h0[2])
    s3 = gf2_mul64(r1, h0[3])
    s = xor64(s0, xor64(s1, xor64(s2, s3)))
    
    t0 = gf2_mul64(l0, h1[0])
    t1 = gf2_mul64(r0, h1[1])
    t2 = gf2_mul64(l1, h1[2])
    t3 = gf2_mul64(r1, h1[3])
    t = xor64(t0, xor64(t1, xor64(t2, t3)))
    
    tag = xor128(aes256(nonce + int2bytes(0x0, 32), key), s + t)

    return c0 + c1, tag

def ip64_512(msg, key, hk0, hk1, nonce):
    m  = [ msg[16*i:16*(i+1)] for i in range(4) ]
    h0 = [ hk0[8*i:8*(i+1)] for i in range(8) ]
    h1 = [ hk1[8*i:8*(i+1)] for i in range(8) ]
    
    c0 = xor128(aes256(nonce + int2bytes(0x1, 32), key), m[0])
    c1 = xor128(aes256(nonce + int2bytes(0x2, 32), key), m[1])
    c2 = xor128(aes256(nonce + int2bytes(0x3, 32), key), m[2])
    c3 = xor128(aes256(nonce + int2bytes(0x4, 32), key), m[3])

    l0, r0 = c0[0:8], c0[8:16]
    l1, r1 = c1[0:8], c1[8:16]
    l2, r2 = c2[0:8], c2[8:16]
    l3, r3 = c3[0:8], c3[8:16]
    
    s0 = gf2_mul64(l0, h0[0])
    s1 = gf2_mul64(r0, h0[1])
    s2 = gf2_mul64(l1, h0[2])
    s3 = gf2_mul64(r1, h0[3])
    s4 = gf2_mul64(l2, h0[4])
    s5 = gf2_mul64(r2, h0[5])
    s6 = gf2_mul64(l3, h0[6])
    s7 = gf2_mul64(r3, h0[7])
    s = xor64(s0, xor64(s1, xor64(s2, xor64(s3, xor64(s4, xor64(s5, xor64(s6, s7)))))))
    
    t0 = gf2_mul64(l0, h1[0])
    t1 = gf2_mul64(r0, h1[1])
    t2 = gf2_mul64(l1, h1[2])
    t3 = gf2_mul64(r1, h1[3])
    t4 = gf2_mul64(l2, h1[4])
    t5 = gf2_mul64(r2, h1[5])
    t6 = gf2_mul64(l3, h1[6])
    t7 = gf2_mul64(r3, h1[7])
    t = xor64(t0, xor64(t1, xor64(t2, xor64(t3, xor64(t4, xor64(t5, xor64(t6, t7)))))))

    tag = xor128(aes256(nonce + int2bytes(0x0, 32), key), s + t)

    return c0 + c1 + c2 + c3, tag

debug = False

import random
random.seed(0)

for i in range(100):
    nonce = int2bytes(random.randint(0, 2**96-1), 96)
    key   = int2bytes(random.randint(0, 2**256-1), 256)
    hk0   = int2bytes(random.randint(0, 2**128-1), 512)
    hk1   = int2bytes(random.randint(0, 2**128-1), 512)
    msg   = int2bytes(random.randint(0, 2**128-1), 512)
    
    ct, tag = ip64_512(msg, key, hk0, hk1, nonce)

    print(i)
    print(bytes2hex(nonce))
    print(bytes2hex(key))
    print(bytes2hex(hk0))
    print(bytes2hex(hk1))
    print(bytes2hex(ct))
    print(bytes2hex(msg))
    print(bytes2hex(tag))
