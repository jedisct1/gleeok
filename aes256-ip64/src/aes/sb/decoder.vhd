library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;
 

entity decoder is
port ( InpxDI : in  std_logic_vector(7 downto 0); 
       PinxD : out std_logic_vector(255 downto 0));
end entity decoder;

architecture parallel of decoder is 

	signal C1xD,C2xD,D1xD,D2xD: std_logic_vector(3 downto 0);
	signal P1xD,P2xD: std_logic_vector (15 downto 0);
	signal NAxD: std_logic_vector (7 downto 0);

begin

NAxD <= not InpxDI;

a000: C1xD(0) <=  NAxD(0) and NAxD(1) ; 
a001: C1xD(1) <=  InpxDI(0) and NAxD(1) ; 
a002: C1xD(2) <=  NAxD(0) and InpxDI(1) ; 
a003: C1xD(3) <=  InpxDI(0) and InpxDI(1) ; 


x000: D1xD(0) <=  NAxD(2) and NAxD(3) ; 
x001: D1xD(1) <=  InpxDI(2) and NAxD(3) ; 
x002: D1xD(2) <=  NAxD(2) and InpxDI(3) ; 
x003: D1xD(3) <=  InpxDI(2) and InpxDI(3) ; 




y000: P1xD(0) <=  C1xD(0) and D1xD(0); 
y001: P1xD(1) <=  C1xD(1) and D1xD(0); 
y002: P1xD(2) <=  C1xD(2) and D1xD(0); 
y003: P1xD(3) <=  C1xD(3) and D1xD(0); 
y004: P1xD(4) <=  C1xD(0) and D1xD(1); 
y005: P1xD(5) <=  C1xD(1) and D1xD(1); 
y006: P1xD(6) <=  C1xD(2) and D1xD(1); 
y007: P1xD(7) <=  C1xD(3) and D1xD(1); 

y008: P1xD(8)  <=  C1xD(0) and D1xD(2); 
y009: P1xD(9)  <=  C1xD(1) and D1xD(2); 
y010: P1xD(10) <=  C1xD(2) and D1xD(2); 
y011: P1xD(11) <=  C1xD(3) and D1xD(2);  
y012: P1xD(12) <=  C1xD(0) and D1xD(3); 
y013: P1xD(13) <=  C1xD(1) and D1xD(3); 
y014: P1xD(14) <=  C1xD(2) and D1xD(3); 
y015: P1xD(15) <=  C1xD(3) and D1xD(3);   



b000: C2xD(0) <=  NAxD(4) and NAxD(5) ; 
b001: C2xD(1) <=  InpxDI(4) and NAxD(5) ; 
b002: C2xD(2) <=  NAxD(4) and InpxDI(5) ; 
b003: C2xD(3) <=  InpxDI(4) and InpxDI(5) ; 


w000: D2xD(0) <=  NAxD(6) and NAxD(7) ; 
w001: D2xD(1) <=  InpxDI(6) and NAxD(7) ; 
w002: D2xD(2) <=  NAxD(6) and InpxDI(7) ; 
w003: D2xD(3) <=  InpxDI(6) and InpxDI(7) ; 




z000: P2xD(0) <=  C2xD(0) and D2xD(0); 
z001: P2xD(1) <=  C2xD(1) and D2xD(0); 
z002: P2xD(2) <=  C2xD(2) and D2xD(0); 
z003: P2xD(3) <=  C2xD(3) and D2xD(0); 
z004: P2xD(4) <=  C2xD(0) and D2xD(1); 
z005: P2xD(5) <=  C2xD(1) and D2xD(1); 
z006: P2xD(6) <=  C2xD(2) and D2xD(1); 
z007: P2xD(7) <=  C2xD(3) and D2xD(1); 

z008: P2xD(8)  <=  C2xD(0) and D2xD(2); 
z009: P2xD(9)  <=  C2xD(1) and D2xD(2); 
z010: P2xD(10) <=  C2xD(2) and D2xD(2); 
z011: P2xD(11) <=  C2xD(3) and D2xD(2);  
z012: P2xD(12) <=  C2xD(0) and D2xD(3); 
z013: P2xD(13) <=  C2xD(1) and D2xD(3); 
z014: P2xD(14) <=  C2xD(2) and D2xD(3); 
z015: P2xD(15) <=  C2xD(3) and D2xD(3); 


i_loop : for i in 0 to 15 generate 
      j_loop : for j in 0 to 15 generate 
             PinxD((16*j + i)) <= P1xD(i) nand P2xD(j);
      end generate j_loop;
end generate i_loop;



end architecture;



