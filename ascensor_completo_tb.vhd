LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Testbench entidad
entity testbench_ascensor_completo is
end testbench_ascensor_completo;

ARCHITECTURE behavior OF testbench_ascensor_completo IS

    -- Componente a probar
    COMPONENT ascensor_completo
        port(
            clk: in std_logic;
            codigo_piso: in std_logic_vector(2 downto 0);
            sube: out std_logic;
            baja: out std_logic;
            piso_donde_esta: out std_logic_vector(1 downto 0)
        );
    END COMPONENT;

    -- Señales para el testbench
    SIGNAL clk : std_logic := '0';
    SIGNAL codigo_piso : std_logic_vector(2 downto 0) := "000";
    SIGNAL sube : std_logic;
    SIGNAL baja : std_logic;
    SIGNAL piso_donde_esta : std_logic_vector(1 downto 0);

BEGIN

    -- Instancia del componente a probar
    DUT: ascensor_completo
        PORT MAP (
            clk => clk,
            codigo_piso => codigo_piso,
            sube => sube,
            baja => baja,
            piso_donde_esta => piso_donde_esta
        );

    -- Proceso de generación de señales de prueba
    stim_proc: process
    begin
        -- Inicialización de señales
        codigo_piso <= "000";
        clk <= '0';

        -- Esperar un ciclo antes de cambiar los valores
        wait for 10 ns;

        -- Establecer nuevos valores
        codigo_piso <= "001";

        -- Esperar un ciclo antes de cambiar los valores
        wait for 10 ns;

        -- Establecer nuevos valores
        codigo_piso <= "010";

        -- Esperar un ciclo antes de cambiar los valores
        wait for 10 ns;

        -- Establecer nuevos valores
        codigo_piso <= "011";

        -- Esperar un ciclo antes de cambiar los valores
        wait for 10 ns;

        -- Finalizar la simulación
        wait;
    end process;

    -- Proceso de generación de clock
    clk_proc: process
    begin
        while now < 100 ns loop
            clk <= not clk;
            wait for 5 ns;
        end loop;
        wait;
    end process;

END behavior;