-------------------------------------------------------------------------------
-- Dr. Kaputa
-- single bit full adder [arcavioral]
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all;      

entity full_adder_single_bit_arc is 
  port (
    a       : in std_logic;
    b       : in std_logic;
    cin     : in std_logic;
    sum     : out std_logic;
    cout    : out std_logic
  );
end full_adder_single_bit_arc;

architecture arc of full_adder_single_bit_arc is

signal x : std_logic_vector(1 downto 0);
signal av: std_logic_vector(1 downto 0);
signal bv: std_logic_vector(1 downto 0);
signal cinv: std_logic_vector(1 downto 0);

begin
sum  <= (a xor b) xor cin;
cout <= (a and b) or (b and cin) or(cin and a);
end arc; 