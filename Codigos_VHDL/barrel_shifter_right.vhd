library ieee;
use ieee.std_logic_1164.all;

entity barrel_shifter_right is
    port (
        A: in  std_logic_vector(7 downto 0);
	B: in  std_logic_vector(2 downto 0);
        Y : out std_logic_vector(7 downto 0)
    );
end barrel_shifter_right;


architecture rtl of barrel_shifter_right is


	component barrel_shifter_N 
	port (
        A: in  std_logic_vector(7 downto 0);
	B: in  std_logic_vector(2 downto 0);
	dir: in std_logic;
        Y : out std_logic_vector(7 downto 0)
    );
	end component;


begin

	---Deslocamento de 1 bit---
	

	--Direção dir=0 => deslocamento a esquerda--
	D0: barrel_shifter_N port map(
	A => A,
	B => B,
	dir => '1', 
	Y => Y
	);

	

end rtl;
