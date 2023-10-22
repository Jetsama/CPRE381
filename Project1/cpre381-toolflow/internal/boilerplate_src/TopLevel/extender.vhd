-------------------------------------------------------------------------
-- Westin Chamberlain
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- extender.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: 
--
-- NOTES:
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity extender is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_D          : in std_logic_vector(15 downto 0);     -- Data value input
       i_S          : in std_logic; --Sign Extender Select
       o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output

end extender;

architecture structural of extender is

signal selectExt : std_logic;

begin

  with i_S select selectExt <= '0' when '0', i_D(15) when others;

  G_15Bit_Ext: for i in 0 to 15 generate
    o_Q(i) <= i_D(i);
  end generate G_15Bit_Ext;

  G_31Bit_Ext: for i in 16 to 31 generate
    o_Q(i) <= selectExt;
  end generate G_31Bit_Ext;
  
end structural;
