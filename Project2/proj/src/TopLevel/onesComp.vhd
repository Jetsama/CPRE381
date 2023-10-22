-------------------------------------------------------------------------
-- Westin Chamberlain
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- onesComp.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: 
-- NOTES:
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity onesComp is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_A         : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));

end onesComp;

architecture structural of onesComp is

  component invg is
    port(i_A          : in std_logic;
         o_F          : out std_logic);
  end component;


begin

  -- Instantiate N mux instances.
  G_NBit_INV: for i in 0 to N-1 generate
    INVI: invg port map(
              i_A     => i_A(i),
              o_F      => o_F(i));  
  end generate G_NBit_INV;
  
end structural;
