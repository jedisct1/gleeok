library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

library work;
use work.all;
--use work.prf128_pkg.all;

entity aes256_ip64_256 is
    port (clk    : in std_logic;
          nonce  : in  std_logic_vector(0 to 95);
          key    : in  std_logic_vector(0 to 255);
          hk0    : in  std_logic_vector(0 to 255);
          hk1    : in  std_logic_vector(0 to 255);
          msg    : in  std_logic_vector(0 to 255);
          ct     : out std_logic_vector(0 to 255);
          tag    : out std_logic_vector(0 to 127));
end entity;

architecture structural of aes256_ip64_256 is

    type msg_arr_t is array (0 to 1) of std_logic_vector(0 to 127);
    signal msg_arr : msg_arr_t;
    
    type hk_arr_t is array (0 to 3) of std_logic_vector(0 to 63);
    signal hk0_arr, hk1_arr, s_arr, t_arr : hk_arr_t;
    
    type mul_arr_t is array (0 to 1) of std_logic_vector(0 to 63);
    signal l_arr, r_arr : mul_arr_t;

    signal iv0, iv1, iv2 : std_logic_vector(0 to 127);
    signal ct0, ct1      : std_logic_vector(0 to 127);
    signal x0, x1, y     : std_logic_vector(0 to 127);
    
    signal s, t : std_logic_vector(0 to 63);

begin

   init_msg : for i in 0 to 1 generate
       msg_arr(i) <= msg(128*i to 128*(i+1)-1);
   end generate;
   
   init_hk : for i in 0 to 3 generate
       hk0_arr(i) <= hk0(64*i to 64*(i+1)-1);
       hk1_arr(i) <= hk1(64*i to 64*(i+1)-1);
   end generate;

   iv0 <= nonce & X"00000001";
   iv1 <= nonce & X"00000002";
   iv2 <= nonce & X"00000000";

   aes256a : entity aes256 port map (clk, iv0, key, x0);
   aes256b : entity aes256 port map (clk, iv1, key, x1);

   ct0 <= x0 xor msg_arr(0);
   ct1 <= x1 xor msg_arr(1);
   ct  <= ct0 & ct1;

   l_arr(0) <= ct0(0 to 63); r_arr(0) <= ct0(64 to 127);
   l_arr(1) <= ct1(0 to 63); r_arr(1) <= ct1(64 to 127);

   mult64a : for i in 0 to 1 generate
       mult64a_0 : entity gf64_mult port map (l_arr(i), hk0_arr(2*i), s_arr(2*i), clk);
       mult64a_1 : entity gf64_mult port map (r_arr(i), hk0_arr(2*i+1), s_arr(2*i+1), clk);
   end generate;
   
   mult64b : for i in 0 to 1 generate
       mult64b_0 : entity gf64_mult port map (l_arr(i), hk1_arr(2*i), t_arr(2*i), clk);
       mult64b_1 : entity gf64_mult port map (r_arr(i), hk1_arr(2*i+1), t_arr(2*i+1), clk);
   end generate;

   s <= s_arr(0) xor s_arr(1) xor s_arr(2) xor s_arr(3); 
   t <= t_arr(0) xor t_arr(1) xor t_arr(2) xor t_arr(3); 

   aes256e : entity aes256 port map (clk, iv2, key, y);

   tag <= y xor (s & t);
    
end architecture;
         

