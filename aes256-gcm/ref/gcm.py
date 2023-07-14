import aes
from utils import *

def _xor(x, y):
    return [ x[i] ^ y[i] for i in range(16) ]
def _and(x, y):
    return [ x[i] & y[i] for i in range(16) ]

debug = False

def gf_2_128_mul(x, y):
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

def encrypt(ad, msg, key, iv, aes_enc):
    adlen = len(ad)
    msglen = len(msg)

    # hash key
    h = int2bytes(0x00, 128)
    aes_enc(h, key)

    # tag key
    count = 0x01
    t = iv + int2bytes(count, 32)
    aes_enc(t, key)
  
    x = int2bytes(0x00, 128)
    for i in range(adlen):
        x = _xor(x, ad[i])
        x = gf_2_128_mul(x, h)

    ct = []
    for i in range(msglen):
        count += 1
        z = iv + int2bytes(count, 32)
        aes_enc(z, key)
        c = _xor(z, msg[i])
        ct.append(c)

        x = _xor(x, c)
        x = gf_2_128_mul(x, h)

    l = int2bytes((adlen << (7 + 64)) | msglen << 7, 128)
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
            iv = int2bytes(random.randint(0, 2**96-1), 96)
            key = int2bytes(random.randint(0, 2**128-1), 256)
            ad = [ int2bytes(random.randint(0, 2**128-1), 128) for _ in range(ad_len) ]
            msg = [ int2bytes(random.randint(0, 2**128-1), 128) for _ in range(msg_len) ]

            ct, tt = encrypt(ad, msg, key, iv, aes.aes256)

            print(count, ad_len, msg_len)
            print(bytes2hex(iv))
            print(bytes2hex(key))
            for a in ad: print(bytes2hex(a))
            for c in ct: print(bytes2hex(c))
            for m in msg: print(bytes2hex(m))
            print(bytes2hex(tt))

            count += 1

