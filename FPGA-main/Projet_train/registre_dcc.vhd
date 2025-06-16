----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2024 23:41:18
-- Design Name: 
-- Module Name: registre_dcc - Behavioral
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

entity registre_dcc is
  Port ( trame_dcc : in std_logic_vector(50 downto 0);
        clk_100M, reset, com, reg : in std_logic;
        sortie_dcc : out std_logic
  );
end registre_dcc;

 architecture Behavioral of registre_dcc is

signal trame : std_logic_vector(50 downto 0):= (others => '0');

begin

process(reset, clk_100M)
    begin
    
        if reset='1' then
            sortie_dcc <= '0';
            
        elsif rising_edge(clk_100M) then 
            
            if com='1' then
                trame <= trame_dcc;
            end if;
            
            if reg='1' then
                sortie_dcc <= trame(50);
                trame(50 downto 0) <= trame(49 downto 0)&'0';
            end if;

        end if;
 end process;

end Behavioral;
