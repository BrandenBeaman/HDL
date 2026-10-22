-------------------------------------------------------------------------------
-- Branden Beaman
-- generic adder and subtractor [behavioral]
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_sub_8bit is
  generic (
    bits    : integer := 8
  );
  port (
    clk     : in std_logic;
	reset   : in std_logic;
    a       : in  std_logic_vector(bits-1 downto 0);
    b       : in  std_logic_vector(bits-1 downto 0);
    sum     : out std_logic_vector(bits downto 0);
	diff    : out std_logic_vector(bits downto 0)
  );
end entity add_sub_8bit;

architecture beh of add_sub_8bit is

  signal math_temp_sum : std_logic_vector(bits downto 0);
  signal math_temp_diff : std_logic_vector(bits downto 0);
  signal b_mod : std_logic_vector(bits downto 0);


begin

 b_mod <= not('0' & b);
 
-- clocked arethmetic process
operation: process(clk,reset)
   begin
   if reset = '1' then
     math_temp_sum  <= "000000000";
     math_temp_diff <= "000000000";
	 
	elsif rising_edge(clk) then
   -- Addition
     math_temp_sum  <= std_logic_vector(unsigned('0' & a) + unsigned('0' & b));   
   -- subtraction	
     math_temp_diff <= std_logic_vector(unsigned('0' & a) + unsigned(b_mod) + 1);
 end if;	
  end process;
  
     sum       <= math_temp_sum; 
     diff       <= math_temp_diff; 

end beh;