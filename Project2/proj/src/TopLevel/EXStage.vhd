-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- MIPS_Processor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a skeleton of a MIPS_Processor  
-- implementation.

-- 01/29/2019 by H3::Design created.
-------------------------------------------------------------------------
--PC must start at 0x 0040 0000 and is a register

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


entity EXStage is
  generic(N : integer := 32);
  port (i_CLK		: in std_logic; 
    	i_RST 		: in std_logic; 
	i_WE 		: in std_logic; 
	iALUOut		: in std_logic_vector(N-1 downto 0);
	iDMemData	: in std_logic_vector(N-1 downto 0);
	iControl	: in std_logic_vector(N-1 downto 0);
	iNextInstAddr	: in std_logic_vector(N-1 downto 0);
iInstruction		:  std_logic_vector(N-1 downto 0);
	oInstruction  		: out std_logic_vector(N-1 downto 0);
	oNextInstAddr	: out std_logic_vector(N-1 downto 0);
	oControl	: out std_logic_vector(N-1 downto 0);
	oALUOut		: out std_logic_vector(N-1 downto 0);
	oDMemData	: out std_logic_vector(N-1 downto 0));
end  EXStage;


architecture structure of EXStage is
	component dffg_N is
    	port(i_CLK        : in std_logic;     -- Clock input
         	i_RST        : in std_logic;     -- Reset input
         	i_WE         : in std_logic;     -- Write enable input
         	i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
         	o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output
  	end component;
Begin
	ALUdffg : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => i_WE,
	         i_D    => iALUOut,
	         o_Q    => oALUOut);

	DMemdffg : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => i_WE,
	         i_D    => iDMemData,
	         o_Q    => oDMemData);

	controldffg : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => i_WE,
	         i_D    => iControl,
	         o_Q    => oControl);

	nextinstaddrdffg : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => i_WE,
	         i_D    => iNextInstAddr,
	         o_Q    => oNextInstAddr);
instructiondffg : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => i_WE,
	         i_D    => iInstruction,
	         o_Q    => oInstruction);
end structure;