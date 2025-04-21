library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity porta_swa is
	Port(
		a	: in std_logic_vector(7 downto 0);
		s	: out  std_logic_vector(7 downto 0)
);
end porta_swa;

architecture OPswa of porta_swa is
begin
	s(7) <= a(0);
	s(6) <= a(1);
	s(5) <= a(2);
	s(4) <= a(3);
	s(3) <= a(4);
	s(2) <= a(5);
	s(1) <= a(6);
	s(0) <= a(7);
end OPswa;
