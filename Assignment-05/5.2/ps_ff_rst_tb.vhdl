library ieee;
use ieee.std_logic_1164.all;
entity ps_ff_rst_tb is
end ps_ff_rst_tb;
architecture testbench of ps_ff_rst_tb is
    component ps_ff_rst
        port (
            d, clk, rst : in std_logic;
            Q, not_Q : out std_logic
        );
    end component;
    signal d, clk, rst : std_logic;
    signal Q, not_Q : std_logic;
begin
    ff_inst: ps_ff_rst port map(d => d, clk => clk, rst => rst, Q => Q, not_Q => not_Q);
    process begin
        -- clk=0, d=0, rst=0 -> memory
        clk <= '0'; d <= '0'; rst <= '0'; wait for 10 ns;
        -- clk=0, d=1, rst=0 -> memory
        clk <= '0'; d <= '1'; rst <= '0'; wait for 10 ns;
        -- rising edge, d=1, rst=0 -> Q becomes 1
        clk <= '1'; d <= '1'; rst <= '0'; wait for 10 ns;
        -- clk=1, d=0, rst=0 -> Q stays 1
        clk <= '1'; d <= '0'; rst <= '0'; wait for 10 ns;
        -- falling edge
        clk <= '0'; d <= '0'; rst <= '0'; wait for 10 ns;
        -- rising edge, d=0, rst=0 -> Q becomes 0
        clk <= '1'; d <= '0'; rst <= '0'; wait for 10 ns;
        -- set Q to 1 again
        clk <= '0'; d <= '1'; rst <= '0'; wait for 10 ns;
        clk <= '1'; d <= '1'; rst <= '0'; wait for 10 ns;
        -- synchronous reset: rst=1, rising edge -> Q becomes 0
        clk <= '0'; d <= '1'; rst <= '1'; wait for 10 ns;
        clk <= '1'; d <= '1'; rst <= '1'; wait for 10 ns;
        assert false report "End of test";
        wait;
    end process;
end testbench;