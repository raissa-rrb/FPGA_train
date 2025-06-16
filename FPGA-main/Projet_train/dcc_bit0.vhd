library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity dcc_bit0 is
    Port ( go_0, clk_100M, clk_1M, reset : in std_logic ;
           fin_0, dcc_0 : out std_logic );
end dcc_bit0;

architecture Behavioral of dcc_bit0 is

signal cpt : integer range 0 to 200;
type etat is ( Idle, Send_0, Send_1, Done);
signal EP, EF : etat;
signal end_cpt : std_logic :='0';

begin
--process pour déterminer l'état présent 
    process( clk_100M, reset )
    
        begin
    
            if reset ='1' then EP <= Idle;
            
            elsif rising_edge(clk_100M) then 
                EP <= EF;
                
            end if;
            
    end process;
    
    -- process gestion cpt
    
    process(clk_1M, reset, end_cpt)
    
        begin
                if reset='1' then cpt <= 0;
                
                elsif rising_edge(clk_1M) then
                 -- on incrémente le compteur pendant l'envoi d'un '0' ou d'un '1'
                    if ( EP = Send_0 ) or ( EP= Send_1) then 
                        cpt <= cpt +1;
                    
                 --end cpt à '1' indique la fin de l'opération de comptage et permet de remettre le compteur à 0
                elsif end_cpt='1' then
                    cpt <= 0;
                
                end if;
                
          end if;
          
      end process;
--Process gestion de la MAE 
    process(clk_100M, EP, go_0)
    
    begin
    
        case(EP) is
        --IDLE : attend go_0 pour commencer la génération de '0'
        when IDLE => EF <= IDLE; 
                     fin_0 <= '0';
                     dcc_0 <='0';
                     end_cpt <='1';
                     if go_0 = '1' and cpt=0 then 
                        EF <= Send_0;
                     end if;
        --SEND_0 : génère l'impulsion '0' pendant 100 us
        when Send_0 => EF <= Send_0;
                       fin_0 <= '0';
                       dcc_0 <= '0';
                       end_cpt <='0';
                       if cpt>=100 then 
                            EF <= Send_1;
                       end if;
        
        --SEND_1 : génère l'impulsion '1' pendant 100 us   
        when Send_1 => EF <= Send_1;
                       fin_0 <= '0';
                       dcc_0 <= '1';
                       end_cpt <='0';
                       if cpt>=200 then 
                            EF <= Done;
                        end if;
           -- Done : retourne à idle et génère l'impulsion fin_0 pour prévenir la MAE ainsi que la remis eà 0 du cpt avec end_cpt                 
        when Done => EF <= Idle;
                    fin_0 <='1';
                    dcc_0 <= '0';
                    end_cpt <='1';
        
        end case;

    end process;


end Behavioral;
