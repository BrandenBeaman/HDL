-------------------------------------------------------------------------------
-- Dr. Kaputa
-- state machine example with output logic
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

entity state_machine is 
  port (
    clk               : in std_logic;
    reset             : in std_logic;
    btn               : in std_logic;
    sel               : out std_logic_vector(1 downto 0)
  );
end state_machine;
 
architecture beh of state_machine is
-- signal declarations
constant sInput_a      : std_logic_vector(1 downto 0) := "00";
constant sInput_b      : std_logic_vector(1 downto 0) := "01";
constant sDisp_sum     : std_logic_vector(1 downto 0) := "10";
constant sDisp_diff    : std_logic_vector(1 downto 0) := "11";

signal state_reg      : std_logic_vector(1 downto 0);
signal state_next     : std_logic_vector(1 downto 0);

begin 
-- state register
process(clk,reset)
begin 
  if (reset = '1') then 
    state_reg <= sInput_a;
  elsif (clk'event and clk = '1') then
    state_reg <= state_next;
  end if;
end process;

-- next state logic
process(state_reg,btn)
begin
  -- default values
  state_next <= state_reg;    -- prevents a latch
  
  case state_reg is  
    when sInput_a =>
      if (btn = '1') then  
        state_next <= sInput_b;
      end if;  
	  
    when sInput_b =>
      if (btn = '1') then  
        state_next <= sDisp_sum;
      end if;
	
	when sDisp_sum =>
	  if (btn = '1') then
	    state_next <= sDisp_diff;
	  end if;
	  
    when sDisp_diff =>
      if (btn = '1') then  
        state_next <= sInput_a;
      end if;

    when others =>
      state_next <= sInput_a;
  end case;
end process;

-- output logic
process(state_reg)
begin
  case state_reg is  
    when sInput_a =>
     sel     <= "00";
    when sInput_b => 
     sel    <= "01";
    when sDisp_sum =>
	 sel    <= "10";
    when sDisp_diff =>
     sel    <= "11";
    when others =>
     sel    <= "00";
  end case;

end process;
end beh; 