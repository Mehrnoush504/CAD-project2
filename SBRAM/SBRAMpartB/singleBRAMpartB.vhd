library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity singleBRAMpartB is
    Port ( clk : in  STD_LOGIC;
           wrEna : in  STD_LOGIC;
           address : in  STD_LOGIC_VECTOR (9 downto 0);
           wrData : in  STD_LOGIC_VECTOR (7 downto 0);
           rdData : out  STD_LOGIC_VECTOR (7 downto 0));
end singleBRAMpartB;

architecture Behavioral of singleBRAMpartB is
----------------------------------------------
type ram_type is array (9 downto 0)   --1023
        of std_logic_vector (7 downto 0);   
signal myRAM : ram_type :=("00000000","00000001","00000010","00000011","00000100",
"00000101","00000110","00000111","00001000","00001001");
----------------------------------------------
type state is (idle,active,final);
signal presentState : state := idle;
----------------------------------------------
signal addr: STD_LOGIC_VECTOR (9 downto 0):= address;
signal sumSig:  STD_LOGIC_VECTOR (23 downto 0):=std_logic_vector(to_unsigned(0,24));
signal wena: STD_LOGIC := wrEna;
----------------------------------------------
begin
	
	process(clk)
	variable a:integer :=0;
	variable i: integer :=-8;
	variable sum : integer :=0;
	begin
		if(clk' event and clk='1') then
			case presentState is
				when idle =>
					sum := 0;
					addr<="0000000000";
					presentState<=active;
				when active =>
					a := to_integer(unsigned(addr));
					
					if(wEna = '1')then
						i:= i+8;
						myram(a)<= sumSig(7+i downto i);
						addr<=std_logic_vector(to_unsigned(a+1,10));
						
						if(i=16)then
							wEna <= '0';
							i := -8;
							addr<=std_logic_vector(to_unsigned(0,10));
							presentState<= final;
						end if;
						
					else
						sum := sum + to_integer(unsigned(myram(a)));
						addr<=std_logic_vector(to_unsigned(a+1,10));
						if(a=9)then
							addr<="0000000000";
							wena<='1';
							presentState<=active;
							sumSig<= std_logic_vector(to_unsigned(sum,24));
						end if;
					end if;
					
				when final =>
					a := to_integer(unsigned(addr));
					if(a<2)then
						rdData<=myram(a);
						addr<=std_logic_vector(to_unsigned(a+1,10));
						presentState <= final;
					else
						presentState <= idle;
					end if;
					
				when others=>
					presentState<=idle;
			end case;
		end if;
	end process;

end Behavioral;

