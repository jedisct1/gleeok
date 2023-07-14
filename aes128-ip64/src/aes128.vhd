library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

library work;
use work.all;
use work.aes128_pkg.all;

entity core is
    generic (rf_conf : rf_t_enum := rf_ttable_e;
             sb_conf : sb_t_enum := sb_fast_e;
	     mc_conf : mc_t_enum := mc_fast_e);
    port (clk    : in std_logic;
          input  : in  std_logic_vector(0 to n-1);
          key    : in  std_logic_vector(0 to k-1);
          output : out std_logic_vector(0 to n-1));
end entity;

architecture parallel of core is
   
    type state_array_type is array (0 to r) of std_logic_vector(0 to n-1);
    type key_array_type is array (0 to r) of std_logic_vector(0 to n-1);
    
    signal state_array : state_array_type;
    signal key_array   : key_array_type;

begin

    state_array(0) <= input xor key;
    key_array(0) <= key;

    unrolled_gen : for i in 1 to r generate
	key_gen : entity keyschedule generic map (i-1, sb_conf)
	    port map (key_array(i-1), key_array(i));	

        rf_gen : entity roundfunction generic map (i=r, rf_conf, sb_conf, mc_conf)
	    port map (state_array(i-1), key_array(i), state_array(i));
    end generate;
    
    output <=state_array(r);
    
end architecture;
         

