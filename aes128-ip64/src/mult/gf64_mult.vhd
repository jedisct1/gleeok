library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;               -- contains conversion functions
use work.all;


entity GF64_mult is   
  
  port (
    I1xDI : in  std_logic_vector(63 downto 0);
    I2xDI : in  std_logic_vector(63 downto 0);
    OpxDO : out std_logic_vector(63 downto 0);
    ClkxCI : in std_logic 
    );

end;


architecture karatsuba of GF64_mult is

 
signal A0xD, A1xD, B0xD, B1xD, C0xD, C1xD: std_logic_vector(31 downto 0);

signal D0xD, D1xD, D2xD, D3xD: std_logic_vector(63 downto 0);

signal JxD, E2xD, OpxD: std_logic_vector(63 downto 0);  

signal MulxD : std_logic_vector(127 downto 0);  

signal tmp0, tmp1, tmp2 : std_logic_vector(63 downto 0);  

begin


--A0xD <= I1xDI (31 downto 0);
--A1xD <= I1xDI (63 downto 32);
--B0xD <= I2xDI (31 downto 0);
--B1xD <= I2xDI (63 downto 32);

A0xD <= tmp1 (31 downto 0);
A1xD <= tmp1 (63 downto 32);
B0xD <= tmp2 (31 downto 0);
B1xD <= tmp2 (63 downto 32);


C0xD<= A0xD xor A1xD;

C1xD<= B0xD xor B1xD;



a16m1 : entity poly32_mult (karatsuba) port map (A0xD, B0xD, D0xD);
a16m2 : entity poly32_mult (karatsuba) port map (A1xD, B1xD, D1xD);


a16m3 : entity poly32_mult (karatsuba) port map (C0xD, C1xD, D2xD);

--combine
D3xD<= D0xD xor D1xD xor D2xD;
JxD <= D1xD(31 downto 0) & D0xD(63 downto 32);
E2xD<= D3xD xor JxD;

MulxD <= D1xD(63 downto 32) & E2xD &  D0xD(31 downto 0);

---------------

norm: entity norm64 (norm) port map (MulxD, OpxD);

lala: for i in 0 to 63 generate
    tmp1(63-i) <= I1xDI(i);
    tmp2(63-i) <= I2xDI(i);
    tmp0(63-i) <= OpxD(i);
end generate;

OpxDO <= tmp0;
 
end architecture karatsuba;
