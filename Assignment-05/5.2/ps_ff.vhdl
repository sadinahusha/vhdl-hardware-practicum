library ieee;
use ieee.std_logic_1164.all;

entity ps_ff is
    port (
      d, clk: in std_logic;
      Q, not_Q : out std_logic
    );
  end ps_ff;

architecture behavioral of ps_ff is

    component D_Latch is
        port(
            D, clk : in std_logic;
            Q, not_Q : out std_logic
        );
    end component;
    component notgate is
        port(
            input1 : in std_logic;
            not_output : out std_logic
        );
    end component;
    -- invertiertes taktsignal fuer primary latch
    signal not_clk : std_logic;
    -- verbindung zwischen primary und secondary latch
    signal n1, not_n1 : std_logic;
begin

    -- takt invertieren
    not1: notgate port map(input1 => clk, not_output => not_clk);
    -- primary latch bekommt invertierten takt
    L1: D_Latch port map(D => d, clk => not_clk, Q => n1, not_Q => not_n1);
    -- secondary latch bekommt normalen takt
    L2: D_Latch port map(D => n1, clk => clk, Q => Q, not_Q => not_Q);
end behavioral ;

