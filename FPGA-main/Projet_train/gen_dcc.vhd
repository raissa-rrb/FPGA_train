----------------------------------------------------------------------------------
-- Company: SORBONNE UNIVERSITE
-- Designed by: J.DENOULET, Winter 2021
--
-- Module Name: DCC_FRAME_GENERATOR - Behavioral
-- Project Name: Centrale DCC
-- Target Devices: NEXYS 4 DDR
-- 
--	GÃ©nÃ©rateur de Trames de Test pour la Centrale DCC
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DCC_FRAME_GENERATOR is
    Port ( Interrupteur	: in STD_LOGIC_VECTOR(7 downto 0);	-- Interrupteurs de la Carte
           Trame_DCC 	: out STD_LOGIC_VECTOR(50 downto 0));					-- Trame DCC de Test					
end DCC_FRAME_GENERATOR;

architecture Behavioral of DCC_FRAME_GENERATOR is

begin

-- GÃ©nÃ©ration d'une Trame selon l'Interrupteur TirÃ© vers le Haut
-- Si Plusieurs Interupteurs Sont TirÃ©s, Celui de Gauche Est Prioritaire

-- ComplÃ©ter les Trames pour RÃ©aliser les Tests Voulus

process(Interrupteur)
begin
	
	-- Interrupteur 7 ActivÃ©
		--> Trame Marche Avant du Train d'Adresse i
	if Interrupteur(7)='1' then
	
		Trame_DCC <= 	"11111111111111111111111"		-- PrÃ©ambule "au moins 14" donc on en met + si besoin comme ici
					& 		'0'		-- Start Bit
					&	"00000001"  -- Champ Adresse : 1 pour le train 1
					& 		'0'		-- Start Bit
					&	"01110100"	-- Champ Commande marche avant : bit D = 1 + step 1 00010
					& 		'0'		-- Start Bit
					& 	"01110101"	-- Champ ContrÃ´le
					&  '1'	;		-- Stop Bit

	-- Interrupteur 6 ActivÃ©
		--> Trame Marche ArriÃ¨re du Train d'Adresse i
	elsif Interrupteur(6)='1' then
	
		Trame_DCC <= "11111111111111111111111"				-- PrÃ©ambule
					& 	'0'			-- Start Bit
					&	"00000001"			-- Champ Adresse
					& 	'0'				-- Start Bit
					&	"01010100"			-- Champ Commande marche arrière bit D=0 + step 
					& 	'0'				-- Start Bit
					& 	"01010101"			-- Champ ContrÃ´le
					& '1'	;			-- Stop Bit


	-- Interrupteur 5 ActivÃ© --ok
		--> Allumage des Phares du Train d'Adresse i
	elsif Interrupteur(5)='1' then
	
		Trame_DCC <="11111111111111111111111"				-- PrÃ©ambule
					& 	'0'			-- Start Bit
					&	"00000001"	-- Champ Adresse
					& 	'0'			-- Start Bit
					&	"10010000" 	-- Champ Commande :  bit 4 a 1 phare allumés - F1-F4 OFF
					& 	'0'			-- Start Bit
					& 	"10010001"			-- Champ ContrÃ´le
					& '1'	;			-- Stop Bit

	-- Interrupteur 4 ActivÃ© --ok
		--> Extinction des Phares du Train d'Adresse i
	elsif Interrupteur(4)='1' then
	
		Trame_DCC <= "11111111111111111111111"				-- PrÃ©ambule
					& 	'0'			-- Start Bit
					&	"00000001"			-- Champ Adresse
					& 	'0'			-- Start Bit
					&	"10000000"			-- Champ Commande phares éteint : bit 4 à 0
					& 	'0'			-- Start Bit
					& 	"10000001"			-- Champ ContrÃ´le
					& '1'	;			-- Stop Bit

	-- Interrupteur 3 ActivÃ© --ok
		--> Activation du Klaxon (Fonction F11) du Train d'Adresse i
	elsif Interrupteur(3)='1' then
	
		Trame_DCC <= 	"11111111111111111111111"			-- PrÃ©ambule
					& 	'0'			-- Start Bit
					&	"00000001"			-- Champ Adresse
					& 	'0'			-- Start Bit
					&	"10100100"	-- Champ Commande bit S à 0 -> fonction F9-F12 + bit 2 à 1 x F11
					& 		'0'		-- Start Bit
					& 	"10100101"			-- Champ ContrÃ´le
					& '1'	;			-- Stop Bit

	-- Interrupteur 2 ActivÃ© --ok
		--> RÃ©amorÃ§age du Klaxon (Fonction F11) du Train d'Adresse i
	elsif Interrupteur(2)='1' then
	
		Trame_DCC <= 	"11111111111111111111111"			-- PrÃ©ambule
					& 	'0'			-- Start Bit
					&	"00000001"			-- Champ Adresse
					& 	'0'			-- Start Bit
					&	"10100000"			-- Champ Commande S à 0 : F9-F12 + F11 OFF
					& 	'0'			-- Start Bit
					& 	"10100001"			-- Champ ContrÃ´le
					& '1'	;			-- Stop Bit

	-- Interrupteur 1 ActivÃ© --ok
		--> Annonce SNCF (Fonction F13) du Train d'Adresse i
	elsif Interrupteur(1)='1' then
	
		Trame_DCC <= 	"11111111111111"			-- PrÃ©ambule
					& 	'0'			-- Start Bit
					&	"00000001"			-- Champ Adresse
					& 	'0'			-- Start Bit
					&	"11011110"			-- Champ Commande (Octet 1)
					& 	'0'			-- Start Bit
					&	"00000001"			-- Champ Commande (Octet 2) annonce = F13 -> bit 0
					& 	'0'			-- Start Bit
					& 	"11011110"			-- Champ ContrÃ´le
					& '1'	;			-- Stop Bit

	-- Interrupteur 0 ActivÃ© --ok
		--> Annonce SNCF (Fonction F13) du Train d'Adresse i
	elsif Interrupteur(0)='1' then
	
		Trame_DCC <= 	"11111111111111"			-- PrÃ©ambule
					& 		'0'		-- Start Bit
					&		"00000001"		-- Champ Adresse
					& 	'0'			-- Start Bit
					&	"11011110"			-- Champ Commande (Octet 1)
					& 		'0'		-- Start Bit
					&	"00000000"			-- Champ Commande (Octet 2)
					& 	'0'			-- Start Bit
					& 	"11011111"			-- Champ ContrÃ´le
					& '1'	;			-- Stop Bit

	-- Aucun Interrupteur ActivÃ©
		--> ArrÃªt du Train d'Adresse i
	else 
	
		Trame_DCC <= 	"11111111111111111111111"			-- PrÃ©ambule
					& 	'0'			-- Start Bit
					&	"00000001"			-- Champ Adresse
					& 	'0'			-- Start Bit
					&	"01100000"			-- Champ Commande marche avant + vitesse = stop
					& 	'0'			-- Start Bit
					& 	"01100001"			-- Champ ContrÃ´le
					& '1'	;			-- Stop Bit
	
	end if;
end process;

end Behavioral;

