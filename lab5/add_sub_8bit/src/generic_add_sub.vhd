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
    clk     : in std_logic;
	reset   : in std_logic;
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
  signal b_mod : std_logic_vector(bits-1 downto 0);
  signal operation_mode : std_logic := '0';

begin
-- store button press
  process(clk, reset)
begin
    if reset = '1' then
        operation_mode <= '0';

    elsif rising_edge(clk) then
        if add_en = '1' then
            operation_mode <= '0';
        elsif sub_en = '1' then
            operation_mode <= '1';
        end if;
    end if;
end process;

 b_mod <= not('0' & b);
 
operation_selection: process(a, b, b_mod, operation_mode)
   begin
   -- Addition
    if(operation_mode = '0') then
     math_temp <= std_logic_vector(unsigned('0' & a) + unsigned('0' & b));   
   -- subtraction	
    else
      math_temp <= std_logic_vector(unsigned('0' & a) + unsigned(b_mod) + 1);
 end if;	
  end process;
  
     sum       <= math_temp(bits-2 downto 0); 
	 cout      <= math_temp(bits-1);

end beh;