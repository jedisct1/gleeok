library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use work.prf128_gcm_pkg.all;

entity branch2 is
    generic (last : boolean := false);
    port (x   : in std_logic_vector(0 to n-1);
          key : in std_logic_vector(0 to n-1);
          rc  : in std_logic_vector(0 to n-1);
          y   : out std_logic_vector(0 to n-1));
end entity;

architecture parallel of branch2 is

    signal sbox_out, theta_out, pi_out : std_logic_vector(0 to n-1);

begin

    last_false_gen : if last = false generate
        sbox_gen : for i in 0 to (n/4)-1 generate
            s4_gen : entity s4 port map(x(i*4 to i*4+3), sbox_out(i*4 to i*4+3));
        end generate;

        theta_gen : for i in 0 to n-1 generate
        theta_out(i) <= sbox_out((i+7) mod n) xor sbox_out((i+15) mod n) xor sbox_out((i+23) mod n);
        end generate;
        
        pi_gen : for i in 0 to n-1 generate
            pi_out(i) <= theta_out((i*11) mod n);
        end generate;

        y <= pi_out xor key xor rc;
    end generate;
    
    last_true_gen : if last = true generate
        sbox_gen : for i in 0 to (n/4)-1 generate
            s4_gen : entity s4 port map(x(i*4 to i*4+3), sbox_out(i*4 to i*4+3));
        end generate;

        y <= sbox_out xor key xor rc;
    end generate;

   
end architecture;


