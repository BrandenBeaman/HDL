-- Branden Beaman
-- add_sub_8bit top

library ieee;
use ieee.std_logic_1164.all;

entity top is
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
end top;

architecture beh of top is 

component rising_edge_synchronizer is
 port (
    clk               : in std_logic;
    reset             : in std_logic;
    input             : in std_logic;
    edge              : out std_logic
  );
end component;

component state_machine is 
 port (
    clk               : in std_logic;
    reset             : in std_logic;
    btn               : in std_logic;
    sel               : out std_logic_vector(1 downto 0)
  );
end component;

signal btn_en  : std_logic;
signal sel     : std_logic_vector(1 downto 0);

begin

u_btn_rising_edge_sync: rising_edge_synchronizer
     port map (
	clk     => clk_50mhz,             
    reset   => reset,          
    input   => btn,          
    edge    => btn_en         
	 );
	 
u_state_machine: state_machine
    port map(
	  clk    => clk_50mhz,
	  reset  => reset,
	  btn    => btn_en,
	  sel    => sel
	  );
	 
process(sel)
 begin 
   case sel is 
     when "00" => 
	 led_a   <= '1';
	 led_b   <= '0';
	 led_add <= '0';
	 led_sub <= '0';
	 selo <= sel;

     when "01" => 
	 led_a   <= '0';
	 led_b   <= '1';
	 led_add <= '0';
	 led_sub <= '0';
	 selo <= sel;

     when "10" => 
	 led_a   <= '0';
	 led_b   <= '0';
	 led_add <= '1';
	 led_sub <= '0';
	 selo <= sel;

     when "11" => 
	 led_a   <= '0';
	 led_b   <= '0';
	 led_add <= '0';
	 led_sub <= '1';
	 selo <= sel;
	 
	 when others =>
	 led_a   <= '0';
	 led_b   <= '0';
	 led_add <= '0';
	 led_sub <= '0';
	 selo <= sel;
  end case;
end process;


end beh;
	  
	  