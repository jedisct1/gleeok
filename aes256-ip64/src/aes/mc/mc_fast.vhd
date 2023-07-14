library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.all;

entity mc_fast is 
    port ( mi : in std_logic_vector (31 downto 0);
           mo : out std_logic_vector (31 downto 0));
end entity;

architecture parallel of mc_fast is
      
    signal t: std_logic_vector (103 downto 1);
    signal x_pre, y_post, x, y : std_logic_vector(31 downto 0);
             
    subtype Int5 is integer range 0 to 127;
    type Int5array is array (0 to 31) of Int5;
    constant PT : Int5array := (26, 8, 22, 13, 6, 3, 15, 9, 21, 11, 12, 5, 4, 27, 25, 16, 14, 19, 20, 18, 29, 28, 0, 30, 10, 1, 17, 31, 2, 23, 24, 7);
    constant QT : Int5array := (26, 23, 1, 10, 3, 14, 5, 0, 9, 6, 24, 20, 15, 31, 22, 4, 28, 17, 27, 19, 7, 16, 11, 8, 13, 25, 18, 30, 21, 29, 12, 2);
    constant Ypos : Int5array := (50, 37, 73, 28, 67, 79, 26, 32, 61, 92, 99, 62, 76, 95, 41, 47, 64, 89, 85, 43, 30, 103, 35, 56, 82, 53, 70, 20, 39, 24, 45, 22);
begin 

    gen0: for i in 0 to 31 generate
       x(QT(i)) <= mi(31-i);
       mo(31 - PT(i)) <= y(i);
       y(i) <= t(Ypos(i));
    end generate gen0;

    t(1) <= x(9) xor x(26);
    t(2) <= x(13) xor x(28);
    t(3) <= x(9) xor x(28);
    t(4) <= x(13) xor x(26);
    t(5) <= x(0) xor x(2);
    t(6) <= x(4) xor x(8);
    t(7) <= x(6) xor x(17);
    t(8) <= x(1) xor x(18);
    t(9) <= x(23) xor x(25);
    t(10) <= x(24) xor x(27);
    t(11) <= x(5) xor x(12);
    t(12) <= x(14) xor x(31);
    t(13) <= x(10) xor x(20);
    t(14) <= x(7) xor x(21);
    t(15) <= x(11) xor x(22);
    t(16) <= x(16) xor x(29);
    t(17) <= x(19) xor x(30);
    t(18) <= x(3) xor x(15);
    t(19) <= x(0) xor t(4);
    t(20) <= t(6) xor t(19);
    t(21) <= x(2) xor t(1);
    t(22) <= t(6) xor t(21);
    t(23) <= x(4) xor t(2);
    t(24) <= t(5) xor t(23);
    t(25) <= x(8) xor t(3);
    t(26) <= t(5) xor t(25);
    t(27) <= x(14) xor t(15);
    t(28) <= t(16) xor t(27);
    t(29) <= x(16) xor t(11);
    t(30) <= t(12) xor t(29);
    t(31) <= x(17) xor t(9);
    t(32) <= t(10) xor t(31);
    t(33) <= x(9) xor x(23);
    t(34) <= x(6) xor t(2);
    t(35) <= t(33) xor t(34);
    t(36) <= x(17) xor x(26);
    t(37) <= t(34) xor t(36);
    t(38) <= x(18) xor t(10);
    t(39) <= t(13) xor t(38);
    t(40) <= x(23) xor t(7);
    t(41) <= t(8) xor t(40);
    t(42) <= x(24) xor t(8);
    t(43) <= t(17) xor t(42);
    t(44) <= x(26) xor t(3);
    t(45) <= t(9) xor t(44);
    t(46) <= t(4) xor t(33);
    t(47) <= t(31) xor t(46);
    t(48) <= x(1) xor x(10);
    t(49) <= x(30) xor t(10);
    t(50) <= t(48) xor t(49);
    t(51) <= x(1) xor x(24);
    t(52) <= x(25) xor t(7);
    t(53) <= t(51) xor t(52);
    t(54) <= x(2) xor x(5);
    t(55) <= t(15) xor t(54);
    t(56) <= t(19) xor t(55);
    t(57) <= x(4) xor x(11);
    t(58) <= x(12) xor x(22);
    t(59) <= x(29) xor x(31);
    t(60) <= t(58) xor t(59);
    t(61) <= t(27) xor t(60);
    t(62) <= t(29) xor t(60);
    t(63) <= t(11) xor t(57);
    t(64) <= t(25) xor t(63);
    t(65) <= x(0) xor t(1);
    t(66) <= t(57) xor t(58);
    t(67) <= t(65) xor t(66);
    t(68) <= x(6) xor x(18);
    t(69) <= x(27) xor t(9);
    t(70) <= t(68) xor t(69);
    t(71) <= x(8) xor t(2);
    t(72) <= t(54) xor t(58);
    t(73) <= t(71) xor t(72);
    t(74) <= x(15) xor t(1);
    t(75) <= t(12) xor t(14);
    t(76) <= t(74) xor t(75);
    t(77) <= x(3) xor x(20);
    t(78) <= t(17) xor t(77);
    t(79) <= t(74) xor t(78);
    t(80) <= x(19) xor x(20);
    t(81) <= x(27) xor t(8);
    t(82) <= t(80) xor t(81);
    t(83) <= x(21) xor t(2);
    t(84) <= t(16) xor t(18);
    t(85) <= t(83) xor t(84);
    t(86) <= x(7) xor x(30);
    t(87) <= x(10) xor x(19);
    t(88) <= t(13) xor t(86);
    t(89) <= t(83) xor t(88);
    t(90) <= x(15) xor t(3);
    t(91) <= t(86) xor t(87);
    t(92) <= t(90) xor t(91);
    t(93) <= x(21) xor t(4);
    t(94) <= t(77) xor t(87);
    t(95) <= t(93) xor t(94);
    t(96) <= x(3) xor x(16);
    t(97) <= x(31) xor t(3);
    t(98) <= t(14) xor t(96);
    t(99) <= t(97) xor t(98);
    t(100) <= x(7) xor x(14);
    t(101) <= x(29) xor t(4);
    t(102) <= t(18) xor t(100);
    t(103) <= t(101) xor t(102);

end architecture;

