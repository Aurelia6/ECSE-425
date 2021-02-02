library ieee;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

-- Do not modify the port map of this structure
entity comments_fsm is
port (clk : in std_logic;
      reset : in std_logic;
      input : in std_logic_vector(7 downto 0);
      output : out std_logic
  );
end comments_fsm;

architecture behavioral of comments_fsm is

-- The ASCII value for the '/', '*' and end-of-line characters
constant SLASH_CHARACTER : std_logic_vector(7 downto 0) := "00101111";
constant STAR_CHARACTER : std_logic_vector(7 downto 0) := "00101010";
constant NEW_LINE_CHARACTER : std_logic_vector(7 downto 0) := "00001010";

type state_type is (state0,state1,state2,state3,state4, state5); -- Declare state types 
signal state : state_type;
signal temp_output : std_logic := '0';

begin

-- Insert your processes here
process (clk, reset)
begin
	if reset = '1' then
		state <= state0;
		temp_output <= '0';
   
	elsif rising_edge(clk) then
        	case state is
            	
			when state0 =>
                		if input = SLASH_CHARACTER then
                    			state <= state1;
                    			temp_output <= '0';
				else
                    			state <= state0;
                    			temp_output <= '0';
                		end if;
            
			when state1 =>
                		if input = STAR_CHARACTER then
                    			state <= state2;
                    			temp_output <= '0';
                		elsif input = SLASH_CHARACTER then
                    			state <= state5;
                    			temp_output <= '0';
                		else
                    			state <= state0;
                    			temp_output <= '0';
                		end if;
            
			when state2 =>
                		if input = STAR_CHARACTER then
                    			state <= state3;
                    			temp_output <= '1';
                		else
                    			state <= state4;
                    			temp_output <= '1';
                		end if;
            
			when state3 =>
                		if input = STAR_CHARACTER then
                    			state <= state3;
                    			temp_output <= '1';
                		elsif input = SLASH_CHARACTER then
                    			state <= state0;
                    			temp_output <= '1';
                		else
                    			state <= state4;
                    			temp_output <= '1';
                		end if;
            
			when state4 =>
                		if input = STAR_CHARACTER then
                    			state <= state3;
                    			temp_output <= '1';
                		else
                    			state <= state4;
                    			temp_output <= '1';
                		end if;
            		
			when state5 =>
                		if input = NEW_LINE_CHARACTER then
                    			state <= state0;
                    			temp_output <= '1';
                		else
                    			state <= state5;
                    			temp_output <= '1';
                		end if;

		end case;
	else 
		state <= state;
		temp_output <= temp_output;
    	end if;
end process;

output <= temp_output;

end behavioral;