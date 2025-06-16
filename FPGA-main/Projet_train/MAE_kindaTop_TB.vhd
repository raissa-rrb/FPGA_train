

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MAE_kindaTop_TB is
end MAE_kindaTop_TB;

architecture Behavioral of MAE_kindaTop_TB is

signal clk, reset :  std_logic := '0';
signal start_tempo, fin_tempo, fin_1, fin_0 :  std_logic :='0';
signal reg, com, go_1, go_0 :  std_logic :='0';
signal bit_dcc :  std_logic :='0';

signal clk_1M : std_logic := '0';
signal  dcc_0 :  std_logic :='0';
signal dcc_1 :  std_logic :='0';
constant CLK_PER: time := 10 ns;

signal sortie_dcc : std_logic :='0';
signal trame_dcc : std_logic_vector(9 downto 0);

begin


l0 : entity work.registre_dcc
port map( trame_dcc => trame_dcc,
          clk_100M => clk,
          reset => reset,
          com => com,
          reg => reg,
          sortie_dcc => sortie_dcc
          );

div : entity work.clk_div

port map (reset => reset,
          clk_in => clk,
          clk_out => clk_1M);

l1 : entity work.dcc_bit0
port map( go_0 => go_0,
        clk_100M => clk,
        clk_1M => clk_1M,
        reset => reset,
        fin_0 => fin_0,
        dcc_0 => dcc_0);
        
l2 : entity work.dcc_bit1
port map( go_1 => go_1,
        clk_100M => clk,
        clk_1M => clk_1M,
        reset => reset,
        fin_1 => fin_1,
        dcc_1 => dcc_1);
        
l3 : entity work.MAE
port map( clk => clk,
         reset => reset,
           start_tempo => start_tempo,
           fin_tempo => fin_tempo,
           fin_1 => fin_1,
            fin_0 => fin_0 ,
            reg => reg,
             com => com,
             go_1 => go_1,
             go_0 => go_0,
            bit_dcc => sortie_dcc);
            
tempo : entity work.compteur_tempo
port map( Clk => clk,
           Reset => reset,
           Clk1M => clk_1M,
           Start_Tempo	=> start_tempo,
           Fin_Tempo => fin_tempo
);                      
horloge : process(clk) is
     begin
       clk <= not clk after CLK_PER/2;
 end process horloge;
           
 reset <= '1', '0' after 10 us;
 
-- start <= '0', '1' after 20 us, '0' after 40 us;
 
 trame_dcc <=  "1010100011" , "1100011101" after 10 ms;
   
end Behavioral;
