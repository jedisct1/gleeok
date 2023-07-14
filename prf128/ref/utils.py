""" Common integer mangling helper functions """

def int2bits(x, bits):
    """ Convert an integer of size 'bits' to an array of 0, 1 integers.

    >>> int2bits(0x00, 8)
    [0, 0, 0, 0, 0, 0, 0, 0]
    >>> int2bits(0x01, 8)
    [0, 0, 0, 0, 0, 0, 0, 1]
    >>> int2bits(0x01, 3)
    [0, 0, 1]
    >>> int2bits(0x05, 3)
    [1, 0, 1]
    """
    return [ (x >> (i)) & 0x1 for i in range(bits) ][::-1]

def bits2int(x):
    """ Convert a 0, 1 integer array to an integer.

    >>> bits2int([0, 0, 0, 0])
    0
    >>> bits2int([1, 1, 1])
    7
    >>> bits2int([1, 1, 1, 0])
    14
    """
    return int(''.join(str(i) for i in x), 2) 

# def bytes2bits(x):
#     """ Convert an byte array into a bit array.

#     >>> bytes2bits([0x00, 0x01])
#     [0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0]
#     """

#     b = []
#     for i in range(len(x)):
#         b.extend(int2bits(x[i], 8))
#     return b

def bits2hex(b):
    """ Convert a bit array into a hex string. 

    >>> bits2hex([0, 0, 0, 0, 0, 0, 1, 0])
    '02'
    """
    return '%0*X' % (len(b)  // 4, int("".join(map(str, b)), 2))

# def bytes2int(b):
#     """ Convert an array of byte values to a single integer.

#     >>> bytes2int([0x01])
#     1
#     >>> bytes2int([0xAA, 0xBB])
#     43707
#     """
#     x = 0x00
#     for i in b:
#         x = (x << 8) | i
#     return x

# def bytes2hex(b):
#     """ Convert an array of byte values to a hex string.

#     >>> bytes2hex([0x01])
#     '01'
#     >>> bytes2hex([0xAA, 0xBB])
#     'AABB'
#     """
#     s = ""
#     for i in b:
#         s = s + "%02X" % (i)
#     return s

# def int2hex(x):
#     """ Convert an integer to a hex string.

#     >>> int2hex(0x01)
#     '01'
#     >>> int2hex(0xAABB)
#     'AABB'
#     """
#     return "%02X" % (x)

if __name__ == "__main__":
    import doctest
    doctest.testmod()
