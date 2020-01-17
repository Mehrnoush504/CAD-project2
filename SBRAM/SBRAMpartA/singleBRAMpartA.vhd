library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity singleBRAMpartA is
    Port ( clk : in  STD_LOGIC;
           wrEna : in  STD_LOGIC;
           address : in  STD_LOGIC_VECTOR (9 downto 0);
           wrData : in  STD_LOGIC_VECTOR (7 downto 0);
           rdData : out  STD_LOGIC_VECTOR (7 downto 0));
end singleBRAMpartA;

architecture Behavioral of singleBRAMpartA is
----------------------------------------------
type ram_type is array (9 downto 0)   --1023
        of std_logic_vector (7 downto 0);   
signal myRAM : ram_type :=("00000000","00000001","00000010","00000011","00000100",
"00000101","00000110","00000111","00001000","00001001");
----------------------------------------------
type state is (idle,active,final);
signal presentState,nextState : state := idle;
----------------------------------------------
type arr is array (1 downto 0)   
        of std_logic_vector (7 downto 0); 
signal temp: arr;
signal addr: STD_LOGIC_VECTOR (9 downto 0):= address;
signal wena: STD_LOGIC := wrEna;
----------------------------------------------
begin
	
	process(clk)
	variable a:integer :=0;
	variable c:integer :=0;
	variable count: integer :=0;
	begin
		if(clk' event and clk='1') then
			case presentState is
				when idle =>
					addr<="0000000000";
					presentState<=active;
				when active =>
					a := to_integer(unsigned(addr));
					c := count;
					if(wEna = '1')then
						myram(a)<=temp(c);
						rdData<=temp(c);--
						count:=count+1;
						
						if(count=2)then
							count:=0;
							wEna <= '0';
							addr<=std_logic_vector(to_unsigned(a+2,10));
						else
							addr<=std_logic_vector(to_unsigned(a-count,10));
						end if;
						
					else
						temp(c)<=myram(a);
						count:=count+1;
						
						if(count=2)then
							count:=0;
							wEna <= '1';
						else
							addr<=std_logic_vector(to_unsigned(a+1,10));
						end if;
						
					end if;
					
					if(a=10)then--1024
						count:=-1;
						presentState<=final;
					else
						presentState<=active;
					end if;
					
				when final =>
					count:= count+1;
					if(count=10)then--1024
						--presentState<=idle;
					else
						rdData<=myram(count);
						presentState<=final;
					end if;
				when others=>
					presentState<=idle;
			end case;
		end if;
	end process;

end Behavioral;

