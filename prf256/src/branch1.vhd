library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use work.prf256_pkg.all;

entity branch1 is
    generic (last : boolean := false);
    port (x   : in std_logic_vector(0 to n-1);
          key : in std_logic_vector(0 to n-1);
          rc  : in std_logic_vector(0 to n-1);
          y   : out std_logic_vector(0 to n-1));
end entity;

architecture parallel of branch1 is

    signal pre_out, sbox_out, theta_out, pi_out : std_logic_vector(0 to n-1);

begin

    pre_gen : for i in 0 to n-1 generate
        pre_out(i) <= x((i*41) mod n); 
    end generate;

    last_false_gen : if last = false generate
        sbox_gen : for i in 0 to (n/8)-1 generate
            s3_gen : entity s3 port map(pre_out(i*8 to i*8+2), sbox_out(i*8 to i*8+2));
            s5_gen : entity s5 port map(pre_out(i*8+3 to i*8+7), sbox_out(i*8+3 to i*8+7));
        end generate;

        theta_gen : for i in 0 to n-1 generate
        theta_out(i) <= sbox_out((i+2) mod n) xor sbox_out((i+90) mod n) xor sbox_out((i+179) mod n);
        end generate;
        
        pi_gen : for i in 0 to n-1 generate
            pi_out(i) <= theta_out((i*85) mod n);
        end generate;

        y <= pi_out xor key xor rc;
    end generate;
    
    last_true_gen : if last = true generate
        sbox_gen : for i in 0 to (n/8)-1 generate
            s3_gen : entity s3 port map(pre_out(i*8 to i*8+2), sbox_out(i*8 to i*8+2));
            s5_gen : entity s5 port map(pre_out(i*8+3 to i*8+7), sbox_out(i*8+3 to i*8+7));
        end generate;

        y <= sbox_out xor key xor rc;
    end generate;

   
end architecture;


