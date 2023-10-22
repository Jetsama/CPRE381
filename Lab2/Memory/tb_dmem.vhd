
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all ; 
entity tb_dmem is
  generic(gCLK_HPER   : time := 50 ns);
end tb_dmem;

architecture behavior of tb_dmem is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;


	component mem is
	generic 
	(
		DATA_WIDTH : natural := 32;
		ADDR_WIDTH : natural := 10
	);

	port 
	(
		clk		: in std_logic;
		addr	        : in std_logic_vector((ADDR_WIDTH-1) downto 0);
		data	        : in std_logic_vector((DATA_WIDTH-1) downto 0);
		we		: in std_logic := '1';
		q		: out std_logic_vector((DATA_WIDTH -1) downto 0)
	);
	  end component;


  -- Temporary signals to connect to the dff component.
  signal s_CLK, s_WE  : std_logic;
signal s_addr : std_logic_vector(10-1 downto 0);
  signal s_D,s_Q : std_logic_vector(32-1 downto 0);

begin

  dmem: mem 
  port map(clk => s_CLK, 
           we => s_WE,


		data   => s_D,
		addr   => s_addr,
           q   => s_Q);

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
  begin
	for i in 0 to 10 loop --write data
		s_WE <= '0';
		s_addr <= to_std_logic_vector(i,10);
		wait for cCLK_PER;
		  s_D <= s_Q;
		s_WE <= '1';
		s_addr <= to_std_logic_vector(256+i,10);
		wait for cCLK_PER;  
	end loop;
    wait for cCLK_PER;
	for i in 0 to 10 loop --write data
		s_WE <= '0';
		s_addr <= to_std_logic_vector(256+i,10);
		wait for cCLK_PER;  
	end loop;  
    wait;
  end process;
  
end behavior;