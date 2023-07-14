library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use work.prf128_gcm_pkg.all;

entity branch0 is
    generic (last : boolean := false);
    port (x   : in std_logic_vector(0 to n-1);
          key : in std_logic_vector(0 to n-1);
          rc  : in std_logic_vector(0 to n-1);
          y   : out std_logic_vector(0 to n-1));
end entity;

architecture parallel of branch0 is

    signal sbox_out, theta_out, pi_out : std_logic_vector(0 to n-1);

begin

    last_false_gen : if last = false generate
        sbox_gen : for i in 0 to (n/8)-1 generate
            s3_gen : entity s3 port map(x(i*8 to i*8+2), sbox_out(i*8 to i*8+2));
            s5_gen : entity s5 port map(x(i*8+3 to i*8+7), sbox_out(i*8+3 to i*8+7));
        end generate;

        theta_gen : for i in 0 to n-1 generate
        theta_out(i) <= sbox_out((i+12) mod n) xor sbox_out((i+31) mod n) xor sbox_out((i+86) mod n);
        end generate;
        
        pi_gen : for i in 0 to n-1 generate
            pi_out(i) <= theta_out((i*117) mod n);
        end generate;

        y <= pi_out xor key xor rc;
    end generate;
    
    last_true_gen : if last = true generate
        sbox_gen : for i in 0 to (n/8)-1 generate
            s3_gen : entity s3 port map(x(i*8 to i*8+2), sbox_out(i*8 to i*8+2));
            s5_gen : entity s5 port map(x(i*8+3 to i*8+7), sbox_out(i*8+3 to i*8+7));
        end generate;

        y <= sbox_out xor key xor rc;
    end generate;
   
end architecture;

