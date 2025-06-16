
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dcc_generator_TB is
end dcc_generator_TB;

architecture Behavioral of dcc_generator_TB is

--signaux pour port map
signal Interrupteur : std_logic_vector(7 downto 0);
signal Trame_DCC : std_logic_vector(50 downto 0);

begin

l0: entity work.DCC_FRAME_GENERATOR
port map( Interrupteur => Interrupteur , Trame_DCC => Trame_DCC);

Interrupteur <= "00000000", "00000001" after 200 ns, "00000010" after 400ns, "00000000" after 600ns;


end Behavioral;
