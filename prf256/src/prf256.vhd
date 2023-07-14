library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

library work;
use work.all;
use work.prf256_pkg.all;

entity prf256 is
    port (clk    : in std_logic;
          input  : in  std_logic_vector(0 to n-1);
          key    : in  std_logic_vector(0 to k-1);
          output : out std_logic_vector(0 to n-1));
end entity;

architecture behavioural of prf256 is
   
    type state_array_type is array (0 to r) of std_logic_vector(0 to n-1);
    type key_array_type is array (0 to r) of std_logic_vector(0 to n-1);
    
    signal branch0_array : state_array_type;
    signal branch1_array : state_array_type;
    signal branch2_array : state_array_type;
    
    signal key0_array : key_array_type;
    signal key1_array : key_array_type;
    signal key2_array : key_array_type;

begin

    white_key0_gen : entity keyschedule0 port map (key, key0_array(0));	
    white_key1_gen : entity keyschedule1 port map (key, key1_array(0));	
    white_key2_gen : entity keyschedule2 port map (key, key2_array(0));	

    branch0_array(0) <= input xor key0_array(0);
    branch1_array(0) <= input xor key1_array(0);
    branch2_array(0) <= input xor key2_array(0);
    
    --branch0_array(0) <= input xor key;
    --branch1_array(0) <= input xor key;
    --branch2_array(0) <= input xor key;
    
    unrolled_gen : for i in 1 to r generate
	key0_gen : entity keyschedule0 port map (key0_array(i-1), key0_array(i));	
	key1_gen : entity keyschedule1 port map (key1_array(i-1), key1_array(i));	
	key2_gen : entity keyschedule2 port map (key2_array(i-1), key2_array(i));	

        branch0_gen : entity branch0 generic map (i=r) port map (branch0_array(i-1), key0_array(i), rc0(i), branch0_array(i));
        branch1_gen : entity branch1 generic map (i=r) port map (branch1_array(i-1), key1_array(i), rc1(i), branch1_array(i));
        branch2_gen : entity branch2 generic map (i=r) port map (branch2_array(i-1), key2_array(i), rc2(i), branch2_array(i));
        
    end generate;
    
    output <= branch0_array(r) xor branch1_array(r) xor branch2_array(r);
    
end architecture;
         

