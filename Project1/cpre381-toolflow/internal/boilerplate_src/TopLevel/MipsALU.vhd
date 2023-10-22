-------------------------------------------------------------------------
-- Westin Chamberlain
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- MipsALU.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: 
--
-- NOTES:
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity MipsALU is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_ALUOp      : in std_logic_vector(3 downto 0);
       i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       i_shamt      : in std_logic_vector(4 downto 0);
       o_COut       : out std_logic;
       o_O          : out std_logic; --Overflow
       o_Z          : out std_logic; --Zero
       o_F          : out std_logic_vector(N-1 downto 0));

end MipsALU;

architecture structural of MipsALU is

  component adderSubtractor is
    port(nAdd_Sub          : in std_logic;
         i_A         : in std_logic_vector(N-1 downto 0);
         i_B         : in std_logic_vector(N-1 downto 0);
         o_CO        : out std_logic;
         o_O          : out std_logic_vector(N-1 downto 0));
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

signal s_oAdder : std_logic_vector(N-1 downto 0);
signal s_oShifter : std_logic_vector(N-1 downto 0);
signal s_oF : std_logic_vector(N-1 downto 0);
signal s_oO : std_logic;
signal s_oAddCO : std_logic;



begin

  inpMux : mux2t1_N
	port Map(i_S  => ALUSrc,
     		 i_D0 => i_B,
    		 i_D1 => i_I,
   		 o_0  => inp);

  AddSubI : adderSubtractor
	port Map(nAdd_Sub => nAdd_Sub,
       		 i_A  => i_A,
         	 i_B  => inp,
		 o_CO => o_CO,
         	 o_O  => o_O);
  
end structural;
