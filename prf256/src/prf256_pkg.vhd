library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

package prf256_pkg is

    constant r : integer := 16;  -- number of rounds
    constant n : integer := 256; -- block size
    constant k : integer := 256; -- key size
    
    type rc_type is array (0 to 16) of std_logic_vector(0 to n-1);
    constant rc0 : rc_type := (
        x"243f6a8885a308d313198a2e03707344a4093822299f31d0082efa98ec4e6c89",
        x"452821e638d01377be5466cf34e90c6cc0ac29b7c97c50dd3f84d5b5b5470917",
        x"9216d5d98979fb1bd1310ba698dfb5ac2ffd72dbd01adfb7b8e1afed6a267e96",
        x"ba7c9045f12c7f9924a19947b3916cf70801f2e2858efc16636920d871574e69",
        x"a458fea3f4933d7e0d95748f728eb658718bcd5882154aee7b54a41dc25a59b5",
        x"9c30d5392af26013c5d1b023286085f0ca417918b8db38ef8e79dcb0603a180e",
        x"6c9e0e8bb01e8a3ed71577c1bd314b2778af2fda55605c60e65525f3aa55ab94",
        x"5748986263e8144055ca396a2aab10b6b4cc5c341141e8cea15486af7c72e993",
        x"b3ee1411636fbc2a2ba9c55d741831f6ce5c3e169b87931eafd6ba336c24cf5c",
        x"7a325381289586773b8f48986b4bb9afc4bfe81b6628219361d809ccfb21a991",
        x"487cac605dec8032ef845d5de98575b1dc262302eb651b8823893e81d396acc5",
        x"0f6d6ff383f442392e0b4482a484200469c8f04a9e1f9b5e21c66842f6e96c9a",
        x"670c9c61abd388f06a51a0d2d8542f68960fa728ab5133a36eef0b6c137a3be4",
        x"ba3bf0507efb2a98a1f1651d39af017666ca593e82430e888cee8619456f9fb4",
        x"7d84a5c33b8b5ebee06f75d885c12073401a449f56c16aa64ed3aa62363f7706",
        x"1bfedf72429b023d37d0d724d00a1248db0fead349f1c09b075372c980991b7b",
        x"25d479d8f6e8def7e3fe501ab6794c3b976ce0bd04c006bac1a94fb6409f60c4"
    );
    constant rc1 : rc_type := (
        x"5e5c9ec2196a246368fb6faf3e6c53b51339b2eb3b52ec6f6dfc511f9b30952c",
        x"cc814544af5ebd09bee3d004de334afd660f2807192e4bb3c0cba85745c8740f",
        x"d20b5f39b9d3fbdb5579c0bd1a60320ad6a100c6402c7279679f25fefb1fa3cc",
        x"8ea5e9f8db3222f83c7516dffd616b152f501ec8ad0552ab323db5fafd238760",
        x"53317b483e00df829e5c57bbca6f8ca01a87562edf1769dbd542a8f6287effc3",
        x"ac6732c68c4f5573695b27b0bbca58c8e1ffa35db8f011a010fa3d98fd2183b8",
        x"4afcb56c2dd1d35b9a53e479b6f84565d28e49bc4bfb9790e1ddf2daa4cb7e33",
        x"62fb1341cee4c6e8ef20cada36774c01d07e9efe2bf11fb495dbda4dae909198",
        x"eaad8e716b93d5a0d08ed1d0afc725e08e3c5b2f8e7594b78ff6e2fbf2122b64",
        x"8888b812900df01c4fad5ea0688fc31cd1cff191b3a8c1ad2f2f2218be0e1777",
        x"ea752dfe8b021fa1e5a0cc0fb56f74e818acf3d6ce89e299b4a84fe0fd13e0b7",
        x"7cc43b81d2ada8d9165fa2668095770593cc7314211a1477e6ad206577b5fa86",
        x"c75442f5fb9d35cfebcdaf0c7b3e89a0d6411bd3ae1e7e4900250e2d2071b35e",
        x"226800bb57b8e0af2464369bf009b91e5563911d59dfa6aa78c14389d95a537f",
        x"207d5ba202e5b9c5832603766295cfa911c819684e734a41b3472dca7b14a94a",
        x"1b5100529a532915d60f573fbc9bc6e42b60a47681e6740008ba6fb5571be91f",
        x"f296ec6b2a0dd915b6636521e7b9f9b6ff34052ec585566453b02d5da99f8fa1"
    );
    constant rc2 : rc_type := (
        x"08ba47996e85076a4b7a70e9b5b32944db75092ec4192623ad6ea6b049a7df7d",
        x"9cee60b88fedb266ecaa8c71699a17ff5664526cc2b19ee1193602a575094c29",
        x"a0591340e4183a3e3f54989a5b429d656b8fe4d699f73fd6a1d29c07efe830f5",
        x"4d2d38e6f0255dc14cdd20868470eb266382e9c6021ecc5e09686b3f3ebaefc9",
        x"3c9718146b6a70a1687f358452a0e286b79c5305aa5007373e07841c7fdeae5c",
        x"8e7d44ec5716f2b8b03ada37f0500c0df01c1f040200b3ffae0cf51a3cb574b2",
        x"25837a58dc0921bdd19113f97ca92ff69432477322f547013ae5e58137c2dadc",
        x"c8b576349af3dda7a94461460fd0030eecc8c73ea4751e41e238cd993bea0e2f",
        x"3280bba1183eb3314e548b384f6db9086f420d03f60a04bf2cb8129024977c79",
        x"5679b072bcaf89afde9a771fd9930810b38bae12dccf3f2e5512721f2e6b7124",
        x"501adde69f84cd877a5847187408da17bc9f9abce94b7d8cec7aec3adb851dfa",
        x"63094366c464c3d2ef1c18473215d908dd433b3724c2ba1612a14d432a65c451",
        x"50940002133ae4dd71dff89e10314e5581ac77d65f11199b043556f1d7a3c76b",
        x"3c11183b5924a509f28fe6ed97f1fbfa9ebabf2c1e153c6e86e34570eae96fb1",
        x"860e5e0a5a3e2ab3771fe71c4e3d06fa2965dcb999e71d0f803e89d65266c825",
        x"2e4cc9789c10b36ac6150eba94e2ea78a5fc3c531e0a2df4f2f74ea7361d2b3d",
        x"1939260f19c279605223a708f71312b6ebadfe6eeac31f66e3bc4595a67bc883"
    );

end package;