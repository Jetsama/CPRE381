library IEEE;
use IEEE.std_logic_1164.all;

entity ForwardingUnit is
  generic(N : integer := 32);
  port (i_RegWr			: in std_logic_vector(4 downto 0);
	i_ExReg1		: in std_logic_vector(4 downto 0);
	i_ExReg2		: in std_logic_vector(4 downto 0);
	o_reg1Haz		: out std_logic;
	o_reg2Haz		: out std_logic);
end  ForwardingUnit;



architecture structure of ForwardingUnit is

begin


 process (i_RegWr,i_ExReg1)
    begin
        if ((i_RegWr = i_ExReg1) and (i_ExReg1 /= "00000")) then
            o_reg1Haz <= '1';
        else 
            o_reg1Haz <= '0';
        end if;
    end process;

 process (i_RegWr,i_ExReg2)
    begin
        if ((i_RegWr = i_ExReg2) and (i_ExReg2 /= "00000")) then
            o_reg2Haz <= '1';
        else 
            o_reg2Haz <= '0';
        end if;
    end process;

end structure;