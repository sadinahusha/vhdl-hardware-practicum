library ieee;
use ieee.std_logic_1164.all;
entity clag_tb is
end clag_tb;
architecture test of clag_tb is
  component clag
    port (
      gin : in std_logic_vector(3 downto 0);
      pin : in std_logic_vector(3 downto 0);
      cin : in std_logic;
      cout : out std_logic_vector(3 downto 0);
      pout : out std_logic;
      gout : out std_logic
    );
  end component;
signal gin, pin, cout : std_logic_vector(3 downto 0);
signal cin, pout, gout : std_logic;
begin
  clag_inst: clag port map(gin => gin, pin => pin, cin => cin, cout => cout, pout => pout, gout => gout);
  process begin
    gin <= "0001"; pin <= "1111"; cin <= '0'; wait for 10 ns;
    gin <= "0000"; pin <= "1111"; cin <= '0'; wait for 10 ns;
    gin <= "1111"; pin <= "1111"; cin <= '0'; wait for 10 ns;
    gin <= "0101"; pin <= "1010"; cin <= '0'; wait for 10 ns;
    assert false report "End of test";
    wait;
  end process;
end test;