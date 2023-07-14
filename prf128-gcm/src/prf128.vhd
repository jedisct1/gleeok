library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

library work;
use work.all;
use work.prf128_gcm_pkg.all;

entity prf128 is
    port (clk    : in std_logic;
          input  : in  std_logic_vector(0 to n-1);
          key    : in  std_logic_vector(0 to k-1);
          output : out std_logic_vector(0 to n-1));
end entity;

architecture behavioural of prf128 is
   
    type state_array_type is array (0 to r) of std_logic_vector(0 to n-1);
    type key_array_type is array (0 to 1, 0 to r) of std_logic_vector(0 to n-1);
    
    signal branch0_array : state_array_type;
    signal branch1_array : state_array_type;
    signal branch2_array : state_array_type;
    
    signal key0_array : key_array_type;
    signal key1_array : key_array_type;
    signal key2_array : key_array_type;

    signal key0, key1 : std_logic_vector(0 to n-1);

begin

    key0 <= key(0 to k/2-1);
    key1 <= key(k/2 to k-1);

    white_key0_gen : entity keyschedule0 generic map (0) port map (key0, key1, key0_array(0, 0), key0_array(1, 0));	
    white_key1_gen : entity keyschedule1 generic map (0) port map (key0, key1, key1_array(0, 0), key1_array(1, 0));	
    white_key2_gen : entity keyschedule2 generic map (0) port map (key0, key1, key2_array(0, 0), key2_array(1, 0));	

    branch0_array(0) <= input xor key0_array(0, 0);
    branch1_array(0) <= input xor key1_array(0, 0);
    branch2_array(0) <= input xor key2_array(0, 0);
    
    unrolled_gen : for i in 1 to r generate
	key0_gen : entity keyschedule0 generic map (i) port map (key0_array(0, i-1), key0_array(1, i-1), key0_array(0, i), key0_array(1, i));	
	key1_gen : entity keyschedule1 generic map (i) port map (key1_array(0, i-1), key1_array(1, i-1), key1_array(0, i), key1_array(1, i));	
	key2_gen : entity keyschedule2 generic map (i) port map (key2_array(0, i-1), key2_array(1, i-1), key2_array(0, i), key2_array(1, i));	

        branch0_gen : entity branch0 generic map (i=r) port map (branch0_array(i-1), key0_array(i mod 2, i), rc0(i), branch0_array(i));
        branch1_gen : entity branch1 generic map (i=r) port map (branch1_array(i-1), key1_array(i mod 2, i), rc1(i), branch1_array(i));
        branch2_gen : entity branch2 generic map (i=r) port map (branch2_array(i-1), key2_array(i mod 2, i), rc2(i), branch2_array(i));
    end generate;
    
    output <= branch0_array(r) xor branch1_array(r) xor branch2_array(r);
    
end architecture;
         

