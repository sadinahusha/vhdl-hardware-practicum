library ieee;
use ieee.std_logic_1164.all;

entity jk_ff_tb is
end jk_ff_tb;

architecture testbench of jk_ff_tb is

component jk_FlipFlop is
    port (
      J,K, clk , reset : in std_logic;
      Q : out std_logic
    );
end component;


signal J, K, clk, reset : std_logic;
signal Q : std_logic;


begin

    jk_inst: jk_FlipFlop port map(J => J, K => K, clk => clk, reset => reset, Q => Q);

process begin

        -- memory: J=0, K=0
        clk <= '0'; J <= '0'; K <= '0'; reset <= '0'; wait for 10 ns;
        clk <= '1'; J <= '0'; K <= '0'; reset <= '0'; wait for 10 ns;
        -- reset: J=0, K=1
        clk <= '0'; J <= '0'; K <= '1'; reset <= '0'; wait for 10 ns;
        clk <= '1'; J <= '0'; K <= '1'; reset <= '0'; wait for 10 ns;
        -- set J=1, K=0
        clk <= '0'; J <= '1'; K <= '0'; reset <= '0'; wait for 10 ns;
        clk <= '1'; J <= '1'; K <= '0'; reset <= '0'; wait for 10 ns;
        -- toggle: J=1, K=1
        clk <= '0'; J <= '1'; K <= '1'; reset <= '0'; wait for 10 ns;
        clk <= '1'; J <= '1'; K <= '1'; reset <= '0'; wait for 10 ns;
        -- toggle again to show it flips back
        clk <= '0'; J <= '1'; K <= '1'; reset <= '0'; wait for 10 ns;
        clk <= '1'; J <= '1'; K <= '1'; reset <= '0'; wait for 10 ns;
        -- reset function
        clk <= '0'; J <= '1'; K <= '0'; reset <= '1'; wait for 10 ns;
        clk <= '1'; J <= '1'; K <= '0'; reset <= '1'; wait for 10 ns;
        assert false report "end of test";
        wait;
	
end process;

end testbench;

