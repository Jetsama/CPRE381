-------------------------------------------------------------------------
-- Westin Chamberlain
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- rippleAdder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION:
--
-- NOTES:
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity rippleAdder is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_C          : in std_logic;
       i_N0         : in std_logic_vector(N-1 downto 0);
       i_N1         : in std_logic_vector(N-1 downto 0);
       o_C0         : out std_logic;
       o_S          : out std_logic_vector(N-1 downto 0));

end rippleAdder;

architecture structural of rippleAdder is

  component fullAdder is
    port(i_C                  : in std_logic;
         i_N0                 : in std_logic;
         i_N1                 : in std_logic;
	 o_C0                 : out std_logic;
         o_S                  : out std_logic);
  end component;

signal s_carry : std_logic_vector(N downto 0);

begin

  s_carry(0) <= i_C;

  G_NBit_ADD: for i in 0 to N-1 generate
    ADDI: fullAdder port map(
              i_C      => s_carry(i),  
              i_N0     => i_N0(i),
              i_N1     => i_N1(i), 
	      o_C0     => s_carry(i + 1),
              o_S      => o_S(i)); 
  end generate G_NBit_ADD;
  o_C0 <= s_carry(32);

end structural;
