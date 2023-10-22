-------------------------------------------------------------------------
-- Westin Chamberlain
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_newALU.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: 
--
-- NOTES:
-- Command List:
--Addu- 0000 0
--Add - 0010 2 
--Sub - 0001 1 
--Slt - 0011 3
--And - 0101 5 
--Or -  0110 6 
--Xor - 0111 7
--Nor - 1111 15 
--Not - 1101 13 
--Lui - 1110 14 
--Sll - 1001 9 
--Srl - 1010 10 
--Sra - 1011 11 
--Repl.qb - 1000 8 
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_newALU is
  generic(gCLK_HPER   : time := 10 ns;
          N           : Integer := 32);   -- Generic for half of the clock cycle period
end tb_newALU;

architecture mixed of tb_newALU is

constant cCLK_PER  : time := gCLK_HPER * 2;

  component newALU is
    port(i_A          : in std_logic_vector(N-1 downto 0);
         i_B          : in std_logic_vector(N-1 downto 0);
         i_ALUOp      : in std_logic_vector(3 downto 0);
         o_CO         : out std_logic;
         o_O          : out std_logic;
         o_Z          : out std_logic;
         o_F          : out std_logic_vector(N-1 downto 0));
  end component;
  

signal s_iA : std_logic_vector(N-1 downto 0);
signal s_iB : std_logic_vector(N-1 downto 0);
signal s_iALUOp : std_logic_vector(3 downto 0);
signal s_oCO : std_logic;
signal s_oO : std_logic;
signal s_oZ : std_logic;
signal s_oF : std_logic_vector(N-1 downto 0);

--For simple operations like and and or, just loop through index and perform operation

begin
    DUT20: newALU
    port map(i_A      => s_iA,
             i_B      => s_iB,
             i_ALUOp  => s_iALUOp,
             o_CO     => s_oCO,
             o_O      => s_oO,
             o_Z      => s_oZ,
             o_F      => s_oF);

  
  -- Testbench process  
  P_TB: process
    begin
      wait for gCLK_HPER/2;

      s_iA <= x"01010101"; --Add x11111111
      s_iB <= x"10101010";
      s_iALUOp <= "0010";
      wait for gCLK_HPER*2;

      s_iA <= x"22222222"; --Sub x12121212
      s_iB <= x"10101010";
      s_iALUOp <= "0001";
      wait for gCLK_HPER*2;

      s_iA <= x"01011111"; --And x00001111
      s_iB <= x"10101111";
      s_iALUOp <= "0101";
      wait for gCLK_HPER*2;

      s_iA <= x"01010000"; --Or x11110000
      s_iB <= x"10100000";
      s_iALUOp <= "0110";
      wait for gCLK_HPER*2;

      s_iA <= x"11010100"; --xor x00111100
      s_iB <= x"11101000";
      s_iALUOp <= "0111";
      wait for gCLK_HPER*2;

      s_iA <= x"000F0FFF"; --nor xFF000000
      s_iB <= x"00F0F0FF";
      s_iALUOp <= "1011";
      wait for gCLK_HPER*2;

      s_iA <= x"0000FFFF"; --not xFFFF0000
      s_iB <= x"F0F0FFFF";
      s_iALUOp <= "1101";
      wait for gCLK_HPER*2;

      s_iA <= x"F1010011"; --sll x10011000
      s_iB <= x"1010000C";
      s_iALUOp <= "1001";
      wait for gCLK_HPER*2;

      s_iA <= x"F1010011"; --srl x000F1010
      s_iB <= x"1010000C";
      s_iALUOp <= "1010";
      wait for gCLK_HPER*2;

      s_iA <= x"F1010011"; --sra xFFF11010
      s_iB <= x"1010000C";
      s_iALUOp <= "1111";
      wait for gCLK_HPER*2;

      s_iA <= x"11011010"; --addu x11111111
      s_iB <= x"00100101";
      s_iALUOp <= "0000";
      wait for gCLK_HPER*2;

      s_iA <= x"11111111"; --lui x11000000
      s_iB <= x"10101100";
      s_iALUOp <= "1110";
      wait for gCLK_HPER*2;

      s_iA <= x"10000101"; --slt x00000001
      s_iB <= x"10110001";
      s_iALUOp <= "0011";
      wait for gCLK_HPER*2;

      s_iA <= x"00000010"; --repl x80808080
      s_iB <= x"00000000";
      s_iALUOp <= "1000";
      wait for gCLK_HPER*2;

  end process;


end mixed;
