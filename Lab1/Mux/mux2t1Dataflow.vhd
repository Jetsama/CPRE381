library IEEE;
use IEEE.std_logic_1164.all;

entity mux2t1Dataflow is

  port(i_A          : in std_logic;
	i_B          : in std_logic;
	i_C          : in std_logic;
       o_F          : out std_logic);

end mux2t1Dataflow;

architecture dataflow of mux2t1Dataflow is
begin

  o_F <= i_B when i_C = '1' else
	i_A;
  
end dataflow;