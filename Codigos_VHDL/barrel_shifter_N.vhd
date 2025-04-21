library ieee;
use ieee.std_logic_1164.all;

entity barrel_shifter_N is
    port (
        A: in  std_logic_vector(7 downto 0);
        B: in  std_logic_vector(2 downto 0);
        dir: in std_logic;
        Y : out std_logic_vector(7 downto 0)
    );
end entity;

architecture rtl of barrel_shifter_N is

    -- Sinais intermediários exclusivos para cada estágio
    signal s1_1, s1_2, s1_3, s1_4: std_logic_vector(7 downto 0);
    signal s2_1, s2_2, s2_3: std_logic_vector(7 downto 0);
    signal s4_1, s4_2, s4_3, s4_4, s4_5: std_logic_vector(7 downto 0);

    -- Componentes
    component mux_1
    port (
        A: in std_logic_vector(7 downto 0);
        B: in std_logic_vector(7 downto 0);
        Sl: in std_logic;
        Y: out std_logic_vector(7 downto 0)
    );
    end component;

    component shifter_1bit
    port (
        A : in  std_logic_vector(7 downto 0);
        dir: in std_logic;
        Y : out std_logic_vector(7 downto 0)
    );
    end component;

begin

    -- Deslocamento de 1 bit
    shift_1: shifter_1bit
    port map (
        A   => A,
        dir => dir,
        Y   => s1_1
    );

    -- Mux para deslocamento de 1
    mux_1_bit: mux_1
    port map (
        A  => A,
        B  => s1_1,
        Sl => B(0),
        Y  => s2_1
    );

    -- Deslocamento de 2 bits (estágio 2)
    shift_2_0: shifter_1bit
    port map (
        A   => s2_1,
        dir => dir,
        Y   => s2_2  
    );

    shift_2_1: shifter_1bit
    port map (
        A   => s2_2,  
        dir => dir,
        Y   => s2_3
    );

    -- Mux para deslocamento de 2
    mux_2_bit: mux_1
    port map (
        A  => s2_1,
        B  => s2_3,
        Sl => B(1),
        Y  => s4_1
    );

    -- Deslocamento de 4 bits (estágio 4)
    shift_4_0: shifter_1bit
    port map (
        A   => s4_1,
        dir => dir,
        Y   => s4_2
    );

    shift_4_1: shifter_1bit
    port map (
        A   => s4_2,
        dir => dir,
        Y   => s4_3
    );

    shift_4_2: shifter_1bit
    port map (
        A   => s4_3,
        dir => dir,
        Y   => s4_4
    );

    shift_4_3: shifter_1bit
    port map (
        A   => s4_4,
        dir => dir,
        Y   => s4_5
    );
	

    -- Mux para deslocamento de 4
    mux_4_bit: mux_1
    port map (
        A  => s4_1,
        B  => s4_5,
        Sl => B(2),
        Y  => Y
    );



end architecture;

