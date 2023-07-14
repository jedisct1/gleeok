library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;               -- contains conversion functions
use work.all;


entity normalize is  -- poly basis: irred x^128 + x^7 + x^2 + x + 1
  
  port (
    InxDI : in  std_logic_vector(255 downto 0);

    OpxDO : out std_logic_vector(127 downto 0) 
    );

end normalize;



architecture norm of normalize is

signal high : std_logic_vector(127 downto 0);  

begin


high <= InxDI(255 downto 128);


OpxDO(0) <= InxDI(0) xor high(0) xor high(121)  xor high(126) xor high(127);
OpxDO(1) <= InxDI(1) xor high(0) xor high(1) xor high(121)  xor high(122) xor high(126);

 


l1: for i in 2 to 3 generate 
OpxDO(i) <= InxDI(i) xor  high(i-2) xor high(i-1) xor high(i)  xor high(i+119) xor high(i+120) xor high(i+121) xor high(i+124);
end generate l1;

l2: for i in 4 to 6 generate 
OpxDO(i) <=  InxDI(i) xor high(i-2) xor high(i-1) xor high(i)  xor high(i+119) xor high(i+120) xor high(i+121) ;
end generate l2;


l3: for i in 7 to 13 generate 
OpxDO(i) <=  InxDI(i) xor high(i-7) xor high(i-2) xor high(i-1)  xor high(i) xor high(i+114);
end generate l3;



l4: for i in 14 to 127 generate 
OpxDO(i) <=  InxDI(i) xor high(i-7) xor high(i-2) xor high(i-1)  xor high(i);
end generate l4;



end architecture norm;

