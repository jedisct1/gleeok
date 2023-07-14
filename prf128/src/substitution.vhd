library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use work.prf128_pkg.all;

entity substitution is
    port (x : in  std_logic_vector(0 to n-1);
          y : out std_logic_vector(0 to n-1));
end entity;

architecture parallel of substitution is

begin

    loop_gen : for i in 0 to (n/8)-1 generate
        s3_gen : entity s3 port map(x(i*8 to i*8+2), y(i*8 to i*8+2));
        s5_gen : entity s5 port map(x(i*8+3 to i*8+7), y(i*8+3 to i*8+7));
    end generate;
    
end architecture;

