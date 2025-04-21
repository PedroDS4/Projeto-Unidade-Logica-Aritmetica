library ieee;
use ieee.std_logic_1164.all;

entity shifter_1bit is
    port (
        A : in  std_logic_vector(7 downto 0);
	dir: in std_logic;
        Y : out std_logic_vector(7 downto 0)
    );
end entity;


architecture rtl of shifter_1bit is

	component mux_1
	port(
		A: in std_logic_vector(7 downto 0);
		B: in std_logic_vector(7 downto 0);

		Sl: in std_logic;
		Y: out std_logic_vector(7 downto 0)
		);
	end component;
	
	signal A_right: std_logic_vector(7 downto 0);
    	signal A_left: std_logic_vector(7 downto 0);

begin

    	-- Deslocamento para a esquerda (dir == 0)
    	A_left <= A(6 downto 0) & '0';

    	-- Deslocamento para a direita (dir == 1)
    	A_right <= '0' & A(7 downto 1);

	M0: mux_1 port map(
	A => A_left,
	B => A_right,
	Sl => dir,
	Y => Y
	);

end architecture;