----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.03.2024 10:43:58
-- Design Name: 
-- Module Name: CLK_DIV_TB - Behavioral
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

entity CLK_DIV_TB is
end CLK_DIV_TB;

architecture Behavioral of CLK_DIV_TB is

signal Clk_In : STD_LOGIC:='0';				-- Horloge
signal Reset : STD_LOGIC:='0';				-- Reset Asynchrone
signal Clk_Out : STD_LOGIC:='0';				-- Horloge
constant CLK_PER: time := 10 ns;

begin

l0: entity work.clk_div
port map (
    Reset => Reset,
    Clk_In => Clk_In,
    Clk_Out => Clk_Out
);

-- Test de l'Horloge et du Reset Asynchrone
Reset <= '1', '0' after 2 ns;

 horloge : process(clk_in) is
     begin
       clk_in <= not clk_in after CLK_PER/2;
 end process horloge;

end Behavioral;
