library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

library work;
use work.all;
use work.aes256_pkg.all;

entity aes256_ip64_tb is

    function vector_equal(a, b : std_logic_vector) return boolean is
    begin
        for i in 0 to a'length-1 loop
            if a(i) /= b(i) then
                return false;
            end if;
        end loop;
        return true;
    end function;

end entity;

architecture test of aes256_ip64_tb is

    -- Input signals.
    signal clk   : std_logic := '0';
    signal reset : std_logic;

    signal start : std_logic;
    signal done  : std_logic;

    signal nonce  : std_logic_vector(0 to 95);
    signal key    : std_logic_vector(0 to 255);
    signal hk0    : std_logic_vector(0 to 127);
    signal hk1    : std_logic_vector(0 to 127);
    signal msg    : std_logic_vector(0 to 127);
    signal ct     : std_logic_vector(0 to 127);
    signal tag    : std_logic_vector(0 to 127);
    
    constant clk_period   : time := 100 ns;

begin

    uut : entity work.aes256_ip64_128
        port map (clk   => clk,
	          nonce => nonce,
		  key   => key,
		  hk0   => hk0,
		  hk1   => hk1,
		  msg   => msg,
                  ct    => ct,
	          tag   => tag);

    clk_process : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
    
    test : process
        variable vec_line  : line;
        variable vec_space : character;

        variable vec_id    : integer;
        variable vec_nonce : std_logic_vector(0 to 95);
        variable vec_key   : std_logic_vector(0 to 255);
        variable vec_hk0   : std_logic_vector(0 to 127);
        variable vec_hk1   : std_logic_vector(0 to 127);
        variable vec_msg   : std_logic_vector(0 to 127);
        variable vec_ct    : std_logic_vector(0 to 127);
        variable vec_tag   : std_logic_vector(0 to 127);
        
        file test_vectors : text;
        
        procedure run(variable v_nonce : std_logic_vector(0 to 95);
                      variable v_key   : std_logic_vector(0 to 255);
                      variable v_hk0   : std_logic_vector(0 to 127);
                      variable v_hk1   : std_logic_vector(0 to 127);
                      variable v_msg   : std_logic_vector(0 to 127);
                      variable v_ct    : std_logic_vector(0 to 127);
	              variable v_tag   : std_logic_vector(0 to 127)) is
	    begin
	    
            nonce <= v_nonce;
	    key   <= v_key;
	    hk0   <= v_hk0;
	    hk1   <= v_hk1;
	    msg   <= v_msg;
            
	    wait for clk_period;
                
            assert vector_equal(tag, v_tag) report "wrong tag" severity failure;

	    wait for clk_period;
	    	
        end procedure run;
        
    begin
        file_open(test_vectors, "../test/vectors_128_dec.txt", read_mode);

        while not endfile(test_vectors) loop
        --for z in 1 to 20 loop
                
	    readline(test_vectors, vec_line); read(vec_line, vec_id); 
                
            readline(test_vectors, vec_line);
            hread(vec_line, vec_nonce);
            readline(test_vectors, vec_line);
            hread(vec_line, vec_key);
            readline(test_vectors, vec_line);
            hread(vec_line, vec_hk0);
            readline(test_vectors, vec_line);
            hread(vec_line, vec_hk1);
            readline(test_vectors, vec_line);
            hread(vec_line, vec_msg);
            readline(test_vectors, vec_line);
            hread(vec_line, vec_ct);
            readline(test_vectors, vec_line);
            hread(vec_line, vec_tag);

            report "vector: " & integer'image(vec_id);

            run(vec_nonce, vec_key, vec_hk0, vec_hk1, vec_msg, vec_ct, vec_tag);

        end loop;

        file_close(test_vectors);

        assert false report "test passed" severity failure;

    end process;

end architecture;

