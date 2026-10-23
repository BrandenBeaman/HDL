-- Branden Beaman
-- add_sub_8bit top

library ieee;
use ieee.std_logic_1164.all;

entity top is
    port (
	  clk_50mhz     : in std_logic;
	  reset         : in std_logic;
	  
	  switch             : in std_logic_vector(7 downto 0);
	  
	  btn           : in std_logic;
	  
	  led_a         : out std_logic;
	  led_b         : out std_logic;
	  led_add       : out std_logic;
	  led_sub       : out std_logic;
	  
	  seven_seg_ones : out std_logic_vector(6 downto 0);
	  seven_seg_tens : out std_logic_vector(6 downto 0);
	  seven_seg_hundreds : out std_logic_vector(6 downto 0);
	  
	  selo  : out std_logic_vector(1 downto 0)
	  
	 );
end top;

architecture beh of top is 

component synchronizer_8bit is
  port(
    clk               : in std_logic;
    reset             : in std_logic;
    async_in          : in std_logic_vector(7 downto 0);
    sync_out          : out std_logic_vector(7 downto 0)
  );
end component;

component add_sub_8bit is 
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
 end component;
 

component rising_edge_synchronizer is
  port (
    clk               : in std_logic;
    reset             : in std_logic;
    input             : in std_logic;
    edge              : out std_logic
  );
end component;

component double_dabble is
 port (
    result_padded           : in  std_logic_vector(11 downto 0); 
    ones                    : out std_logic_vector(3 downto 0);
    tens                    : out std_logic_vector(3 downto 0);
    hundreds                : out std_logic_vector(3 downto 0)
  );  
end component;

component seven_seg is
     port ( 
    clk             : in std_logic;
    reset           : in std_logic;
    bcd             : in std_logic_vector(3 downto 0);
    seven_seg_out   : out std_logic_vector(6 downto 0)
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

signal switch_sync  : std_logic_vector(7 downto 0);

signal a_reg : std_logic_vector(7 downto 0);
signal b_reg : std_logic_vector(7 downto 0);

signal sum     : std_logic_vector(8 downto 0);
signal diff     : std_logic_vector(8 downto 0);

signal a_12bit  : std_logic_vector(11 downto 0);
signal b_12bit  : std_logic_vector(11 downto 0);

signal sum_12bit   : std_logic_vector(11 downto 0);
signal diff_12bit  : std_logic_vector(11 downto 0);

signal mux_result : std_logic_vector(11 downto 0);

signal BCD_ones     : std_logic_vector(3 downto 0);
signal BCD_tens     : std_logic_vector(3 downto 0);
signal BCD_hundreds : std_logic_vector(3 downto 0);


 
begin

a_12bit <= "0000" & switch_sync;
b_12bit <= "0000" & switch_sync;

sum_12bit <= "000" & sum;
diff_12bit <= "000" & diff;



u_switch_synchronizer_8bit: synchronizer_8bit
   port map (
      clk => clk_50mhz,
	  reset => reset,
	  async_in => switch,
	  sync_out => switch_sync
	);

u_btn_rising_edge_sync: rising_edge_synchronizer
     port map (
	clk     => clk_50mhz,             
    reset   => reset,          
    input   => btn,          
    edge    => btn_en         
	 );
	 
u_add_sub_8bit: add_sub_8bit
    port map (
	 clk   => clk_50mhz,
	 reset => reset,
	 a     => a_reg,
	 b     => b_reg,
	 sum   => sum,
	 diff  => diff
	 );
	 
u_state_machine: state_machine
    port map(
	  clk    => clk_50mhz,
	  reset  => reset,
	  btn    => btn_en,
	  sel    => sel
	  );
	  
u_double_dabble: double_dabble
   port map (
     result_padded => mux_result,
	 ones          => BCD_ones,
	 tens          => BCD_tens,
	 hundreds      => BCD_hundreds
	 );
	 
u_seven_seg_ones: seven_seg
    port map (
	 clk => clk_50mhz,
	 reset => reset,
	 bcd => BCD_ones,
	 seven_seg_out => seven_seg_ones
	 );
	 
u_seven_seg_tens: seven_seg
    port map (
	 clk => clk_50mhz,
	 reset => reset,
	 bcd => BCD_tens,
	 seven_seg_out => seven_seg_tens
	 );
	 
u_seven_seg_hundreds: seven_seg
    port map (
	 clk => clk_50mhz,
	 reset => reset,
	 bcd => BCD_hundreds,
	 seven_seg_out => seven_seg_hundreds
	 );
	 
-- Store A and B based on selected state
input_registers: process(clk_50mhz, reset)
begin
    if reset = '1' then
        a_reg <= (others => '0');
        b_reg <= (others => '0');

    elsif rising_edge(clk_50mhz) then
        if btn_en = '1' then
            case sel is
                when "00" =>
                    a_reg <= switch_sync;

                when "01" =>
                    b_reg <= switch_sync;

                when others =>
                    null;
            end case;
        end if;
    end if;
end process;
	 
process(sel, a_12bit, b_12bit, sum_12bit, diff_12bit)
 begin 
   case sel is 
     when "00" => 
	 mux_result <= a_12bit;
	 led_a   <= '1';
	 led_b   <= '0';
	 led_add <= '0';
	 led_sub <= '0';
	 selo <= sel;

     when "01" => 
	 mux_result <= b_12bit;
	 led_a   <= '0';
	 led_b   <= '1';
	 led_add <= '0';
	 led_sub <= '0';
	 selo <= sel;

     when "10" => 
	 mux_result <= sum_12bit;
	 led_a   <= '0';
	 led_b   <= '0';
	 led_add <= '1';
	 led_sub <= '0';
	 selo <= sel;

     when "11" =>
     mux_result <= diff_12bit;	 
	 led_a   <= '0';
	 led_b   <= '0';
	 led_add <= '0';
	 led_sub <= '1';
	 selo <= sel;
	 
	 when others =>
	 mux_result <= a_12bit;
	 led_a   <= '0';
	 led_b   <= '0';
	 led_add <= '0';
	 led_sub <= '0';
	 selo <= sel;
  end case;
end process;


end beh;
	  
	  