-------------------------------------------------------------------------
-- Westin Chamberlain
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- 5to32decoder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: 
--
-- NOTES:
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity decoder5to32 is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_D          : in std_logic_vector(4 downto 0);     -- Data value input
       i_E          : in std_logic; --Data value enable
       o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output

end decoder5to32;

architecture structural of decoder5to32 is

begin

 	o_Q <=  x"00000000" when (i_E = '0') else
                x"00000000" when (i_D = b"00000") else
	        x"00000002" when (i_D = b"00001") else
	        x"00000004" when (i_D = b"00010") else
		x"00000008" when (i_D = b"00011") else
		x"00000010" when (i_D = b"00100") else
	        x"00000020" when (i_D = b"00101") else
	        x"00000040" when (i_D = b"00110") else
		x"00000080" when (i_D = b"00111") else
		x"00000100" when (i_D = b"01000") else
	        x"00000200" when (i_D = b"01001") else
	        x"00000400" when (i_D = b"01010") else
		x"00000800" when (i_D = b"01011") else
		x"00001000" when (i_D = b"01100") else
	        x"00002000" when (i_D = b"01101") else
	        x"00004000" when (i_D = b"01110") else
		x"00008000" when (i_D = b"01111") else
		x"00010000" when (i_D = b"10000") else --16
	        x"00020000" when (i_D = b"10001") else
	        x"00040000" when (i_D = b"10010") else
		x"00080000" when (i_D = b"10011") else
		x"00100000" when (i_D = b"10100") else
	        x"00200000" when (i_D = b"10101") else
	        x"00400000" when (i_D = b"10110") else
		x"00800000" when (i_D = b"10111") else
		x"01000000" when (i_D = b"11000") else
	        x"02000000" when (i_D = b"11001") else
	        x"04000000" when (i_D = b"11010") else
		x"08000000" when (i_D = b"11011") else
		x"10000000" when (i_D = b"11100") else
	        x"20000000" when (i_D = b"11101") else
	        x"40000000" when (i_D = b"11110") else
		x"80000000" when (i_D = b"11111") else --31
	        x"00000000";
  
end structural;
