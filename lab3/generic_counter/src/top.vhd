--Branden Beaman
-- counter top

library ieee;
use ieee.std_logic_1164.all;

entity top is
  port (
     clk_50mhz     : in std_logic;
	 reset         : in std_logic;
	 seven_seg_out : out std_logic_vector(6 downto 0)
	 );
	end top;
	
architecture beh of top is 
	
component generic_counter is 
	 generic (
    max_count       : integer := 3
  );
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    output          : out std_logic
  );  
end component;  

component generic_adder_beh is 
   generic (
    bits    : integer := 4
  );
  port (
    a       : in  std_logic_vector(bits-1 downto 0);
    b       : in  std_logic_vector(bits-1 downto 0);
    cin     : in  std_logic;
    sum     : out std_logic_vector(bits-1 downto 0);
    cout    : out std_logic
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


signal enable : std_logic;
signal sum_sig : std_logic_vector(3 downto 0 );
signal reg_out : std_logic_vector(3 downto 0 );

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
