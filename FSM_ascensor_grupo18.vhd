  -- Proyecto:             Ascensor de 3 pisos
-- Dise?o:               M?quina de estados finitos (FSM)
-- Nombre del fichero:   FSM_ascensor.vhd                                 
-- Autor: Germ?n Ruiz Cabello y Jesús David De Amorim Arciniegas
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
USE ieee.STD_LOGIC_1164.all;

ENTITY FSM_ascensor IS
PORT (clk: IN STD_LOGIC; 
      codigo_piso: IN STD_LOGIC_VECTOR (1 DOWNTO 0); 
      sube, baja: OUT STD_LOGIC; 
      piso_donde_esta: OUT STD_LOGIC_VECTOR (1 DOWNTO 0)); 
END FSM_ascensor;

ARCHITECTURE FSM_arquitectura OF FSM_ascensor IS
	TYPE estado IS (piso_0, piso_1, piso_2);
	SIGNAL e_futuro:estado;
	SIGNAL e_actual:estado := piso_0;
BEGIN
combinacional:PROCESS(codigo_piso,e_actual)

BEGIN 
CASE e_actual IS

WHEN piso_0 => piso_donde_esta <= "00";
WHEN piso_1 => piso_donde_esta <= "01";
WHEN piso_2 => piso_donde_esta <= "10";
WHEN OTHERS => null;
END CASE;

CASE codigo_piso IS
    WHEN "00" => 
        -- Estás en el piso 0, puedes subir al piso 1 o al piso 2
        IF e_actual = piso_0 THEN
            e_futuro <= piso_1; -- sube al piso_1
            sube <= '1';
            baja <= '0';
        ELSIF e_actual = piso_1 THEN
            e_futuro <= piso_2; -- sube al piso_2
            sube <= '1';
            baja <= '0';
        END IF;

    WHEN "01" =>
        -- Estás en el piso 1, puedes subir al piso 2 o bajar al piso 0
        IF e_actual = piso_1 THEN
            e_futuro <= piso_2; -- sube al piso_2
            sube <= '1';
            baja <= '0';
        ELSIF e_actual = piso_2 THEN
            e_futuro <= piso_1; -- baja al piso_1
            sube <= '0';
            baja <= '1';
        END IF;

    WHEN "10" =>
        -- Estás en el piso 2, puedes bajar al piso 1 o al piso 0
        IF e_actual = piso_2 THEN
            e_futuro <= piso_1; -- baja al piso_1
            sube <= '0';
            baja <= '1';
        ELSIF e_actual = piso_1 THEN
            e_futuro <= piso_0; -- baja al piso_0
            sube <= '0';
            baja <= '1';
        END IF;

    WHEN OTHERS =>
        -- No se realiza ninguna acción, se mantiene en el estado actual
        e_futuro <= e_actual;
        sube <= '0';
        baja <= '0';
END CASE;
 
END PROCESS combinacional;

memoria: PROCESS (clk)
BEGIN 
IF rising_edge (clk) THEN
e_actual <= e_futuro;
ELSE 
e_actual <= e_actual;
END IF;
END PROCESS memoria;
END FSM_arquitectura;