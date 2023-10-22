library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
entity mux32t1 is
  port(i_S          : in std_logic_vector(5-1 downto 0); --integer range 0 to 31;
       i_I         : in std_logic_vector(32-1 downto 0);
       o_O          : out std_logic);

end mux32t1;

architecture dataflow of mux32t1 is

  


begin
	 o_O <= i_I(to_integer(unsigned(i_S)));
	--o_O <= i_I(i_S);
  
end dataflow;