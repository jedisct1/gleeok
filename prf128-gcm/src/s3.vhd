library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;

entity s3 is
    port (x : in  std_logic_vector(0 to 2);
          y : out std_logic_vector(0 to 2));
end entity;

architecture parallel of s3 is

    type tbox_type is array (0 to 7) of std_logic_vector (0 to 2);
    constant tbox : tbox_type := (
         "000", "101", "011", "010", "110", "001", "100", "111"
    );

    signal z : std_logic_vector(2 downto 0);

begin

    z <= x;
    y <= tbox(to_integer(unsigned(z)));

    --y(0) <= x(0) xor (not(x(1)) and x(2));
    --y(1) <= x(1) xor (not(x(2)) and x(0));
    --y(2) <= x(2) xor (not(x(0)) and x(1));

end architecture;

