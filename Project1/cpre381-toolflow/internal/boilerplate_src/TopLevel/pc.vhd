-------------------------------------------------------------------------
-- Westin Chamberlain
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- pc.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: 
--
-- NOTES:
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity pc is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output

end pc;

architecture structural of pc is

  component dffg is
    port(i_CLK        : in std_logic;     -- Clock input
         i_RST        : in std_logic;     -- Reset input
         i_WE         : in std_logic;     -- Write enable input
         i_D          : in std_logic;     -- Data value input
         o_Q          : out std_logic);   -- Data value output
  end component;

signal s_Start : std_logic_vector(31 downto 0) := x"00400000";

begin

  G_NBit_DFFG: for i in 0 to N-1 generate
    DFFGI: dffg port map(
              i_CLK      => i_CLK,
              i_RST      => i_RST, 
	      i_WE       => s_Start(i), 
              i_D        => i_D(i),  
              o_Q        => o_Q(i)); 
  end generate G_NBit_DFFG;
  
end structural;
