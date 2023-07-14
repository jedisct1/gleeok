library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use work.aes256_gcm_pkg.all;

entity aes is
    generic (rf_conf : rf_t_enum := rf_ttable_e;
             sb_conf : sb_t_enum := sb_bonus_e;
	     mc_conf : mc_t_enum := mc_small_e);
    port (clk     : in std_logic;
          reset_n : in std_logic;

          start : in std_logic;

          key : in  std_logic_vector(127 downto 0);
          pt  : in  std_logic_vector(127 downto 0);
          ct  : out std_logic_vector(127 downto 0);
          cycle : in unsigned(3 downto 0));
end entity;

architecture structural of aes is

    signal sbox_out       : std_logic_vector(127 downto 0);
    signal shiftrows_out  : std_logic_vector(127 downto 0);
    signal mixcolumns_out : std_logic_vector(127 downto 0);
    signal mixttable_out  : std_logic_vector(127 downto 0);

    signal state_in, state_out, rf_out : std_logic_vector(127 downto 0);
    signal key_in, key_out, ks_out     : std_logic_vector(255 downto 0);
    signal roundkey : std_logic_vector(127 downto 0);

    signal run  : std_logic;
    signal inter    : std_logic_vector(127 downto 0);

begin

    --counter : process(clk, reset_n)
    --begin
    --    if reset_n = '0' then
    --        cycle <= "0000";
    --    elsif rising_edge(clk) then
    --        if run = '1' then
    --            cycle <= (cycle + 1) mod 15;
    --        end if;
    --    end if;
    --end process;

    run_reg : process(clk, reset_n)
    begin
        if reset_n = '0' then
            run <= '0';
        elsif rising_edge(clk) then
            if start = '1' then
                run <= '1';
            elsif cycle = 14 then
                run <= '0';
            end if;
        end if;
    end process;

    ct       <= state_out;
    roundkey <= key_out(127 downto 0);

    state_in <= key(255 downto 128) xor pt when start = '1' else
                inter xor roundkey when cycle = 14  else rf_out;
    key_in   <= key when start = '1' else ks_out;

    state_reg : entity reg generic map (128) port map (clk, reset_n, state_in, state_out);
    key_reg   : entity reg generic map (256) port map (clk, reset_n, key_in, key_out);

    ks  : entity keysched generic map (sb_conf) port map (cycle, key_out, ks_out);

    rf_split_gen : if rf_conf = rf_split_e generate
        subbytes_gen    : entity subbytes   generic map (sb_conf) port map (state_out, sbox_out);
        shiftrows_gen   : entity shiftrows  port map (sbox_out, shiftrows_out);
        mixcolumns_gen  : entity mixcolumns generic map (mc_conf) port map (shiftrows_out, mixcolumns_out);
        addroundkey_gen : entity addroundkey port map (mixcolumns_out, roundkey, rf_out);

        inter <= shiftrows_out;
    end generate;

    rf_ttable_gen : if rf_conf = rf_ttable_e generate
        mixttable_gen   : entity mixttable   port map (state_out, mixttable_out, inter);
        addroundkey_gen : entity addroundkey port map (mixttable_out, roundkey, rf_out);
    end generate;

end architecture;

