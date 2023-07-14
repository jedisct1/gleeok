library ieee;
use ieee.std_logic_1164.all;

entity addroundkey is 
    port (x : in std_logic_vector(127 downto 0);
          k : in std_logic_vector(127 downto 0);
          y : out std_logic_vector(127 downto 0));
end entity addroundkey;

architecture parallel of addroundkey is
begin

    y <= x xor k;

end architecture;
