library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--permet de relier tous les blocs entre eux
entity Top is
 Port ( Interrupteurs : in std_logic_vector(7 downto 0 );
        clk, reset : in std_logic;
        sortie_dcc_top : out std_logic);
end Top;

architecture Behavioral of Top is

 --toutes les entrées et sorties des blocs à relier
signal trame_dcc: std_logic_vector(50 downto 0);
signal com, reg, go_0, fin_0, dcc_0, go_1, fin_1, dcc_1 : std_logic := '0';
signal clk_1M, start_tempo, fin_tempo: std_logic := '0';
signal sortie_dcc : std_logic :='0';

begin

 --instance du bloc de générateur de trames selon l'interrupteur levé
 -- retourne une trame dcc
gen_dcc : entity work.dcc_frame_generator
    port map( interrupteur => interrupteurs,
                trame_dcc => trame_dcc);

 -- instance du bloc registre dcc : charge la trame reçue par gen_dcc et retourne le bit de poids forst
 -- à la mae à chhauqe réception de la commande reg
reg_dcc : entity work.registre_dcc
port map( trame_dcc => trame_dcc,
          clk_100M => clk,
          reset => reset,
          com => com,
          reg => reg,
          sortie_dcc => sortie_dcc
          );

 --diviseur d'horloge fourni
div : entity work.clk_div

port map (reset => reset,
          clk_in => clk,
          clk_out => clk_1M);

 --instance du boc dcc 0 qui représente le bit 0
 -- communique avec la mae par fin_0 et go_0
dcc_b0 : entity work.dcc_bit0
port map( go_0 => go_0,
        clk_100M => clk,
        clk_1M => clk_1M,
        reset => reset,
        fin_0 => fin_0,
        dcc_0 => dcc_0);

 --instance du boc dcc  qui représente le bit 1
 -- communique avec la mae par fin_1 et go_1
 dcc_b1 : entity work.dcc_bit1
port map( go_1 => go_1,
        clk_100M => clk,
        clk_1M => clk_1M,
        reset => reset,
        fin_1 => fin_1,
        dcc_1 => dcc_1);

  -- instance du bloc mae qui communique avec reg_dcc, dcc_0 et dcc_1 et tempo
mae : entity work.MAE
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
 
 --  instance du bloc tempo qui permet d'attendre un délai de 6ms   
tempo : entity work.compteur_tempo
port map( Clk => clk,
           Reset => reset,
           Clk1M => clk_1M,
           Start_Tempo	=> start_tempo,
           Fin_Tempo => fin_tempo
);                      

 --selon l'architecture demandée, on fait un ou de dcc0 et cc1 en sortie
sortie_dcc_top <= dcc_1 or dcc_0;
 
     
end Behavioral;
