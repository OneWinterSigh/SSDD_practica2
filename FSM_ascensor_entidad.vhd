-- Proyecto:             Ascensor de 3 pisos
-- Dise?o:               M?quina de estados finitos (FSM)
-- Nombre del fichero:   FSM_ascensor.vhd                                 
-- Autor: Germán Ruiz Cabello 	 
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
		piso_donde_esta: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);  -- c?digo binario del piso donde se encuentra
		-- Además es el e_actual
		e_futuro: in STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END FSM_ascensor ;

-- Modelo de arquitectura
architecture FSM_arquitectura of FSM_ascensor is 
-- Comienzo de la arquitectura
begin
	--Proceso para generar el estado futuro y salida
	-- Modificar el process con la señal de reloj
	combinacional:
	PROCESS (codigo_piso, e_futuro)
	begin
		CASE e_futuro is
			WHEN "00"=>
			IF codigo_piso = "01" THEN
				piso_donde_esta <= "01";
				sube <= '1';
				baja <= '0';
			ELSIF codigo_piso = "10" THEN
				piso_donde_esta <= "10";
				sube <= '1';
				baja <= '0';
			ELSE 
				piso_donde_esta <= "00";
				sube <= '0';
				baja <= '0';
			END IF;
			WHEN "01" =>
			IF codigo_piso = "00" THEN
				piso_donde_esta <= "01";
				sube <= '0';
				baja <= '1';
			ELSIF codigo_piso = "10" THEN
				piso_donde_esta <= "10";
				sube <= '1';
				baja <= '0';
			ELSE 
				piso_donde_esta <= "01";
				sube <= '0';
				baja <= '0';
			END IF;
			WHEN "10" =>
			IF codigo_piso = "00" THEN
				piso_donde_esta <= "10";
				sube <= '0';
				baja <= '1';
			ELSIF codigo_piso = "01" THEN
				piso_donde_esta <= "01";
				sube <= '0';
				baja <= '1';
			ELSE 
				piso_donde_esta <= "10";
				sube <= '0';
				baja <= '0';
			END IF;
			WHEN OTHERS =>
				piso_donde_esta <= "00";
				sube <= '0';
				baja <= '0';
		END CASE;
	END PROCESS combinacional;
	memoria:
	PROCESS(clk, e_futuro)
	BEGIN
		CASE clk IS
			WHEN "1" =>
				e_futuro <= piso_donde_esta;
			WHEN OTHERS =>
				e_futuro <= e_futuro;
		END CASE;
	END PROCESS memoria;
END FSM_arquitectura;