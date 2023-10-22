
library IEEE;
use IEEE.std_logic_1164.all;

entity mux32t1_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_S          : in std_logic_vector(5-1 downto 0); --integer range 0 to 31;
       i_I         : in std_logic_vector((32)*N -1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));

end mux32t1_N;

architecture structural of mux32t1_N is

  component mux32t1 is
    port(i_S          : in std_logic_vector(5-1 downto 0); --integer range 0 to 31;
       i_I         : in std_logic_vector(32-1 downto 0);
       o_O          : out std_logic);
  end component;


signal s_c   : std_logic_vector(N-1 downto 0);
signal v_I : std_logic_vector((32)*N -1 downto 0);
begin



generate_label: for i in 0 to 31 generate
    generate_label2:for j in 0 to 31 generate
      v_I(i*32 + j) <= i_I(i +j*32);
    end generate;
  end generate;


  -- Instantiate N mux instances.
  G_NBit_MUX: for i in 0 to N-1 generate
    MUXI: mux32t1 port map(
              i_S      => i_S,      -- All instances share the same select input.
		i_I     => v_I(i*N+N-1 downto i*N),
         --     i_I     => {i_I(i*N),i_I((i+1)*N),i_I((i+2)*N),i_I((i+3)*N),i_I((i+4)*N),
--i_I((i+5)*N),i_I((i+6)*N),i_I((i+7)*N),i_I((i+8)*N),i_I((i+9)*N),i_I((i+10)*N),
--i_I((i+11)*N),i_I((i+12)*N),i_I((i+13)*N),i_I((i+14)*N),i_I((i+15)*N),i_I((i+16)*N),
--i_I((i+17)*N),i_I((i+18)*N),i_I((i+19)*N),i_I((i+20)*N),i_I((i+21)*N),i_I((i+22)*N),
--i_I((i+23)*N),i_I((i+24)*N),i_I((i+25)*N),i_I((i+26)*N),i_I((i+27)*N),i_I((i+28)*N),
--i_I((i+29)*N),i_I((i+30)*N),i_I((i+31)*N)},  -- ith instance's data 1 input hooked up to ith data 1 input.
              o_O      => o_O(i));  -- ith instance's data output hooked up to ith data output.
  end generate G_NBit_MUX;

end structural;