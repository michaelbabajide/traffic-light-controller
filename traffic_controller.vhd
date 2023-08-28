library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity traffic_controller is
	port(clk_fpga, reset, override			: in std_logic;
			hex0			 							: out std_logic_vector(6 downto 0));
end entity;

architecture behaviour of traffic_controller is
constant clk_freq	: integer := 50e6; --clock frequency of the DE10-Lite


type light_state is (ovride, rst, RED, RED_YELLOW, GREEN, YELLOW_RED);
signal pres_state, next_state: light_state;
signal clk_1Hz : std_logic;

constant OVERRIDE_TIME		: integer := 15;	--15 seconds (dummy constant, system remains in a loop during override unless reset)
constant RESET_TIME			: integer := 1;	--1 second
constant RED_TIME				: integer := 5; 	--5 seconds
constant RED_YELLOW_TIME	: integer := 2;  	--1.5 seconds
constant GREEN_TIME			: integer := 9;	--9 seconds
constant YELLOW_RED_TIME	: integer := 2;	--2 seconds


begin
		
	create_1Hz_clk: process(clk_fpga, reset, override)
	variable cnt : integer range 0 to clk_freq := 0;
	begin
		if override = '0' then
			cnt := 0;
		elsif reset = '0' then
			cnt := 0;
		elsif rising_edge(clk_fpga) then
			if cnt >= clk_freq/2 then
				clk_1Hz <= not clk_1Hz;
				cnt := 0;
			else
				cnt := cnt + 1;
			end if;
		end if;
	end process;
	
	sync_state_transition: process(clk_fpga, reset, override)
	variable cnt: integer range 0 to 10 := 0;
	begin
		if (override = '0') then
			pres_state <= ovride;
		elsif (reset = '0') then
			pres_state <= rst;
		elsif rising_edge(clk_fpga) then
			pres_state <= next_state;
		end if;
	end process;
	
	state_transition_logic: process(pres_state, clk_1Hz, reset, override)
	variable cnt: integer range 0 to 10 := 0;
	begin
		if override = '0' then
			cnt := 0;
			next_state <= ovride;
		elsif reset = '0' then
			cnt := 0;
			next_state <= rst;
		elsif rising_edge(clk_1Hz) then
			case pres_state is
				when ovride =>
					if cnt >= OVERRIDE_TIME then
						cnt := 0;
						next_state <= ovride;
					else
						cnt := cnt + 1;
						next_state <= ovride;
					end if;
					
				when rst =>
					if cnt >= RESET_TIME then
						cnt := 0;
						next_state <= RED;
					else
						cnt := cnt+ 1;
						next_state <= rst;
					end if;
				
				when RED =>
					if cnt >= RED_TIME then
						cnt := 0;
						next_state <= RED_YELLOW;
					else
						cnt := cnt+ 1;
						next_state <= RED;
					end if;
				
				when RED_YELLOW =>
					if cnt >= RED_YELLOW_TIME then
						cnt := 0;
						next_state <= GREEN;
					else
						cnt := cnt+ 1;
						next_state <= RED_YELLOW;
					end if;
				
				when GREEN =>
					if cnt >= GREEN_TIME then
						cnt := 0;
						next_state <= YELLOW_RED;
					else
						cnt := cnt+ 1;
						next_state <= GREEN;
					end if;
				
				when YELLOW_RED =>
					if cnt >= YELLOW_RED_TIME then
						cnt := 0;
						next_state <= RED;
					else
						cnt := cnt + 1;
						next_state <= YELLOW_RED;
					end if;
			end case;
		end if;
	end process;
	
	

	output_logic: process(pres_state)
	begin
		case pres_state is
			when ovride =>
				hex0 <= "0110110";
			when rst =>
				hex0 <= "0110110";
			when RED =>
				hex0 <= "1111110";
			when RED_YELLOW =>
				hex0 <= "0111111";
			when GREEN =>
				hex0 <= "1110111";
			when YELLOW_RED =>
				hex0 <= "0111111";
		end case;
	end process;

end behaviour;