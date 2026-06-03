library ieee;
use ieee.std_logic_1164.all;

entity D_Latch is
    port(
        D, clk : in std_logic;
        Q, not_Q : out std_logic
    );
end D_Latch;

architecture Behavioral of D_Latch is
    
    -- component declarations
    component SR_Latch is
        port(
            S, R : in std_logic;
            Q, not_Q : out std_logic
        );
    end component;
    component andgate is
        port(
            input1 : in std_logic;
            input2 : in std_logic;
            and_output : out std_logic
        );
    end component;
    component notgate is
        port(
            input1 : in std_logic;
            not_output : out std_logic
        );
    end component;
    -- internal signals
    signal S, R : std_logic;
    signal not_D : std_logic;
begin

    -- invert D
    not1: notgate port map(input1 => D, not_output => not_D);
    -- S = D AND CLK
    and1: andgate port map(input1 => D, input2 => clk, and_output => S);
    -- R = NT D AND CLK
    and2: andgate port map(input1 => not_D, input2 => clk, and_output => R);
    -- sr latch takes S and R and produces Q and not_Q
    sr1: SR_Latch port map(S => S, R => R, Q => Q, not_Q => not_Q);

end Behavioral;

