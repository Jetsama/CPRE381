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

      s_iO <= "000000";
      s_iF <= "100000";
      wait for gCLK_HPER*2;

      s_iO <= "000000";
      s_iF <= "100100";
      wait for gCLK_HPER*2;

      s_iO <= "001000";
      s_iF <= "100000";
      wait for gCLK_HPER*2;


    end process;
 
end mixed;
