----------------------------------------------------------------------------------
-- Company: UPMC
-- Engineer: Julien Denoulet
-- 
-- Create Date:   	Septembre 2016 
-- Module Name:    	Impulse_Count - Behavioral 
-- Project Name: 		TP1 - FPGA1
-- Target Devices: 	Nexys4 / Artix7

-- XDC File:			Impulse_Count.xdc					

-- Description: Compteur d'Impulsions - Version KO
--
--		Compteur d'Impulsions sur 4 bits
--			- Le Compteur s'IncrÃ©mente si on Appuie sur le Bouton Left
--			- Le Compteur se'DÃ©crÃ©mente si on Appuie sur le Bouton Center
--			- Sup Passe Ã  1 si le Compteur DÃ©passe 9
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity IMPULSE_COUNT is
    Port ( clk : in std_logic;
           Reset : in  STD_LOGIC;								-- Reset Asynchrone
           Button_L : in  STD_LOGIC;							-- Bouton Left
           Button_C : in  STD_LOGIC;							-- Bouton Center
           Count : out  STD_LOGIC_VECTOR (3 downto 0);	-- Compteur d'Impulsions
           Sup : out  STD_LOGIC);								-- Indicateur Valeur Seuil
end IMPULSE_COUNT;

architecture Behavioral of IMPULSE_COUNT is

signal cpt: std_logic_vector(3 downto 0);		-- Compteur d'Impulsions
signal last_L: std_logic;
signal last_C: std_logic;
begin

	

	-------------------------
	-- Gestion du Compteur --
	-------------------------
	process(clk,reset)

	begin

		-- Reset Asynchrone
		if reset='1' then cpt<="0000"; --end if;
		last_L<='0';
		last_C<='0';

		-- IncrÃ©mentation Si on Appuie sur le Bouton Left
		--pour les rising edge on les fait sur clk => il faut un seul chef d'orchestre
		--if rising_edge(Button_L) then	
		elsif rising_edge(clk) then 
		      last_L <= Button_L;
		      last_C <= Button_C;
		      
		    if Button_L='1' and last_L='0' then
              cpt<=cpt+1;
              last_L<='1';
            end if;
            if Button_C='1' and last_C='0' then
              cpt<=cpt-1;
              last_C<='1';
            end if;

            if Button_L='0' and last_L='1' then
              last_L<='0';
            end if;
            if Button_C='0' and last_C='1' then
              last_C<='0';
            end if;

		end if;
		
		-- DÃ©crÃ©mentation Si on Appuie sur le Bouton Center
		--if rising_edge(clk) and Button_C ='1' then			
            --cpt<=cpt-1;
        --end if;
	end process;

	-------------------------
	-- Gestion du Flag Sup --
	-------------------------
	process(Cpt)

	begin
		 count <= cpt;	-- Affichage en Sortie du Compteur
		-- Mise Ã  1 si CPT DÃ©passe 9. A 0 Sinon...
		if (cpt > 9) then 			
			Sup<='1'; 									
		else 							
			Sup<='0'; 
		end if;
	end process;

 

end Behavioral;

-- il faut modifier le .xdc et remettre clk normale ( lignes 7 et 8 

