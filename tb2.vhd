--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:23:19 01/11/2022
-- Design Name:   
-- Module Name:   D:/vhdl/project/washing_machiine/tb2.vhd
-- Project Name:  washing_machiine
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: WM
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb2 IS
END tb2;
 
ARCHITECTURE behavior OF tb2 IS 
 
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
   constant clk_period : time := 10 ns;
 
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
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
