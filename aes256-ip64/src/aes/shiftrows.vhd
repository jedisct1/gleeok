library ieee;
use ieee.std_logic_1164.all;

entity shiftrows is 
    port (x : in std_logic_vector(127 downto 0);
          y : out std_logic_vector(127 downto 0));
end entity shiftrows;

architecture parallel of shiftrows is

  type BytesType is array (0 to 15) of std_logic_vector (7 downto 0);
  signal InBxD, OutBxD : BytesType;
  
begin

    gen_byte_assign: for i in 0 to 15 generate
        InBxD(i) <= x(((15-i)*8)+7 downto (15-i)*8);
        y(((15-i)*8)+7 downto (15-i)*8) <= OutBxD(i);
    end generate gen_byte_assign;

    -- Row 0 as it is 
    OutBxD(0)  <= InBxD(0);
    OutBxD(4)  <= InBxD(4);
    OutBxD(8)  <= InBxD(8);
    OutBxD(12) <= InBxD(12); 
    -- Row 1 one left
    OutBxD(1)  <= InBxD(5) ;
    OutBxD(5)  <= InBxD(9);
    OutBxD( 9) <= InBxD(13) ;
    OutBxD(13) <= InBxD(1) ;
    -- Row 2 two left
    OutBxD(2)  <= InBxD(10);
    OutBxD(6)  <= InBxD(14);
    OutBxD(10) <= InBxD(2);
    OutBxD(14) <= InBxD(6); 
    -- Row 3 three left
    OutBxD(3)  <= InBxD(15) ;
    OutBxD(7)  <= InBxD(3) ;
    OutBxD(11) <= InBxD(7) ;
    OutBxD(15) <= InBxD(11) ;
  
end architecture;

