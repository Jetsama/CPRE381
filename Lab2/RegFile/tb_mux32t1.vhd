
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all ; 

entity tb_mux32t1 is
  generic(gCLK_HPER   : time := 50 ns);
end tb_mux32t1;

architecture behavior of tb_mux32t1 is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;


	component mux32t1 is
  port(i_S          : in std_logic_vector(5-1 downto 0); --integer range 0 to 31;
       i_I         : in std_logic_vector(32-1 downto 0);
       o_O          : out std_logic);

end component;


  -- Temporary signals to connect to the dff component.
  signal s_CLK,s_O  : std_logic;
	signal s_S : std_logic_vector(5-1 downto 0);
  signal s_I : std_logic_vector(32-1 downto 0);

begin

  DUT: mux32t1 
  port map(i_I => s_I,
		i_S => s_S, 
           o_O   => s_O);

  -- This process sets the clock value (low for gCLK_HPER, then high
  -- for gCLK_HPER). Absent a "wait" command, processes restart 
  -- at the beginning once they have reached the final statement.
  P_CLK: process
  begin
l_select: for j in 0 to 5 loop
	s_S <= to_std_logic_vector(j,5);
	l_parity : for k in 0 to 31 loop
      		s_I <= to_std_logic_vector(k,32);
		wait for gCLK_HPER;
	
    	end loop l_parity;
end loop l_select;

  end process;
  
  
end behavior;