library ieee;
use ieee.std_logic_1164.all;

entity mc_small is 
    port (mi : in std_logic_vector(31 downto 0);
          mo : out std_logic_vector(31 downto 0));
end entity;

architecture parallel of mc_small is

    signal t    : std_logic_vector(59 downto 0);
    signal x, y : std_logic_vector(31 downto 0);

begin

    x <= mi(7 downto 0) & mi(15 downto 8) & mi(23 downto 16) & mi(31 downto 24);

    t(0)  <= x(0)  xor x(8);
    t(1)  <= x(16) xor x(24);
    t(2)  <= x(1)  xor x(9);
    t(3)  <= x(17) xor x(25);
    t(4)  <= x(2)  xor x(10);
    t(5)  <= x(18) xor x(26);
    t(6)  <= x(3)  xor x(11);
    t(7)  <= x(19) xor x(27);
    t(8)  <= x(4)  xor x(12);
    t(9)  <= x(20) xor x(28);
    t(10) <= x(5)  xor x(13);
    t(11) <= x(21) xor x(29);
    t(12) <= x(6)  xor x(14);
    t(13) <= x(22) xor x(30);
    t(14) <= x(23) xor x(31);
    t(15) <= x(7)  xor x(15);
    t(16) <= x(8)  xor t(1);
    y(0)  <= t(15) xor t(16);
    t(17) <= x(7)  xor x(23);
    t(18) <= x(24) xor t(0);
    y(16) <= t(14) xor t(18);
    t(19) <= t(1)  xor y(16);
    y(24) <= t(17) xor t(19);
    t(20) <= x(27) xor t(14);
    t(21) <= t(0)  xor y(0);
    y(8)  <= t(17) xor t(21);
    t(22) <= t(5)  xor t(20);
    y(19) <= t(6)  xor t(22);
    t(23) <= x(11) xor t(15);
    t(24) <= t(7)  xor t(23);
    y(3)  <= t(4)  xor t(24);
    t(25) <= x(2)  xor x(18);
    t(26) <= t(17) xor t(25);
    t(27) <= t(9)  xor t(23);
    t(28) <= t(8)  xor t(20);
    t(29) <= x(10) xor t(2);
    y(2)  <= t(5)  xor t(29);
    t(30) <= x(26) xor t(3);
    y(18) <= t(4)  xor t(30);
    t(31) <= x(9)  xor x(25);
    t(32) <= t(25) xor t(31);
    y(10) <= t(30) xor t(32);
    y(26) <= t(29) xor t(32);
    t(33) <= x(1)  xor t(18);
    t(34) <= x(30) xor t(11);
    y(22) <= t(12) xor t(34);
    t(35) <= x(14) xor t(13);
    y(6)  <= t(10) xor t(35);
    t(36) <= x(5)  xor x(21);
    t(37) <= x(30) xor t(17);
    t(38) <= x(17) xor t(16);
    t(39) <= x(13) xor t(8);
    y(5)  <= t(11) xor t(39);
    t(40) <= x(12) xor t(36);
    t(41) <= x(29) xor t(9);
    y(21) <= t(10) xor t(41);
    t(42) <= x(28) xor t(40);
    y(13) <= t(41) xor t(42);
    y(29) <= t(39) xor t(42);
    t(43) <= x(15) xor t(12);
    y(7)  <= t(14) xor t(43);
    t(44) <= x(14) xor t(37);
    y(31) <= t(43) xor t(44);
    t(45) <= x(31) xor t(13);
    y(15) <= t(44) xor t(45);
    y(23) <= t(15) xor t(45);
    t(46) <= t(12) xor t(36);
    y(14) <= y(6)  xor t(46);
    t(47) <= t(31) xor t(33);
    y(17) <= t(19) xor t(47);
    t(48) <= t(6)  xor y(3);
    y(11) <= t(26) xor t(48);
    t(49) <= t(2)  xor t(38);
    y(25) <= y(24) xor t(49);
    t(50) <= t(7)  xor y(19);
    y(27) <= t(26) xor t(50);
    t(51) <= x(22) xor t(46);
    y(30) <= t(11) xor t(51);
    t(52) <= x(19) xor t(28);
    y(20) <= x(28) xor t(52);
    t(53) <= x(3)  xor t(27);
    y(4)  <= x(12) xor t(53);
    t(54) <= t(3)  xor t(33);
    y(9)  <= y(8)  xor t(54);
    t(55) <= t(21) xor t(31);
    y(1)  <= t(38) xor t(55);
    t(56) <= x(4)  xor t(17);
    t(57) <= x(19) xor t(56);
    y(12) <= t(27) xor t(57);
    t(58) <= x(3)  xor t(28);
    t(59) <= t(17) xor t(58);
    y(28) <= x(20) xor t(59);

    mo <= y(7 downto 0) & y(15 downto 8) & y(23 downto 16) & y(31 downto 24);

end architecture;

