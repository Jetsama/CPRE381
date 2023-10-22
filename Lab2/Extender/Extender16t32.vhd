
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all ; 
entity Extender16t32 is
	generic(N : integer := 32); 
  port(i         : in std_logic_vector(16-1 downto 0);
       o         : out std_logic_vector(32-1 downto 0));

end Extender16t32;


architecture dataflow of Extender16t32 is
begin
	process(i)
begin 
	if i(15) = '1' then
 		o <= X"FFFF" & i;
	else 
		o <= X"0000" & i; 
  	end if;
	end process;
end dataflow;