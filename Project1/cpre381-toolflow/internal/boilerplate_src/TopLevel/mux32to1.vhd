-------------------------------------------------------------------------
-- Westin Chamberlain
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux32to1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: 
--
-- NOTES:
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux32to1 is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_S          : in std_logic_vector(4 downto 0);
       i_D0          : in std_logic_vector(N-1 downto 0);
       i_D1          : in std_logic_vector(N-1 downto 0);  
       i_D2          : in std_logic_vector(N-1 downto 0);
       i_D3          : in std_logic_vector(N-1 downto 0);
       i_D4          : in std_logic_vector(N-1 downto 0);
       i_D5          : in std_logic_vector(N-1 downto 0);  
       i_D6          : in std_logic_vector(N-1 downto 0);
       i_D7          : in std_logic_vector(N-1 downto 0);
       i_D8          : in std_logic_vector(N-1 downto 0);
       i_D9          : in std_logic_vector(N-1 downto 0);  
       i_D10         : in std_logic_vector(N-1 downto 0);
       i_D11         : in std_logic_vector(N-1 downto 0);
       i_D12         : in std_logic_vector(N-1 downto 0);
       i_D13         : in std_logic_vector(N-1 downto 0);  
       i_D14         : in std_logic_vector(N-1 downto 0);
       i_D15         : in std_logic_vector(N-1 downto 0);
       i_D16         : in std_logic_vector(N-1 downto 0);
       i_D17         : in std_logic_vector(N-1 downto 0);  
       i_D18         : in std_logic_vector(N-1 downto 0);
       i_D19         : in std_logic_vector(N-1 downto 0);
       i_D20         : in std_logic_vector(N-1 downto 0);
       i_D21         : in std_logic_vector(N-1 downto 0);  
       i_D22         : in std_logic_vector(N-1 downto 0);
       i_D23         : in std_logic_vector(N-1 downto 0);
       i_D24         : in std_logic_vector(N-1 downto 0);
       i_D25         : in std_logic_vector(N-1 downto 0);  
       i_D26         : in std_logic_vector(N-1 downto 0);
       i_D27         : in std_logic_vector(N-1 downto 0);
       i_D28         : in std_logic_vector(N-1 downto 0);
       i_D29         : in std_logic_vector(N-1 downto 0);  
       i_D30         : in std_logic_vector(N-1 downto 0);
       i_D31         : in std_logic_vector(N-1 downto 0);   -- Data value input
       o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output

end mux32to1;

architecture structural of mux32to1 is

begin
o_Q <=  i_D0  when (i_S = b"00000") else
	i_D1  when (i_S = b"00001") else
	i_D2  when (i_S = b"00010") else
	i_D3  when (i_S = b"00011") else
	i_D4  when (i_S = b"00100") else
	i_D5  when (i_S = b"00101") else
	i_D6  when (i_S = b"00110") else
	i_D7  when (i_S = b"00111") else
	i_D8  when (i_S = b"01000") else
	i_D9  when (i_S = b"01001") else
	i_D10 when (i_S = b"01010") else
	i_D11 when (i_S = b"01011") else
	i_D12 when (i_S = b"01100") else
	i_D13 when (i_S = b"01101") else
	i_D14 when (i_S = b"01110") else
	i_D15 when (i_S = b"01111") else
	i_D16 when (i_S = b"10000") else --16
	i_D17 when (i_S = b"10001") else
	i_D18 when (i_S = b"10010") else
	i_D19 when (i_S = b"10011") else
	i_D20 when (i_S = b"10100") else
	i_D21 when (i_S = b"10101") else
	i_D22 when (i_S = b"10110") else
	i_D23 when (i_S = b"10111") else
	i_D24 when (i_S = b"11000") else
	i_D25 when (i_S = b"11001") else
	i_D26 when (i_S = b"11010") else
	i_D27 when (i_S = b"11011") else
	i_D28 when (i_S = b"11100") else
	i_D29 when (i_S = b"11101") else
	i_D30 when (i_S = b"11110") else
	i_D31 when (i_S = b"11111") else --31
        x"00000000";
  
  
end structural;
