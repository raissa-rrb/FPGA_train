library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dcc_TB is
end dcc_TB;

architecture Behavioral of dcc_TB is
          
--signaux temporaires pour le port map
signal clk_100M : std_logic := '0';
signal clk_1M : std_logic := '0';
signal go_0:  std_logic ;
signal fin_0, dcc_0 :  std_logic :='0';
signal go_1, reset :  std_logic ;
signal fin_1, dcc_1 :  std_logic :='0';
constant CLK_PER: time := 10 ns;

begin


div : entity work.clk_div

port map (reset => reset,
          clk_in => clk_100M,
          clk_out => clk_1M);


l0 : entity work.dcc_bit0
port map( go_0 => go_0,
        clk_100M => clk_100M,
        clk_1M => clk_1M,
        reset => reset,
        fin_0 => fin_0,
        dcc_0 => dcc_0);
        
l1 : entity work.dcc_bit1
port map( go_1 => go_1,
        clk_100M => clk_100M,
        clk_1M => clk_1M,
        reset => reset,
        fin_1 => fin_1,
        dcc_1 => dcc_1);
           
          
horloge : process(clk_100M) is
     begin
       clk_100M <= not clk_100M after CLK_PER/2;
 end process horloge;

reset <= '1', '0' after 10 us;

-- on test si l'alternance dcc0 / dcc1 fonctionne et ensuite si on ça fonctionne pour deux bits 1 consécutifs et pareil pour deux bit 0 consécutifs
go_0 <= '0', '1' after 20 us, '0' after 30 us, '1' after 250 us, '1' after 355 us;

go_1 <= '0' , '1' after 230 us, '0' after 240 us, '1' after 600 us, '0' after 605 us, '1' after 750 us;

end Behavioral;
