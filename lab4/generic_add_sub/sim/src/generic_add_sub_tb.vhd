
-------------------------------------------------------------------------------
-- Branden
-- generic add sub test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity generic_add_sub_tb is
end generic_add_sub_tb;

architecture arch of generic_add_sub_tb is


component top is
port ( 
     clk_50mhz     : in std_logic;
	 reset         : in std_logic;
	 
     a             : in std_logic_vector(2 downto 0);
	 b             : in std_logic_vector(2 downto 0);
	 add_btn       : in std_logic;
	 sub_btn       : in std_logic;
	 a_bcd         : out std_logic_vector(6 downto 0);
	 b_bcd         : out std_logic_vector(6 downto 0);
	 result_bcd    : out std_logic_vector(6 downto 0)
 

	 );
	 
end component;
                                             
signal clk          : std_logic := '0';
constant period     : time := 20ns;   
signal reset        : std_logic := '1';

signal a_in         : std_logic_vector(2 downto 0);
signal b_in         : std_logic_vector(2 downto 0);

signal add_sig      : std_logic;
signal sub_sig      : std_logic;

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
    sub_sig <= '0';
    add_sig <= '1';
    wait for 1400 ns;
    add_sig <= '0';

    sub_sig <= '1';
    wait for 1400 ns;
    sub_sig <= '0';
end process;

stimuli_ab: process
begin

  while true loop
 
    for i in 0 to 7 loop
      a_in <= std_logic_vector(to_unsigned(i, 3));
      
  
      for j in 0 to 7 loop
        b_in <= std_logic_vector(to_unsigned(j, 3));
        wait for 20 ns; 
      end loop;
      
    end loop;
  end loop;
end process;

uut1: top  

  port map(
    clk_50mhz  => clk,
    reset      => reset,
	
	a => a_in,
	b => b_in,
	
	add_btn => add_sig,
	sub_btn => sub_sig,
	
    a_bcd      => open,
	b_bcd      => open,
	result_bcd => open
  );

end arch;