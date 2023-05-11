 -- Proyecto:             Ascensor de 3 pisos
-- Dise?o:               M?quina de estados finitos (FSM)
-- Nombre del fichero:   FSM_ascensor.vhd                                 
-- Autor: Germ�n Ruiz Cabello 	 
-- Fecha: 10/05/2023
-- Versi?n: 1.0
-- Resumen: Contiene una entidad y una arquitectura
-- en estilo de comportamiento de la FSM de un ascensor de 3 
-- pisos. Act?a por flanco de subida de reloj 
-- Se utilizan el tipo de datos STD_LOGIC para todas        
--las se?ales
--
-- Modificaciones:
--
-- Fecha	Autor	  Versi?n	 	Descripci?n del cambio
--============================================================

-- Declaraci?n de librerias

LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Modelo de entidad

ENTITY FSM_ascensor IS
	PORT
	(
		clk: IN	STD_LOGIC; 				-- activo por flanco de subida
		-- Codigos entrada
		codigo_piso: IN	STD_LOGIC_VECTOR(1 DOWNTO 0); -- codigo binario del N? de piso pulsado
		-- Salidas de la FSM 
		sube, baja: OUT	STD_LOGIC;				-- direcci?n movimiento del motor
		-- Estados (piso_donde_esta0, piso_donde_esta1, piso_donde_esta2)
		piso_donde_esta: OUT STD_LOGIC_VECTOR(1 DOWNTO 0)  -- c?digo binario del piso donde se encuentra
		-- Adem�s es el e_actual
	);
END FSM_ascensor ;

-- Modelo de arquitectura
architecture FSM_arquitectura of FSM_ascensor is 
TYPE estado IS (piso0, piso1, piso2);
SIGNAL e_actual: estado := piso0;
SIGNAL e_futuro: estado;
-- Comienzo de la arquitectura
begin
	--Proceso para generar el estado futuro y salida
	-- Modificar el process con la se�al de reloj
	combinacional:
	PROCESS (codigo_piso, e_actual)
	begin
		CASE e_actual is
			WHEN piso0 =>
				piso_donde_esta <= "00";
			IF codigo_piso = "01" THEN
				e_futuro <= piso1;
				sube <= '1';
				baja <= '0';
			ELSIF codigo_piso = "10" THEN
				e_futuro <= piso2;
				sube <= '1';
				baja <= '0';
			ELSE
				e_futuro <= piso0;
				sube <= '0';
				baja <= '0';
			END IF;
			WHEN piso1 =>
			piso_donde_esta <= "01";
			IF codigo_piso = "00" THEN
				e_futuro <= piso0;
				sube <= '0';
				baja <= '1';
			ELSIF codigo_piso = "10" THEN
				e_futuro <= piso2;
				sube <= '1';
				baja <= '0';
			ELSE
				e_futuro <= piso1;
				sube <= '0';
				baja <= '0';
			END IF;
			WHEN piso2 =>
			piso_donde_esta <= "10";
			IF codigo_piso = "00" THEN
				e_futuro <= piso0;
				sube <= '0';
				baja <= '1';
			ELSIF codigo_piso = "01" THEN
				e_futuro <= piso1;
				sube <= '0';
				baja <= '1';
			ELSE
				e_futuro <= piso2;
				sube <= '0';
				baja <= '0';
			END IF;
			WHEN OTHERS =>
			piso_donde_esta <= "00";
				e_futuro <= piso0;
				sube <= '0';
				baja <= '0';
			
		END CASE;
	END PROCESS combinacional;
	memoria:
	PROCESS(clk)
	BEGIN
		IF (rising_edge(clk))THEN
			e_actual <= e_futuro;
		ELSE
			e_actual <= e_actual;
		END IF;
	END PROCESS memoria;
END FSM_arquitectura;