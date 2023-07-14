library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

library work;
use work.all;
use work.prf256_pkg.all;

entity prf256_tb is

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

architecture test of prf256_tb is

    -- Input signals.
    signal clk   : std_logic := '0';
    signal reset : std_logic;

    signal start : std_logic;
    signal done  : std_logic;

    signal input  : std_logic_vector(0 to n-1);
    signal key    : std_logic_vector(0 to k-1);
    signal output : std_logic_vector(0 to n-1);
    
    constant clk_period   : time := 100 ns;

begin

    uut : entity work.prf256
        port map (clk    => clk,
                  input  => input,
		  key    => key,
                  output => output);

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

        variable vec_id     : integer;
        variable vec_input  : std_logic_vector(0 to n-1);
        variable vec_key    : std_logic_vector(0 to k-1);
        variable vec_output : std_logic_vector(0 to n-1);
        
        file test_vectors : text;
        
        procedure run(constant v_input  : in std_logic_vector(0 to n-1);
	              constant v_key    : in std_logic_vector(0 to k-1);
                      constant v_output : in std_logic_vector(0 to n-1)) is
	    begin
	    input <= v_input;
	    key   <= v_key;
            
	    wait for clk_period;
                
            assert vector_equal(output, v_output) report "wrong tag" severity failure;

	    wait for clk_period;
	    	
        end procedure run;
        
    begin
        file_open(test_vectors, "../test/vectors_short.txt", read_mode);

        while not endfile(test_vectors) loop
        --for z in 1 to 1 loop
                
	    readline(test_vectors, vec_line); read(vec_line, vec_id); 
                
            readline(test_vectors, vec_line);
            hread(vec_line, vec_input);
            readline(test_vectors, vec_line);
            hread(vec_line, vec_key);
            readline(test_vectors, vec_line);
            hread(vec_line, vec_output);

            report "vector: " & integer'image(vec_id);

            run(vec_input, vec_key, vec_output);

        end loop;

        file_close(test_vectors);

        assert false report "test passed" severity failure;

    end process;

end architecture;

