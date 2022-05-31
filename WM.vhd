library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity WM is
    Port ( clk : in STD_LOGIC;
			  sel : in  STD_LOGIC_VECTOR (1 downto 0);
           cancel : in  STD_LOGIC;
           door_sensor : in  STD_LOGIC;
           water_soap : in  STD_LOGIC;
           mode : out  STD_LOGIC_VECTOR (6 downto 0):= "0000001";
           rinse_finished : out  STD_LOGIC:= '0';
           dry_finished : out  STD_LOGIC:= '0';
			  temperature : out STD_LOGIC_VECTOR (2 downto 0):= "000");
end WM;

architecture Behavioral of WM is
signal counter : integer;
signal finished : STD_LOGIC;
constant rinse_time : integer := 60;
constant dry_time : integer := 20;
type WM_state is (idle,mode_sel,cold,warm,hot,rinse,dry);
signal state : WM_state;
begin
Washing_process: process(clk,cancel,door_sensor)
begin
	if(cancel = '1' or door_sensor = '0') then
		state <= idle;
		dry_finished <= '0';
		rinse_finished <= '0';
		finished <= '0';
	elsif rising_edge(clk) then
		case state is
			when idle =>
				counter <= 0;
				mode <= "0000001";
				if cancel = '0' and door_sensor = '1' and finished = '0' then
					state <= mode_sel;
				else
					state <= idle;
				end if;
			when mode_sel =>
				mode <= "0000010";
				if sel = "00" then
					state <= cold;
				elsif sel = "01" then
					state <= warm;
				elsif sel = "10" then
					state <= hot;
				elsif sel = "11" then
					state <= dry;
				else
					state <= mode_sel;
				end if;
			when cold =>
				mode <= "0000100";
				temperature <= "001";
				if water_soap = '1' then
					state <= rinse;
				else
					state <= cold;
				end if;
			when warm =>
				mode <= "0001000";
				temperature <= "010";
				if water_soap = '1' then
					state <= rinse;
				else
					state <= warm;
				end if;
			when hot =>
				mode <= "0010000";
				temperature <= "100";
				if water_soap = '1' then
					state <= rinse;
				else
					state <= hot;
				end if;
			when rinse =>
				mode <= "0100000";
				if counter >= rinse_time then
					counter <= 0;
					rinse_finished <= '1';
					state <= dry;
				else
					counter <= counter + 1;
					state <= rinse;
				end if;
			when dry =>
				mode <= "1000000";
				if counter >= dry_time then
					counter <= 0;
					dry_finished <= '1';
					finished <= '1';
					state <= idle;
				else
					counter <= counter + 1;
					state <= dry;
				end if;
		end case;
	end if;
end process;
end Behavioral;

