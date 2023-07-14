library ieee;
use ieee.std_logic_1164.all;

entity sb_fast is 
    port (x : in std_logic_vector(7 downto 0);
          y : out std_logic_vector(7 downto 0));
end entity;

architecture parallel of sb_fast is
    
    signal U0, U1, U2, U3, U4, U5, U6, U7 : std_logic;

    signal Z10, Z18, Z36, Z96, Z160 : std_logic;
    signal L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31 : std_logic;
    signal Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17 : std_logic;
    signal T0, T1, T2, T3, T4, T10, T11, T12, T13, T20, T21, T22 : std_logic;
    signal X0, X1, X2, X3 : std_logic;
    signal Y0, Y1, Y2, Y3, Y4 : std_logic;
    signal K0, K1, K2, K3, K4, K5, K6, K7, K8, K9, K10, K11, K12, K13, K14, K15, K16, K17, K18, K19, K20, K21, K22, K23, K24, K25, K26, K27, K28, K29, K30, K31 : std_logic;
    signal R0, R1, R2, R3, R4, R5, R6, R7 : std_logic;

begin

    U0 <= x(7);
    U1 <= x(6);
    U2 <= x(5);
    U3 <= x(4);
    U4 <= x(3);
    U5 <= x(2);
    U6 <= x(1);
    U7 <= x(0);

    -- ftop.d
    Z18 <= U1 xor U4;
    L28 <= Z18 xor U6;
    Q0  <= U2 xor L28;
    Z96 <= U5 xor U6;
    Q1  <= U0 xor Z96;
    Z160 <= U5 xor U7;
    Q2 <= U6 xor Z160;
    Q11 <= U2 xor U3;
    L6 <= U4 xor Z96;
    Q3  <= Q11 xor L6;
    Q16 <= U0  xor Q11;
    Q4  <= Q16 xor U4;
    Q5  <= Z18 xor Z160;
    Z10 <= U1  xor U3;
    Q6  <= Z10 xor Q2;
    Q7  <= U0  xor U7;
    Z36 <= U2 xor U5;
    Q8  <= Z36 xor Q5;
    L19 <= U2  xor Z96;
    Q9  <= Z18 xor L19;
    Q10 <= Z10 xor Q1;
    Q12 <= U3  xor L28;
    Q13 <= U3  xor Q2;
    L10 <= Z36 xor Q7;
    Q14 <= U6  xor L10;
    Q15 <= U0  xor Q5;
    L8  <= U3 xor Q5;
    L12 <= Q16 xor Q2;
    L16 <= U2 xor Q4;
    L15 <= U1  xor Z96;
    L31 <= Q16 xor L15;
    L5  <= Q12 xor L31;
    L13 <= U3  xor Q8;
    L17 <= U4  xor L10;
    L29 <= Z96 xor L10;
    L14 <= Q11 xor L10;
    L26 <= Q11 xor Q5;
    L30 <= Q11 xor U6;
    L7  <= Q12 xor Q1;
    L11 <= Q12 xor L15;
    L27 <= L30 xor L10;
    Q17 <= U0;
    L0  <= Q10;
    L4  <= U6;
    L20 <= Q0;
    L24 <= Q16;
    L1  <= Q6;
    L9  <= U5;
    L21 <= Q11;
    L25 <= Q13;
    L2  <= Q9;
    L18 <= U1;
    L22 <= Q15;
    L3  <= Q8;
    L23 <= U0;

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
    Y0 <= T2 when X2 = '1' else X3; -- MUX(X2, T2, X3);
    Y2 <= T2 when X0 = '1' else X1; -- MUX(X0, T2, X1);
    T3 <= X2 when X1 = '1' else '1'; -- MUX(X1, X2, 1);
    Y1 <= X3 when T2 = '1' else T3; -- MUX(T2, X3, T3);
    T4 <= X0 when X3 = '1' else '1'; -- MUX(X3, X0, 1);
    Y3 <= X1 when T2 = '1' else T4; -- MUX(T2, X1, T4)

    -- mull.f
    K4  <= Y0 and L4;
    K8  <= Y0 and L8;
    K24 <= Y0 and L24;
    K28 <= Y0 and L28;

    -- mull.d
    K0  <= Y0 nand L0;
    K12 <= Y0 nand L12;
    K16 <= Y0 nand L16;
    K20 <= Y0 nand L20;

    K1  <= Y1 nand L1;
    K5  <= Y1 nand L5;
    K9  <= Y1 nand L9;
    K13 <= Y1 nand L13;
    K17 <= Y1 nand L17;
    K21 <= Y1 nand L21;
    K25 <= Y1 nand L25;
    K29 <= Y1 nand L29;

    K2  <= Y2 nand L2;
    K6  <= Y2 nand L6;
    K10 <= Y2 nand L10;
    K14 <= Y2 nand L14;
    K18 <= Y2 nand L18;

    K22 <= Y2 nand L22;
    K26 <= Y2 nand L26;
    K30 <= Y2 nand L30;

    K3  <= Y3 nand L3;
    K7  <= Y3 nand L7;
    K11 <= Y3 nand L11;
    K15 <= Y3 nand L15;
    K19 <= Y3 nand L19;
    K23 <= Y3 nand L23;
    K27 <= Y3 nand L27;
    K31 <= Y3 nand L31;

    -- 8xor4.d
    R0 <= (K0 xor K1) xor (K2 xor K3);
    R1 <= (K4 xor K5) xor (K6 xor K7);
    R2 <= (K8 xor K9) xor (K10 xor K11);
    R3 <= (K12 xor K13) xor (K14 xor K15);
    R4 <= (K16 xor K17) xor (K18 xor K19);
    R5 <= (K20 xor K21) xor (K22 xor K23);
    R6 <= (K24 xor K25) xor (K26 xor K27);
    R7 <= (K28 xor K29) xor (K30 xor K31);

    y(7) <= R0;
    y(6) <= R1;
    y(5) <= R2;
    y(4) <= R3;
    y(3) <= R4;
    y(2) <= R5;
    y(1) <= R6;
    y(0) <= R7;
    
end architecture;
