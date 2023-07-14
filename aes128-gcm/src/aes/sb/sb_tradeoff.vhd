library ieee;
use ieee.std_logic_1164.all;

entity sb_tradeoff is 
    port (x : in  std_logic_vector(7 downto 0);
          y : out std_logic_vector(7 downto 0));
end entity;

architecture parallel of sb_tradeoff is

    signal U0, U1, U2, U3, U4, U5, U6, U7 : std_logic;
    signal R0, R1, R2, R3, R4, R5, R6, R7 : std_logic;

    signal X0, X1, X2, X3 : std_logic;
    signal Y00, Y01, Y02, Y0, Y1, Y2, Y3, Y13, Y23 : std_logic;
    signal T0, T1, T2, T3, T4, T5, T6, T20, T21, T22, T10, T11, T12, T13 : std_logic; 
    signal Z6, Z9, Z66, Z80, Z114 : std_logic;
    signal Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17 : std_logic;
    signal N0, N1, N2, N3, N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15, N16, N17 : std_logic;
    signal H0, H1, H2, H3, H4, H5, H6, H7, H8, H9, H10, H11, H12, H13, H14, H15, H16, H17, H18, H19, H20, H21, H22, H23 : std_logic;

begin

    U0 <= x(7);
    U1 <= x(6);
    U2 <= x(5);
    U3 <= x(4);
    U4 <= x(3);
    U5 <= x(2);
    U6 <= x(1);
    U7 <= x(0);

    -- ftop.a
    Z6   <= U1  xor U2;
    Q12  <= Z6  xor U3;
    Q11  <= U4  xor U5;
    Q0   <= Q12 xor Q11;
    Z9   <= U0  xor U3;
    Z80  <= U4  xor U6;
    Q1   <= Z9  xor Z80;
    Q7   <= Z6  xor U7;
    Q2   <= Q1  xor Q7;
    Q3   <= Q1  xor U7;
    Q13  <= U5  xor Z80;
    Q5   <= Q12 xor Q13;
    Z66  <= U1  xor U6;
    Z114 <= Q11 xor Z66;
    Q6   <= U7  xor Z114;
    Q8   <= Q1  xor Z114;
    Q9   <= Q7  xor Z114;
    Q10  <= U2  xor Q13;
    Q16  <= Z9  xor Z66;
    Q14  <= Q16 xor Q13;
    Q15  <= U0  xor U2;
    Q17  <= Z9  xor Z114;
    Q4   <= U7;

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

    -- s1.a
    T0 <= X0 nand X2;
    T1 <= X1 nor X3;
    T2 <= T0 xnor T1;
    Y0 <= T2 when X2 = '1' else X3;  -- MUX(X2, T2, X3)
    Y2 <= T2 when X0 = '1' else X1;  -- MUX(X0, T2, X1)
    T3 <= X2 when X1 = '1' else '1'; -- MUX(X1, X2, 1)
    Y1 <= X3 when T2 = '1' else T3;  -- MUX(T2, X3, T3)
    T4 <= X0 when X3 = '1' else '1'; -- MUX(X3, X0, 1)
    Y3 <= X1 when T2 = '1' else T4;  -- MUX(T2, X1, T4)

    T5  <= T0 when X0 = '1' else X3;           -- MUX(X0, T0, X3)
    Y23 <= T5 when X1 = '1' else X0;           -- MUX(X1, T5, X0)
    T6  <= not(X2) when T3 = '1' else not(X3); -- NMUX(T3, X2, X3)
    Y01 <= not(T6) when T0 = '1' else not(X3); -- NMUX(T0, T6, X3)
    Y02 <= Y2  xor Y0;
    Y13 <= Y3  xor Y1;
    Y00 <= Y01 xor Y23;
    
    -- muln.a;
    N0 <= Y01 nand Q11;
    N1 <= Y0  nand Q12;
    N2 <= Y1  nand Q0;
    N3 <= Y23 nand Q17;
    N4 <= Y2  nand Q5;
    N5 <= Y3  nand Q15;
    N6 <= Y13 nand Q14;

    N7  <= Y00 nand Q16;
    N8  <= Y02 nand Q13;
    N9  <= Y01 nand Q7;
    N10 <= Y0  nand Q10;
    N11 <= Y1  nand Q6;
    N12 <= Y23 nand Q2;
    N13 <= Y2  nand Q9;
    N14 <= Y3  nand Q8;

    N15 <= Y13 nand Q3;
    N16 <= Y00 nand Q1;
    N17 <= Y02 nand Q4;

    -- fbot.a
    H0  <= N3  xor N8;
    H1  <= N5  xor N6;
    H2  <= H0  xnor H1;
    H3  <= N1  xor N4;
    H4  <= N9  xor N10;
    H5  <= N13 xor N14;
    H6  <= N15 xor H4;
    H7  <= N0  xor H3;    
    H8  <= N17 xor H5;
    H9  <= N3  xor H7;
    H10 <= N15 xor N17;
    H11 <= N9  xor N11;
    H12 <= N12 xor N14;
    H13 <= N1  xor N2;
    H14 <= N5  xor N16;
    H15 <= N7  xor H11;
    H16 <= H10 xor H11;
    H17 <= N16 xor H8;
    H18 <= H6  xor H8;
    H19 <= H10 xor H12;
    H20 <= N2  xor H3;
    H21 <= H6  xor H14;
    H22 <= N8  xor H12;
    H23 <= H13 xor H15;

    R0 <= H16 xnor H2;
    R1 <= H2;
    R2 <= H20 xnor H21;
    R3 <= H17 xnor H2;
    R4 <= H18 xnor H2;
    R5 <= H22 xor H23;
    R6 <= H19 xnor H9;
    R7 <= H18 xnor H9;

    y(7) <= R0;
    y(6) <= R1;
    y(5) <= R2;
    y(4) <= R3;
    y(3) <= R4;
    y(2) <= R5;
    y(1) <= R6;
    y(0) <= R7;

end architecture;
