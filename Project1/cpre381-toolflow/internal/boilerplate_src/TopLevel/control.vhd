-------------------------------------------------------------------------
-- Westin Chamberlain
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- control.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: 
--
-- NOTES:
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all; --000000000000 ALUSrc 1, ALUOp 4, MemtoReg 1, MemWr 1, RegWr 1, RegDst 1, Ext 1, Branch 1, Jump 1 

entity control is
  port(i_O         : in std_logic_vector(5 downto 0); --OPCODE
       i_F         : in std_logic_vector(5 downto 0); --Function
       o_O          : out std_logic_vector(11 downto 0));

end control;

architecture structural of control is

signal s_Control : std_logic_vector(11 downto 0); --12 Total Bits


begin

with i_F select s_Control <=
		"000100011000" when "100000", --add  ALUOP: 0010
                "000000011000" when "100001", --addu        0000 
	        "001010011000" when "100100", --and         0101
                "001110011000" when "100110", --xor         0111
		"001100011000" when "100101", --or          0110
                "000110011000" when "101010", --slt         0011
	        "010010011000" when "000000", --sll         1001
                "010100011000" when "000010", --srl         1010
		"010110011000" when "000011", --sra         1011
                "000010011000" when "100010",--sub          0001
	        "000000000001" when "001000", --jr          0000
                "011110011000" when "100111", --nor         1111
		"000000000000" when others;

with i_O select o_O <=
		s_Control when "000000",
		"100100010100" when "001000",--addi         0010
                "100000010100" when "001001", --addiu       0000
		"101010010000" when "001100", --andi        0101
                "111100010000" when "001111", --lui         1110
		"100110010100" when "001010", --slti        0011
                "101110010000" when "001110", --xori        0111
		"101100010000" when "001101", --ori         0110
                "100001010100" when "100011", --lw          0000
                "100000000100" when "101011", --sw          0000
		"000000000010" when "000100", --beq         0000
                "000000000010" when "000101", --bne         0000

		"000000011000" when "000010", --j           0000
                "000000011000" when "000011", --jal         0000
		"000000000000" when others;
		--"000000000000" when (i_O = "000000") else --not //TODO
       
  
end structural;
