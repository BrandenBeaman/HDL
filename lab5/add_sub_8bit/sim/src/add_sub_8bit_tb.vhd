
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
	  
	  btn           : in std_logic;
	  
	  led_a         : out std_logic;
	  led_b         : out std_logic;
	  led_add       : out std_logic;
	  led_sub       : out std_logic;
	   selo  : out std_logic_vector(1 downto 0)
	 );
	 
end component;
                                             
signal clk          : std_logic := '0';
constant period     : time := 20ns;   
signal reset        : std_logic := '1';

signal btn_sig          : std_logic;

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
    wait for 500 ns;
    btn_sig <= '0';
	wait for 500 ns;
 end loop;
	
end process;

uut1: top  

  port map(
    clk_50mhz  => clk,
    reset      => reset,
	
	btn => btn_sig,
	
    led_a      => open,
    led_b      => open,
    led_add    => open,
    led_sub    => open,
	selo  => open
	
  );

end arch;