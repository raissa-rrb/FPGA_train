library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Top_TB is
end Top_TB;

architecture Behavioral of Top_TB is
signal Interrupteurs :  std_logic_vector(7 downto 0 ):= (others => '0');
signal clk, reset :  std_logic :='0';
signal   sortie_dcc_top : std_logic :='0';
constant CLK_PER: time := 10 ns;
begin

--instance de top
top : entity work.top
    port map ( Interrupteurs => Interrupteurs,
                clk => clk,
                reset => reset,
                sortie_dcc_top => sortie_dcc_top );
                
horloge : process(clk) is
     begin
       clk <= not clk after CLK_PER/2;
 end process horloge;
           
 reset <= '1', '0' after 10 us;
process
begin 
-- Test une série d'interrupteur et vérifie la prise en compte de celui le plus à gauche  
  for j in 0 to 7 loop
        Interrupteurs <= (others => '0');
        Interrupteurs(j) <= '1';
        wait for 12 ms;
    end loop;
wait;
end process;


end Behavioral;
