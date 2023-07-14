library ieee;
use ieee.std_logic_1164.all;

library work;
use work.all;
use work.aes256_gcm_pkg.all;

entity subbytes is
    generic (sb_conf : sb_t_enum);
    port (x : in  std_logic_vector(n-1 downto 0);
          y : out std_logic_vector(n-1 downto 0));
end entity subbytes;

architecture structural of subbytes is
begin
   
    sb_bonus_gen : if sb_conf = sb_bonus_e generate
        sb_bonus_byte_gen : for i in 0 to 15 generate
            sbox : entity sb_bonus port map (
                x((i+1)*8 - 1 downto i*8), 
                y((i+1)*8 - 1 downto i*8)
            ); 
        end generate;
    end generate;
    
    sb_fast_gen : if sb_conf = sb_fast_e generate
        sb_fast_byte_gen : for i in 0 to 15 generate
            sbox : entity sb_fast port map (
                x((i+1)*8 - 1 downto i*8), 
                y((i+1)*8 - 1 downto i*8)
            ); 
        end generate;
    end generate;
    
    sb_tradeoff_gen : if sb_conf = sb_tradeoff_e generate
        sb_tradeoff_byte_gen : for i in 0 to 15 generate
            sbox : entity sb_tradeoff port map (
                x((i+1)*8 - 1 downto i*8), 
                y((i+1)*8 - 1 downto i*8)
            ); 
        end generate;
    end generate;
    
    sb_dse_gen : if sb_conf = sb_dse_e generate
        sb_dse_fast_gen : for i in 0 to 15 generate
            sbox : entity sb_dse port map (
                x((i+1)*8 - 1 downto i*8), 
                y((i+1)*8 - 1 downto i*8)
            ); 
        end generate;
    end generate;
    
    sb_lut_gen : if sb_conf = sb_lut_e generate
        sb_lut_byte_gen : for i in 0 to 15 generate
            sbox : entity sb_lut port map (
                x((i+1)*8 - 1 downto i*8), 
                y((i+1)*8 - 1 downto i*8)
            ); 
        end generate;
    end generate;

end architecture;

