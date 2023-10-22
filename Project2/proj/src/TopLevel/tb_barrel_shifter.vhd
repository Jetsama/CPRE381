-------------------------------------------------------------------------
-- TJ Thielen
-- tb_barrel_shifter.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the barrel shifter
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_barrel_shifter is
  generic(gCLK_HPER   : time := 50 ns);
end tb_barrel_shifter;

architecture behavior of tb_barrel_shifter is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;


  component barrel_shifter
    port( i_d		: in STD_LOGIC_VECTOR(31 downto 0);
	i_shamt		: in STD_LOGIC_VECTOR(4 downto 0);
	i_sra		: in STD_LOGIC;
	i_shLeft	: in STD_LOGIC;
	o_o		: out STD_LOGIC_VECTOR(31 downto 0));
  end component;

  signal s_CLK, s_shLeft: std_logic;
  signal s_d, s_o : std_logic_vector(31 downto 0);
  signal s_shamt : std_logic_vector(4 downto 0);
  signal s_sra : std_logic;

begin

  DUT101: barrel_shifter 
  port map(i_d => s_d,
           i_shamt  => s_shamt,
	   i_sra => s_sra,
           i_shLeft   => s_shLeft,
           o_o   => s_o);

  -- This process sets the clock value (low for gCLK_HPER, then high
  -- for gCLK_HPER). Absent a "wait" command, processes restart 
  -- at the beginning once they have reached the final statement.
  P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;
  
  -- Testbench process  
  P_TB: process
	--test if no shift nothing happens
  begin
    s_sra <= '0';
    s_d <= "11111111111111111111111111111111";	
    s_shamt  <= "00000";
    s_shLeft   <= '0';
    wait for cCLK_PER;

    -- test if shLeft changes anything
    s_d <= "11111111111111111111111111111111";	
    s_shamt  <= "00000";
    s_shLeft   <= '1';
    wait for cCLK_PER;

    -- test shifting left by 1
    s_d <= "11111111111111111111111111111111";	
    s_shamt  <= "00001";
    s_shLeft   <= '1';
    wait for cCLK_PER;

    -- test shifting left by 2
    s_d <= "11111111111111111111111111111111";	
    s_shamt  <= "00010";
    s_shLeft   <= '1';
    wait for cCLK_PER;

    -- test shifting left by 4
    s_d <= "11111111111111111111111111111111";	
    s_shamt  <= "00100";
    s_shLeft   <= '1';
    wait for cCLK_PER;
    
    -- test shifting left by 8
    s_d <= "11111111111111111111111111111111";	
    s_shamt  <= "01000";
    s_shLeft   <= '1';
    wait for cCLK_PER;

    -- test shifting left by 16
    s_d <= "11111111111111111111111111111111";	
    s_shamt  <= "10000";
    s_shLeft   <= '1';
    wait for cCLK_PER;

    -- test shifting left by 31
    s_d <= "11111111111111111111111111111111";	
    s_shamt  <= "11111";
    s_shLeft   <= '1';
    wait for cCLK_PER;
    
    -- test shifting right by 1
    s_d <= "11111111111111111111111111111111";	
    s_shamt  <= "00001";
    s_shLeft   <= '0';
    wait for cCLK_PER;

    -- test shifting right by 2
    s_d <= "11111111111111111111111111111111";	
    s_shamt  <= "00010";
    s_shLeft   <= '0';
    wait for cCLK_PER;

    -- test shifting right by 4
    s_d <= "11111111111111111111111111111111";	
    s_shamt  <= "00100";
    s_shLeft   <= '0';
    wait for cCLK_PER;
    
    -- test shifting right by 8
    s_d <= "11111111111111111111111111111111";	
    s_shamt  <= "01000";
    s_shLeft   <= '0';
    wait for cCLK_PER;

    -- test shifting right by 16
    s_d <= "11111111111111111111111111111111";	
    s_shamt  <= "10000";
    s_shLeft   <= '0';
    wait for cCLK_PER;

    -- test shifting right by 31
    s_d <= "11111111111111111111111111111111";	
    s_shamt  <= "11111";
    s_shLeft   <= '0';
    wait for cCLK_PER;

    -- test shifting right with different numbers
    s_d <= "10001010101010100001011111100010";	
    s_shamt  <= "00011";
    s_shLeft   <= '0';
    wait for cCLK_PER;
    --sra = 1 now
    -- test shifting right by 1
    s_sra <= '1';
    s_d <= "11111111111111111111111111111111";	
    s_shamt  <= "00001";
    s_shLeft   <= '0';
    wait for cCLK_PER;

    -- test shifting right by 2
    s_d <= "11111111111111111111111111111111";	
    s_shamt  <= "00010";
    s_shLeft   <= '0';
    wait for cCLK_PER;

    -- test shifting right by 4
    s_d <= "11111111111111111111111111111111";	
    s_shamt  <= "00100";
    s_shLeft   <= '0';
    wait for cCLK_PER;
    
    -- test shifting right by 8
    s_d <= "11111111111111111111111111111111";	
    s_shamt  <= "01000";
    s_shLeft   <= '0';
    wait for cCLK_PER;

    -- test shifting right by 16
    s_d <= "11111111111111111111111111111111";	
    s_shamt  <= "10000";
    s_shLeft   <= '0';
    wait for cCLK_PER;

    -- test shifting right by 31
    s_d <= "11111111111111111111111111111111";	
    s_shamt  <= "11111";
    s_shLeft   <= '0';
    wait for cCLK_PER;

    -- test shifting right with different numbers
    s_d <= "10001010101010100001011111100010";	
    s_shamt  <= "00011";
    s_shLeft   <= '0';
    wait for cCLK_PER;
    wait;
  end process;
  
end behavior;