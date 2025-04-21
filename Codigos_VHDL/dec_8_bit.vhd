
library ieee;
use ieee.std_logic_1164.all;


entity dec_8_bit is
	port(

	A : in std_logic_vector(7 downto 0);
	
	C_0 : out std_logic;
	S :   out std_logic_vector(7 downto 0) 
	);
end dec_8_bit;




architecture CKT of dec_8_bit is

	component subtrator_8_bit
		port(
			A, B: in std_logic_vector(7 downto 0);

			C_0: out std_logic;
			S: out std_logic_vector(7 downto 0)
			);
	end component;

	
	signal w : std_logic_vector(7 downto 0);
	
	

	
begin 	
	

	w <= (0 => '1', others => '0');
	U0: subtrator_8_bit port map(
	A => A,
	B => w,
	C_0 => C_0,
	S => S 
	);

end CKT;