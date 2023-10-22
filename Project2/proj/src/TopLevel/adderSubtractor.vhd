-------------------------------------------------------------------------
-- Westin Chamberlain
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- adderSubtractor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: 
--
-- NOTES:
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity adderSubtractor is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(nAdd_Sub          : in std_logic;
       i_A         : in std_logic_vector(N-1 downto 0);
       i_B         : in std_logic_vector(N-1 downto 0);
       o_CO        : out std_logic;
       o_O          : out std_logic_vector(N-1 downto 0));

end adderSubtractor;

architecture structural of adderSubtractor is

  component rippleAdder is
    port(i_C          : in std_logic;
         i_N0         : in std_logic_vector(N-1 downto 0);
         i_N1         : in std_logic_vector(N-1 downto 0);
         o_C0         : out std_logic;
         o_S          : out std_logic_vector(N-1 downto 0));
  end component;
  
  component mux2t1_N is
    port(i_S          : in std_logic;
         i_D0         : in std_logic_vector(N-1 downto 0);
         i_D1         : in std_logic_vector(N-1 downto 0);
         o_0          : out std_logic_vector(N-1 downto 0));
  end component;

  component onesComp is
    port(i_A         : in std_logic_vector(N-1 downto 0);
         o_F          : out std_logic_vector(N-1 downto 0));
  end component;

signal invInp : std_logic_vector(N-1 downto 0);
signal arithOp : std_logic_vector(N-1 downto 0);
signal subFin : std_logic_vector(N-1 downto 0);
signal carryFin : std_logic;
signal subPlus : std_logic_vector(N-1 downto 0);

begin

  Inverter : onesComp
	port Map(i_A => i_B,
		 o_F => invInp);

  AddOrSub : mux2t1_N
	port Map(i_S  => nAdd_Sub,
     		 i_D0 => x"00000000",
    		 i_D1 => x"00000001",
   		 o_0  => subPlus);

  SubAdd1 : mux2t1_N
	port Map(i_S  => nAdd_Sub,
     		 i_D0 => i_B,
    		 i_D1 => invInp,
   		 o_0  => arithOp);

  FullInvert : rippleAdder
	port Map(i_C  => '0',
       		 i_N0 => subPlus,
        	 i_N1 => arithOp,
       		 o_C0 => carryFin,
        	 o_S  => subFin);

  ArithModule : rippleAdder
	port Map(i_C  => '0',
       		 i_N0 => i_A,
        	 i_N1 => subFin,
       		 o_C0 => o_CO,
        	 o_S  => o_O);
  
end structural;
