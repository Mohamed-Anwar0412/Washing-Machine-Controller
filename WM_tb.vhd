LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY WM_tb IS
END WM_tb;
 
ARCHITECTURE behavior OF WM_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT WM
    PORT(
         clk : IN  std_logic;
         sel : IN  std_logic_vector(1 downto 0);
         cancel : IN  std_logic;
         door_sensor : IN  std_logic;
         water_soap : IN  std_logic;
         mode : OUT  std_logic_vector(6 downto 0);
         rinse_finished : OUT  std_logic;
         dry_finished : OUT  std_logic;
         temperature : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    
   --Inputs
   signal clk : std_logic := '0';
   signal sel : std_logic_vector(1 downto 0) := (others => '0');
   signal cancel : std_logic := '0';
   signal door_sensor : std_logic := '0';
   signal water_soap : std_logic := '0';

 	--Outputs
   signal mode : std_logic_vector(6 downto 0);
   signal rinse_finished : std_logic;
   signal dry_finished : std_logic;
   signal temperature : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant clk_period : time := 1000 ms;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: WM PORT MAP (
          clk => clk,
          sel => sel,
          cancel => cancel,
          door_sensor => door_sensor,
          water_soap => water_soap,
          mode => mode,
          rinse_finished => rinse_finished,
          dry_finished => dry_finished,
          temperature => temperature
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.	
      -- insert stimulus here 
		cancel <= '1';
		door_sensor <= '0';
		water_soap <= '0';
      wait for clk_period*10;
		cancel <= '0';
		door_sensor <= '1';
		sel <= "00";
		wait for clk_period*10;
		water_soap <= '1';
		wait for clk_period*90;
		cancel <= '1';
		door_sensor <= '0';
		water_soap <= '0';
      wait for clk_period*10;
		cancel <= '0';
		door_sensor <= '1';
		sel <= "01";
		wait for clk_period*10;
		water_soap <= '1';
		wait for clk_period*90;
		cancel <= '1';
		door_sensor <= '0';
		water_soap <= '0';
      wait for clk_period*10;
		cancel <= '0';
		door_sensor <= '1';
		sel <= "10";
		wait for clk_period*10;
		water_soap <= '1';
		wait for clk_period*90;
		cancel <= '1';
		door_sensor <= '0';
		water_soap <= '0';
      wait for clk_period*10;
		cancel <= '0';
		door_sensor <= '1';
		sel <= "11";
		wait for clk_period*30;
		sel <= "10";
		wait for clk_period*50;

      wait;
   end process;

END;
