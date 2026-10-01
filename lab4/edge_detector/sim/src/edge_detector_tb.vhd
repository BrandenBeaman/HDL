-------------------------------------------------------------------------------
-- Dr. Kaputa
-- edge detector test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      -- gives you the std_logic type

entity edge_detector_tb is 
end edge_detector_tb;

architecture beh of edge_detector_tb is

component edge_detector is 
  port (
    clk               : in std_logic;
    reset             : in std_logic;
    input             : in std_logic;
    edge              : out std_logic
  );
end component;
  
constant period         : time := 20ns;                                              
signal clk              : std_logic := '0';
signal reset            : std_logic := '1';
signal input            : std_logic := '1';
signal edge             : std_logic;

begin 
uut: edge_detector 
  port map(
    clk               => clk,
    reset             => reset,
    input             => input,
    edge              => edge
  );
 
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
    
main: process 
  begin
    report "****************** TB Start ****************" severity note;
    wait for 5 * period/2;
    input <= '0';
    wait for 20 * period/2;
    input <= '1';
    report "****************** TB Finish ****************" severity note;
    wait;
  end process;  
end beh;