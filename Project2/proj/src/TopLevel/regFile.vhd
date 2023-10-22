-------------------------------------------------------------------------
-- Westin Chamberlain
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- regFile.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: 
--
-- NOTES:
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity regFile is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32. 
  port(i_CLK         : in std_logic;     -- Clock input
       i_RST         : in std_logic; --Reset all Registers
       i_rD          : in std_logic_vector(4 downto 0); --Write Select
       i_wE          : in std_logic; --Write Enable
       i_rS          : in std_logic_vector(4 downto 0); --Read Select
       i_rT          : in std_logic_vector(4 downto 0); --Read Select
       i_Di          : in std_logic_vector(N-1 downto 0); --rD input  
       o_rS          : out std_logic_vector(N-1 downto 0);    --rS output       
       o_rT          : out std_logic_vector(N-1 downto 0));   --rT output

end regFile;

architecture structural of regFile is

  component dffg_N is
    port(i_CLK        : in std_logic;     -- Clock input
         i_RST        : in std_logic;     -- Reset input
         i_WE         : in std_logic;     -- Write enable input
         i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
         o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output
  end component;

  component decoder5to32 is
    port(i_D          : in std_logic_vector(4 downto 0);     -- Data value input
         i_E          : in std_logic; --Data value enable
         o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output
  end component;

  component mux32to1 is
    port(i_S          : in std_logic_vector(4 downto 0);
         i_D0          : in std_logic_vector(N-1 downto 0);
         i_D1          : in std_logic_vector(N-1 downto 0);  
         i_D2          : in std_logic_vector(N-1 downto 0);
         i_D3          : in std_logic_vector(N-1 downto 0);
         i_D4          : in std_logic_vector(N-1 downto 0);
         i_D5          : in std_logic_vector(N-1 downto 0);  
         i_D6          : in std_logic_vector(N-1 downto 0);
         i_D7          : in std_logic_vector(N-1 downto 0);
         i_D8          : in std_logic_vector(N-1 downto 0);
         i_D9          : in std_logic_vector(N-1 downto 0);  
         i_D10         : in std_logic_vector(N-1 downto 0);
         i_D11         : in std_logic_vector(N-1 downto 0);
         i_D12         : in std_logic_vector(N-1 downto 0);
         i_D13         : in std_logic_vector(N-1 downto 0);  
         i_D14         : in std_logic_vector(N-1 downto 0);
         i_D15         : in std_logic_vector(N-1 downto 0);
         i_D16         : in std_logic_vector(N-1 downto 0);
         i_D17         : in std_logic_vector(N-1 downto 0);  
         i_D18         : in std_logic_vector(N-1 downto 0);
         i_D19         : in std_logic_vector(N-1 downto 0);
         i_D20         : in std_logic_vector(N-1 downto 0);
         i_D21         : in std_logic_vector(N-1 downto 0);  
         i_D22         : in std_logic_vector(N-1 downto 0);
         i_D23         : in std_logic_vector(N-1 downto 0);
         i_D24         : in std_logic_vector(N-1 downto 0);
         i_D25         : in std_logic_vector(N-1 downto 0);  
         i_D26         : in std_logic_vector(N-1 downto 0);
         i_D27         : in std_logic_vector(N-1 downto 0);
         i_D28         : in std_logic_vector(N-1 downto 0);
         i_D29         : in std_logic_vector(N-1 downto 0);  
         i_D30         : in std_logic_vector(N-1 downto 0);
         i_D31         : in std_logic_vector(N-1 downto 0);   -- Data value input
         o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output
  end component;

signal regSelect : std_logic_vector(N-1 downto 0);
signal reg0Output : std_logic_vector(N-1 downto 0);
signal reg1Output : std_logic_vector(N-1 downto 0);
signal reg2Output : std_logic_vector(N-1 downto 0);
signal reg3Output : std_logic_vector(N-1 downto 0);
signal reg4Output : std_logic_vector(N-1 downto 0);
signal reg5Output : std_logic_vector(N-1 downto 0);
signal reg6Output : std_logic_vector(N-1 downto 0);
signal reg7Output : std_logic_vector(N-1 downto 0);
signal reg8Output : std_logic_vector(N-1 downto 0);
signal reg9Output : std_logic_vector(N-1 downto 0);
signal reg10Output : std_logic_vector(N-1 downto 0);
signal reg11Output : std_logic_vector(N-1 downto 0);
signal reg12Output : std_logic_vector(N-1 downto 0);
signal reg13Output : std_logic_vector(N-1 downto 0);
signal reg14Output : std_logic_vector(N-1 downto 0);
signal reg15Output : std_logic_vector(N-1 downto 0);
signal reg16Output : std_logic_vector(N-1 downto 0);
signal reg17Output : std_logic_vector(N-1 downto 0);
signal reg18Output : std_logic_vector(N-1 downto 0);
signal reg19Output : std_logic_vector(N-1 downto 0);
signal reg20Output : std_logic_vector(N-1 downto 0);
signal reg21Output : std_logic_vector(N-1 downto 0);
signal reg22Output : std_logic_vector(N-1 downto 0);
signal reg23Output : std_logic_vector(N-1 downto 0);
signal reg24Output : std_logic_vector(N-1 downto 0);
signal reg25Output : std_logic_vector(N-1 downto 0);
signal reg26Output : std_logic_vector(N-1 downto 0);
signal reg27Output : std_logic_vector(N-1 downto 0);
signal reg28Output : std_logic_vector(N-1 downto 0);
signal reg29Output : std_logic_vector(N-1 downto 0);
signal reg30Output : std_logic_vector(N-1 downto 0);
signal reg31Output : std_logic_vector(N-1 downto 0);
signal o_oDo : std_logic_vector(N-1 downto 0);



begin

  WriteDecoder : decoder5to32
 	port Map(i_D  => i_rD,
       	         i_E  => i_wE,
 	         o_Q  => regSelect);
	
  Reg0 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(0),
	         i_D    => x"00000000",
	         o_Q    => reg0Output);
  Reg1 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(1),
	         i_D    => i_Di,
	         o_Q    => reg1Output);
  Reg2 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(2),
	         i_D    => i_Di,
	         o_Q    => reg2Output);
  
  Reg3 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(3),
	         i_D    => i_Di,
	         o_Q    => reg3Output);
  Reg4 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(4),
	         i_D    => i_Di,
	         o_Q    => reg4Output);
  
  Reg5 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(5),
	         i_D    => i_Di,
	         o_Q    => reg5Output);
  Reg6 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(6),
	         i_D    => i_Di,
	         o_Q    => reg6Output);
  
  Reg7 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(7),
	         i_D    => i_Di,
	         o_Q    => reg7Output);
  Reg8 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(8),
	         i_D    => i_Di,
	         o_Q    => reg8Output);
  
  Reg9 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(9),
	         i_D    => i_Di,
	         o_Q    => reg9Output);
  Reg10 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(10),
	         i_D    => i_Di,
	         o_Q    => reg10Output);
  
  Reg11 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(11),
	         i_D    => i_Di,
	         o_Q    => reg11Output);
  Reg12 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(12),
	         i_D    => i_Di,
	         o_Q    => reg12Output);
  
  Reg13 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(13),
	         i_D    => i_Di,
	         o_Q    => reg13Output);
  Reg14 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(14),
	         i_D    => i_Di,
	         o_Q    => reg14Output);
  
  Reg15 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(15),
	         i_D    => i_Di,
	         o_Q    => reg15Output);
  Reg16 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(16),
	         i_D    => i_Di,
	         o_Q    => reg16Output);
  
  Reg17 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(17),
	         i_D    => i_Di,
	         o_Q    => reg17Output);
  Reg18 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(18),
	         i_D    => i_Di,
	         o_Q    => reg18Output);
  
  Reg19 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(19),
	         i_D    => i_Di,
	         o_Q    => reg19Output);    
  Reg20 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(20),
	         i_D    => i_Di,
	         o_Q    => reg20Output);
  
  Reg21 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(21),
	         i_D    => i_Di,
	         o_Q    => reg21Output);
  Reg22 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(22),
	         i_D    => i_Di,
	         o_Q    => reg22Output);
  
  Reg23 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(23),
	         i_D    => i_Di,
	         o_Q    => reg23Output);
  Reg24 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(24),
	         i_D    => i_Di,
	         o_Q    => reg24Output);
  
  Reg25 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(25),
	         i_D    => i_Di,
	         o_Q    => reg25Output);
  Reg26 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(26),
	         i_D    => i_Di,
	         o_Q    => reg26Output);
  
  Reg27 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(27),
	         i_D    => i_Di,
	         o_Q    => reg27Output);
  Reg28 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(28),
	         i_D    => i_Di,
	         o_Q    => reg28Output);
  
  Reg29 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(29),
	         i_D    => i_Di,
	         o_Q    => reg29Output);
  Reg30 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(30),
	         i_D    => i_Di,
	         o_Q    => reg30Output);
  
  Reg31 : dffg_N
	port Map(i_CLK  => i_CLK,
 	         i_RST  => i_RST,
	         i_WE   => regSelect(31),
	         i_D    => i_Di,
	         o_Q    => reg31Output);

  ReadMux : mux32to1
	port Map(i_S    => i_rS,
	         i_D0   => reg0Output,
	         i_D1   => reg1Output,
	         i_D2   => reg2Output,
	         i_D3   => reg3Output,
	         i_D4   => reg4Output,
       	         i_D5   => reg5Output, 
  	         i_D6   => reg6Output,
	         i_D7   => reg7Output,
	         i_D8   => reg8Output,
	         i_D9   => reg9Output,
 	         i_D10  => reg10Output,
  	         i_D11  => reg11Output,
 	         i_D12  => reg12Output,
	         i_D13  => reg13Output,
	         i_D14  => reg14Output,
	         i_D15  => reg15Output,
	         i_D16  => reg16Output,
	         i_D17  => reg17Output, 
	         i_D18  => reg18Output,
	         i_D19  => reg19Output,
	         i_D20  => reg20Output,
	         i_D21  => reg21Output,
	         i_D22  => reg22Output,
	         i_D23  => reg23Output,
	         i_D24  => reg24Output,
	         i_D25  => reg25Output, 
	         i_D26  => reg26Output,
	         i_D27  => reg27Output,
	         i_D28  => reg28Output,
	         i_D29  => reg29Output,
	         i_D30  => reg30Output,
	         i_D31  => reg31Output,
	         o_Q    => o_rS);

  ReadMux2 : mux32to1
	port Map(i_S    => i_rT,
	         i_D0   => reg0Output,
	         i_D1   => reg1Output,
	         i_D2   => reg2Output,
	         i_D3   => reg3Output,
	         i_D4   => reg4Output,
       	         i_D5   => reg5Output, 
  	         i_D6   => reg6Output,
	         i_D7   => reg7Output,
	         i_D8   => reg8Output,
	         i_D9   => reg9Output,
 	         i_D10  => reg10Output,
  	         i_D11  => reg11Output,
 	         i_D12  => reg12Output,
	         i_D13  => reg13Output,
	         i_D14  => reg14Output,
	         i_D15  => reg15Output,
	         i_D16  => reg16Output,
	         i_D17  => reg17Output, 
	         i_D18  => reg18Output,
	         i_D19  => reg19Output,
	         i_D20  => reg20Output,
	         i_D21  => reg21Output,
	         i_D22  => reg22Output,
	         i_D23  => reg23Output,
	         i_D24  => reg24Output,
	         i_D25  => reg25Output, 
	         i_D26  => reg26Output,
	         i_D27  => reg27Output,
	         i_D28  => reg28Output,
	         i_D29  => reg29Output,
	         i_D30  => reg30Output,
	         i_D31  => reg31Output,
	         o_Q    => o_rT);
end structural;
