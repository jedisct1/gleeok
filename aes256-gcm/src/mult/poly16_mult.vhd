library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;               -- contains conversion functions
use work.all;


entity poly16_mult is   
  
  port (
    I1xDI : in  std_logic_vector(15 downto 0);
    I2xDI : in  std_logic_vector(15 downto 0);
    OpxDO : out std_logic_vector(31 downto 0)
    );

end poly16_mult;


architecture karatsuba of poly16_mult is

 
signal A0xD, A1xD, B0xD, B1xD, C0xD, C1xD: std_logic_vector(7 downto 0);

signal D0xD, D1xD, D2xD, D3xD: std_logic_vector(15 downto 0);

signal JxD, E2xD, OpxD: std_logic_vector(15 downto 0);  

signal MulxD : std_logic_vector(31 downto 0);  

begin


A0xD <= I1xDI (7 downto 0);
A1xD <= I1xDI (15 downto 8);


B0xD <= I2xDI (7 downto 0);
B1xD <= I2xDI (15 downto 8);


C0xD<= A0xD xor A1xD;

C1xD<= B0xD xor B1xD;



a8m1 : entity poly8_mult (karatsuba) port map (A0xD, B0xD, D0xD);
a8m2 : entity poly8_mult (karatsuba) port map (A1xD, B1xD, D1xD);


a8m3 : entity poly8_mult (karatsuba) port map (C0xD, C1xD, D2xD);

--combine
D3xD<= D0xD xor D1xD xor D2xD;
JxD<= D1xD(7 downto 0) & D0xD(15 downto 8);
E2xD<= D3xD xor JxD;

MulxD <= D1xD(15 downto 8) & E2xD &  D0xD(7 downto 0);

---------------
 


 

OpxDO <= MulxD;
 
end architecture karatsuba ;
