library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

package prf128_gcm_pkg is

    constant r : integer := 12;  -- number of rounds
    constant n : integer := 128; -- block size
    constant k : integer := 256; -- key size
    
    type state_type is (
        idle_state,
	-- generate hash key
	hk_state,
	-- generate tag key
	tk_state,
	-- absorb ad
	ad_state,
	-- absorb msg
	msg_state,
	msg_state_mul,
	-- generate tag
	tag_state
    );
    
    type rc_type is array (0 to 12) of std_logic_vector(0 to n-1);
    constant rc0 : rc_type := (
        x"243f6a8885a308d313198a2e03707344",
        x"a4093822299f31d0082efa98ec4e6c89",
        x"452821e638d01377be5466cf34e90c6c",
        x"c0ac29b7c97c50dd3f84d5b5b5470917",
        x"9216d5d98979fb1bd1310ba698dfb5ac",
        x"2ffd72dbd01adfb7b8e1afed6a267e96",
        x"ba7c9045f12c7f9924a19947b3916cf7",
        x"0801f2e2858efc16636920d871574e69",
        x"a458fea3f4933d7e0d95748f728eb658",
        x"718bcd5882154aee7b54a41dc25a59b5",
        x"9c30d5392af26013c5d1b023286085f0",
        x"ca417918b8db38ef8e79dcb0603a180e",
        x"6c9e0e8bb01e8a3ed71577c1bd314b27"	
    );
    constant rc1 : rc_type := (
        x"78af2fda55605c60e65525f3aa55ab94",
        x"5748986263e8144055ca396a2aab10b6",
        x"b4cc5c341141e8cea15486af7c72e993",
        x"b3ee1411636fbc2a2ba9c55d741831f6",
        x"ce5c3e169b87931eafd6ba336c24cf5c",
        x"7a325381289586773b8f48986b4bb9af",
        x"c4bfe81b6628219361d809ccfb21a991",
        x"487cac605dec8032ef845d5de98575b1",
        x"dc262302eb651b8823893e81d396acc5",
        x"0f6d6ff383f442392e0b4482a4842004",
        x"69c8f04a9e1f9b5e21c66842f6e96c9a",
        x"670c9c61abd388f06a51a0d2d8542f68",
        x"960fa728ab5133a36eef0b6c137a3be4"	
    );
    constant rc2 : rc_type := (
        x"ba3bf0507efb2a98a1f1651d39af0176",
        x"66ca593e82430e888cee8619456f9fb4",
        x"7d84a5c33b8b5ebee06f75d885c12073",
        x"401a449f56c16aa64ed3aa62363f7706",
        x"1bfedf72429b023d37d0d724d00a1248",
        x"db0fead349f1c09b075372c980991b7b",
        x"25d479d8f6e8def7e3fe501ab6794c3b",
        x"976ce0bd04c006bac1a94fb6409f60c4",
        x"5e5c9ec2196a246368fb6faf3e6c53b5",
        x"1339b2eb3b52ec6f6dfc511f9b30952c",
        x"cc814544af5ebd09bee3d004de334afd",
        x"660f2807192e4bb3c0cba85745c8740f",
        x"d20b5f39b9d3fbdb5579c0bd1a60320a"
    );

end package;
