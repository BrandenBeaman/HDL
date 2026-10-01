--Branden Beaman
-- counter top

library ieee;
use ieee.std_logic_1164.all;

entity top is
  port ( 
     clk_50mhz     : in std_logic;
	 reset         : in std_logic;
	 
     a             : in std_logic;
	 b             : in std_logic;
	 add_btn       : in std_logic;
	 sub_btn       : in std_logic;
	 a_bcd         : out std_logic_vector(6 downto 0);
	 b_bcd         : out std_logic_vector(6 downto 0);
	 result_bcd    : out std_logic_vector(6 downto 0);
 

	 );
	end top;
	
architecture beh of top is 
	
component generic_add_sub is 
	generic (
    bits    : integer := 3
  );
  port (
    a       : in  std_logic_vector(bits-2 downto 0);
    b       : in  std_logic_vector(bits-2 downto 0);
    cin     : in  std_logic;
    sum     : out std_logic_vector(bits-2 downto 0);
    cout    : out std_logic
  );
end component;  

component synchronizer_3bit is 
   port (
    clk               : in std_logic;
    reset             : in std_logic;
    async_in          : in std_logic_vector(2 downto 0);
    sync_out          : out std_logic_vector(2 downto 0)
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

component edge_detector is
 port (
    clk               : in std_logic;
    reset             : in std_logic;
    input             : in std_logic;
    edge              : out std_logic
  );

end component;


signal a_sync  : std_logic_vector(bits-2 downto 0);
signal b_sync  : std_logic_vector(bits-2 downto 0);

signal add_en  : std_logic;
signal sub_en : std_logic;

signal 

begin

 
counter: generic_counter  
  generic map (
    max_count => 50000000
  )
  port map(
    clk       => clk_50mhz,
    reset     => reset,
    output    => enable
  );
  
 
  adder: generic_adder_beh
    generic map (
      bits => 4
    )
    port map (
      a    => "0001",       -- Constant +1
      b    => reg_out,      -- Feedback from register
      cin  => '0',
      sum  => sum_sig,
      cout => open
    );

  -- 5. Sum Register Process (Clocked on 50MHz edge, enabled by enable_sig)
  sum_register: process(clk_50mhz, reset)
  begin
    if reset = '1' then
      reg_out <= (others => '0');
    elsif rising_edge(clk_50mhz) then
      if enable = '1' then
        reg_out <= sum_sig;
      end if;
    end if;
  end process;

  -- 6. Seven Segment Display Instance
  seg: seven_seg
    port map (
      clk           => clk_50mhz,
      reset         => reset,
      bcd           => reg_out,
      seven_seg_out => seven_seg_out
    );

end beh;
