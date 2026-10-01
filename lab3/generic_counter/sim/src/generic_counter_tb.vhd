
-------------------------------------------------------------------------------
-- Dr. Kaputa
-- generic counter test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity generic_counter_tb is
end generic_counter_tb;

architecture arch of generic_counter_tb is


component top is
   port (
     clk_50mhz     : in std_logic;
	 reset         : in std_logic;
	 seven_seg_out : out std_logic_vector(6 downto 0)
	 );
	 
end component;
                                             
signal clk          : std_logic := '0';
constant period     : time := 20ns;   
signal reset        : std_logic := '1';
signal output       : std_logic_vector(6 downto 0);

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

uut1: top  

  port map(
    clk_50mhz       => clk,
    reset     => reset,
    seven_seg_out    => open
  );

end arch;