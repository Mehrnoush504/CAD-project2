library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity singleBRAMpartA is
        Port ( clk : in  STD_LOGIC;
           wrEna : in  STD_LOGIC;
           address : in  STD_LOGIC_VECTOR (9 downto 0):="0000000000";
           wrData : in  STD_LOGIC_VECTOR (7 downto 0);
           rdData : out  STD_LOGIC_VECTOR (7 downto 0);
           check : inout integer :=2);
end singleBRAMpartA;

architecture Behavioral of singleBRAMpartA is
----------------------------------------------
type ram_type is array (0 to 9)   --1023
        of std_logic_vector (7 downto 0);   
signal myRAM : ram_type :=("00000000","00000001","00000010","00000011","00000100",
"00000101","00000110","00000111","00001000","00001001");
----------------------------------------------
type state is (idle,readData,writeData,swap);
signal presentState,nextState : state := idle;
----------------------------------------------
type arr is array (1 downto 0)   
        of STD_LOGIC_VECTOR (7 downto 0); 

signal addr: STD_LOGIC_VECTOR (9 downto 0):= address;
signal wena: STD_LOGIC := wrEna;
----------------------------------------------
begin
	
	process(clk)
	variable temp: STD_LOGIC_VECTOR (7 downto 0);
	variable a:integer :=0;
	variable cnt:integer :=-1;
	variable count: integer :=-2;
	begin
		if(clk' event and clk='1') then
			addr<=address;
			case presentState is
			when idle =>
				case check is
					when 0 =>
						presentState <= writeData;
					when 1 =>
						presentState <= readData;
					when 2 =>
						presentState <= swap;
					when 3 =>--show all data in ram
						cnt := cnt + 1;
						addr <= std_logic_vector(to_unsigned(cnt,10));
						if(cnt >= 10)then--1024
							NULL;
						else
							presentState <= readData;
						end if;
					when others =>
						presentState <= idle;
						
				end case;
			when readData =>
				a := to_integer(unsigned(addr));
				rdData <= myram(a);
				presentState <= idle;
			when writeData =>
				a := to_integer(unsigned(addr));
				myram(a) <= wrData;
				presentState <= idle;
			when swap =>
				count := count + 2;
				if(count = 10)then--
					check <= 3;
					cnt:=-1;
					count:=-2;
					presentState <= idle;
				else
					temp := myram(count);
					myram(count) <= myram(count+1);
					myram(count+1) <= temp;
					presentState <= swap;
				end if;
				
			end case;
		end if;
	end process;

end Behavioral;
