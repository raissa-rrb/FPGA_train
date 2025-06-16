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


process
begin 
-- Test une série d'interrupteur et vérifie la prise en compte de celui le plus à gauche  
  for j in 0 to 7 loop
        Interrupteur <= (others => '0');
        Interrupteur(j) <= '1';
        wait for 200 ns;
    end loop;
wait;
end process;

end Behavioral;
