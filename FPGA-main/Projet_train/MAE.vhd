
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MAE is
    Port ( clk, reset : in std_logic ;
           fin_tempo, fin_1, fin_0 : in std_logic; 
           start_tempo, reg, com, go_1, go_0 : out std_logic;
            bit_dcc : in std_logic
    );
end MAE;

architecture Behavioral of MAE is

signal cpt : integer range 0 to 51;
type etat is (IDLE, LOAD, SEND_REG, DCC, BIT_1, BIT_0, SUIV);
signal EP, EF : etat;

begin

    --gestion cpt 
    process (clk, reset)
        begin
            if reset='1' then cpt <= 0; 
            
            elsif rising_edge(clk) then 
                -- le compteur s'incrémente quand on envoie reg pour décaler la trame
                if EP = DCC then cpt <= cpt +1;

                --on le remet à 0 dans idle pour une nouvelle trame
                elsif EP = IDLE then cpt <= 0;
                end if;
            end if;
    end process;
    
    --gestion EP et EF
    process (clk, reset)
        begin
            if reset='1' then EP <= IDLE;
            
            elsif rising_edge(clk) then EP <= EF;
            
            end if;
    end process;
    
    --gestion MAE : états
    process (clk,EP, fin_1, fin_0)
        begin 
        
            case(EP) is

                --IDLE attend la fin du délai de 6ms
            when IDLE =>EF <= IDLE; 
                      --  reg <= '0';
                      --  com <= '0';
                      --  go_0 <= '0';
                      --  go_1 <= '0';
            --une fois le délai passé et le compteur à 00 on peut demander a reg dcc de charge la trame
                        if fin_tempo='1' and cpt=0  
                            then EF <= LOAD;
                        end if;

            -- Load demande a dcc de charger la trame, on saute dnas l'état send reg 
            when LOAD => --EF <= LOAD;
                     --   reg <= '0';
                      --  com <= '1';
                      --  go_0 <= '0';
                      --  go_1 <= '0'; 
                        EF <= SEND_REG; 

            --celui ci demande a reg dcc d'envoyer un bit de la trame et de décaler le reste
            when SEND_REG => EF <= DCC;

            -- ici on détermine si le bit reçu est un '1' ou un '0'
            when DCC => EF <= DCC;
                    --    reg <= '1';
                    --    com <= '0';
                    --    go_0 <= '0';
                     --   go_1 <= '0';
                                                 
                        if bit_dcc ='0' then
                            EF <= BIT_0; --représentation de 0 selon le protocole DCC
                        elsif bit_dcc ='1' then 
                            EF <= BIT_1; -- représentation de 1 selon le protocole DCC
                        end if;
                        
            when BIT_1 => EF <= BIT_1; 
                       -- reg <= '0';
                      --  com <= '0';
                       -- go_0 <= '0';
                       -- go_1 <= '1';

                        -- on attend la fin de la représentation
                        if fin_1 ='1' then 
                            EF <= SUIV;
                        end if;
            
            when BIT_0 => EF <= BIT_0;
                       -- reg <= '0';
                       -- com <= '0';
                       -- go_0 <= '1';
                        --go_1 <= '0';

                        -- on attend la fin de la représentation                        
                        if fin_0 ='1' then 
                            EF <= SUIV;
                        end if;
            
            when SUIV => EF <= SUIV;
            --si le compteur affiche 51 alors on est à la fin de la trame et on retourne à idle
                        if cpt=51 then EF <= IDLE;
            --sinon on demande l'envoi du bit suivant
                        else EF <= SEND_REG;
                        end if;
            
            end case;
    end process;
    
    --combinatoire etats
    process(EP)
        begin
        
            case(EP) is
                when IDLE => reg <= '0'; com <= '0' ; go_0 <= '0'; go_1 <= '0'; start_tempo <='1';
                
                when LOAD => reg <= '0'; com <= '1' ; go_0 <= '0'; go_1 <= '0'; start_tempo <='0';
                
                when SEND_REG => reg <= '1'; com <= '0' ; go_0 <= '0'; go_1 <= '0'; start_tempo <='0';
                
                when DCC => reg <= '0'; com <= '0' ; go_0 <= '0'; go_1 <= '0';start_tempo <='0';
                
                when BIT_1 => reg <= '0'; com <= '0' ; go_0 <= '0'; go_1 <= '1';start_tempo <='0';
                
                when BIT_0 => reg <= '0'; com <= '0' ; go_0 <= '1'; go_1 <= '0';start_tempo <='0';

                when SUIV =>reg <= '0'; com <= '0' ; go_0 <= '0'; go_1 <= '0'; start_tempo <='0';
            end case;
    end process;
end Behavioral;
