library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity led is
    port (  sw_state : in std_logic_vector(3 downto 0);
            leds : out std_logic_vector(15 downto 0));
end led;

architecture behavioural of led is

begin

    leds(3 downto 0) <= X"F" when sw_state(0) = '1';
    leds(7 downto 4) <= X"F" when sw_state(1) = '1';
    leds(11 downto 8) <= X"F" when sw_state(2) = '1';
    leds(15 downto 12) <= X"F" when sw_state(3) = '1';    
    
end behavioural;