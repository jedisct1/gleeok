library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;               -- contains conversion functions
use work.all;


entity normalize is  -- poly basis: irred x^128 + x^7 + x^2 + x + 1
  
  port (
    InxDI : in  std_logic_vector(255 downto 0);

    OpxDO : out std_logic_vector(127 downto 0) 
    );

end normalize;



architecture norm of normalize is

signal high : std_logic_vector(127 downto 0);  

begin


high <= InxDI(255 downto 128);


--OpxDO(0) <= InxDI(0) xor high(0) xor high(121)  xor high(126) xor high(127);
--OpxDO(1) <= InxDI(1) xor high(0) xor high(1) xor high(121)  xor high(122) xor high(126);
--
-- 
--
--
--l1: for i in 2 to 3 generate 
--OpxDO(i) <= InxDI(i) xor  high(i-2) xor high(i-1) xor high(i)  xor high(i+119) xor high(i+120) xor high(i+121) xor high(i+124);
--end generate l1;
--
--l2: for i in 4 to 6 generate 
--OpxDO(i) <=  InxDI(i) xor high(i-2) xor high(i-1) xor high(i)  xor high(i+119) xor high(i+120) xor high(i+121) ;
--end generate l2;
--
--
--l3: for i in 7 to 13 generate 
--OpxDO(i) <=  InxDI(i) xor high(i-7) xor high(i-2) xor high(i-1)  xor high(i) xor high(i+114);
--end generate l3;
--
--
--
--l4: for i in 14 to 127 generate 
--OpxDO(i) <=  InxDI(i) xor high(i-7) xor high(i-2) xor high(i-1)  xor high(i);
--end generate l4;

OpxDO(0) <= InxDI(0) xor high(127) xor high(126) xor high(121) xor high(0);
OpxDO(1) <= InxDI(1) xor high(126) xor high(122) xor high(121) xor high(1) xor high(0);
OpxDO(2) <= InxDI(2) xor high(126) xor high(123) xor high(122) xor high(121) xor high(2) xor high(1) xor high(0);
OpxDO(3) <= InxDI(3) xor high(127) xor high(124) xor high(123) xor high(122) xor high(3) xor high(2) xor high(1);
OpxDO(4) <= InxDI(4) xor high(125) xor high(124) xor high(123) xor high(4) xor high(3) xor high(2);
OpxDO(5) <= InxDI(5) xor high(126) xor high(125) xor high(124) xor high(5) xor high(4) xor high(3);
OpxDO(6) <= InxDI(6) xor high(127) xor high(126) xor high(125) xor high(6) xor high(5) xor high(4);
OpxDO(7) <= InxDI(7) xor high(121) xor high(7) xor high(6) xor high(5) xor high(0);
OpxDO(8) <= InxDI(8) xor high(122) xor high(8) xor high(7) xor high(6) xor high(1);
OpxDO(9) <= InxDI(9) xor high(123) xor high(9) xor high(8) xor high(7) xor high(2);
OpxDO(10) <= InxDI(10) xor high(124) xor high(10) xor high(9) xor high(8) xor high(3);
OpxDO(11) <= InxDI(11) xor high(125) xor high(11) xor high(10) xor high(9) xor high(4);
OpxDO(12) <= InxDI(12) xor high(126) xor high(12) xor high(11) xor high(10) xor high(5);
OpxDO(13) <= InxDI(13) xor high(127) xor high(13) xor high(12) xor high(11) xor high(6);
OpxDO(14) <= InxDI(14) xor high(14) xor high(13) xor high(12) xor high(7);
OpxDO(15) <= InxDI(15) xor high(15) xor high(14) xor high(13) xor high(8);
OpxDO(16) <= InxDI(16) xor high(16) xor high(15) xor high(14) xor high(9);
OpxDO(17) <= InxDI(17) xor high(17) xor high(16) xor high(15) xor high(10);
OpxDO(18) <= InxDI(18) xor high(18) xor high(17) xor high(16) xor high(11);
OpxDO(19) <= InxDI(19) xor high(19) xor high(18) xor high(17) xor high(12);
OpxDO(20) <= InxDI(20) xor high(20) xor high(19) xor high(18) xor high(13);
OpxDO(21) <= InxDI(21) xor high(21) xor high(20) xor high(19) xor high(14);
OpxDO(22) <= InxDI(22) xor high(22) xor high(21) xor high(20) xor high(15);
OpxDO(23) <= InxDI(23) xor high(23) xor high(22) xor high(21) xor high(16);
OpxDO(24) <= InxDI(24) xor high(24) xor high(23) xor high(22) xor high(17);
OpxDO(25) <= InxDI(25) xor high(25) xor high(24) xor high(23) xor high(18);
OpxDO(26) <= InxDI(26) xor high(26) xor high(25) xor high(24) xor high(19);
OpxDO(27) <= InxDI(27) xor high(27) xor high(26) xor high(25) xor high(20);
OpxDO(28) <= InxDI(28) xor high(28) xor high(27) xor high(26) xor high(21);
OpxDO(29) <= InxDI(29) xor high(29) xor high(28) xor high(27) xor high(22);
OpxDO(30) <= InxDI(30) xor high(30) xor high(29) xor high(28) xor high(23);
OpxDO(31) <= InxDI(31) xor high(31) xor high(30) xor high(29) xor high(24);
OpxDO(32) <= InxDI(32) xor high(32) xor high(31) xor high(30) xor high(25);
OpxDO(33) <= InxDI(33) xor high(33) xor high(32) xor high(31) xor high(26);
OpxDO(34) <= InxDI(34) xor high(34) xor high(33) xor high(32) xor high(27);
OpxDO(35) <= InxDI(35) xor high(35) xor high(34) xor high(33) xor high(28);
OpxDO(36) <= InxDI(36) xor high(36) xor high(35) xor high(34) xor high(29);
OpxDO(37) <= InxDI(37) xor high(37) xor high(36) xor high(35) xor high(30);
OpxDO(38) <= InxDI(38) xor high(38) xor high(37) xor high(36) xor high(31);
OpxDO(39) <= InxDI(39) xor high(39) xor high(38) xor high(37) xor high(32);
OpxDO(40) <= InxDI(40) xor high(40) xor high(39) xor high(38) xor high(33);
OpxDO(41) <= InxDI(41) xor high(41) xor high(40) xor high(39) xor high(34);
OpxDO(42) <= InxDI(42) xor high(42) xor high(41) xor high(40) xor high(35);
OpxDO(43) <= InxDI(43) xor high(43) xor high(42) xor high(41) xor high(36);
OpxDO(44) <= InxDI(44) xor high(44) xor high(43) xor high(42) xor high(37);
OpxDO(45) <= InxDI(45) xor high(45) xor high(44) xor high(43) xor high(38);
OpxDO(46) <= InxDI(46) xor high(46) xor high(45) xor high(44) xor high(39);
OpxDO(47) <= InxDI(47) xor high(47) xor high(46) xor high(45) xor high(40);
OpxDO(48) <= InxDI(48) xor high(48) xor high(47) xor high(46) xor high(41);
OpxDO(49) <= InxDI(49) xor high(49) xor high(48) xor high(47) xor high(42);
OpxDO(50) <= InxDI(50) xor high(50) xor high(49) xor high(48) xor high(43);
OpxDO(51) <= InxDI(51) xor high(51) xor high(50) xor high(49) xor high(44);
OpxDO(52) <= InxDI(52) xor high(52) xor high(51) xor high(50) xor high(45);
OpxDO(53) <= InxDI(53) xor high(53) xor high(52) xor high(51) xor high(46);
OpxDO(54) <= InxDI(54) xor high(54) xor high(53) xor high(52) xor high(47);
OpxDO(55) <= InxDI(55) xor high(55) xor high(54) xor high(53) xor high(48);
OpxDO(56) <= InxDI(56) xor high(56) xor high(55) xor high(54) xor high(49);
OpxDO(57) <= InxDI(57) xor high(57) xor high(56) xor high(55) xor high(50);
OpxDO(58) <= InxDI(58) xor high(58) xor high(57) xor high(56) xor high(51);
OpxDO(59) <= InxDI(59) xor high(59) xor high(58) xor high(57) xor high(52);
OpxDO(60) <= InxDI(60) xor high(60) xor high(59) xor high(58) xor high(53);
OpxDO(61) <= InxDI(61) xor high(61) xor high(60) xor high(59) xor high(54);
OpxDO(62) <= InxDI(62) xor high(62) xor high(61) xor high(60) xor high(55);
OpxDO(63) <= InxDI(63) xor high(63) xor high(62) xor high(61) xor high(56);
OpxDO(64) <= InxDI(64) xor high(64) xor high(63) xor high(62) xor high(57);
OpxDO(65) <= InxDI(65) xor high(65) xor high(64) xor high(63) xor high(58);
OpxDO(66) <= InxDI(66) xor high(66) xor high(65) xor high(64) xor high(59);
OpxDO(67) <= InxDI(67) xor high(67) xor high(66) xor high(65) xor high(60);
OpxDO(68) <= InxDI(68) xor high(68) xor high(67) xor high(66) xor high(61);
OpxDO(69) <= InxDI(69) xor high(69) xor high(68) xor high(67) xor high(62);
OpxDO(70) <= InxDI(70) xor high(70) xor high(69) xor high(68) xor high(63);
OpxDO(71) <= InxDI(71) xor high(71) xor high(70) xor high(69) xor high(64);
OpxDO(72) <= InxDI(72) xor high(72) xor high(71) xor high(70) xor high(65);
OpxDO(73) <= InxDI(73) xor high(73) xor high(72) xor high(71) xor high(66);
OpxDO(74) <= InxDI(74) xor high(74) xor high(73) xor high(72) xor high(67);
OpxDO(75) <= InxDI(75) xor high(75) xor high(74) xor high(73) xor high(68);
OpxDO(76) <= InxDI(76) xor high(76) xor high(75) xor high(74) xor high(69);
OpxDO(77) <= InxDI(77) xor high(77) xor high(76) xor high(75) xor high(70);
OpxDO(78) <= InxDI(78) xor high(78) xor high(77) xor high(76) xor high(71);
OpxDO(79) <= InxDI(79) xor high(79) xor high(78) xor high(77) xor high(72);
OpxDO(80) <= InxDI(80) xor high(80) xor high(79) xor high(78) xor high(73);
OpxDO(81) <= InxDI(81) xor high(81) xor high(80) xor high(79) xor high(74);
OpxDO(82) <= InxDI(82) xor high(82) xor high(81) xor high(80) xor high(75);
OpxDO(83) <= InxDI(83) xor high(83) xor high(82) xor high(81) xor high(76);
OpxDO(84) <= InxDI(84) xor high(84) xor high(83) xor high(82) xor high(77);
OpxDO(85) <= InxDI(85) xor high(85) xor high(84) xor high(83) xor high(78);
OpxDO(86) <= InxDI(86) xor high(86) xor high(85) xor high(84) xor high(79);
OpxDO(87) <= InxDI(87) xor high(87) xor high(86) xor high(85) xor high(80);
OpxDO(88) <= InxDI(88) xor high(88) xor high(87) xor high(86) xor high(81);
OpxDO(89) <= InxDI(89) xor high(89) xor high(88) xor high(87) xor high(82);
OpxDO(90) <= InxDI(90) xor high(90) xor high(89) xor high(88) xor high(83);
OpxDO(91) <= InxDI(91) xor high(91) xor high(90) xor high(89) xor high(84);
OpxDO(92) <= InxDI(92) xor high(92) xor high(91) xor high(90) xor high(85);
OpxDO(93) <= InxDI(93) xor high(93) xor high(92) xor high(91) xor high(86);
OpxDO(94) <= InxDI(94) xor high(94) xor high(93) xor high(92) xor high(87);
OpxDO(95) <= InxDI(95) xor high(95) xor high(94) xor high(93) xor high(88);
OpxDO(96) <= InxDI(96) xor high(96) xor high(95) xor high(94) xor high(89);
OpxDO(97) <= InxDI(97) xor high(97) xor high(96) xor high(95) xor high(90);
OpxDO(98) <= InxDI(98) xor high(98) xor high(97) xor high(96) xor high(91);
OpxDO(99) <= InxDI(99) xor high(99) xor high(98) xor high(97) xor high(92);
OpxDO(100) <= InxDI(100) xor high(100) xor high(99) xor high(98) xor high(93);
OpxDO(101) <= InxDI(101) xor high(101) xor high(100) xor high(99) xor high(94);
OpxDO(102) <= InxDI(102) xor high(102) xor high(101) xor high(100) xor high(95);
OpxDO(103) <= InxDI(103) xor high(103) xor high(102) xor high(101) xor high(96);
OpxDO(104) <= InxDI(104) xor high(104) xor high(103) xor high(102) xor high(97);
OpxDO(105) <= InxDI(105) xor high(105) xor high(104) xor high(103) xor high(98);
OpxDO(106) <= InxDI(106) xor high(106) xor high(105) xor high(104) xor high(99);
OpxDO(107) <= InxDI(107) xor high(107) xor high(106) xor high(105) xor high(100);
OpxDO(108) <= InxDI(108) xor high(108) xor high(107) xor high(106) xor high(101);
OpxDO(109) <= InxDI(109) xor high(109) xor high(108) xor high(107) xor high(102);
OpxDO(110) <= InxDI(110) xor high(110) xor high(109) xor high(108) xor high(103);
OpxDO(111) <= InxDI(111) xor high(111) xor high(110) xor high(109) xor high(104);
OpxDO(112) <= InxDI(112) xor high(112) xor high(111) xor high(110) xor high(105);
OpxDO(113) <= InxDI(113) xor high(113) xor high(112) xor high(111) xor high(106);
OpxDO(114) <= InxDI(114) xor high(114) xor high(113) xor high(112) xor high(107);
OpxDO(115) <= InxDI(115) xor high(115) xor high(114) xor high(113) xor high(108);
OpxDO(116) <= InxDI(116) xor high(116) xor high(115) xor high(114) xor high(109);
OpxDO(117) <= InxDI(117) xor high(117) xor high(116) xor high(115) xor high(110);
OpxDO(118) <= InxDI(118) xor high(118) xor high(117) xor high(116) xor high(111);
OpxDO(119) <= InxDI(119) xor high(119) xor high(118) xor high(117) xor high(112);
OpxDO(120) <= InxDI(120) xor high(120) xor high(119) xor high(118) xor high(113);
OpxDO(121) <= InxDI(121) xor high(121) xor high(120) xor high(119) xor high(114);
OpxDO(122) <= InxDI(122) xor high(122) xor high(121) xor high(120) xor high(115);
OpxDO(123) <= InxDI(123) xor high(123) xor high(122) xor high(121) xor high(116);
OpxDO(124) <= InxDI(124) xor high(124) xor high(123) xor high(122) xor high(117);
OpxDO(125) <= InxDI(125) xor high(125) xor high(124) xor high(123) xor high(118);
OpxDO(126) <= InxDI(126) xor high(126) xor high(125) xor high(124) xor high(119);
OpxDO(127) <= InxDI(127) xor high(127) xor high(126) xor high(125) xor high(120);



end architecture norm;

