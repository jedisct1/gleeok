library ieee;
use ieee.std_logic_1164.all;

library work;
use work.all;
use work.aes256_gcm_pkg.all;

entity mixcolumns is 
    generic (mc_conf : mc_t_enum);
    port (x : in std_logic_vector(127 downto 0);
          y : out std_logic_vector(127 downto 0));
end entity;

architecture structural of mixcolumns is
begin
    
    mc_simple_gen : if mc_conf = mc_simple_e generate
        mc_simple_cols_gen : for i in 0 to 3 generate
            mc : entity mc_simple port map (
                x((i+1)*32 - 1 downto i*32), 
                y((i+1)*32 - 1 downto i*32)
            ); 
        end generate;
    end generate;

    mc_small_gen : if mc_conf = mc_small_e generate
        mc_small_cols_gen : for i in 0 to 3 generate
            mc : entity mc_small port map (
                x((i+1)*32 - 1 downto i*32), 
                y((i+1)*32 - 1 downto i*32)
            ); 
        end generate;
    end generate;
    
    mc_fast_gen : if mc_conf = mc_fast_e generate
        mc_fast_cols_gen : for i in 0 to 3 generate
            mc : entity mc_fast port map (
                x((i+1)*32 - 1 downto i*32), 
                y((i+1)*32 - 1 downto i*32)
            ); 
        end generate;
    end generate;
    
end architecture;

