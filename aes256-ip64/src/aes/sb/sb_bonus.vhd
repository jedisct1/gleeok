library ieee;
use ieee.std_logic_1164.all;

entity sb_bonus is 
    port (x : in std_logic_vector(7 downto 0);
          y : out std_logic_vector(7 downto 0));
end entity;

architecture parallel of sb_bonus is 

    signal Z24, Z66, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17 : std_logic;
    signal T0, T1, T2, T3, T4, T10, T11, T12, T13, T20, T21, T22, X0, X1, X2, X3, Y0, Y1, Y2, Y3    : std_logic;
    signal Y00, Y01, Y02, Y13, Y23, N0, N1, N2, N3, N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15, N16, N17 : std_logic;
    signal H0, H1, H2, H3, H4, H5, H6, H7, H8, H9, H10, H11, H12, H13, H14, H15, H16, H17, H18 : std_logic;
    signal R0, R1, R2, R3, R4, R5, R6, R7 : std_logic;
    signal U0, U1, U2, U3, U4, U5, U6, U7 : std_logic;

begin  

    U0 <= x(7);
    U1 <= x(6);
    U2 <= x(5);
    U3 <= x(4);
    U4 <= x(3);
    U5 <= x(2);
    U6 <= x(1);
    U7 <= x(0);
    
    -- below: edited and pasted from the paper
    Z24 <= U3 xor U4;
    Q17 <= U1 xor U7;
    Q16 <= U5 xor Q17;
    Q0  <= Z24 xor Q16;
    Z66 <= U1 xor U6;
    Q7  <= Z24 xor Z66;
    Q2  <= U2 xor Q0;
    Q1  <= Q7 xor Q2;
    Q3  <= U0 xor Q7;
    Q4  <= U0 xor Q2;
    Q5  <= U1 xor Q4;
    Q6  <= U2 xor U3;
    Q10 <= Q6 xor Q7;
    Q8  <= U0 xor Q10;
    Q9  <= Q8 xor Q2;
    Q12 <= Z24 xor Q17;
    Q15 <= U7 xor Q4;
    Q13 <= Z24 xor Q15;
    Q14 <= Q15 xor Q0;
    Q11 <= U5;

    -- mulx.a
    T20 <= Q6 nand Q12;
    T21 <= Q3 nand Q14;
    T22 <= Q1 nand Q16;
    T10 <= (Q3 nor Q14) xor (Q0 nand Q7);
    T11 <= (Q4 nor Q13) xor (Q10 nand Q11);
    T12 <= (Q2 nor Q17) xor (Q5 nand Q9);
    T13 <= (Q8 nor Q15) xor (Q2 nand Q17);

    X0 <= T10 xor (T20 xor T22);
    X1 <= T11 xor (T21 xor T20);
    X2 <= T12 xor (T21 xor T22);
    X3 <= T13 xor (T21 xor (Q4 nand Q13));

    -- inv.a
    T0 <= X0 nand X2;
    T1 <= X1 nor X3;
    T2 <= T0 xnor T1;

    Y0 <= T2 when X2 = '1' else X3;  -- MUX(X2, T2, X3);
    Y2 <= T2 when X0 = '1' else X1;  -- MUX(X0, T2, X1);
    T3 <= X2 when X1 = '1' else '1'; -- MUX(X1, X2, 1);
    Y1 <= X3 when T2 = '1' else T3;  -- MUX(T2, X3, T3);
    T4 <= X0 when X3 = '1' else '1'; -- MUX(X3, X0, 1);
    Y3 <= X1 when T2 = '1' else T4;  -- MUX(T2, X1, T4)

    -- s0.a, calls inv.a;
    Y02 <= Y2 xor Y0;
    Y13 <= Y3 xor Y1;
    Y23 <= Y3 xor Y2;
    Y01 <= Y1 xor Y0;
    Y00 <= Y02 xor Y13;

    -- File: muln.a;
    N0 <= Y01 nand Q11;
    N1 <= Y0 nand Q12;
    N2 <= Y1 nand Q0;
    N3 <= Y23 nand Q17;
    N4 <= Y2 nand Q5;
    N5 <= Y3 nand Q15;
    N6 <= Y13 nand Q14;

    N7  <= Y00 nand Q16;
    N8  <= Y02 nand Q13;
    N9  <= Y01 nand Q7;
    N10 <= Y0 nand Q10;
    N11 <= Y1 nand Q6;
    N12 <= Y23 nand Q2;
    N13 <= Y2 nand Q9;
    N14 <= Y3 nand Q8;

    N15 <= Y13 nand Q3;
    N16 <= Y00 nand Q1;
    N17 <= Y02 nand Q4;

    -- fbot.b;
    H0  <= N1 xor N5;
    H1  <= N4 xor H0;
    R2  <= N2 xnor H1;
    H2  <= N9 xor N15;
    H3  <= N11 xor N17;
    R6  <= H2 xnor H3;
    H4  <= N11 xor N14;
    H5  <= N9 xor N12;
    R5  <= H4 xor H5;
    H6  <= N16 xor H2;
    H7  <= R2 xor R6;
    H8  <= N10 xor H7;
    R7  <= H6 xnor H8;
    H9  <= N8 xor H1;
    H10 <= N13 xor H8;
    R3  <= H5 xor H10;
    H11 <= H9 xor H10;
    H12 <= N7 xor H11;
    H13 <= H4 xor H12;
    R4  <= N1 xor H13;
    H14 <= N0 xnor R7;
    H15 <= H9 xor H14;
    H16 <= H7 xor H15;
    R1  <= N6 xnor H16;
    H17 <= N4 xor H14;
    H18 <= N3 xor H17;
    R0  <= H13 xor H18;
    
    y(7) <= R0;
    y(6) <= R1;
    y(5) <= R2;
    y(4) <= R3;
    y(3) <= R4;
    y(2) <= R5;
    y(1) <= R6;
    y(0) <= R7;

end architecture;

