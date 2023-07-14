library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;
 

entity encoder is
port ( InpxDI : in  std_logic_vector(255 downto 0); 
 
       OupxDO : out std_logic_vector(7 downto 0));
end entity encoder;

architecture structural of encoder is 

signal PoutxD : std_logic_vector (255 downto 0);

signal E1xD,F1xD: std_logic_vector (63 downto 0);


signal G1xD,E2xD,F2xD,GF2xD               : std_logic_vector(31 downto 0);

signal H1xD,E3xD,F3xD,GF3xD,HF2xD,HGF3xD               : std_logic_vector(15 downto 0);

signal I1xD,E4xD,F4xD,GF4xD,HGF4xD,IF2xD,IGF3xD,IHGF4xD           : std_logic_vector(7 downto 0);

signal J1xD,E5xD,F5xD,GF5xD,HGF5xD,IHGF5xD,JF2xD,JGF3xD,JHGF4xD,JIHGF5xD              : std_logic_vector(3 downto 0);

signal K1xD,E6xD,F6xD,GF6xD,HGF6xD,IHGF6xD,JIHGF6xD,KF2xD,KGF3xD,KHGF4xD,KIHGF5xD,KJIHGF6xD             : std_logic_vector(1 downto 0);

signal L1xD,LF2xD,LGF3xD,LHGF4xD,LIHGF5xD,LJIHGF6xD               : std_logic;


begin

PoutxD <= InpxDI;




l_loop : for l in 0 to 63 generate 
  
E1xD(l) <= PoutxD(4*l + 1) and PoutxD(4*l + 3);
F1xD(l) <= PoutxD(4*l + 2) and PoutxD(4*l + 3);

end generate l_loop;

m_loop : for m in 0 to 31 generate 
  
G1xD(m) <= PoutxD(8*m + 4) and PoutxD(8*m + 5);
 

end generate m_loop;

n_loop : for n in 0 to 15 generate 
  
H1xD(n) <= PoutxD(16*n + 8) and PoutxD(16*n + 9);
 

end generate n_loop;

o_loop : for o in 0 to 7 generate 
  
I1xD(o) <= PoutxD(32*o + 16) and PoutxD(32*o + 17);
 

end generate o_loop;

p_loop : for p in 0 to 3 generate 
  
J1xD(p) <= PoutxD(64*p + 32) and PoutxD(64*p + 33);
 

end generate p_loop;

q_loop : for q in 0 to 1 generate 
  
K1xD(q) <= PoutxD(128*q + 64) and PoutxD(128*q + 65);
 

end generate q_loop;

L1xD <= PoutxD(128) and PoutxD(129);


r_loop : for r in 0 to 31 generate 

E2xD(r) <= E1xD(2*r) and E1xD (2*r+1);
F2xD(r) <= F1xD(2*r) and F1xD (2*r+1);
GF2xD(r) <= G1xD(r) and F1xD (2*r+1);

end generate r_loop;

s_loop : for s in 0 to 15 generate 

E3xD(s) <= E2xD(2*s) and E2xD (2*s+1);
F3xD(s) <= F2xD(2*s) and F2xD (2*s+1);
HF2xD(s) <= H1xD(s) and F1xD (4*s+2);

GF3xD(s) <= GF2xD(2*s) and GF2xD(2*s+1);

HGF3xD(s) <= HF2xD(s) and GF2xD(2*s+1);





end generate s_loop;


t_loop : for t in 0 to 7 generate 

E4xD(t) <= E3xD(2*t) and E3xD (2*t+1);
F4xD(t) <= F3xD(2*t) and F3xD (2*t+1);
IF2xD(t) <= I1xD(t) and F1xD(8*t+4);

GF4xD(t) <= GF3xD(2*t) and GF3xD(2*t+1);
HGF4xD(t) <= HGF3xD(2*t) and HGF3xD(2*t+1);

IGF3xD(t) <= IF2xD(t) and GF2xD(4*t+2);

IHGF4xD(t) <= IGF3xD(t) and HGF3xD(2*t+1);



end generate t_loop;

u_loop : for u in 0 to 3 generate 

E5xD(u) <= E4xD(2*u) and E4xD (2*u+1);
F5xD(u) <= F4xD(2*u) and F4xD (2*u+1);
JF2xD(u) <= J1xD(u) and F1xD(16*u+8);

GF5xD(u) <= GF4xD(2*u) and GF4xD (2*u+1);
HGF5xD(u) <= HGF4xD(2*u) and HGF4xD (2*u+1);

JGF3xD(u) <= JF2xD(u) and GF2xD(8*u+4);
JHGF4xD(u) <= JGF3xD(u) and HGF3xD(4*u+2);
JIHGF5xD(u) <= JHGF4xD(u) and IHGF4xD(2*u+1);

IHGF5xD(u) <= IHGF4xD(2*u) and IHGF4xD (2*u+1);

end generate u_loop;



v_loop : for v in 0 to 1 generate 

E6xD(v) <= E5xD(2*v) and E5xD (2*v+1);
F6xD(v) <= F5xD(2*v) and F5xD (2*v+1);
KF2xD(v) <= K1xD(v) and F1xD(32*v+16);

GF6xD(v) <= GF5xD(2*v) and GF5xD (2*v+1);
HGF6xD(v) <= HGF5xD(2*v) and HGF5xD (2*v+1);
IHGF6xD(v) <= IHGF5xD(2*v) and IHGF5xD (2*v+1);
JIHGF6xD(v) <= JIHGF5xD(2*v) and JIHGF5xD(2*v+1);

KGF3xD(v) <= KF2xD(v) and GF2xD(16*v+8);
KHGF4xD(v) <= KGF3xD(v) and HGF3xD(8*v+4);
KIHGF5xD(v) <= KHGF4xD(v) and IHGF4xD(4*v+2);
KJIHGF6xD(v) <= KIHGF5xD(v) and JIHGF5xD(2*v+1);

end generate v_loop;

OupxDO(0) <= E6xD(0) nand E6xD(1);
OupxDO(1) <= F6xD(0) nand F6xD(1);
OupxDO(2) <= GF6xD(0) nand GF6xD(1);
OupxDO(3) <= HGF6xD(0) nand HGF6xD(1);
OupxDO(4) <= IHGF6xD(0) nand IHGF6xD(1);
OupxDO(5) <= JIHGF6xD(0) nand JIHGF6xD(1);
OupxDO(6) <= KJIHGF6xD(0) nand KJIHGF6xD(1);


LF2xD <= L1xD and F1xD(32);
LGF3xD <= LF2xD and GF2xD(16);
LHGF4xD <= LGF3xD and HGF3xD(8);
LIHGF5xD <= LHGF4xD and IHGF4xD(4);
LJIHGF6xD <= LIHGF5xD and JIHGF5xD(2);

OupxDO(7)<= LJIHGF6xD nand KJIHGF6xD(1);


end architecture;



