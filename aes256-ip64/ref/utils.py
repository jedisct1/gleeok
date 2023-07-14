""" Common integer mangling helper functions """

def int2bytes(x, bits):
    """ Convert an integer of size 'bits' to an array of bytes.

    >>> int2bytes(0x01, 8)
    [1]
    >>> int2bytes(0xAABB, 16)
    [93, 187]
    """
    return [ (x >> (8*i)) & 0xff for i in range(bits//8) ][::-1]

def bytes2int(b):
    """ Convert an array of byte values to a single integer.

    >>> bytes2int([0x01])
    1
    >>> bytes2int([0xAA, 0xBB])
    43707
    """
    x = 0x00
    for i in b:
        x = (x << 8) | i
    return x

def bytes2hex(b):
    """ Convert an array of byte values to a hex string.

    >>> bytes2hex([0x01])
    '01'
    >>> bytes2hex([0xAA, 0xBB])
    'AABB'
    """
    s = ""
    for i in b:
        s = s + "%02X" % (i)
    return s

def int2hex(x):
    """ Convert an integer to a hex string.

    >>> int2hex(0x01)
    '01'
    >>> int2hex(0xAABB)
    'AABB'
    """
    return "%02X" % (x)

if __name__ == "__main__":
    import doctest
    doctest.testmod()
