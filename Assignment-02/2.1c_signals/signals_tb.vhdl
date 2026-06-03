

library ieee;
use ieee.std_logic_1164.all;

entity signals_tb is
end signals_tb;

architecture test of signals_tb is
  signal a, b, c : std_logic;
begin
  process begin
    -- dies sind nur Beispiel für Tupel die nicht verwendet werden muessen
    -- insgesamt sollen 8 verschiedene Tupel ausgewaehlt werden
    -- Beispiel für ein Tupel mit 2 unterschiedlichen Signalwerten

    a <= 'X';  --hier ist unsere signal a , in einem unbestimmte stark Zustand, also bei 0ns
    b <= 'W'; -- unsere signal b presentiert die schwache unbestimmte zustand hier
    wait for 10 ns; -- Ansonsten werden die Zuordnungen für a, b und c gleichzeitig ausgeführt
    c <= a and b;    --hier wird c inatlisiert, mit das operator and,dann c kommt als x vor
    wait for 10 ns; -- Gibt ein Zeitfenster für die Beobachtung der Ausgabe von a und b im GTK Wave
    c <= a or b;
    wait for 10 ns; -- Gibt ein Zeitfenster für die Beobachtung der Ausgabe von a oder b im GTK Wave
--die signalen bleiben gleich bis die 30ns .
    -- Das Tupel (0,1) das auf jeden Fall ausgewertet werden soll
    a <= '0';   --jetzt bei der 30ns kommen die neue signale vor
    b <= '1';
    wait for 10 ns;
    c <= a and b;        --c ist 0
    wait for 10 ns;
    c <= a or b;        --c ist 1
    wait for 10 ns;
    -- Ab hier folgen die eigenen Paare

    a <= '0';
    b <= 'L';
    wait for 10 ns;
    c <= a and b;    -- c ist 0
    wait for 10 ns;
    c <= a or b;    -- c ist 0
    wait for 10 ns;

    a <= '1';
    b <= 'H';
    wait for 10 ns;
    c <= a and b;    --c ist 1
    wait for 10 ns;
    c <= a or b;    -- c ist 1
    wait for 10 ns;

    a <= '0';
    b <= 'Z';
    wait for 10 ns;
    c <= a and b;    --c ist 0
    wait for 10 ns;
    c <= a or b;    --c ist x
    wait for 10 ns;

    a <= '1';
    b <= 'Z';
    wait for 10 ns;
    c <= a and b;    -- c ist x
    wait for 10 ns;
    c <= a or b;    --c ist 1
    wait for 10 ns;
   
    a <= '0';
    b <= 'W';
    wait for 10 ns;
    c <= a and b;    -- c ist 0
    wait for 10 ns;
    c <= a or b;    -- c ist x
    wait for 10 ns;

    a <= '1';
    b <= 'X';
    wait for 10 ns;
    c <= a and b;    -- c ist x
    wait for 10 ns;
    c <= a or b;    --c ist 1
    wait for 10 ns;

    a <= 'W';
    b <= 'L';
    wait for 10 ns;
    c <= a and b;    -- c ist 0
    wait for 10 ns;
    c <= a or b;    -- c ist x
    wait for 10 ns;

    a <= 'H';
    b <= 'X';
    wait for 10 ns;
    c <= a and b;    -- c ist x
    wait for 10 ns;
    c <= a or b;    -- c ist 1
    wait for 10 ns;
    
    -- Beispiele für Tupel die nicht verwendet werden sollten
    -- (0,1) und (1,0) sind das gleiche Tupel, es sollte also nur eins davon verwendet werden
   -- a <= '1';
   -- b <= '0';
    -- (0,0) hat die gleichen Signalwerte, sollte also nicht verwendet werden
   -- a <= '0';
   -- b <= '0';
    -- (1,1) hat die gleichen Signalwerte, sollte also nicht verwendet werden
    a <= '1';
    b <= '1';
    assert false report "End of test"; -- Diese Fehlermeldung zeigt, dass der Test erfolgreich beendet wurde
    wait;
  end process;
end test;

