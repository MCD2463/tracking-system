library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
entity tracker is
port( x: in std_logic;
y: in std_logic;
clk: in std_logic;
reset: in std_logic;
max_occupancy: in std_logic_vector(5 downto 0);
z: out std_logic);
end tracker;

architecture beh of tracker is
signal occupancy: std_logic_vector(5 downto 0):=(others=>'0');--initialisation
signal result_mul_x, result_mul_y: std_logic_vector(5 downto 0);

begin

-- Whether there is +1

result_mul_x<=occupancy when x='1'else 
		occupancy+1; --when light gets obstructed (x ='0')

--whether there is -1
result_mul_y<=result_mul_x when y='1'else
		result_mul_x-1 when result_mul_x>0; --when light gets obstructed (y ='0')

--register dq

process(clk,reset)
begin
	if(reset='1') then
		occupancy<=(others=>'0');
	elsif(rising_edge(clk)) then
		occupancy<=result_mul_y;
end if;
end process;


--comparator
z<= '1' when occupancy>max_occupancy or occupancy=max_occupancy else '0';
end architecture;


