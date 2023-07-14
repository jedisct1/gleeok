library ieee;
use ieee.std_logic_1164.all;
 
entity dff is
   generic(n : integer := 128);
   port (clk     : in std_logic;
         en      : in std_logic;
         d       : in  std_logic_vector(n-1 downto 0);
         q       : out std_logic_vector(n-1 downto 0));
end entity;

architecture behavioural of dff is
begin

    bank : process(clk)
    begin
        if rising_edge(clk) then
            if en = '1' then
                q <= d;
            end if;
        end if;
    end process;

end architecture;

