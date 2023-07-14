library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

library work;
use work.all;
--use work.prf128_pkg.all;

entity prf128_ip64_128 is
    port (clk    : in std_logic;
          nonce  : in  std_logic_vector(0 to 95);
          key    : in  std_logic_vector(0 to 255);
          hk0    : in  std_logic_vector(0 to 127);
          hk1    : in  std_logic_vector(0 to 127);
          msg    : in  std_logic_vector(0 to 127);
          ct     : out std_logic_vector(0 to 127);
          tag    : out std_logic_vector(0 to 127));
end entity;

architecture structural of prf128_ip64_128 is

    type msg_arr_t is array (0 to 0) of std_logic_vector(0 to 127);
    signal msg_arr : msg_arr_t;
    
    type hk_arr_t is array (0 to 1) of std_logic_vector(0 to 63);
    signal hk0_arr, hk1_arr, s_arr, t_arr : hk_arr_t;
    
    type mul_arr_t is array (0 to 0) of std_logic_vector(0 to 63);
    signal l_arr, r_arr : mul_arr_t;

    signal iv0, iv1 : std_logic_vector(0 to 127);
    signal ct0, ct1      : std_logic_vector(0 to 127);
    signal x0, y     : std_logic_vector(0 to 127);
    
    signal s, t : std_logic_vector(0 to 63);

begin

   init_msg : for i in 0 to 0 generate
       msg_arr(i) <= msg(128*i to 128*(i+1)-1);
   end generate;
   
   init_hk : for i in 0 to 1 generate
       hk0_arr(i) <= hk0(64*i to 64*(i+1)-1);
       hk1_arr(i) <= hk1(64*i to 64*(i+1)-1);
   end generate;

   iv0 <= nonce & X"00000001";
   iv1 <= nonce & X"00000000";

   prf128a : entity prf128 port map (clk, iv0, key, x0);

   ct0 <= x0 xor msg_arr(0);
   ct  <= ct0;

   l_arr(0) <= ct0(0 to 63); r_arr(0) <= ct0(64 to 127);

   mult64a : for i in 0 to 0 generate
       mult64a_0 : entity gf64_mult port map (l_arr(i), hk0_arr(2*i), s_arr(2*i), clk);
       mult64a_1 : entity gf64_mult port map (r_arr(i), hk0_arr(2*i+1), s_arr(2*i+1), clk);
   end generate;
   
   mult64b : for i in 0 to 0 generate
       mult64b_0 : entity gf64_mult port map (l_arr(i), hk1_arr(2*i), t_arr(2*i), clk);
       mult64b_1 : entity gf64_mult port map (r_arr(i), hk1_arr(2*i+1), t_arr(2*i+1), clk);
   end generate;

   s <= s_arr(0) xor s_arr(1); 
   t <= t_arr(0) xor t_arr(1); 

   prf128e : entity prf128 port map (clk, iv1, key, y);

   tag <= y xor (s & t);
    
end architecture;
         

