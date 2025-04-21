library ieee;
use ieee.std_logic_1164.all;

entity barrel_shifter is
    port (
        A: in  std_logic_vector(7 downto 0);
	B: in  std_logic_vector(2 downto 0);
        Y : out std_logic_vector(7 downto 0)
    );
end entity;


architecture rtl of barrel_shifter is

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
	dir => '0', 
	Y => Y
	);

	

end architecture;
