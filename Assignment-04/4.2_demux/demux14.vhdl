LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
-- 1:4 demultiplexer mit einem 3 bit eingang
-- leitet den eingang In an einen der vier ausgange weiter
-- auswahlsignal sel bestimmt an welchen ausgang weitergeleitet wird
ENTITY demux14 IS
    PORT (
        I_n : IN std_logic_vector(2 DOWNTO 0); -- eingang
        sel : IN std_logic_vector(1 DOWNTO 0); -- auswahlsignal (2 bit)
        Y0 : OUT std_logic_vector(2 DOWNTO 0);-- ausgang 0 (sel=00)
        Y1 : OUT std_logic_vector(2 DOWNTO 0);
        Y2 : OUT std_logic_vector(2 DOWNTO 0);
        Y3 : OUT std_logic_vector(2 DOWNTO 0)  -- ausgang 3 (sel=11)
        );
END demux14;

ARCHITECTURE rtl OF demux14 IS
    COMPONENT and_gate IS
        PORT (input1 : IN std_logic;
            input2 : IN std_logic;
            input3 : IN std_logic;
            and_output : OUT std_logic);
    END COMPONENT;
    -- invertiertes auswahlsignal
    signal not_sel : std_logic_vector(1 downto 0);

BEGIN    
   -- auswahlsignal invertieren

    not_sel(0) <= not sel(0);
    not_sel(1) <= not sel(1);
    -- eingang wird nur an y0 weitergeleitet wenn sel=0
    y0_assignment : for i in 0 to 2 generate
        y0_gate: and_gate port map(input1 => I_n(i), input2 => not_sel(1), input3 => not_sel(0), and_output => Y0(i));
    end generate y0_assignment;

    y1_assignment : for i in 0 to 2 generate
        y1_gate: and_gate port map(input1 => I_n(i), input2 => not_sel(1), input3 => sel(0), and_output => Y1(i));
    end generate y1_assignment;

    y2_assignment : for i in 0 to 2 generate
        y2_gate: and_gate port map(input1 => I_n(i), input2 => sel(1), input3 => not_sel(0), and_output => Y2(i));
    end generate y2_assignment;
    
    -- eingang wird nur an y3 weitergeleitet wenn sel=11
    y3_assignment : for i in 0 to 2 generate
        y3_gate: and_gate port map(input1 => I_n(i), input2 => sel(1), input3 => sel(0), and_output => Y3(i));
    end generate y3_assignment;

END rtl;

