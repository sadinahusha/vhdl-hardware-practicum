LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
--the 4:1 multiplexer to be designed consists of four 3-bit inputs, i.e., i0, i1, i2 and i3.
--sel is a 2-bit select signal.
--y is the output.

ENTITY mux41 IS
    PORT (
        i0 : IN std_logic_vector(2 DOWNTO 0); 
        i1 : IN std_logic_vector(2 DOWNTO 0);
        i2 : IN std_logic_vector(2 DOWNTO 0);
        i3 : IN std_logic_vector(2 DOWNTO 0);
        sel : IN std_logic_vector(1 DOWNTO 0); 
        y : OUT std_logic_vector(2 DOWNTO 0)
        );
END mux41;

ARCHITECTURE rtl OF mux41 IS
--you can add more components you need
--you can also increase the number of inputs, e.g., the "and" gate below is extended to a 3-input gate.

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

     COMPONENT not_gate IS
         PORT (input1 : IN std_logic;
            not_output : OUT std_logic);
      END COMPONENT;

    -- invertiertes auswahlsignal
    signal not_sel : std_logic_vector(1 DOWNTO 0); 
    -- zwischensignale fuer die and-gatter ausgaenge
    signal wire_and1 : std_logic_vector(2 downto 0); -- ausgang and fur i0
    signal wire_and2 : std_logic_vector(2 downto 0); -- same thing for the others
    signal wire_and3 : std_logic_vector(2 downto 0);
    signal wire_and4 : std_logic_vector(2 downto 0);

BEGIN

--bitwise operation for each logic gate because the input signals are multilple-bit signals.
    not_sel(0) <= not sel(0);
    not_sel(1) <= not sel(1);
    and_gate_assignment : for i in 0 to 2 generate
        and_output1: and_gate port map(input1 => i0(i), input2 => not_sel(1), input3 => not_sel(0), and_output => wire_and1(i));
        and_output2: and_gate port map(input1 => i1(i), input2 => not_sel(1), input3 => sel(0),     and_output => wire_and2(i));
        and_output3: and_gate port map(input1 => i2(i), input2 => sel(1),     input3 => not_sel(0), and_output => wire_and3(i));
        and_output4: and_gate port map (input1 => i3(i), input2 => sel(1),     input3 => sel(0),     and_output => wire_and4(i));
    end generate and_gate_assignment;
   
    -- or-gatter kombiniert alle and-ausgaenge nur einer ist gleichzeitig aktiv
    or_gate_assignment : for i in 0 to 2 generate
    or_output: or_gate port map(input1 => wire_and1(i), input2 => wire_and2(i), input3 => wire_and3(i), input4 =>      wire_and4(i), or_result => y(i));
    end generate or_gate_assignment;
END rtl;

