library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;

entity s5 is
    port (x : in  std_logic_vector(0 to 4);
          y : out std_logic_vector(0 to 4));
end entity;

architecture parallel of s5 is

    type tbox_type is array (0 to 31) of std_logic_vector (0 to 4);
    constant tbox : tbox_type := (
         "00000", "00101", "01010", "01011", "10100", "10001", "10110", "10111",
         "01001", "01100", "00011", "00010", "01101", "01000", "01111", "01110",
         "10010", "10101", "11000", "11011", "00110", "00001", "00100", "00111",
         "11010", "11101", "10000", "10011", "11110", "11001", "11100", "11111"
    );

    signal z : std_logic_vector(4 downto 0);

begin

    z <= x;
    y <= tbox(to_integer(unsigned(z)));
    
    --y(0) <= x(0) xor (not(x(1)) and x(2));
    --y(1) <= x(1) xor (not(x(2)) and x(3));
    --y(2) <= x(2) xor (not(x(3)) and x(4));
    --y(3) <= x(3) xor (not(x(4)) and x(0));
    --y(4) <= x(4) xor (not(x(0)) and x(1));

end architecture;


