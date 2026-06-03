library ieee;
use ieee.std_logic_1164.all;

entity fa is
  port (
    a : in std_logic;
    b : in std_logic;
    cin : in std_logic;
    cout : out std_logic;
    s : out std_logic
);
end fa;

architecture rtl of fa is
  signal wire_1 : std_logic;
  signal wire_2 : std_logic;
  signal wire_3 : std_logic;
begin
  wire_1 <= a xor b;
  wire_2 <= a and b;
  wire_3 <= (a or b) and cin;
  s <= wire_1 xor cin;
  cout <= wire_2 or wire_3;
end rtl;
