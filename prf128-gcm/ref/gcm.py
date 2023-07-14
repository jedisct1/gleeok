from utils import *
from prf128 import prf128

def _xor(x, y):
    return [ x[i] ^ y[i] for i in range(128) ]
def _and(x, y):
    return [ x[i] & y[i] for i in range(128) ]

def gf_2_128_mul(x, y):
    """
    >>> x = int2bits(0x1E45CF4B59CF6263C7968BA04207AFAE, 128)
    >>> y = int2bits(0x9648D6CECA549BBF561EC6DFADE4053D, 128)
    >>> z = gf_2_128_mul(x, y)
    >>> bits2hex(z)
    '33B34D98BF84B86F292AE2E19E08A49A'
    >>> x = int2bits(0x0BA70EF25E1980D637BB105261E14D25, 128)
    >>> y = int2bits(0x7E896CD9EADCB83588BFA3BD3DC5F25A, 128)
    >>> z = gf_2_128_mul(x, y)
    >>> bits2hex(z)
    '39CD230EF0E5A039465E0A254BD9BFE7'
    """
    x = bits2int(x)
    y = bits2int(y)
    
    res = 0
    for i in range(127, -1, -1):
        res ^= x * ((y >> i) & 1)  # branchless
        x = (x >> 1) ^ ((x & 1) * 0xE1000000000000000000000000000000)
    return int2bits(res, 128)

debug = True

def encrypt(ad, msg, key, iv):
    adlen = len(ad)
    msglen = len(msg)

    # hash key
    h = int2bits(0x00, 128)
    h = prf128(h, key)

    # tag key
    count = 0x01
    t = iv + int2bits(count, 32)
    t = prf128(t, key)
  
    x = int2bits(0x00, 128)
    for i in range(adlen):
        x = _xor(x, ad[i])
        x = gf_2_128_mul(x, h)

    ct = []
    for i in range(msglen):
        count += 1
        z = iv + int2bits(count, 32)
        z = prf128(z, key)
        c = _xor(z, msg[i])
        ct.append(c)

        #print("x0", bits2hex(x))
        x = _xor(x, c)
        x = gf_2_128_mul(x, h)
        #print("x1", bits2hex(x))

    l = int2bits((adlen << (7 + 64)) | msglen << 7, 128)
    x = _xor(x, l)
    x = gf_2_128_mul(x, h)
    x = _xor(x, t)

    return ct, x

debug = False

import random
random.seed(0)

count = 0
for ad_len in range(2, 6):
    for msg_len in range(2, 6):
        for _ in range(5):
            iv = int2bits(random.randint(0, 2**96-1), 96)
            key = int2bits(random.randint(0, 2**256-1), 256)
            ad = [ int2bits(random.randint(0, 2**128-1), 128) for _ in range(ad_len) ]
            msg = [ int2bits(random.randint(0, 2**128-1), 128) for _ in range(msg_len) ]

            ct, tt = encrypt(ad, msg, key, iv)

            print(count, ad_len, msg_len)
            print(bits2hex(iv))
            print(bits2hex(key))
            for a in ad: print(bits2hex(a))
            for c in ct: print(bits2hex(c))
            for m in msg: print(bits2hex(m))
            print(bits2hex(tt))

            count += 1

