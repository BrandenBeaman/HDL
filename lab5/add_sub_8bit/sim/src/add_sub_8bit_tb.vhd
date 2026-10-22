
-------------------------------------------------------------------------------
-- Branden
--  add sub 8 bit test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_sub_8bit_tb is
end add_sub_8bit_tb;

architecture arch of add_sub_8bit_tb is

component top is
   port (
	  clk_50mhz     : in std_logic;
	  reset         : in std_logic;
	  
	  a             : in std_logic_vector(7 downto 0);
	  b             : in std_logic_vector(7 downto 0);
	  
	  btn           : in std_logic;
	  
	  led_a         : out std_logic;
	  led_b         : out std_logic;
	  led_add       : out std_logic;
	  led_sub       : out std_logic;
	  
	  seven_seg_ones : out std_logic_vector(6 downto 0);
	  seven_seg_tens : out std_logic_vector(6 downto 0);
	  seven_seg_hundreds : out std_logic_vector(6 downto 0);
	  
	  
	  selo  : out std_logic_vector(1 downto 0)
	  
	 );
	 
end component;
                                             
signal clk          : std_logic := '0';
constant period     : time := 20ns;   
signal reset        : std_logic := '1';

signal btn_sig          : std_logic;

signal a_sig : std_logic_vector(7 downto 0);
signal b_sig : std_logic_vector(7 downto 0);

signal seven_seg_ones_sig : std_logic_vector(6 downto 0);
signal seven_seg_tens_sig : std_logic_vector(6 downto 0);
signal seven_seg_hundreds_sig : std_logic_vector(6 downto 0);

signal led_a        : std_logic;
signal led_b        : std_logic;
signal led_add      : std_logic;
signal led_sub      : std_logic;

begin

-- clock process
clock: process
  begin
    clk <= not clk;
    wait for period/2;
end process; 
 
-- reset process
async_reset: process
  begin
    wait for 2 * period;
    reset <= '0';
    wait;
end process; 

-- Stimulus process
stimuli_btn: process
begin

 loop 
    btn_sig <= '1';
    wait for 100 ns;
    btn_sig <= '0';
	wait for 100 ns;
 end loop;
	
end process;

-- Stimulus process
stimuli: process
begin
    -- Test 1: A = 5, B = 2
    a_sig <= "00000101";
    b_sig <= "00000010";
    wait for 1 us;

    -- Test 2: A = 2, B = 5
    a_sig <= "00000010";
    b_sig <= "00000101";
    wait for 1 us;

    -- Test 3: A = 200, B = 100
    a_sig <= "11001000";
    b_sig <= "01100100";
    wait for 1 us;

    -- Test 4: A = 100, B = 200
    a_sig <= "01100100";
    b_sig <= "11001000";
    wait for 1 us;

    wait;
end process;

uut1: top  

  port map(
    clk_50mhz  => clk,
    reset      => reset,
	
	btn => btn_sig,
	a => a_sig,
	b => b_sig,
	
	  seven_seg_ones => seven_seg_ones_sig,
	  seven_seg_tens => seven_seg_tens_sig,
	  seven_seg_hundreds => seven_seg_hundreds_sig,
	  
	
    led_a      => open,
    led_b      => open,
    led_add    => open,
    led_sub    => open,
	selo  => open
  );

end arch;