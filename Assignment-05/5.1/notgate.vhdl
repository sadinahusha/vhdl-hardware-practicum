library ieee;
use ieee.std_logic_1164.all;
entity notgate is
  port (
    input1 : in std_logic;
    not_output : out std_logic
  );
end notgate;
architecture rtl of notgate is
  signal notgate_sig : std_logic;
begin
  notgate_sig <= NOT input1;
  not_output <= notgate_sig;
end rtl;