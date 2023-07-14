library ieee;
use ieee.std_logic_1164.all;

library work;
use work.all;
use work.aes256_pkg.all;

entity mixttable is 
    port (x : in std_logic_vector(127 downto 0);
          y : out std_logic_vector(127 downto 0);
          inter : out std_logic_vector(127 downto 0));
end entity;

architecture structural of mixttable is
    
    signal shiftrows_out : std_logic_vector(127 downto 0);

begin

    shiftrows_gen : entity shiftrows port map (x, shiftrows_out);

    ttable_gen : for i in 0 to 3 generate
        ttable : entity work.ttable port map (
            shiftrows_out((i+1)*32 - 1 downto i*32), 
            y((i+1)*32 - 1 downto i*32),
            inter((i+1)*32 - 1 downto i*32)
        ); 
    end generate;

end architecture;

