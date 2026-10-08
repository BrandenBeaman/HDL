-------------------------------------------------------------------------------
-- Branden Beaman
-- generic adder and subtractor [behavioral]
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity generic_add_sub is
  generic (
    bits    : integer := 4
  );
  port (
    a       : in  std_logic_vector(bits-2 downto 0);
    b       : in  std_logic_vector(bits-2 downto 0);
	add_en  : in std_logic;
	sub_en  : in std_logic;
    sum     : out std_logic_vector(bits-2 downto 0);
    cout    : out std_logic
  );
end entity generic_add_sub;

architecture beh of generic_add_sub is

  signal math_temp : std_logic_vector(bits-1 downto 0);
  signal b_mod     : std_logic_vector(bits-2 downto 0);

begin

operation_selection: process(add_en, sub_en, a, b)
   begin
   -- Addition
    if(add_en = '1') then
     math_temp <= std_logic_vector(unsigned('0' & a) + unsigned('0' & b));
	 sum       <= math_temp(bits-2 downto 0); 
	 cout      <= math_temp(bits-1);
    
   -- subtraction	
    elsif(sub_en = '1') then
     b_mod <= not(b);
     math_temp <= std_logic_vector(unsigned('0' & a) + unsigned('0' & b_mod) + 1);
	 sum       <= math_temp(bits-2 downto 0);
	 cout      <= math_temp(bits-1);
	
	else
	 -- Default to addition
     math_temp <= std_logic_vector(unsigned('0' & a) + unsigned('0' & b));
     sum       <= math_temp(bits-2 downto 0);
     cout      <= math_temp(bits-1);
 end if;
 end process;
end beh;