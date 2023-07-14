library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;

entity s4 is
    port (x : in  std_logic_vector(0 to 3);
          y : out std_logic_vector(0 to 3));
end entity;

architecture parallel of s4 is

    type tbox_type is array (0 to 15) of std_logic_vector (0 to 3);
    constant tbox : tbox_type := (
        --  1      0        2     4        3      8       6      13
        "0001", "0000", "0010", "0100", "0011", "1000", "0110", "1101",
	-- 9,     10,     11,     14,     15,     12,     7,      5 
	"1001", "1010", "1011", "1110", "1111", "1100", "0111", "0101"	
    );

    signal z : std_logic_vector(3 downto 0);

begin

    z <= x;
    y <= tbox(to_integer(unsigned(z)));

end architecture;

