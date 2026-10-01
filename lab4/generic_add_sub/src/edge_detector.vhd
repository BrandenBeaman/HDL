-------------------------------------------------------------------------------
-- Dr. Kaputa
-- edge detector example
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

entity edge_detector is 
  port (
    clk               : in std_logic;
    reset             : in std_logic;
    input             : in std_logic;
    edge              : out std_logic
  );
end edge_detector;

architecture beh of edge_detector is

signal prev_input     : std_logic := '1';

begin 
process(reset,clk,input)
  begin
    if reset = '1' then
      edge <= '0';
    elsif rising_edge(clk) then
      prev_input <= input;
      edge <= input xor prev_input;
    end if;
end process;
end beh; 