----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.05.2024 01:41:47
-- Design Name: 
-- Module Name: dcc_bit0_TB - Behavioral
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


entity dcc_bit1_TB is
end dcc_bit1_TB;

architecture Behavioral of dcc_bit1_TB is

signal clk_100M : std_logic := '0';
signal clk_1M : std_logic := '0';
signal go_1, reset :  std_logic ;
signal fin_1, dcc_1 :  std_logic :='0';
constant CLK_PER: time := 10 ns;

begin

div : entity work.clk_div

port map (reset => reset,
          clk_in => clk_100M,
          clk_out => clk_1M);

l0 : entity work.dcc_bit1
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
 
 reset <= '1', '0'  after 10 us;
 go_1 <= '0', '1' after 20 us, '0' after 40 us, '1' after 160 us, '0' after 180 us;


end Behavioral;
