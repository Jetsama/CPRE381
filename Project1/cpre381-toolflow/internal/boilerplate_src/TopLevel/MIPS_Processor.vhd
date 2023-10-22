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

library work;
use work.MIPS_types.all;

entity MIPS_Processor is
  generic(N : integer := DATA_WIDTH);
  port(iCLK            : in std_logic;
       iRST            : in std_logic;
       iInstLd         : in std_logic;
       iInstAddr       : in std_logic_vector(N-1 downto 0);
       iInstExt        : in std_logic_vector(N-1 downto 0);
       oALUOut         : out std_logic_vector(N-1 downto 0)); -- TODO: Hook this up to the output of the ALU. It is important for synthesis that you have this output that can effectively be impacted by all other components so they are not optimized away.

end  MIPS_Processor;


architecture structure of MIPS_Processor is

  -- Required data memory signals
  signal s_DMemWr       : std_logic; -- TODO: use this signal as the final active high data memory write enable signal
  signal s_DMemAddr     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory address input
  signal s_DMemData     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input
  signal s_DMemOut      : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the data memory output
 
  -- Required register file signals 
  signal s_RegWr        : std_logic; -- TODO: use this signal as the final active high write enable input to the register file
  signal s_RegWrAddr    : std_logic_vector(4 downto 0); -- TODO: use this signal as the final destination register address input
  signal s_RegWrData    : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input

  -- Required instruction memory signals
  signal s_IMemAddr     : std_logic_vector(N-1 downto 0); -- Do not assign this signal, assign to s_NextInstAddr instead
  signal s_NextInstAddr : std_logic_vector(N-1 downto 0); -- TODO: use this signal as your intended final instruction memory address input.
  signal s_Inst         : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the instruction signal 

  -- Required halt signal -- for simulation
  signal s_Halt         : std_logic;  -- TODO: this signal indicates to the simulation that intended program execution has completed. (Opcode: 01 0100)

  -- Required overflow signal -- for overflow exception detection
  signal s_Ovfl         : std_logic;  -- TODO: this signal indicates an overflow exception would have been initiated

  --Additional Signals

  --Register Outputs
  signal s_RegOut1      : std_logic_vector(N-1 downto 0); --Signal for Register Out connected to ALU
  signal s_RegOut2      : std_logic_vector(N-1 downto 0); --Signal for Register Out connected to MUX with Sign Extender

  --Control Signals
  signal s_Control      : std_logic_vector(11 downto 0); --Signal array for the control signals

  --Extender Signals
  signal s_ExtOut       : std_logic_vector(N-1 downto 0); --Signal for Extender Output connected to Mux with RegOut2
 
  --New ALU Signals
  signal s_ALUIn        : std_logic_vector(N-1 downto 0); --Signal for the second input of new ALU, first signal is RegOut1
  signal s_ALUZero      : std_logic; --Signal for ALU Zero
  signal s_ALUCarry     : std_logic; --Signal for ALU Carry out

  component mem is
    generic(ADDR_WIDTH : integer;
            DATA_WIDTH : integer);
    port(
          clk          : in std_logic;
          addr         : in std_logic_vector((ADDR_WIDTH-1) downto 0);
          data         : in std_logic_vector((DATA_WIDTH-1) downto 0);
          we           : in std_logic := '1';
          q            : out std_logic_vector((DATA_WIDTH -1) downto 0));
    end component;

  -- TODO: You may add any additional signals or components your implementation 
  --       requires below this comment

  component control is
    port(i_O         : in std_logic_vector(5 downto 0); --OPCODE
         i_F         : in std_logic_vector(5 downto 0); --Function
         o_O         : out std_logic_vector(11 downto 0));
    end component;

  component regFile is
    port(i_CLK         : in std_logic;     -- Clock input
         i_RST         : in std_logic; --Reset all Registers
         i_rD          : in std_logic_vector(4 downto 0); --Write Select
         i_wE          : in std_logic; --Write Enable
         i_rS          : in std_logic_vector(4 downto 0); --Read Select
         i_rT          : in std_logic_vector(4 downto 0); --Read Select
         i_Di          : in std_logic_vector(N-1 downto 0); --rD input  
         o_rS          : out std_logic_vector(N-1 downto 0);    --rS output       
         o_rT          : out std_logic_vector(N-1 downto 0));   --rT output
    end component;

  component mux2t1 is
    port(i_S          : in std_logic;
         i_D0         : in std_logic;
         i_D1         : in std_logic;
         o_O          : out std_logic);
    end component;

  component extender is
    port(i_D          : in std_logic_vector(15 downto 0);     -- Data value input
         i_S          : in std_logic; --Sign Extender Select
         o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output
    end component;

  component pc is
    port(i_CLK        : in std_logic;     -- Clock input
         i_RST        : in std_logic;     -- Reset input
         i_WE         : in std_logic;     -- Write enable input
         i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
         o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output
    end component;

  component barrel_shifter is
    port(i_d		: in STD_LOGIC_VECTOR(31 downto 0);
	 i_sra		: in STD_LOGIC;
	 i_shamt	: in STD_LOGIC_VECTOR(4 downto 0);
	 i_shLeft	: in STD_LOGIC;
	 o_o		: out STD_LOGIC_VECTOR(31 downto 0));
    end component;

  component adderSubtractor is
    port(nAdd_Sub          : in std_logic;
         i_A         : in std_logic_vector(N-1 downto 0);
         i_B         : in std_logic_vector(N-1 downto 0);
         o_CO        : out std_logic;
         o_O          : out std_logic_vector(N-1 downto 0));
    end component;

  component newALU is
    port(i_A          : in std_logic_vector(N-1 downto 0);
         i_B          : in std_logic_vector(N-1 downto 0);
         i_ALUOp      : in std_logic_vector(3 downto 0);
         o_CO         : out std_logic;
         o_O          : out std_logic;
         o_Z          : out std_logic;
         o_F          : out std_logic_vector(N-1 downto 0));
    end component;

begin

  -- TODO: This is required to be your final input to your instruction memory. This provides a feasible method to externally load the memory module which means that the synthesis tool must assume it knows nothing about the values stored in the instruction memory. If this is not included, much, if not all of the design is optimized out because the synthesis tool will believe the memory to be all zeros.
  with iInstLd select
    s_IMemAddr <= s_NextInstAddr when '0',
      iInstAddr when others;


  IMem: mem
    generic map(ADDR_WIDTH => ADDR_WIDTH,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_IMemAddr(11 downto 2),
             data => iInstExt,
             we   => iInstLd,
             q    => s_Inst);
  
  DMem: mem
    generic map(ADDR_WIDTH => ADDR_WIDTH,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_DMemAddr(11 downto 2),
             data => s_DMemData,
             we   => s_DMemWr,
             q    => s_DMemOut);

  -- TODO: Ensure that s_Halt is connected to an output control signal produced from decoding the Halt instruction (Opcode: 01 0100)
  -- TODO: Ensure that s_Ovfl is connected to the overflow output of your ALU

  -- TODO: Implement the rest of your processor below this comment! 


  PC: pc
    port map(i_CLK   => iCLK,
             i_RST   => iRST, 
             i_WE    => '1',
             i_D     => --TODO,
             o_Q     => s_NextInstAddr);

  RegDst: mux2t1
    port map(i_S     => s_Control(3),
             i_D0    => s_Inst(20 downto 16),
             i_D1    => s_Inst(15 downto 11),
             o_O     => s_RegWrData);

  s_RegWr <= s_Control(4);
  Registers: regFile
    port map(i_CLK   => iCLK,
             i_RST   => iRST,
             i_rD    => s_RegWrAddr,
             i_wE    => s_RegWr,
             i_rS    => s_Inst(25 downto 21),
             i_rT    => s_Inst(20 downto 16),
             i_Di    => s_RegWrData,
             o_rS    => s_RegOut1,
             o_rT    => s_DMemData);

  Extender: extender
    port map(i_D     => s_Inst(15 downto 0),
             i_S     => s_Control(2),
             o_Q     => s_ExtOut);

  ALUSrc: mux2t1
    port map(i_S     => s_Control(11),
             i_D0    => s_DMemData,
             i_D1    => s_ExtOut,
             o_O     => s_ALUIn);

  NewALU: newALU
    port map(i_A     => s_RegOut1,
             i_B     => s_ALUIn,
             i_ALUOp => s_Control(10 downto 7),
             o_CO    => s_ALUCarry,
             o_O     => s_Ovfl,
             o_Z     => s_ALUZero,
             o_F     => s_DMemAddr);
  oALUOut <= s_DMemAddr;

end structure;

