library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sigGenPA is
    Port ( clk : in  STD_LOGIC;
           output : out  STD_LOGIC);
end sigGenPA;

architecture Behavioral of sigGenPA is
	type state is (one,two,three,four,five,six,seven,eight,nine,ten,eleven,twelve,thirteen,fourteen);
	signal presentState: state;
	signal out1, out2: std_logic;

begin
	process(clk)
	variable cnt:integer :=0;
	begin
		if(clk' event and clk='1') then
			cnt := cnt + 1;
			--count <= std_logic_vector(to_unsigned(cnt1,6));
			case presentState is
			when one =>
				out1 <='0';
				out2 <='1';
				presentState <= two;
			when two =>
				out1 <='0';
				out2 <='1';
				presentState <= three;
			when three =>
				out1 <='0';
				out2 <='1';
				if(cnt <= 30)then
					presentState <= three;
				else
					cnt := 0;
					presentState <= four;
				end if;
			when four =>
				out1 <='1';
				out2 <='1';
				presentState <= five;
			when five =>
				out1 <='1';
				out2 <='1';
				presentState <= six;
			when six =>
				out1 <='1';
				out2 <='1';
				presentState <= seven;
			when seven =>
				out1 <='1';
				out2 <='1';
				if(cnt <= 40)then
					presentState <= seven;
				else
					cnt :=0;
					presentState <= eight;
				end if;		
			when eight =>
				out1 <='0';
				out2 <='0';
				presentState <= nine;
			when nine =>
				out1 <='0';
				out2 <='0';
				presentState <= ten;
			when ten =>
				out1 <='0';
				out2 <='0';
				presentState <= eleven;
			when eleven =>
				out1 <='1';
				out2 <='0';
				presentState <= twelve;
			when twelve =>
				out1 <='1';
				out2 <='0';
				if(cnt <= 50)then
					presentState <= twelve;
				else
					cnt := 0;
					presentState <= thirteen;
				end if;	
			when thirteen =>
				out1 <='1';
				out2 <='1';
				presentState <= fourteen;
			when fourteen =>
				out1 <='1';
				out2 <='1';
				if(cnt <= 20)then
					presentState <= fourteen;
				else
					cnt :=0;
					presentState <= one;
				end if;			
			end case;
		end if;
	end process;

	output <= out1 and out2;

end Behavioral;
