library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;               -- contains conversion functions
use work.all;


entity poly2_mult is   
  
  port (
    I1xDI : in  std_logic_vector(1 downto 0);
    I2xDI : in  std_logic_vector(1 downto 0);
    OpxDO : out std_logic_vector(3 downto 0)
    );

end poly2_mult;


architecture lut of poly2_mult is

 subtype Int4Type is integer range 0 to 15;
	type Int4Array is array (0 to 15) of Int4Type;
	constant SBOX : Int4Array := (0, 0, 0, 0,   0, 1, 2, 3,    0, 2, 4, 6,   0, 3, 6, 5);
 signal InxD: std_logic_vector(3 downto 0);

begin


          InxD <= I1xDI & I2xDI;
	  OpxDO <= std_logic_vector(to_unsigned(SBOX(to_integer(unsigned(InxD(3 downto 0)))), 4));
 
 
end architecture lut ;
