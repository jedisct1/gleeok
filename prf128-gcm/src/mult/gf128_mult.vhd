library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;               -- contains conversion functions
use work.all;


entity GF128_mult is  -- poly basis: irred x^128 + x^7+ x^2 +x + 1
  
  port (
    I1xDI : in  std_logic_vector(127 downto 0);
    I2xDI : in  std_logic_vector(127 downto 0);
    OpxDO : out std_logic_vector(127 downto 0));

end GF128_mult;


architecture karatsuba of GF128_mult is

 
signal A0xD, A1xD, B0xD, B1xD, C0xD, C1xD: std_logic_vector(63 downto 0);

signal D0xD, D1xD, D2xD, D3xD: std_logic_vector(127 downto 0);

signal JxD, E2xD, OpxD: std_logic_vector(127 downto 0);  

signal MulxD : std_logic_vector(255 downto 0);  

signal tmp0, tmp1, tmp2: std_logic_vector(127 downto 0);  

begin


A0xD <= tmp1 (63 downto 0);
A1xD <= tmp1 (127 downto 64);
B0xD <= tmp2 (63 downto 0);
B1xD <= tmp2 (127 downto 64);

--A0xD <= I1xDI (63 downto 0);
--A1xD <= I1xDI (127 downto 64);
--B0xD <= I2xDI (63 downto 0);
--B1xD <= I2xDI (127 downto 64);


C0xD<= A0xD xor A1xD;

C1xD<= B0xD xor B1xD;



a64m1 : entity poly64_mult (karatsuba) port map (A0xD, B0xD, D0xD);
a64m2 : entity poly64_mult (karatsuba) port map (A1xD, B1xD, D1xD);


a64m3 : entity poly64_mult (karatsuba) port map (C0xD, C1xD, D2xD);

--combine
D3xD<= D0xD xor D1xD xor D2xD;
JxD <= D1xD(63 downto 0) & D0xD(127 downto 64);
E2xD<= D3xD xor JxD;

MulxD <= D1xD(127 downto 64) & E2xD &  D0xD(63 downto 0);

---------------
-- wrap around


norm: entity normalize (norm) port map (MulxD, OpxD);

lala: for i in 0 to 127 generate
    tmp1(127-i) <= I1xDI(i);
    tmp2(127-i) <= I2xDI(i);
    tmp0(127-i) <= OpxD(i);
end generate;

--OpxDO <= OpxD;
OpxDO <= tmp0;

 
end architecture karatsuba ;
