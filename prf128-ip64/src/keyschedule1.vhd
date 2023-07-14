library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use work.prf128_pkg.all;

entity keyschedule1 is
    generic (round  : integer := 0);
    port (key0_in  : in std_logic_vector(0 to n-1);
          key1_in  : in std_logic_vector(0 to n-1);
          key0_out : out std_logic_vector(0 to n-1);
          key1_out : out std_logic_vector(0 to n-1));
end entity;

architecture parallel of keyschedule1 is
begin

    ks_even_gen : if round mod 2 = 0 generate
        ks_perm_gen : for i in 0 to n-1 generate
            key0_out(i) <= key0_in((i*51) mod n);
        end generate;
	key1_out <= key1_in;
    end generate;
    
    ks_odd_gen : if round mod 2 = 1 generate
        ks_perm_gen : for i in 0 to n-1 generate
            key1_out(i) <= key1_in((i*51) mod n);
        end generate;
	key0_out <= key0_in;
    end generate;

end architecture;

