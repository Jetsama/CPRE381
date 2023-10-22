library IEEE;
use IEEE.std_logic_1164.all;

entity inverter is

  port(i_S          : in std_logic;
       	o_O          : out std_logic);

end inverter;

architecture dataflow of inverter is
begin

  o_O <= (not i_S);
  
end dataflow;