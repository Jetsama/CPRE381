-------------------------------------------------------------------------
-- Westin Chamberlain
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- fullAdder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 2-input 1-output multiplexor
--
--
-- NOTES:
-- 
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity fullAdder is

  port(i_N1          : in std_logic;
       i_N0          : in std_logic;
       i_C           : in std_logic;
       o_S           : out std_logic;
       o_C0          : out std_logic);

end fullAdder;

architecture structure of fullAdder is

component invg is
  port(i_A          : in std_logic;
       o_F          : out std_logic);
end component;

component andg2 is
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;

component org2 is
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;
  
  signal invC  : std_logic;
  signal invN0 : std_logic;
  signal invN1 : std_logic;
  signal s_notN1andN0 : std_logic;
  signal s_N1andnotN0 : std_logic;
  signal s_N1andN0 : std_logic;
  signal s_notN1andnotN0 : std_logic;
  signal s_c0expr1 : std_logic;
  signal s_c0expr2 : std_logic;
  signal s_c0expr3 : std_logic;
  signal s_c0expr4 : std_logic;
  signal s_sexpr1 : std_logic;
  signal s_sexpr2 : std_logic;
  signal s_sexpr3 : std_logic;
  signal s_sexpr4 : std_logic;
  signal s_c0or1 : std_logic;
  signal s_c0or2 : std_logic;
  signal s_c0or3 : std_logic;
  signal s_sor1 : std_logic;
  signal s_sor2 : std_logic;
  signal s_sor3 : std_logic;

begin

  InvertC : invg
	port MAP(i_A => i_C,
		 o_F => invC);
  InvertN0 : invg
	port MAP(i_A => i_N0,
		 o_F => invN0);
  InvertN1 : invg
	port MAP(i_A => i_N1,
		 o_F => invN1);

  notN1andN0: andg2
	port Map(i_A => invN1,
       		 i_B => i_N0,
      		 o_F => s_notN1andN0);
  N1andnotN0: andg2
	port Map(i_A => i_N1,
       		 i_B => invN0,
      		 o_F => s_N1andnotN0);
  N1andN0: andg2
	port Map(i_A => i_N1,
       		 i_B => i_N0,
      		 o_F => s_N1andN0);
  notN1andnotN0 : andg2
	port Map(i_A => invN1,
       		 i_B => invN0,
      		 o_F => s_notN1andnotN0);

  c0expr1 : andg2
	port Map(i_A => s_notN1andN0,
       		 i_B => i_C,
      		 o_F => s_c0expr1);
  c0expr2 : andg2
	port Map(i_A => s_N1andnotN0,
       		 i_B => i_C,
      		 o_F => s_c0expr2);
  c0expr3 : andg2
	port Map(i_A => s_N1andN0,
       		 i_B => invC,
      		 o_F => s_c0expr3);
  c0expr4 : andg2
	port Map(i_A => s_N1andN0,
       		 i_B => i_C,
      		 o_F => s_c0expr4);

  sexpr1 : andg2
	port Map(i_A => s_notN1andnotN0,
       		 i_B => i_C,
      		 o_F => s_sexpr1);
  sexpr2 : andg2
	port Map(i_A => s_notN1andN0,
       		 i_B => invC,
      		 o_F => s_sexpr2);
  sexpr3 : andg2
	port Map(i_A => s_N1andnotN0,
       		 i_B => invC,
      		 o_F => s_sexpr3);
  sexpr4 : andg2
	port Map(i_A => s_N1andN0,
       		 i_B => i_C,
      		 o_F => s_sexpr4);

  c0or1 : org2
	port Map(i_A => s_c0expr1,
       		 i_B => s_c0expr2,
      		 o_F => s_c0or1);
  c0or2 : org2
	port Map(i_A => s_c0expr3,
       		 i_B => s_c0expr4,
      		 o_F => s_c0or2);
  c0or3 : org2
	port Map(i_A => s_c0or1,
       		 i_B => s_c0or2,
      		 o_F => s_c0or3);

  sor1 : org2
	port Map(i_A => s_sexpr1,
       		 i_B => s_sexpr2,
      		 o_F => s_sor1);
  sor2 : org2
	port Map(i_A => s_sexpr3,
       		 i_B => s_sexpr4,
      		 o_F => s_sor2);
  sor3 : org2
	port Map(i_A => s_sor1,
       		 i_B => s_sor2,
      		 o_F => s_sor3);

  o_C0 <= s_c0or3;
  o_S <= s_sor3;
end structure;
