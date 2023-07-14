library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use work.prf256_pkg.all;

entity keyschedule0 is
    port (key_in  : in  std_logic_vector(0 to k-1);
          key_out : out std_logic_vector(0 to k-1));
end entity;

architecture parallel of keyschedule0 is
begin

    ks_perm_gen : for i in 0 to k-1 generate
        key_out(i) <= key_in((i*57) mod n);
    end generate;
    
end architecture;

