library ieee;
use ieee.std_logic_1164.all;
entity andgate is
  port (
    input1 : in std_logic;
    input2 : in std_logic;
    and_output : out std_logic
  );
end andgate;
architecture rtl of andgate is
  signal andgate_sig : std_logic;
begin
  andgate_sig <= input1 and input2;
  and_output <= andgate_sig;
end rtl;