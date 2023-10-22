library IEEE;
use IEEE.std_logic_1164.all;

entity mux2t1 is

  port(i_A          : in std_logic;
	i_B          : in std_logic;
	i_C        : in std_logic;
       o_F          : out std_logic);

end mux2t1;

architecture structure of mux2t1 is

component invg is

  port(i_A          : in std_logic;
       o_F          : out std_logic);

end component;

component andg2

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

component org2 is

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

  signal s_xsN_and, s_ys_and, s_sN         : std_logic;


begin

g_sN_not: invg
    port MAP(i_A               => i_C,
             o_F               => s_sN);
g_ys_and: andg2
    port MAP(i_A               => i_B,
             i_B               => i_C,
             o_F               => s_ys_and);

g_xsN_and: andg2
    port MAP(i_A               => i_A,
             i_B               => s_SN,
             o_F               => s_xsN_and);


g_mux_or: org2
    port MAP(i_A               => s_ys_and,
             i_B               => s_xsN_and,
             o_F               => o_F);
  --o_F <= ((not i_C) and i_A) or (i_B and I_C);
  
end structure;