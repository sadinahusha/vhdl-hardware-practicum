LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
-- 8:1 multiplexer mit acht 3-bit eingangen
-- besteht aus zwei 4:1 mux komponenten
-- sel_81(1 downto 0) wahlt den eingang innerhalb der gruppe
-- sel_81(2) wahlt zwischen den zwei gruppen (s2=0 -> i0-i3, s2=1 -> i4-i7)
ENTITY mux81 IS
    PORT (
        i0_81 : IN std_logic_vector(2 DOWNTO 0); -- eingang 0
        i1_81 : IN std_logic_vector(2 DOWNTO 0);
        i2_81 : IN std_logic_vector(2 DOWNTO 0);
        i3_81 : IN std_logic_vector(2 DOWNTO 0);
        i4_81 : IN std_logic_vector(2 DOWNTO 0);
        i5_81 : IN std_logic_vector(2 DOWNTO 0);
        i6_81 : IN std_logic_vector(2 DOWNTO 0);
        i7_81 : IN std_logic_vector(2 DOWNTO 0); -- eingang 7
        sel_81 : IN std_logic_vector(2 DOWNTO 0);   -- auswahlsignal (3 bit)
        y_81 : OUT std_logic_vector(2 DOWNTO 0));  -- ausgang
END mux81;

ARCHITECTURE rtl OF mux81 IS

    COMPONENT mux41 IS
        PORT (
            i0 : IN std_logic_vector(2 DOWNTO 0); 
            i1 : IN std_logic_vector(2 DOWNTO 0);
            i2 : IN std_logic_vector(2 DOWNTO 0);
            i3 : IN std_logic_vector(2 DOWNTO 0);
            sel : IN std_logic_vector(1 DOWNTO 0); 
            y : OUT std_logic_vector(2 DOWNTO 0)
        );
    END COMPONENT;
    
    -- weitere Komponenten 

    COMPONENT and_gate IS
        PORT (input1 : IN std_logic;
           input2 : IN std_logic;
           input3 : IN std_logic;
           and_output : OUT std_logic);
    END COMPONENT;

    COMPONENT or_gate IS
        PORT (input1 : IN std_logic;
            input2 : IN std_logic;
            input3 : IN std_logic;
            input4 : IN std_logic;
            or_result : OUT std_logic);
     END COMPONENT;
    
    
    -- ausgange der zwei 4:1 mux instanzen
signal mux1_out : std_logic_vector(2 downto 0);
signal mux2_out : std_logic_vector(2 downto 0);
    -- invertiertes s2 signal
signal not_s2 : std_logic;
    -- zwischensignale fur die and-gatter ausgange
signal wire_and1 : std_logic_vector(2 downto 0);
signal wire_and2 : std_logic_vector(2 downto 0);
        begin
    -- s2 invertieren
       not_s2 <= not sel_81(2);
    -- erste gruppe i0-i3 mit s1,s0 auswahlen
        mux1: mux41 port map(i0 => i0_81, i1 => i1_81, i2 => i2_81, i3 => i3_81, sel => sel_81(1 downto 0), y => mux1_out);
        -- zweite gruppe i4-i7 mit s1,s0 auswahlen
        mux2: mux41 port map(i0 => i4_81, i1 => i5_81, i2 => i6_81, i3 => i7_81, sel => sel_81(1 downto 0), y => mux2_out);

    -- s2 entscheidet welche gruppe durchgeleitet wird
    and_assignment1 : for i in 0 to 2 generate
        and1: and_gate port map(input1 => mux1_out(i), input2 => not_s2, input3 => not_s2, and_output => wire_and1(i));
        and2: and_gate port map(input1 => mux2_out(i), input2 => sel_81(2), input3 => sel_81(2), and_output => wire_and2(i));
    end generate and_assignment1;

    -- or-gatter kombiniert beide and ausgange
    or_assignment : for i in 0 to 2 generate
        or1: or_gate port map(input1 => wire_and1(i), input2 => wire_and2(i), input3 => wire_and2(i), input4 => wire_and2(i), or_result => y_81(i));
    end generate or_assignment;
end rtl;

