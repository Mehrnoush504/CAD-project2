library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity singleBRAMpartC is
    Port ( clk : in  STD_LOGIC;
           wrEna : in  STD_LOGIC;
           address : in  STD_LOGIC_VECTOR (9 downto 0);
           wrData : in  STD_LOGIC_VECTOR (7 downto 0);
           rdData : out  STD_LOGIC_VECTOR (7 downto 0));
end singleBRAMpartC;

architecture Behavioral of singleBRAMpartC is
----------------------------------------------
type ram_type is array (9 downto 0)   --1023
        of std_logic_vector (7 downto 0);   
signal myRAM : ram_type :=("00000000","00000001","00000010","00000011","00000100",
"00000101","00000110","00000001","00001001","00001001");
----------------------------------------------
type state is (idle,active,final);
signal presentState,nextState : state := idle;
----------------------------------------------
signal addr: STD_LOGIC_VECTOR (9 downto 0):= address;
signal sumSig:  STD_LOGIC_VECTOR (23 downto 0):=std_logic_vector(to_unsigned(0,24));
signal wena: STD_LOGIC := wrEna;
signal value: STD_LOGIC_VECTOR (7 downto 0);
----------------------------------------------
begin
	

	process(clk)
	variable a:integer :=0;
	variable i: integer :=-1;
	variable count: integer :=0;
	variable sum : integer :=0;
	begin
		if(clk' event and clk='1') then
			case presentState is
				when idle =>
					addr<="0000000000";
					value <= myram(0);
					rdData <= myram(0);
					presentState<=active;
				when active =>
					a := to_integer(unsigned(addr));
					
					if(wEna = '1')then
						presentState<= final;
						myram(a)<= std_logic_vector(to_unsigned(count,8));
						addr<=std_logic_vector(to_unsigned(9,10));
						--wEna <= '0';
						
					elsif(value = myram(a) and a<=9)then
							count:=count+1;
							presentState<= active;
							--a:=a+1;
							addr<=std_logic_vector(to_unsigned(a+1,10));
					else
							wEna <='1';
							addr<="0000001001";					
					end if;
					
					
				when final =>
					a := to_integer(unsigned(addr));
					rdData <= myram(a);
					presentState<=idle;

			end case;
		end if;
	end process;

end Behavioral;

