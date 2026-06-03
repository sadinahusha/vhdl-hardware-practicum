library ieee;
use ieee.std_logic_1164.all;

-- 4:2 prioritatskodierer
-- kodiert vier eingange in ein 2-bit ausgangssignal
-- i(3) hat die hochste prioritat, i(0) die niedrigste
entity encoder42 is 
	port (
		i : in  std_logic_vector(3 downto 0); -- eingange i(3) bis i(0)
		y : out std_logic_vector(1 downto 0)  -- kodierter ausgang
		);
end encoder42;

architecture rtl of encoder42 is
begin
    -- y(1) ist 1 wenn i(3) oder i(2) aktiv sind
  y(1) <= i(3) or i(2);
    -- y(0) ist 1 wenn i(3) aktiv ist, oder wenn i(2) nicht aktiv aber i(1) aktiv ist
  y(0) <= i(3) or (not i(2) and i(1));
end rtl;


