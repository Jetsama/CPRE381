-------------------------------------------------------------------------
-- Westin Chamberlain
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- newALU.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: 
--
-- NOTES:
-- Command List:
--Addu- 0000 0
--Add - 0010 2 
--Sub - 0001 1 
--Slt - 0011 3
--And - 0101 5 
--Or -  0110 6 
--Xor - 0111 7
--Nor - 1011 11 
--Not - 1101 13 
--Lui - 1110 14 
--Sll - 1001 9 
--Srl - 1010 10 
--Sra - 1111 15 
--Repl.qb - 1000 8 
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity newALU is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       i_ALUOp      : in std_logic_vector(3 downto 0);
       o_CO         : out std_logic;
       o_O          : out std_logic;
       o_Z          : out std_logic;
       o_F          : out std_logic_vector(N-1 downto 0));

end newALU;

architecture mixed of newALU is

  component adderSubtractor is
    port(nAdd_Sub          : in std_logic;
         i_A         : in std_logic_vector(N-1 downto 0);
         i_B         : in std_logic_vector(N-1 downto 0);
         o_CO        : out std_logic;
         o_O          : out std_logic_vector(N-1 downto 0));
  end component;
  
  component barrel_shifter is
    port(i_d		: in STD_LOGIC_VECTOR(31 downto 0);
	i_sra		: in STD_LOGIC;
	i_shamt		: in STD_LOGIC_VECTOR(4 downto 0);
	i_shLeft	: in STD_LOGIC;
	o_o		: out STD_LOGIC_VECTOR(31 downto 0));
  end component;

  component onesComp is
    port(i_A         : in std_logic_vector(N-1 downto 0);
         o_F          : out std_logic_vector(N-1 downto 0));
  end component;

signal s_oAdder : std_logic_vector(N-1 downto 0);
signal s_obShifter : std_logic_vector(N-1 downto 0);
signal s_cOAdder : std_logic;
signal s_oF : std_logic_vector(N-1 downto 0);
signal s_oTmp : std_logic_vector(N-1 downto 0);
signal s_sra : std_logic;
signal s_shleft: std_logic;

--For simple operations like and and or, just loop through index and perform operation

begin
  s_sra <= '1' when i_ALUOp = "1111" else '0';
  s_shleft <= '0' when i_ALUOp(1) = '1' else '1'; --Putting "NOT" in front of i_ALUOp(1) in the actual mapping was erroring out and this was the only workaround I could see
  bShifter : barrel_shifter
	port Map(i_d  => i_A,
		 i_sra => s_sra,
     		 i_shamt => i_B(4 downto 0),
    		 i_shleft => s_shleft,
   		 o_o  => s_obShifter);

  Adder : adderSubtractor
	port Map(nAdd_Sub => i_ALUOp(0), --Only changes between add and sub are last bit of ALU used to differentiate them
       		 i_A  => i_A,
         	 i_B  => i_B,
		 o_CO => s_cOAdder,
         	 o_O  => s_oAdder);
    
  process(i_ALUOp, i_A, i_B, s_oAdder, s_obShifter, s_cOAdder, s_oF, s_oTmp, s_shleft, s_sra)
  begin

    if(i_ALUOp = "0000") then --Addu
      s_oF <= s_oAdder;
    elsif(i_ALUOp = "0001") then --Sub
      s_oF <= s_oAdder;
    elsif(i_ALUOp = "0010") then --Add
      s_oF <= s_oAdder;
    elsif(i_ALUOp = "0011") then --Slt
      if(s_oAdder(31) = '1')  then
        s_oF <= x"00000001";
      elsif (s_oAdder(31) = '0') then
        s_oF <= x"00000000";
      else
        s_oF <= x"11111111";
      end if;
    elsif(i_ALUOp = "0101") then --And
      for i in 0 to 31 loop
	s_oTmp(i) <= i_A(i) AND i_B(i);
      end loop;
      s_oF <= s_oTmp;
    elsif(i_ALUOp = "0110") then --Or
      for i in 0 to 31 loop
	s_oTmp(i) <= i_A(i) OR i_B(i);
      end loop;	  
      s_oF <= s_oTmp;
    elsif(i_ALUOp = "0111") then --Xor
      for i in 0 to 31 loop
	s_oTmp(i) <= i_A(i) XOR i_B(i);
      end loop;	  
      s_oF <= s_oTmp;
    elsif(i_ALUOp = "1011") then --Nor
      for i in 0 to 31 loop
	s_oTmp(i) <= i_A(i) NOR i_B(i);
      end loop;	  
      s_oF <= s_oTmp;
    elsif(i_ALUOp = "1101") then --Not
      s_oF <= not i_A;
    elsif(i_ALUOp = "1110") then --Lui
      s_oTmp <= x"00000000";
      for i in 16 to 31 loop
        s_oTmp(i) <= i_B(i-16);
      end loop;
      s_oF <= s_oTmp;
    elsif(i_ALUOp = "1001") then --Sll
      s_oF <= s_obShifter;
    elsif(i_ALUOp = "1010") then --Srl
      s_oF <= s_obShifter;
    elsif(i_ALUOp = "1111") then --Sra
      s_oF <= s_obShifter;
    --elsif(i_ALUOp = "1000") then --Repl.qb
      --TODO
    else
      s_oF <= x"FEED1111";
    end if;

    if(s_oF = x"00000000") then
      o_Z <= '1';
    else
      o_Z <= '0';
    end if;

  end process;
  
  o_F <= s_oF;
end mixed;
