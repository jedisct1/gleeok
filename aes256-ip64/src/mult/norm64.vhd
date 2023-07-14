library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;               -- contains conversion functions
use work.all;


entity norm64 is  -- poly basis: irred x^128 + x^7 + x^2 + x + 1
  
  port (
    InxDI : in  std_logic_vector(127 downto 0);

    OpxDO : out std_logic_vector(63 downto 0) 
    );

end;



architecture norm of norm64 is

signal high : std_logic_vector(63 downto 0);  

begin


high <= InxDI(127 downto 64);


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

OpxDO(0) <= InxDI(0) xor high(63) xor high(61) xor high(60) xor high(0);
OpxDO(1) <= InxDI(1) xor high(63) xor high(62) xor high(60) xor high(1) xor high(0);
OpxDO(2) <= InxDI(2) xor high(63) xor high(61) xor high(2) xor high(1);
OpxDO(3) <= InxDI(3) xor high(63) xor high(62) xor high(61) xor high(60) xor high(3) xor high(2) xor high(0);
OpxDO(4) <= InxDI(4) xor high(62) xor high(60) xor high(4) xor high(3) xor high(1) xor high(0);
OpxDO(5) <= InxDI(5) xor high(63) xor high(61) xor high(5) xor high(4) xor high(2) xor high(1);
OpxDO(6) <= InxDI(6) xor high(62) xor high(6) xor high(5) xor high(3) xor high(2);
OpxDO(7) <= InxDI(7) xor high(63) xor high(7) xor high(6) xor high(4) xor high(3);
OpxDO(8) <= InxDI(8) xor high(8) xor high(7) xor high(5) xor high(4);
OpxDO(9) <= InxDI(9) xor high(9) xor high(8) xor high(6) xor high(5);
OpxDO(10) <= InxDI(10) xor high(10) xor high(9) xor high(7) xor high(6);
OpxDO(11) <= InxDI(11) xor high(11) xor high(10) xor high(8) xor high(7);
OpxDO(12) <= InxDI(12) xor high(12) xor high(11) xor high(9) xor high(8);
OpxDO(13) <= InxDI(13) xor high(13) xor high(12) xor high(10) xor high(9);
OpxDO(14) <= InxDI(14) xor high(14) xor high(13) xor high(11) xor high(10);
OpxDO(15) <= InxDI(15) xor high(15) xor high(14) xor high(12) xor high(11);
OpxDO(16) <= InxDI(16) xor high(16) xor high(15) xor high(13) xor high(12);
OpxDO(17) <= InxDI(17) xor high(17) xor high(16) xor high(14) xor high(13);
OpxDO(18) <= InxDI(18) xor high(18) xor high(17) xor high(15) xor high(14);
OpxDO(19) <= InxDI(19) xor high(19) xor high(18) xor high(16) xor high(15);
OpxDO(20) <= InxDI(20) xor high(20) xor high(19) xor high(17) xor high(16);
OpxDO(21) <= InxDI(21) xor high(21) xor high(20) xor high(18) xor high(17);
OpxDO(22) <= InxDI(22) xor high(22) xor high(21) xor high(19) xor high(18);
OpxDO(23) <= InxDI(23) xor high(23) xor high(22) xor high(20) xor high(19);
OpxDO(24) <= InxDI(24) xor high(24) xor high(23) xor high(21) xor high(20);
OpxDO(25) <= InxDI(25) xor high(25) xor high(24) xor high(22) xor high(21);
OpxDO(26) <= InxDI(26) xor high(26) xor high(25) xor high(23) xor high(22);
OpxDO(27) <= InxDI(27) xor high(27) xor high(26) xor high(24) xor high(23);
OpxDO(28) <= InxDI(28) xor high(28) xor high(27) xor high(25) xor high(24);
OpxDO(29) <= InxDI(29) xor high(29) xor high(28) xor high(26) xor high(25);
OpxDO(30) <= InxDI(30) xor high(30) xor high(29) xor high(27) xor high(26);
OpxDO(31) <= InxDI(31) xor high(31) xor high(30) xor high(28) xor high(27);
OpxDO(32) <= InxDI(32) xor high(32) xor high(31) xor high(29) xor high(28);
OpxDO(33) <= InxDI(33) xor high(33) xor high(32) xor high(30) xor high(29);
OpxDO(34) <= InxDI(34) xor high(34) xor high(33) xor high(31) xor high(30);
OpxDO(35) <= InxDI(35) xor high(35) xor high(34) xor high(32) xor high(31);
OpxDO(36) <= InxDI(36) xor high(36) xor high(35) xor high(33) xor high(32);
OpxDO(37) <= InxDI(37) xor high(37) xor high(36) xor high(34) xor high(33);
OpxDO(38) <= InxDI(38) xor high(38) xor high(37) xor high(35) xor high(34);
OpxDO(39) <= InxDI(39) xor high(39) xor high(38) xor high(36) xor high(35);
OpxDO(40) <= InxDI(40) xor high(40) xor high(39) xor high(37) xor high(36);
OpxDO(41) <= InxDI(41) xor high(41) xor high(40) xor high(38) xor high(37);
OpxDO(42) <= InxDI(42) xor high(42) xor high(41) xor high(39) xor high(38);
OpxDO(43) <= InxDI(43) xor high(43) xor high(42) xor high(40) xor high(39);
OpxDO(44) <= InxDI(44) xor high(44) xor high(43) xor high(41) xor high(40);
OpxDO(45) <= InxDI(45) xor high(45) xor high(44) xor high(42) xor high(41);
OpxDO(46) <= InxDI(46) xor high(46) xor high(45) xor high(43) xor high(42);
OpxDO(47) <= InxDI(47) xor high(47) xor high(46) xor high(44) xor high(43);
OpxDO(48) <= InxDI(48) xor high(48) xor high(47) xor high(45) xor high(44);
OpxDO(49) <= InxDI(49) xor high(49) xor high(48) xor high(46) xor high(45);
OpxDO(50) <= InxDI(50) xor high(50) xor high(49) xor high(47) xor high(46);
OpxDO(51) <= InxDI(51) xor high(51) xor high(50) xor high(48) xor high(47);
OpxDO(52) <= InxDI(52) xor high(52) xor high(51) xor high(49) xor high(48);
OpxDO(53) <= InxDI(53) xor high(53) xor high(52) xor high(50) xor high(49);
OpxDO(54) <= InxDI(54) xor high(54) xor high(53) xor high(51) xor high(50);
OpxDO(55) <= InxDI(55) xor high(55) xor high(54) xor high(52) xor high(51);
OpxDO(56) <= InxDI(56) xor high(56) xor high(55) xor high(53) xor high(52);
OpxDO(57) <= InxDI(57) xor high(57) xor high(56) xor high(54) xor high(53);
OpxDO(58) <= InxDI(58) xor high(58) xor high(57) xor high(55) xor high(54);
OpxDO(59) <= InxDI(59) xor high(59) xor high(58) xor high(56) xor high(55);
OpxDO(60) <= InxDI(60) xor high(60) xor high(59) xor high(57) xor high(56);
OpxDO(61) <= InxDI(61) xor high(61) xor high(60) xor high(58) xor high(57);
OpxDO(62) <= InxDI(62) xor high(62) xor high(61) xor high(59) xor high(58);
OpxDO(63) <= InxDI(63) xor high(63) xor high(62) xor high(60) xor high(59);



end architecture norm;

