library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

library work;
use work.all;
use work.prf128_gcm_pkg.all;

entity prf128_gcm is
    port (clk     : in std_logic;
          reset_n : in std_logic;

          iv  : in std_logic_vector(95 downto 0);
          key : in std_logic_vector(255 downto 0);
          
          start      : in std_logic; 
          last_block : in std_logic;
          
          data      : in std_logic_vector(127 downto 0);
          ad_len    : in std_logic_vector(63 downto 0);
          ad_empty  : in std_logic;
          msg_len   : in std_logic_vector(63 downto 0);
          msg_empty : in std_logic;
          
          ct        : out std_logic_vector(127 downto 0);
          tag       : out std_logic_vector(127 downto 0));
end entity;

architecture structural of prf128_gcm is

    signal state : state_type;
    signal count : unsigned(31 downto 0);

    signal length : std_logic_vector(127 downto 0);

    signal prf_key   : std_logic_vector(255 downto 0);
    signal prf_pt    : std_logic_vector(127 downto 0);
    signal prf_ct    : std_logic_vector(127 downto 0);

    signal dh_load : std_logic;
    signal gh_load : std_logic;
    signal hk_load : std_logic;
    signal tg_load : std_logic;

    signal dh_in, dh_out : std_logic_vector(127 downto 0);
    signal gh_in, gh_out : std_logic_vector(127 downto 0);
    signal hk_in, hk_out : std_logic_vector(127 downto 0);
    signal tg_in, tg_out : std_logic_vector(127 downto 0);

    signal mult_in0, mult_in1, mult_out : std_logic_vector(127 downto 0);

begin

    tag <= tg_out xor mult_out; 

    length <= ad_len(56 downto 0) & "0000000" & msg_len(56 downto 0) & "0000000";

    prf_key <= key;
    prf_pt  <= (others => '0') when state = hk_state else iv & std_logic_vector(count);

    gh_in <= mult_out;
    hk_in <= prf_ct;
    tg_in <= prf_ct;
    
    dh_load <= '1' when state = msg_state else '0';
    gh_load <= '1' when state = hk_state or state = msg_state or state = ad_state else '0';
    hk_load <= '1' when state = hk_state else '0';
    tg_load <= '1' when state = tk_state else '0';
   
    with state select
        mult_in0 <= data   xor gh_out when ad_state,
                    data   xor gh_out when msg_state,
                    length xor gh_out when tag_state,
                    (others => '0')   when others;
    mult_in1 <= hk_out;

    ct <= prf_ct xor data;

    gh_reg : entity dff port map (clk, gh_load, gh_in, gh_out);
    hk_reg : entity dff port map (clk, hk_load, hk_in, hk_out);
    tg_reg : entity dff port map (clk, tg_load, tg_in, tg_out);
   
    prf_gen : entity prf128 port map (clk, prf_pt, prf_key, prf_ct);
    gf_gen : entity gf128_mult port map (mult_in0, mult_in1, mult_out); 

    cont : entity controller port map (
        clk, reset_n, start, last_block, ad_empty, msg_empty, count, state
    );

end architecture;

