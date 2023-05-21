LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Model entidad
entity ascensor_completo is
    port(
        clk: in std_logic;
	piso_donde_va : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        sube: out std_logic;
        baja: out std_logic;
        piso_donde_esta: out std_logic_vector(1 downto 0)
    );
end ascensor_completo;

-- Arqutiecture model in structural style 
ARCHITECTURE arquitectura_ascensor_completo OF ascensor_completo IS

COMPONENT FSM_ascensor is
 	PORT (clk: IN STD_LOGIC; 
      		codigo_piso: IN STD_LOGIC_VECTOR (1 DOWNTO 0); 
      		sube, baja: OUT STD_LOGIC; 
     		piso_donde_esta: OUT STD_LOGIC_VECTOR (1 DOWNTO 0));
end COMPONENT;

COMPONENT codifica_boton is 
	PORT	
		(piso_donde_va : IN STD_LOGIC_VECTOR(2 DOWNTO 0); --selección de piso
		 codigo_piso    : OUT STD_LOGIC_VECTOR(1 DOWNTO 0) --código generado
		);
end COMPONENT;

SIGNAL entrada : STD_LOGIC_VECTOR (1 DOWNTO 0);

begin
     boton: codifica_boton 
	PORT MAP (
        piso_donde_va   => piso_donde_va,
        codigo_piso     => entrada
    );

    ascensor : FSM_ascensor
        port map (
            clk => clk,
            codigo_piso => entrada,
            sube => sube,
            baja => baja,
            piso_donde_esta => piso_donde_esta
        );
end ARCHITECTURE arquitectura_ascensor_completo;
