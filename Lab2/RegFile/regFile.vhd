
library IEEE;
use IEEE.std_logic_1164.all;

entity regFile is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_SR0          : in std_logic_vector(5-1 downto 0);
	i_SR1          : in std_logic_vector(5-1 downto 0);
       i_SW         : in std_logic_vector(5-1 downto 0);
	i_D          : in std_logic_vector(N-1 downto 0);
	i_CLK         : in std_logic;
	i_RST         : in std_logic;

       o_R0          : out std_logic_vector(N-1 downto 0);
	o_R1          : out std_logic_vector(N-1 downto 0));

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

	component mux32t1_N is
 	 generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  	port(i_S          : in std_logic_vector(5-1 downto 0); --integer range 0 to 31;
       i_I         : in std_logic_vector((32)*N -1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));
	end component;


component dec5t32 is
  port(i_I          : in std_logic_vector(5-1 downto 0); --integer range 0 to 31;
       o_O          : out std_logic_vector(32-1 downto 0));

end component;

	signal muxE : std_logic_vector(N-1 downto 0);
	
  	signal s_xyc_and         : std_logic;
	signal s_E :std_logic_vector(N-1 downto 0);

	signal s_REGISTERS :	std_logic_vector((32)*N -1 downto 0);

	begin

	
	decoder: dec5t32
	port MAP(i_I               => i_SW,
             o_O               => s_E);

    read0mux: mux32t1_N port map(
              i_S      => i_SR0,      -- All instances share the same select input.
              i_I     => s_REGISTERS,  -- ith instance's data 0 input hooked up to ith data 0 input.
		o_O      => o_R0);  -- ith instance's data output hooked up to ith data output.
 read1mux: mux32t1_N port map(
              i_S      => i_SR1,      -- All instances share the same select input.
              i_I     => s_REGISTERS,  -- ith instance's data 0 input hooked up to ith data 0 input.
		o_O      => o_R1);  -- ith instance's data output hooked up to ith data output.

  -- Instantiate N regN instances.
  G_NRegisters: for i in 0 to N-1 generate
    REGI: register_N port map(
              i_CLK      => i_CLK,      -- All instances share the same select input.
              i_RST     => i_RST,  -- ith instance's data 0 input hooked up to ith data 0 input.
              i_E     => s_E(i),  -- ith instance's data 1 input hooked up to ith data 1 input.
             i_D     => i_D, 
		o_O     => s_REGISTERS(i*N+N-1 downto i*N));  -- ith instance's data output hooked up to ith data output.
  end generate G_NRegisters;
  
end structural;