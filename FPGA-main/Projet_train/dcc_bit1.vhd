library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity dcc_bit1 is
    Port ( go_1, clk_100M, clk_1M, reset : in std_logic ;
           fin_1, dcc_1 : out std_logic );
end dcc_bit1;

architecture Behavioral of dcc_bit1 is

signal cpt : integer range 0 to 116;
type etat is ( Idle, Send_0, Send_1, Done);
signal EP, EF : etat;

begin
--process état présent
    process( clk_100M, reset )
    
        begin
        
            if reset ='1' then EP <= Idle;
            
            elsif rising_edge(clk_100M) then 
                EP <= EF;
                
            end if;
            
    end process;
    
    -- process gestion cpt
    
    process(clk_1M, reset)
    
        begin
        
                if reset='1' then cpt <= 0;
                
                elsif rising_edge(clk_1M) then
                if ( EP = Idle ) then 
                    cpt <= 0;
                end if;

            -- on génère une impulsion seulement si on est dans un de ces deux états
                if ( EP = Send_0 ) or ( EP= Send_1) then 
                    cpt <= cpt +1;
                
                end if;
                
          end if;
          
      end process;

    --process pour la gestion de la MAE
    process(clk_100M, EP, go_1)
    
    begin
    
        case(EP) is

            --IDLE : attend la demande de la MAE de représenter un '1' avec go_1
        when IDLE => EF <= IDLE; 
                     fin_1 <= '0';
                     dcc_1 <='0';
                     if go_1 = '1' and cpt=0 then 
                        EF <= Send_0;
                     end if;
                         
        -- Send_0 : impulsion '0' de 58 us
        when Send_0 => EF <= Send_0;
                       fin_1 <= '0';
                       dcc_1 <= '0';
                       if cpt=58 then 
                            EF <= Send_1;
                       end if;
        
        -- Send_1 : impulsion '1' de 58 us
        when Send_1 => EF <= Send_1;
                       fin_1 <= '0';
                       dcc_1 <= '1';
                       if cpt=116 then 
                            EF <= Done;
                        end if;

        --Done : retour sur Idle
        when Done => EF <= Idle;
                    fin_1 <='1';
                    dcc_1 <= '0';
        
        end case;

    end process;


end Behavioral;
