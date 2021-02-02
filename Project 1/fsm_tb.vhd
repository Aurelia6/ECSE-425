LIBRARY ieee;
USE ieee.STD_LOGIC_1164.all;

ENTITY fsm_tb IS
END fsm_tb;

ARCHITECTURE behaviour OF fsm_tb IS

COMPONENT comments_fsm IS
PORT (clk : in std_logic;
      reset : in std_logic;
      input : in std_logic_vector(7 downto 0);
      output : out std_logic
  );
END COMPONENT;

--The input signals with their initial values
SIGNAL clk, s_reset, s_output: STD_LOGIC := '0';
SIGNAL s_input: std_logic_vector(7 downto 0) := (others => '0');

CONSTANT clk_period : time := 1 ns;
CONSTANT SLASH_CHARACTER : std_logic_vector(7 downto 0) := "00101111";
CONSTANT STAR_CHARACTER : std_logic_vector(7 downto 0) := "00101010";
CONSTANT NEW_LINE_CHARACTER : std_logic_vector(7 downto 0) := "00001010";

BEGIN
dut: comments_fsm
PORT MAP(clk, s_reset, s_input, s_output);

 --clock process
clk_process : PROCESS
BEGIN
	clk <= '0';
	WAIT FOR clk_period/2;
	clk <= '1';
	WAIT FOR clk_period/2;
END PROCESS;
 
--TODO: Thoroughly test your FSM
stim_process: PROCESS
BEGIN   
	-- Test 1 - State 0 to State 0
	REPORT "Test 1: Example case, reading a meaningless character";
	s_input <= "01011000";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a meaningless character after State 0, the output should be '0'" SEVERITY ERROR;
	REPORT "Position: State 0";
	REPORT "_______________________";
	
	-- Test 2 - State 0 to State 1
	REPORT "Test 2: Example case, reading '/' after State 0";
	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading '/' after State 0, the output should be '0'" SEVERITY ERROR;
	REPORT "Position: State 1";
	REPORT "_______________________";

	-- Test 3 - State 1 to State 2
	REPORT "Test 3: Example case, reading '*' after State 1";
	s_input <= STAR_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading '*' after State 1, the output should be '0'" SEVERITY ERROR;
	REPORT "Position: State 2";
	REPORT "_______________________";

	-- Test 4 - State 2 to State 3
	REPORT "Test 4: Example case, reading '*' after State 2";
	s_input <= STAR_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading '*' after State 2, the output should be '1'" SEVERITY ERROR;
	REPORT "Position: State 3";
	REPORT "_______________________";

	-- Test 5 - State 3 to State 3
	REPORT "Test 5: Example case, reading '*' after State 3";
	s_input <= STAR_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading '*' after State 3, the output should be '1'" SEVERITY ERROR;
	REPORT "Position: State 3";
	REPORT "_______________________";

	-- Test 6 - State 3 to State 4
	REPORT "Test 6: Example case, reading a meaningless character after State 3";
	s_input <= "01011000";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a meaningless character after State 3, the output should be '1'" SEVERITY ERROR;
	REPORT "Position: State 4";
	REPORT "_______________________";

	-- Test 7 - State 4 to State 4
	REPORT "Test 7: Example case, reading a meaningless character after State 4";
	s_input <= "01011000";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a meaningless character after State 4, the output should be '1'" SEVERITY ERROR;
	REPORT "Position: State 4";
	REPORT "_______________________";
	
	-- Test 8 - State 4 to State 3
	REPORT "Test 8: Example case, reading '*' after State 4";
	s_input <= STAR_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a '*' after State 4, the output should be '1'" SEVERITY ERROR;
	REPORT "Position: State 3";
	REPORT "_______________________";

	-- Test 9 - State 3 to State 0
	REPORT "Test 9: Example case, reading '/' after State 3";
	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a '/' after State 3, the output should be '1'" SEVERITY ERROR;
	REPORT "Position: State 0";
	REPORT "_______________________";

	-- Test 10 - State 0 to State 0 (passing through State 1)
	REPORT "Test 10: Example case, reading '/' and a meaningless character after State 0";
	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a '/' after State 0, the output should be '0'" SEVERITY ERROR;
	REPORT "Position: State 1";

	s_input <= "01011000";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a meaningless character after State 1, the output should be '0'" SEVERITY ERROR;
	REPORT "Position: State 0";
	REPORT "_______________________";

	-- Test 11 - State 0 to State 4 (passing through States 1 and 2)
	REPORT "Test 11: Example case, reading '/*' and a meaningless character after State 0";
	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading '/' after State 0, the output should be '0'" SEVERITY ERROR;
	REPORT "Position: State 1";
	
	s_input <= STAR_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading '*' after State 1, the output should be '0'" SEVERITY ERROR;
	REPORT "Position: State 2";

	s_input <= "01011000";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a meaningless character after State 2, the output should be '1'" SEVERITY ERROR;
	REPORT "Position: State 4";
	REPORT "_______________________";

	-- Test 12 - State 4 to State 5 (passing through States 3,0 and 1)
	REPORT "Test 12: Example case, reading '*///' after State 4";
	s_input <= STAR_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading '*' after State 4, the output should be '1'" SEVERITY ERROR;
	REPORT "Position: State 3";
	
	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading '/' after State 3, the output should be '1'" SEVERITY ERROR;
	REPORT "Position: State 0";
	
	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading '/' after State 0, the output should be '0'" SEVERITY ERROR;
	REPORT "Position: State 1";

	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading '/' after State 1, the output should be '0'" SEVERITY ERROR;
	REPORT "Position: State 5";
	REPORT "_______________________";

	-- Test 13 - State 5 to State 5 
	REPORT "Test 13: Example case, reading a meaningless character after State 5";
	s_input <= "01011000";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a meaningless character after State 5, the output should be '1'" SEVERITY ERROR;
	REPORT "Position: State 5";
	REPORT "_______________________";

	-- Test 14 - State 5 to State 0 
	REPORT "Test 14: Example case, reading '\n' character after State 5";
	s_input <= NEW_LINE_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading '\n' after State 5, the output should be '1'" SEVERITY ERROR;
	REPORT "Position: State 0";
	REPORT "_______________________";

	REPORT "END";

	WAIT;
END PROCESS stim_process;
END;
