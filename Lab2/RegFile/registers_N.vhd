
library IEEE;
use IEEE.std_logic_1164.all;

entity regFile is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_E          : in std_logic_vector(N-1 downto 0);
       i_D         : in std_logic_vector(N-1 downto 0);
	i_CLK         : in std_logic;
	i_RST         : in std_logic;
       o_O          : out std_logic_vector(N-1 downto 0));

end regFile;



architecture structural of regFile is

  component register_N is
  	generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  	port(i_E          : in std_logic;
       	i_D         : in std_logic_vector(N-1 downto 0);
	i_CLK         : in std_logic;
	i_RST         : in std_logic;
       o_O          : out std_logic_vector(N-1 downto 0));
	  end component;

	entity mux2t1_N is
 	 generic(N : integer := 16); -- Generic of type integer for input/output data width. Default value is 32.
  	port(i_S          : in std_logic;
       	i_D0         : in std_logic_vector(N-1 downto 0);
      	 i_D1         : in std_logic_vector(N-1 downto 0);
       	o_O          : out std_logic_vector(N-1 downto 0));
	end component;


	begin

  -- Instantiate N regN instances.
  G_NRegisters: for i in 0 to N-1 generate
    REGI: register_N port map(
              i_CLK      => i_CLK,      -- All instances share the same select input.
              i_RST     => i_RST,  -- ith instance's data 0 input hooked up to ith data 0 input.
              i_E     => i_E(i),  -- ith instance's data 1 input hooked up to ith data 1 input.
              i_D      => i_D(i),
		o_Q      => o_O(i));  -- ith instance's data output hooked up to ith data output.
  end generate G_NRegisters;
  
end structural;