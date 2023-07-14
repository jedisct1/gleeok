library ieee;
use ieee.std_logic_1164.all;

entity xtime is
  
  port (
    InpxDI : in  std_logic_vector(7 downto 0);
    OupxDO : out std_logic_vector(7 downto 0)
    );

end xtime;

architecture structural of xtime is
  signal DataxD : std_logic_vector(7 downto 0);
begin
  DataxD <= InpxDI(6 downto 0) & '0';

  OupxDO <= DataxD when (InpxDI(7) = '0') else
            (DataxD xor "00011011");
  
end structural;
