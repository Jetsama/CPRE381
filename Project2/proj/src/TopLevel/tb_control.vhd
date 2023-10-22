-------------------------------------------------------------------------
-- Westin Chamberlain
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_control.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: 
--
--
-- NOTES:
-- 
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;


entity tb_control is
  generic(gCLK_HPER   : time := 10 ns;
          N           : Integer := 32);   -- Generic for half of the clock cycle period
end tb_control;

architecture mixed of tb_control is

constant cCLK_PER  : time := gCLK_HPER * 2;

component control is

  port(i_O         : in std_logic_vector(5 downto 0); --OPCODE
       i_F         : in std_logic_vector(5 downto 0); --Function
       o_O          : out std_logic_vector(11 downto 0));
end component;


signal s_iO : std_logic_vector(5 downto 0);
signal s_iF : std_logic_vector(5 downto 0);
signal s_oO : std_logic_vector(11 downto 0);

begin
    DUT0: control
    port map(i_O     => s_iO,
             i_F     => s_iF,
             o_O      => s_oO);

  P_TEST_CASES: process
    begin
      wait for gCLK_HPER/2;
											
	--Op Code = 0
      s_iO <= "000000";		--add
      s_iF <= "100000";
      wait for gCLK_HPER*2;

      s_iO <= "000000";		--addu
      s_iF <= "100001";
      wait for gCLK_HPER*2;

      s_iO <= "000000";		--and
      s_iF <= "100100";
      wait for gCLK_HPER*2;

      s_iO <= "000000";		--xor
      s_iF <= "100110";
      wait for gCLK_HPER*2;

      s_iO <= "000000";		--or
      s_iF <= "100101";
      wait for gCLK_HPER*2;
      
      s_iO <= "000000";		--slt
      s_iF <= "101010";
      wait for gCLK_HPER*2;

      s_iO <= "000000";		--sll
      s_iF <= "000000";
      wait for gCLK_HPER*2;

      s_iO <= "000000";		--srl
      s_iF <= "000010";
      wait for gCLK_HPER*2;

      s_iO <= "000000";		--sra
      s_iF <= "000011";
      wait for gCLK_HPER*2;

      s_iO <= "000000";		--sub
      s_iF <= "100010";
      wait for gCLK_HPER*2;

      s_iO <= "000000";		--jr
      s_iF <= "001000";
      wait for gCLK_HPER*2;
      
      s_iO <= "000000";		--nor
      s_iF <= "100111";
      wait for gCLK_HPER*2;

	--Op Code != 0

      s_iO <= "001000";		--addi
      s_iF <= "100100";	
      wait for gCLK_HPER*2;	

      s_iO <= "001001";		--addiu
      s_iF <= "100000";
      wait for gCLK_HPER*2;
     
      s_iO <= "001100";		--andi
      s_iF <= "100100";
      wait for gCLK_HPER*2;

      s_iO <= "001111";		--lui
      s_iF <= "100000";
      wait for gCLK_HPER*2;

      s_iO <= "001010";		--slti
      s_iF <= "100100";
      wait for gCLK_HPER*2;
      
      s_iO <= "001110";		--xori
      s_iF <= "100000";
      wait for gCLK_HPER*2;

      s_iO <= "001101";		--ori
      s_iF <= "100100";
      wait for gCLK_HPER*2;

      s_iO <= "100011";		--lw
      s_iF <= "100100";
      wait for gCLK_HPER*2;

      s_iO <= "101011";		--sw
      s_iF <= "100000";
      wait for gCLK_HPER*2;

      s_iO <= "111111";		--repl
      s_iF <= "100000";
      wait for gCLK_HPER*2;

      s_iO <= "000100";		--beq
      s_iF <= "100100";
      wait for gCLK_HPER*2;
      
      s_iO <= "000101";		--bne
      s_iF <= "100000";
      wait for gCLK_HPER*2;

      s_iO <= "000010";		--j
      s_iF <= "100100";
      wait for gCLK_HPER*2;

      s_iO <= "000011";		--jal
      s_iF <= "100000";
      wait for gCLK_HPER*2;

    end process;
 
end mixed;
