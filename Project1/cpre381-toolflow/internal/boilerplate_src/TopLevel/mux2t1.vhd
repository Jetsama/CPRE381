-------------------------------------------------------------------------
-- TJ Thielen
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- mux2t1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide 2:1
-- mux using structural VHDL.
--
-- NOTES: 
-- 9/5/22 by TJ::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux2t1 is
  port(i_S          : in std_logic;
       i_D0         : in std_logic;
       i_D1         : in std_logic;
       o_O          : out std_logic);
end mux2t1;

architecture structural of mux2t1 is
 component org2
    port(i_A             : in std_logic;
         i_B             : in std_logic;
         o_F             : out std_logic);
  end component;

  component andg2
    port(i_A             : in std_logic;
         i_B             : in std_logic;
         o_F             : out std_logic);
  end component;

  component invg
    port(i_A             : in std_logic;
         o_F             : out std_logic);
  end component;

  
  -- Signal to carry s & D1
  signal s_D1        : std_logic;
  -- Signal to carry ~s & D0
  signal s_D0        : std_logic;
  -- Signal to carry ~s
  signal s_N         : std_logic;

begin
 g_and1: andg2
    port MAP(i_A               => i_S,
             i_B               => i_D1,
             o_F               => s_D1);
 g_not: invg
    port MAP(i_A               => i_S,
             o_F               => s_N);
 g_and2: andg2
    port MAP(i_A               => s_N,
             i_B               => i_D0,
             o_F               => s_D0);
 g_org2: org2
    port MAP(i_A               => s_D1,
             i_B               => s_D0,
             o_F               => o_O);
end structural;
