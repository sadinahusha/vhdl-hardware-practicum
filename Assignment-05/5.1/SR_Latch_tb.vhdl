library ieee;
use ieee.std_logic_1164.all;

entity SR_Latch_tb is
end SR_Latch_tb;

architecture testbench of SR_Latch_tb is
    component SR_Latch
        port (
            S, R : in std_logic;
            Q, not_Q : out std_logic
        );
    end component;
    signal S, R : std_logic;
    signal Q, not_Q : std_logic;

begin

    sr_inst: SR_Latch port map(S => S, R => R, Q => Q, not_Q => not_Q);
    process begin

        -- set, Q wird 1
        S <= '1';
        R <= '0';
        wait for 10 ns;
        -- reset, Q wird 0
        S <= '0';
        R <= '1';
        wait for 10 ns;
        -- memory, Q bleibt 0
        S <= '0';
        R <= '0';
        wait for 10 ns;
        -- irregularer zustand, Q und not_Q beide 0
        S <= '1';
        R <= '1';
        wait for 10 ns;
        -- zuruck zu memory nach irregularem zustand
        -- verhalten ist unvorhersehbar, GHDL stoppt die simulation hier
        S <= '0';
        R <= '0';
        wait for 10 ns;
        -- set dann memory
        S <= '1';
        R <= '0';
        wait for 10 ns;
        S <= '0';
        R <= '0';
        wait for 10 ns;
        assert false report "End of test";
        wait;
    end process;
end testbench;
