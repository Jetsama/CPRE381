
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all ; 

entity tb_dec5t32 is
  generic(gCLK_HPER   : time := 50 ns);
end tb_dec5t32;

architecture behavior of tb_dec5t32 is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;


	component dec5t32 is
  port(i_I          : in std_logic_vector(5-1 downto 0); --integer range 0 to 31;
       o_O          : out std_logic_vector(32-1 downto 0));

end component;


  -- Temporary signals to connect to the dff component.
  signal s_CLK  : std_logic;
	signal s_I : std_logic_vector(5-1 downto 0);
  signal s_O : std_logic_vector(32-1 downto 0);

begin

  DUT: dec5t32 
  port map(i_I => s_I, 
           o_O   => s_O);

  -- This process sets the clock value (low for gCLK_HPER, then high
  -- for gCLK_HPER). Absent a "wait" command, processes restart 
  -- at the beginning once they have reached the final statement.
  P_CLK: process
  begin
l_parity : for k in 0 to 31 loop
      s_I <= to_std_logic_vector(k,5);
wait for gCLK_HPER;
    end loop l_parity;


    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;
  
  
end behavior;