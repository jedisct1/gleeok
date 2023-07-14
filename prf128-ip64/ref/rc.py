from utils import *

rc128 = [
    [
        int2bits(0x243f6a8885a308d313198a2e03707344, 128),
        int2bits(0xa4093822299f31d0082efa98ec4e6c89, 128),
        int2bits(0x452821e638d01377be5466cf34e90c6c, 128),
        int2bits(0xc0ac29b7c97c50dd3f84d5b5b5470917, 128),
        int2bits(0x9216d5d98979fb1bd1310ba698dfb5ac, 128),
        int2bits(0x2ffd72dbd01adfb7b8e1afed6a267e96, 128),
        int2bits(0xba7c9045f12c7f9924a19947b3916cf7, 128),
        int2bits(0x0801f2e2858efc16636920d871574e69, 128),
        int2bits(0xa458fea3f4933d7e0d95748f728eb658, 128),
        int2bits(0x718bcd5882154aee7b54a41dc25a59b5, 128),
        int2bits(0x9c30d5392af26013c5d1b023286085f0, 128),
        int2bits(0xca417918b8db38ef8e79dcb0603a180e, 128),
        int2bits(0x6c9e0e8bb01e8a3ed71577c1bd314b27, 128)
    ],
    [
        int2bits(0x78af2fda55605c60e65525f3aa55ab94, 128),
        int2bits(0x5748986263e8144055ca396a2aab10b6, 128),
        int2bits(0xb4cc5c341141e8cea15486af7c72e993, 128),
        int2bits(0xb3ee1411636fbc2a2ba9c55d741831f6, 128),
        int2bits(0xce5c3e169b87931eafd6ba336c24cf5c, 128),
        int2bits(0x7a325381289586773b8f48986b4bb9af, 128),
        int2bits(0xc4bfe81b6628219361d809ccfb21a991, 128),
        int2bits(0x487cac605dec8032ef845d5de98575b1, 128),
        int2bits(0xdc262302eb651b8823893e81d396acc5, 128),
        int2bits(0x0f6d6ff383f442392e0b4482a4842004, 128),
        int2bits(0x69c8f04a9e1f9b5e21c66842f6e96c9a, 128),
        int2bits(0x670c9c61abd388f06a51a0d2d8542f68, 128),
        int2bits(0x960fa728ab5133a36eef0b6c137a3be4, 128)
    ],
    [
        int2bits(0xba3bf0507efb2a98a1f1651d39af0176, 128),
        int2bits(0x66ca593e82430e888cee8619456f9fb4, 128),
        int2bits(0x7d84a5c33b8b5ebee06f75d885c12073, 128),
        int2bits(0x401a449f56c16aa64ed3aa62363f7706, 128),
        int2bits(0x1bfedf72429b023d37d0d724d00a1248, 128),
        int2bits(0xdb0fead349f1c09b075372c980991b7b, 128),
        int2bits(0x25d479d8f6e8def7e3fe501ab6794c3b, 128),
        int2bits(0x976ce0bd04c006bac1a94fb6409f60c4, 128),
        int2bits(0x5e5c9ec2196a246368fb6faf3e6c53b5, 128),
        int2bits(0x1339b2eb3b52ec6f6dfc511f9b30952c, 128),
        int2bits(0xcc814544af5ebd09bee3d004de334afd, 128),
        int2bits(0x660f2807192e4bb3c0cba85745c8740f, 128),
        int2bits(0xd20b5f39b9d3fbdb5579c0bd1a60320a, 128)
    ]
]


# rounds = 13
# n = 128
# mp.dps = 10000
# p = mp.pi - 3

# for b in range(3):
#     print("branch", b)
#     rc = []
#     for r in range(rounds):
#         s = []
#         for i in range(n):
#             p *= 2
#             if p >= 1.0:
#                 s.append(1)
#                 p -= 1
#             else:
#                 s.append(0)
#         rc.append(s)
    
#     for r in rc:
#         print(hex(bits2int(r)))
