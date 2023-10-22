
library IEEE;
use IEEE.std_logic_1164.all;

entity Add_Sub_N is
  generic(N : integer := 16); -- Generic of type integer for input/output data width. Default value is 32.
  port(nAdd_Sub          : in std_logic;
       	i_A1         : in std_logic_vector(N-1 downto 0);
       	i_B1         : in std_logic_vector(N-1 downto 0);
       	o_S          : out std_logic_vector(N-1 downto 0);
	o_CN          : out std_logic);

end Add_Sub_N;


architecture structural of Add_Sub_N is

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

component xorg2 is

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

	signal s_C         : std_logic_vector(N-1 downto 0);
	signal s_Bxor         : std_logic_vector(N-1 downto 0);
	



begin

G_NBit_XORS: for i in 0 to N-1 generate
    XORI: xorg2 port map(
              	i_A     	=> nAdd_Sub,      -- All instances share the same select input.
              	i_B      	=> i_B1(i),
		o_F      	=> s_Bxor(i));  -- ith instance's data output hooked up to ith data output.

  end generate G_NBit_XORS;

g_Add: adder_N
    port MAP(i_C0             => nAdd_Sub,
             i_X               => i_A1,
             i_Y               => s_Bxor,
		o_S               => o_S,
             o_C               => o_CN);


end structural;