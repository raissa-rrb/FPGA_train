
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity registre_dcc_TB is
end registre_dcc_TB;

architecture Behavioral of registre_dcc_TB is

signal trame_dcc : std_logic_vector(9 downto 0);
signal reset, com, sortie_dcc : std_logic;
signal clk_100M : std_logic :='0';
signal reg : std_logic := '0';
constant CLK_PER: time := 10 ns;

begin

l0 : entity work.registre_dcc
port map( trame_dcc => trame_dcc,
          clk_100M => clk_100M,
          reset => reset,
          com => com,
          reg => reg,
          sortie_dcc => sortie_dcc
          );
          
horloge : process(clk_100M) is
     begin
       clk_100M <= not clk_100M after CLK_PER/2;
       reg <= not reg after 15 ns;
 end process horloge;

--pour le testbench de ce module nous avions modifier le bloc regDCC pour avoir une trame sur 10 bits
--cela  était plus facile pour contrôler le bon fonctionnement du décalage 
trame_dcc <= "0000000000", "1010101001" after 20 ns;
--"111111111111111111111110000000010010000010010000111", 
--"111111111111111111111110000000010100100000100100011" after 500 ns;

reset <= '1', '0' after 10 ns;

com <= '0', '1' after 20 ns, '0' after 40 ns;

end Behavioral;
