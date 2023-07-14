library ieee;
use ieee.std_logic_1164.all;

package aes256_pkg is

    constant n : integer := 128; -- block size
    constant k : integer := 256; -- key size
    constant v : integer := 96;  -- iv size
    constant r : integer := 14;  -- rounds
    
    -- Round function config: either split into separate functions
    -- or merged as a single T-table procedure.
    type rf_t_enum is (rf_split_e, rf_ttable_e);

    -- S-box config: Several implementations are supported:
    --  1. Lookup table.
    --  2. Decode-switch encoder.
    --  3. Maximov's and Ekdahl's low-depth circuit [TCHES'2019].
    --  4. Maximov's and Ekdahl's world record smallest circuit [TCHES'2019].
    --  5. Maximov's and Ekdahl's tradeoff (depth/size) circuit [TCHES'2019].
    type sb_t_enum is (sb_lut_e, sb_dse_e, sb_fast_e, sb_bonus_e, sb_tradeoff_e);
    
    -- MixColumns config: Several implementations are supported:
    --  1. Satoh et al.'s straightforward circuit [ASIACRYPT'2001].
    --  2. Li et al.'s depth-3 circuit [TCHES'2019].
    --  3. Maximov's world record smallest circuit [IACR-EPRINT].
    type mc_t_enum is (mc_simple_e, mc_fast_e, mc_small_e);
    
end package;
