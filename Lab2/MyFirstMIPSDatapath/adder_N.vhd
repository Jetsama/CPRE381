
library IEEE;
use IEEE.std_logic_1164.all;

entity adder_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_C0          : in std_logic;
       	i_X         : in std_logic_vector(N-1 downto 0);
       	i_Y         : in std_logic_vector(N-1 downto 0);
       	o_S          : out std_logic_vector(N-1 downto 0);
	o_C          : out std_logic);

end adder_N;


architecture structural of adder_N is

  component adder is
    port(iX 		            : in std_logic;
       iY 		            : in std_logic;
       iC 		            : in std_logic;
	
       oS 		            : out std_logic;
       oC 		            : out std_logic);
  end component;

component adder_N is
  generic(N : integer := 16); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_C0          : in std_logic;
       	i_X         : in std_logic_vector(N-1 downto 0);
       	i_Y         : in std_logic_vector(N-1 downto 0);
       	o_S          : out std_logic_vector(N-1 downto 0);
	o_C          : out std_logic);

end component;


	signal s_C         : std_logic_vector(N-1 downto 0);

	
begin
	adder0: adder
    	port MAP(iX      	=> i_X(0),      -- All instances share the same select input.
              	iY      	=> i_Y(0),
		iC      	=> i_C0,  -- ith instance's data 0 input hooked up to ith data 0 input.
              	oS     	=> o_S(0),  -- ith instance's data 1 input hooked up to ith data 1 input.
              	oC      	=> s_C(0));

  -- Instantiate N adder instances.
  G_NBit_ADDER: for i in 1 to N-1 generate
    MUXI: adder port map(
              	iX      	=> i_X(i),      -- All instances share the same select input.
              	iY      	=> i_Y(i),
		iC      	=> s_C(i-1),  -- ith instance's data 0 input hooked up to ith data 0 input.
              	oS     	=> o_S(i),  -- ith instancSe's data 1 input hooked up to ith data 1 input.
              	oC      	=> s_C(i));  -- ith instance's data output hooked up to ith data output.
  end generate G_NBit_ADDER;
	
  o_C <= s_C(N-1);


end structural;