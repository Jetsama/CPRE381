
library IEEE;
use IEEE.std_logic_1164.all;

entity firstdatapath is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(nAdd_Sub          : in std_logic;
	ALUSrc :  in std_logic;
i_CLK         : in std_logic;
       	i_rs         : in std_logic_vector(5-1 downto 0);
       	i_rt         : in std_logic_vector(5-1 downto 0);
	i_rd         : in std_logic_vector(5-1 downto 0);
	i_I          : in std_logic_vector(N-1 downto 0);
	i_RST : in std_logic;
	o_REG         : out std_logic_vector(N -1 downto 0));

end firstdatapath;


architecture mixed of firstdatapath is

  component Add_Sub_N is
     port(nAdd_Sub          : in std_logic;
	ALUSrc :  in std_logic;
       	i_A1         : in std_logic_vector(N-1 downto 0);
       	i_B1         : in std_logic_vector(N-1 downto 0);
	i_I         : in std_logic_vector(N-1 downto 0);
       	o_S          : out std_logic_vector(N-1 downto 0);
	o_CN          : out std_logic);

  end component;

component regFile is
  	generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  	port(i_SR0          : in std_logic_vector(5-1 downto 0);
	i_SR1          : in std_logic_vector(5-1 downto 0);
       i_SW         : in std_logic_vector(5-1 downto 0);
	i_D          : in std_logic_vector(N-1 downto 0);

	i_CLK         : in std_logic;
	i_RST         : in std_logic;

       o_R0          : out std_logic_vector(N-1 downto 0);
	o_R1          : out std_logic_vector(N-1 downto 0));
	  end component;




	signal s_C         : std_logic_vector(N-1 downto 0);
	signal s_Bxor         : std_logic_vector(N-1 downto 0);
	signal s_mux         : std_logic_vector(N-1 downto 0);
	  signal s_CLK, s_RST, s_WE  : std_logic;
  signal s_D, s_RS,s_RT : std_logic_vector(32-1 downto 0);




begin

	registers: regFile 
  	port map(i_CLK => i_CLK, 
           i_RST => i_RST,
           i_SW  => i_rd,
           i_SR1   => i_rs,
		i_SR0   => i_rt,
		i_D   => s_D,
		o_R0   => s_RT,
           o_R1   => s_RS);



g_Add: Add_Sub_N
    port MAP(ALUSrc             => ALUSrc,
             nAdd_Sub               => nAdd_Sub,
             i_A1               => s_RS,
		i_B1               => s_RT,
i_I               => i_I,
o_S               => s_D);


    o_REG <= s_D;
	

end mixed;