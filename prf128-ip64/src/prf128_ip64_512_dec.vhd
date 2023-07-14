library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

library work;
use work.all;
--use work.prf128_pkg.all;

entity prf128_ip64_512 is
    port (clk    : in std_logic;
          nonce  : in  std_logic_vector(0 to 95);
          key    : in  std_logic_vector(0 to 255);
          hk0    : in  std_logic_vector(0 to 511);
          hk1    : in  std_logic_vector(0 to 511);
          msg    : in  std_logic_vector(0 to 511);
          ct     : out std_logic_vector(0 to 511);
          tag    : out std_logic_vector(0 to 127));
end entity;

architecture structural of prf128_ip64_512 is

    type msg_arr_t is array (0 to 3) of std_logic_vector(0 to 127);
    signal msg_arr : msg_arr_t;
    
    type hk_arr_t is array (0 to 8) of std_logic_vector(0 to 63);
    signal hk0_arr, hk1_arr, s_arr, t_arr : hk_arr_t;
    
    type mul_arr_t is array (0 to 3) of std_logic_vector(0 to 63);
    signal l_arr, r_arr : mul_arr_t;

    signal iv0, iv1, iv2, iv3, iv4 : std_logic_vector(0 to 127);
    signal ct0, ct1, ct2, ct3      : std_logic_vector(0 to 127);
    signal x0, x1, x2, x3, y       : std_logic_vector(0 to 127);
    
    signal s, t : std_logic_vector(0 to 63);

begin

   init_msg : for i in 0 to 3 generate
       msg_arr(i) <= msg(128*i to 128*(i+1)-1);
   end generate;
   
   init_hk : for i in 0 to 7 generate
       hk0_arr(i) <= hk0(64*i to 64*(i+1)-1);
       hk1_arr(i) <= hk1(64*i to 64*(i+1)-1);
   end generate;

   iv0 <= nonce & X"00000001";
   iv1 <= nonce & X"00000002";
   iv2 <= nonce & X"00000003";
   iv3 <= nonce & X"00000004";
   iv4 <= nonce & X"00000000";

   prf128a : entity prf128 port map (clk, iv0, key, x0);
   prf128b : entity prf128 port map (clk, iv1, key, x1);
   prf128c : entity prf128 port map (clk, iv2, key, x2);
   prf128d : entity prf128 port map (clk, iv3, key, x3);

   ct0 <= x0 xor msg_arr(0);
   ct1 <= x1 xor msg_arr(1);
   ct2 <= x2 xor msg_arr(2);
   ct3 <= x3 xor msg_arr(3);
   ct  <= ct0 & ct1 & ct2 & ct3;

   l_arr(0) <= msg_arr(0)(0 to 63); r_arr(0) <= msg_arr(0)(64 to 127);
   l_arr(1) <= msg_arr(1)(0 to 63); r_arr(1) <= msg_arr(1)(64 to 127);
   l_arr(2) <= msg_arr(2)(0 to 63); r_arr(2) <= msg_arr(2)(64 to 127);
   l_arr(3) <= msg_arr(3)(0 to 63); r_arr(3) <= msg_arr(3)(64 to 127);

   mult64a : for i in 0 to 3 generate
       mult64a_0 : entity gf64_mult port map (l_arr(i), hk0_arr(2*i), s_arr(2*i), clk);
       mult64a_1 : entity gf64_mult port map (r_arr(i), hk0_arr(2*i+1), s_arr(2*i+1), clk);
   end generate;
   
   mult64b : for i in 0 to 3 generate
       mult64b_0 : entity gf64_mult port map (l_arr(i), hk1_arr(2*i), t_arr(2*i), clk);
       mult64b_1 : entity gf64_mult port map (r_arr(i), hk1_arr(2*i+1), t_arr(2*i+1), clk);
   end generate;

   s <= s_arr(0) xor s_arr(1) xor s_arr(2) xor s_arr(3) xor s_arr(4) xor s_arr(5) xor s_arr(6) xor s_arr(7); 
   t <= t_arr(0) xor t_arr(1) xor t_arr(2) xor t_arr(3) xor t_arr(4) xor t_arr(5) xor t_arr(6) xor t_arr(7); 

   prf128e : entity prf128 port map (clk, iv4, key, y);

   tag <= y xor (s & t);
    
end architecture;
         

