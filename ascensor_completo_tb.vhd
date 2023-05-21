LIBRARY ieee;
USE ieee.STD_LOGIC_1164.all;

ENTITY ascensor_completo_test IS
END ascensor_completo_test;

ARCHITECTURE behaviour OF ascensor_completo_test IS

COMPONENT ascensor_completo IS
	PORT
	(
		clk				: IN 	STD_LOGIC;
		piso_donde_va			: IN	STD_LOGIC_VECTOR(2 DOWNTO 0);
		sube, baja 			: OUT	STD_LOGIC;
		piso_donde_esta 		: OUT	STD_LOGIC_VECTOR(1 DOWNTO 0)
	);

END COMPONENT;
-- Declaración de señales

	CONSTANT periodo 			:TIME := 20 ns;
	SIGNAL reloj				:STD_LOGIC := '0';			-- Arranque de secuencias
	SIGNAL piso_donde_va 			: STD_LOGIC_VECTOR (2 DOWNTO 0); 	-- boton que se activa
	SIGNAL sube 				: STD_LOGIC;				-- ascensor sube
	SIGNAL baja				: STD_LOGIC; 				-- ascensor baja
	SIGNAL piso_donde_esta 			: STD_LOGIC_VECTOR (1 DOWNTO 0); 	-- piso


BEGIN 
ascen: ascensor_completo PORT MAP (clk		=> reloj,	
				piso_donde_va	=> piso_donde_va,
				sube 		=> sube,
				baja		=> baja,
				piso_donde_esta	=> piso_donde_esta);
reloj	<= NOT reloj AFTER periodo/2;

piso_donde_va <= "100",
			"001" AFTER periodo,
			"010" AFTER 2 * periodo,
			"100" AFTER 3 * periodo,
			"000" AFTER 4 * periodo,
			"111" AFTER 5 * periodo,
			"001" AFTER 6 * periodo,
			"100" AFTER 7 * periodo,
			"010" AFTER 8 * periodo,
			"010" AFTER 9 * periodo,
			"001" AFTER 10 * periodo;
END behaviour;