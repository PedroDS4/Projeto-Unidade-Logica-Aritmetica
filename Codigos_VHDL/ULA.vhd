library ieee;
use ieee.std_logic_1164.all;


entity ula is
	port(

	A,B : in std_logic_vector(7 downto 0);
	key : in std_logic_vector(3 downto 0);
	
	c_0 :out std_logic;
	z :  out std_logic;
	
	HEX0:  out std_logic_vector(6 downto 0);
	HEX1: out std_logic_vector(13 downto 7);
	HEX2: out std_logic_vector(20 downto 14)
	);
end ula;




architecture CKT of ula is 
	
	
	component somador_8_bits
		port(
			A: in std_logic_vector(7 downto 0);
			B: in std_logic_vector(7 downto 0);

			C_0: out std_logic;
			S: out std_logic_vector(7 downto 0)
			);
	end component;
	
	component subtrator_8_bit
		port(
			A: in std_logic_vector(7 downto 0);
			B: in std_logic_vector(7 downto 0);

			C_0: out std_logic;
			S: out std_logic_vector(7 downto 0)
			);
	end component;
	
	component multiplicador_8_bits
		port(
			A: in std_logic_vector(7 downto 0);
			B: in std_logic_vector(7 downto 0);
  
			C_0: out std_logic;
			S: out std_logic_vector(7 downto 0)
			);
	end component;
	
	component inc_8_bit
	port(
			A: in std_logic_vector(7 downto 0);
			
			C_0: out std_logic;
			S: out std_logic_vector(7 downto 0)
			);
	end component;
	
	component dec_8_bit
	port(
			A: in std_logic_vector(7 downto 0);
			
			C_0: out std_logic;
			S: out std_logic_vector(7 downto 0)
			);
	end component;
	
	component barrel_shifter
	  port (
        A : in  std_logic_vector(7 downto 0);
        B : in  std_logic_vector(2 downto 0); -- número de deslocamentos (0 a 7)
        Y : out std_logic_vector(7 downto 0)
    );
  end component;
  
  component barrel_shifter_right
  port (
        A : in  std_logic_vector(7 downto 0);
        B : in  std_logic_vector(2 downto 0); -- número de deslocamentos (0 a 7)
        Y : out std_logic_vector(7 downto 0)
    );
	end component;

  component porta_swp 
  port(
		a	: in std_logic_vector(7 downto 0);
		s	: out  std_logic_vector(7 downto 0)
  );	
  end component;
	
	component porta_swa
	port(
		a	: in std_logic_vector(7 downto 0);
		s	: out  std_logic_vector(7 downto 0)
  );	
  end component;
  
	component porta_and
	port(
		a,b	: in std_logic_vector(7 downto 0);
		s	: out  std_logic_vector(7 downto 0)
  );	
  end component;
	
	component porta_or
	port(
		a,b	: in std_logic_vector(7 downto 0);
		s	: out  std_logic_vector(7 downto 0)
  );	
  end component;
  
  component porta_xor
	port(
		a,b	: in std_logic_vector(7 downto 0);
		s	: out  std_logic_vector(7 downto 0)
  );	
  end component;
  
  component porta_not
	port(
		a : in std_logic_vector(7 downto 0);
		s : out  std_logic_vector(7 downto 0)
  );	
  end component;
  
  
  component mux_16
  port(
		A: in std_logic_vector(7 downto 0);
		B: in std_logic_vector(7 downto 0);
		C: in std_logic_vector(7 downto 0);
		D: in std_logic_vector(7 downto 0);
		E: in std_logic_vector(7 downto 0);
		F: in std_logic_vector(7 downto 0);
		G: in std_logic_vector(7 downto 0);
		H: in std_logic_vector(7 downto 0);
	  	I: in std_logic_vector(7 downto 0);
		J: in std_logic_vector(7 downto 0);
		K: in std_logic_vector(7 downto 0);
		L: in std_logic_vector(7 downto 0);
		M: in std_logic_vector(7 downto 0);
		N: in std_logic_vector(7 downto 0);
		O: in std_logic_vector(7 downto 0);
		P: in std_logic_vector(7 downto 0);

		S: in std_logic_vector(3 downto 0);

		Y_16: out std_logic_vector(7 downto 0)
	);
	end component;
	
	component BCD4
	  port (
        BIN    : in  std_logic_vector(7 downto 0);
        BCD_C  : out std_logic_vector(3 downto 0); -- Centenas
        BCD_D  : out std_logic_vector(3 downto 0); -- Dezenas
        BCD_U  : out std_logic_vector(3 downto 0)  -- Unidades
    );

  end component;
  
  component display7
    port (
        A, B, C, D : in std_logic;
        l: out std_logic_vector(6 downto 0)
    );
    
  end component;
  
  signal R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14,R15,R16: std_logic_vector(7 downto 0);
  
  signal S_mux: std_logic_vector(7 downto 0);
  
  signal BCD: std_logic_vector(11 downto 0);
  
  
  
  
begin 
	
   Canal1: somador_8_bits port map(
  	A => A,
  	B => B,
  	C_0 => c_0,      -- carry-out vai pro próximo estágio
  	S => R1
);

  Canal2: subtrator_8_bit port map(
  	A => A,
  	B => B,
  	C_0 => c_0,      -- carry-out vai pro próximo estágio
  	S => R2
);
  
  Canal3: multiplicador_8_bits port map(
  	A => A,
  	B => B,
  	C_0 => c_0,      -- carry-out vai pro próximo estágio
  	S => R3
);
  
  Canal4: inc_8_bit port map(
  	A => A,
  	C_0 => c_0,      -- carry-out vai pro próximo estágio
  	S => R4
);

  Canal5: dec_8_bit port map(
  	A => A,
  	C_0 => c_0,      -- carry-out vai pro próximo estágio
  	S => R5
);

  Canal8:barrel_shifter port map(
  	A => A,
  	B => B(2 downto 0),
  	Y => R8
);

  Canal9: barrel_shifter_right port map(
  	A => A,
  	B => B(2 downto 0),
  	Y => R9
);

  Canal10: porta_swp port map(
  	A => A,
  	S => R10
);
  
  Canal11: porta_swa port map(
  	A => A,
  	S => R11
);

  Canal12: porta_and port map(
  	A => A,
  	B => B,
  	S => R12
);

  Canal13: porta_or port map(
 	A => A,
  	B => B,
  	S => R13
	);

  	Canal14: porta_xor port map(
  	A => A,
  	B => B,
  	S => R14
	);

  	Canal15: porta_not port map(
  	A => A,
  	S => R15
	);

 	 R6 <= "00000000";
 	 R7 <= "00000000";
	 R16 <= "00000000";

		
  
  	mux16: mux_16 port map(
    		A => R1,
		B => R2,
		C => R3,
		D => R4,
		E => R5,
		F => R6,
		G => R7,
		H => R8,
		I => R9,
		J => R10,
		K => R11,
		L => R12,
		M => R13,
		N => R14,
		O => R15,
		P => R16,
		S => key(3 downto 0),
		Y_16 => S_mux
		
		);
	
	
	 
	 BCD_1: BCD4 port map(
	   BIN => S_mux,
	   BCD_C => BCD(11 downto 8),
	   BCD_D => BCD(7 downto 4),
  	   BCD_U => BCD(3 downto 0)
	   );
	   
	 --- A: bit mais significativo ---
	 LED1: display7 port map(
	   A => BCD(3),
	   B => BCD(2),
	   C => BCD(1),
	   D => BCD(0),
	   l => HEX0
	   );
	   
	   
	   LED2: display7 port map(
	   A => BCD(7),
	   B => BCD(6),
	   C => BCD(5),
	   D => BCD(4),
	   l => HEX1
	   );
	   
	   LED3: display7 port map(
	   A => BCD(11),
	   B => BCD(10),
	   C => BCD(9),
	   D => BCD(8),
	   l => HEX2
	   );
	   
	   
	
	
	 

end CKT;