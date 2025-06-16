----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.03.2024 11:12:35
-- Design Name: 
-- Module Name: COMPTEUR_TEMPO_TB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity COMPTEUR_TEMPO_TB is
--  Port ( );
end COMPTEUR_TEMPO_TB;

architecture Behavioral of COMPTEUR_TEMPO_TB is

signal Clk 			:  STD_LOGIC:='0';		-- Horloge 100 MHz
signal Reset 		:  STD_LOGIC:='0';		-- Reset Asynchrone
signal Clk1M 		:  STD_LOGIC:='0';		-- Horloge 1 MHz
signal Start_Tempo	:  STD_LOGIC:='0';		-- Commande de Démarrage de la Temporisation
signal Fin_Tempo	:  STD_LOGIC:='0';		-- Drapeau de Fin de la Temporisation
signal Clk_Out : STD_LOGIC:='0';				-- Horloge
constant CLK_PER: time := 10 ns;

begin

l0: entity work.clk_div
port map (
    Reset => Reset,
    Clk_In => Clk,
    Clk_Out => Clk_Out
);

l1: entity work.compteur_tempo
port map (
    Reset => Reset,
    Clk => Clk,
    Clk1M => Clk_Out,
    Start_Tempo => Start_Tempo,
    Fin_Tempo => Fin_Tempo
);

-- CLK_DIV 100MHz 
Reset <= '1', '0' after 2 ns;
Clk1M <= Clk_out;
-- COMPTEUR_TEMPO
Start_Tempo <= '1' after 5ns;

horloge : process(Clk) is
     begin
       Clk <= not Clk after CLK_PER/2;
 end process horloge;



end Behavioral;
