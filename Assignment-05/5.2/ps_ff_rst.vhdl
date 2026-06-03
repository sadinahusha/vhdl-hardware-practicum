library ieee;
use ieee.std_logic_1164.all;
-- d flip flop mit synchronem reset
-- new_d = d and not rst
-- bei aufsteigender taktflanke: wenn rst=1 wird q=0, sonst q=d
entity ps_ff_rst is
    port (
        d, clk, rst : in std_logic;
        Q, not_Q : out std_logic
    );
end ps_ff_rst;
architecture behavioral of ps_ff_rst is
    component ps_ff is
        port(
            d, clk : in std_logic;
            Q, not_Q : out std_logic
        );
    end component;
    component notgate is
        port(
            input1 : in std_logic;
            not_output : out std_logic
        );
    end component;
    component andgate is
        port(
            input1 : in std_logic;
            input2 : in std_logic;
            and_output : out std_logic
        );
    end component;
    -- not rst signal
    signal not_rst : std_logic;
    -- new d after reset logic
    signal new_d : std_logic;
begin
    -- rst invertieren
    not1: notgate port map(input1 => rst, not_output => not_rst);
    -- new_d = d and not_rst
    and1: andgate port map(input1 => d, input2 => not_rst, and_output => new_d);
    -- flip flop bekommt new_d statt d
    ff1: ps_ff port map(d => new_d, clk => clk, Q => Q, not_Q => not_Q);
end behavioral;