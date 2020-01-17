LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY SBRAMpartB_tb IS
END SBRAMpartB_tb;
 
ARCHITECTURE behavior OF SBRAMpartB_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SBRAMpartB
    PORT(
         clk : IN  std_logic;
         wrEna : IN  std_logic;
         address : IN  std_logic_vector(9 downto 0);
         wrData : IN  std_logic_vector(7 downto 0);
         rdData : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal wrEna : std_logic := '0';
   signal address : std_logic_vector(9 downto 0) := (others => '0');
   signal wrData : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal rdData : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SBRAMpartB PORT MAP (
          clk => clk,
          wrEna => wrEna,
          address => address,
          wrData => wrData,
          rdData => rdData
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
