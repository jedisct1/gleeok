library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.all;

entity mc_simple is 
port ( InpxDI : in std_logic_vector (31 downto 0);
       OupxDO : out std_logic_vector (31 downto 0)
       );
       
end entity;

architecture parallel of mc_simple is
  
  signal A0xD,A1xD,A2xD,A3xD, X0xD,X1xD,X2xD,X3xD, Y0xD,Y1xD,Y2xD,Y3xD : std_logic_vector (7 downto 0);
  signal H0xD,H1xD,H2xD,H3xD, Z0xD,Z1xD,Z2xD,Z3xD, G0xD,G1xD,G2xD,G3xD , X02xD,X13xD,F02xD,F13xD: std_logic_vector (7 downto 0);
  signal GxD, HxD : std_logic_vector (31 downto 0);

begin 
  
    HxD <=  InpxDI;
    
    H0xD <= HxD(31 downto 24);
    H1xD <= HxD(23 downto 16);
    H2xD <= HxD(15 downto 8);
    H3xD <= HxD(7 downto 0);  
    
    X0xD <= H0xD xor H1xD;
    X1xD <= H1xD xor H2xD;
    X2xD <= H2xD xor H3xD;
    X3xD <= H3xD xor H0xD;
    
    xt1: entity xtime (structural) port map (X3xD,Y3xD);
    xt2: entity xtime (structural) port map (X2xD,Y2xD);  
    xt3: entity xtime (structural) port map (X1xD,Y1xD);
    xt4: entity xtime (structural) port map (X0xD,Y0xD);
     
    Z0xD <= Y0xD xor  X1xD xor H3xD;
    Z1xD <= Y1xD xor  X2xD xor H0xD;
    Z2xD <= Y2xD xor  X3xD xor H1xD;
    Z3xD <= Y3xD xor  X0xD xor H2xD;
    
    OupxDO <= Z0xD & Z1xD & Z2xD & Z3xD ;

end architecture;

