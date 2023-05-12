LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Model entidad
entity ascensor_completo is
    port(
        clk: in std_logic;
        codigo_piso: in std_logic_vector(2 downto 0);
        sube: out std_logic;
        baja: out std_logic;
        piso_donde_esta: out std_logic_vector(1 downto 0)
    );
end ascensor_completo;

-- Arqutiecture model in structural style 
ARCHITECTURE arquitectura_ascensor_completo OF ascensor_completo IS

SIGNAL codigo_piso_codificaBoton: std_logic_vector(1 downto 0);

begin
    codifica_boton: entity work.codifica_boton(arquitectura_cod_boton)
        port map(
            piso_donde_va => codigo_piso,
            codigo_piso => codigo_piso_codificaBoton
        );
    fsm_ascensor: entity work.FSM_ascensor(FSM_arquitectura)
        port map (
            clk => clk,
            codigo_piso => codigo_piso_codificaBoton,
            sube => sube,
            baja => baja,
            piso_donde_esta => piso_donde_esta
        );
end arquitectura_ascensor_completo;
