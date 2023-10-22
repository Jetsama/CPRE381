library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
entity dec5t32 is
  port(i_I          : in std_logic_vector(5-1 downto 0); --integer range 0 to 31;
       o_O          : out std_logic_vector(32-1 downto 0));

end dec5t32;

architecture dataflow of dec5t32 is

  
constant val1 : unsigned(31 downto 0):= X"00000001";


begin
	 o_O <= std_logic_vector(shift_left(val1,to_integer(unsigned(i_I))));
	--o_O <= i_I(i_S);
  
end dataflow;