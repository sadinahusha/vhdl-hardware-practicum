library ieee;
use ieee.std_logic_1164.all;

entity SR_Latch is
    port (
      S,R : in std_logic;
      Q,not_Q : out std_logic
    );
  end SR_Latch;

architecture Behavioral of SR_Latch is

    -- nor gate component from blatt 2
    component norgate is
        port (
            input1 : in std_logic;
            input2 : in std_logic;
            nor_result : out std_logic
        );
    end component;
    -- internal signals for feedback loop
    -- q and not_q are out ports so we cant read from them directly
    signal q_internal : std_logic;
    signal nq_internal : std_logic;
begin

    -- N1: inputs are S and q_internal (feedback from N2), output is nq_internal
    N1: norgate port map(input1 => S, input2 => q_internal, nor_result => nq_internal);
    -- N2: inputs are R and nq_internal (feedback from N1), output is q_internal
    N2: norgate port map(input1 => R, input2 => nq_internal, nor_result => q_internal);
    -- connect internal signals to output ports
    Q <= q_internal;
    not_Q <= nq_internal;

end Behavioral;

