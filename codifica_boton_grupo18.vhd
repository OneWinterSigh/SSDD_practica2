-- ========================================================================
--Este diseño es propietario el autor y puede ser utilizado con fines de estudio
--Proyecto: Primera practica de Sistemas Digitales
--Diseño: Codificador
--Nombre del fichero: codifica_boton_grupo18.vhd
--Autor: Germán Ruiz Cabello y Jesús David De Amorim Arciniegas
--Fecha: 21/02/2023--
--Versión:1.0.0
--Resumen: PONER POR EJEMPLO:
 --Contiene una entidad y una arquitectura de un codificador.
 --Se utilizan el tipo de datos STD_LOGIC_VECTOR para todas las señales.
 --La arquitectura se realiza en estilo comportamiento.
--Modificaciones: PONER COMENTARIOS (si es necesario) RELACIONADOS CON
 --Fecha Autor Versión Descripción del cambio
-- ======================================================================== 
--
LIBRARY IEEE;
USE ieee.STD_LOGIC_1164.all;

entity codifica_boton is 
	port (piso_donde_va: IN std_logic_vector(2 DOWNTO 0);
	      codigo_piso: OUT std_logic_vector(1 DOWNTO 0));
end codifica_boton;

architecture arquitectura_cod_boton of codifica_boton is 
 begin
  PROCESS (piso_donde_va)
   begin
	CASE piso_donde_va is
	 WHEN "001" => codigo_piso <= "00";
	 WHEN "010" => codigo_piso <= "01";
	 WHEN "100" => codigo_piso <= "10";
	 WHEN "000" => codigo_piso <= "11";
	 WHEN "011" => codigo_piso <= "11";
	 WHEN "111" => codigo_piso <= "11";
	 WHEN OTHERS => null;
	end CASE;
  end PROCESS;
end arquitectura_cod_boton;