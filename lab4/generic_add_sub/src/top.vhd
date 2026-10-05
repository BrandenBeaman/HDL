--Branden Beaman
-- generic_add_sub top

library ieee;
use ieee.std_logic_1164.all;

entity top is
  port ( 
     clk_50mhz     : in std_logic;
	 reset         : in std_logic;
	 
     a             : in std_logic;
	 b             : in std_logic;
	 add_btn       : in std_logic;
	 sub_btn       : in std_logic;
	 a_bcd         : out std_logic_vector(6 downto 0);
	 b_bcd         : out std_logic_vector(6 downto 0);
	 result_bcd    : out std_logic_vector(6 downto 0);
 

	 );
	end top;
	
architecture beh of top is 
	
component generic_add_sub is 
	generic (
    bits    : integer := 3
  );
  port (
    a       : in  std_logic_vector(bits-2 downto 0);
    b       : in  std_logic_vector(bits-2 downto 0);
    add_en  : in std_logic;
	sub_en  : in std_logic;
    sum     : out std_logic_vector(bits-2 downto 0);
    cout    : out std_logic
  );
end component;  

component synchronizer_3bit is 
   port (
    clk               : in std_logic;
    reset             : in std_logic;
    async_in          : in std_logic_vector(2 downto 0);
    sync_out          : out std_logic_vector(2 downto 0)
  );
end component;

component seven_seg is

    port ( 
    clk             : in std_logic;
    reset           : in std_logic;
    bcd             : in std_logic_vector(3 downto 0);
    seven_seg_out   : out std_logic_vector(6 downto 0)
  ); 

end component;

component rising_edge_synchronizer is
 port (
    clk               : in std_logic;
    reset             : in std_logic;
    input             : in std_logic;
    edge              : out std_logic
  );

end component;


signal a_sync  : std_logic_vector(bits-2 downto 0);
signal b_sync  : std_logic_vector(bits-2 downto 0);

signal add_en  : std_logic;
signal sub_en  : std_logic;


signal a_4bit       : std_logic_vector(3 downto 0);
signal b_4bit       : std_logic_vector(3 downto 0);
signal result_4bit  : std_logic_vector(3 downto 0);

begin

-- a and b silder input to syncs
u_a_synchronizer: synchronizer_3bit
  port map(
    clk       => clk_50mhz,
    reset     => reset,       
    async_in  => a,  
    sync_out  => a_sync
);

u_B_synchronizer: synchronizer_3bit
  port map(
    clk       => clk_50mhz,
    reset     => reset,       
    async_in  => b,  
    sync_out  => b_sync
);	

-- add and sub button inputs to rising_edge_synchronizer
u_add_rising_edge_sync: rising_edge_synchronizer
     port map (
	clk     => clk_50mhz,             
    reset   => reset,          
    input   => add_btn,          
    edge    => add_en         
	 );
	 
 u_sub_rising_edge_synchronizer: rising_edge_synchronizer
     port map (
	clk     => clk_50mhz,             
    reset   => reset,          
    input   => sub_btn,          
    edge    => sub_en          
	 );

-- a_sync, b_sync, add_en, sub_en, to generic_add_sub to result_ 4bit 
u_generic_add_sub: generic_add_sub
   generic (
    bits    : integer := 3
  );
  port (
    a      => a_sync,
    b      => b_sync,
    add_en => add_en, 
	sub_en => sub_en,
    sum    => result_4bit,
    cout   => open
  );
  
u_a_seven_seg: seven_seg
   port map( 
    clk           => clk_50mhz,
    reset         => reset,
    bcd           => a_4bit,
    seven_seg_out => a_bcd
);

u_b_seven_seg: seven_seg
   port map( 
    clk           => clk_50mhz,
    reset         => reset,
    bcd           => b_4bit,
    seven_seg_out => b_bcd
);

u_result_seven_seg: seven_seg
   port map( 
    clk           => clk_50mhz,
    reset         => reset,
    bcd           => result_4bit,
    seven_seg_out => result_bcd
);

  
end beh;
