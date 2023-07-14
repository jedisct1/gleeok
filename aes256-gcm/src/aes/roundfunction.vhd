library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use work.aes256_gcm_pkg.all;

entity roundfunction is
    generic (last : boolean := false;
             rf_conf : rf_t_enum := rf_ttable_e;
             sb_conf : sb_t_enum := sb_bonus_e;
	     mc_conf : mc_t_enum := mc_small_e);
    port (x  : in  std_logic_vector(n-1 downto 0);
          k  : in  std_logic_vector(n-1 downto 0);
          y  : out std_logic_vector(n-1 downto 0));
end entity;

architecture parallel of roundfunction is
	
    signal sb_out, sr_out, mc_out, mt_out, mt_inter : std_logic_vector(n-1 downto 0);	

begin
	
    last_false_gen : if last = false generate
        rf_split_gen : if rf_conf = rf_split_e generate
            sb_gen  : entity subbytes   generic map (sb_conf) port map (x, sb_out);
            sr_gen  : entity shiftrows  port map (sb_out, sr_out);
            mc_gen  : entity mixcolumns generic map (mc_conf) port map (sr_out, mc_out);
            ark_gen : entity addroundkey port map (mc_out, k, y);
        end generate;
        rf_ttable_gen : if rf_conf = rf_ttable_e generate
            mt_gen  : entity mixttable  port map (x, mt_out, mt_inter);
            ark_gen : entity addroundkey port map (mt_out, k, y);
        end generate;
    end generate;
    
    last_true_gen : if last = true generate
        rf_split_gen : if rf_conf = rf_split_e generate
            sb_gen  : entity subbytes   generic map (sb_conf) port map (x, sb_out);
            sr_gen  : entity shiftrows  port map (sb_out, sr_out);
            ark_gen : entity addroundkey port map (sr_out, k, y);
        end generate;
        rf_ttable_gen : if rf_conf = rf_ttable_e generate
            mt_gen  : entity mixttable  port map (x, mt_out, mt_inter);
            ark_gen : entity addroundkey port map (mt_inter, k, y);
        end generate;
    end generate;

end architecture;

