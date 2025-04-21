library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Sua entidade original
entity BCD4 is
    port (
        BIN   : in  std_logic_vector(7 downto 0);
        BCD_C : out std_logic_vector(3 downto 0); -- Centenas
        BCD_D : out std_logic_vector(3 downto 0); -- Dezenas
        BCD_U : out std_logic_vector(3 downto 0)  -- Unidades
    );
end entity BCD4;

architecture Structural_Boolean of BCD4 is

    -- Declaração do componente auxiliar
    component add3_if_over4 is
        port (
            bcd_in  : in  std_logic_vector(3 downto 0);
            bcd_out : out std_logic_vector(3 downto 0)
        );
    end component add3_if_over4;

    -- Sinais internos para as etapas do algoritmo Double Dabble
    -- O registrador 's' contém [BCD Centenas | BCD Dezenas | BCD Unidades | Binário Restante]
    -- Total de bits = 4 (C) + 4 (D) + 4 (U) + 8 (BIN) = 20 bits
    signal s0, s1, s2, s3, s4, s5, s6, s7, s8 : std_logic_vector(19 downto 0);

    -- Sinais para armazenar os nibbles BCD corrigidos em cada etapa
    signal u1_c, u2_c, u3_c, u4_c, u5_c, u6_c, u7_c, u8_c : std_logic_vector(3 downto 0); -- Unidades Corrigidas
    signal d1_c, d2_c, d3_c, d4_c, d5_c, d6_c, d7_c, d8_c : std_logic_vector(3 downto 0); -- Dezenas Corrigidas
    signal c1_c, c2_c, c3_c, c4_c, c5_c, c6_c, c7_c, c8_c : std_logic_vector(3 downto 0); -- Centenas Corrigidas

    -- Sinal temporário para reconstrução antes do shift
    signal temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8 : std_logic_vector(19 downto 0);


begin

    -- Etapa 0: Inicialização
    -- Concatena 12 bits '0' (para os BCDs) com os 8 bits de entrada binária
    s0 <= "000000000000" & BIN; -- 12 zeros + 8 bits BIN = 20 bits

    -- --- Início das 8 Etapas do Double Dabble ---
    -- Para cada bit da entrada BIN (8 bits = 8 etapas)

    -- Etapa 1: Corrigir nibbles de s0, depois deslocar para s1
    U1_corr: add3_if_over4 port map (bcd_in => s0(11 downto 8),  bcd_out => u1_c); -- Unidades
    D1_corr: add3_if_over4 port map (bcd_in => s0(15 downto 12), bcd_out => d1_c); -- Dezenas
    C1_corr: add3_if_over4 port map (bcd_in => s0(19 downto 16), bcd_out => c1_c); -- Centenas
    -- Reconstrói o valor com BCDs corrigidos e parte binária original
    temp1 <= c1_c & d1_c & u1_c & s0(7 downto 0);
    -- Desloca 1 bit para a esquerda (multiplica por 2)
    s1 <= temp1(18 downto 0) & '0';

    -- Etapa 2: Corrigir nibbles de s1, depois deslocar para s2
    U2_corr: add3_if_over4 port map (bcd_in => s1(11 downto 8),  bcd_out => u2_c);
    D2_corr: add3_if_over4 port map (bcd_in => s1(15 downto 12), bcd_out => d2_c);
    C2_corr: add3_if_over4 port map (bcd_in => s1(19 downto 16), bcd_out => c2_c);
    temp2 <= c2_c & d2_c & u2_c & s1(7 downto 0);
    s2 <= temp2(18 downto 0) & '0';

    -- Etapa 3: Corrigir nibbles de s2, depois deslocar para s3
    U3_corr: add3_if_over4 port map (bcd_in => s2(11 downto 8),  bcd_out => u3_c);
    D3_corr: add3_if_over4 port map (bcd_in => s2(15 downto 12), bcd_out => d3_c);
    C3_corr: add3_if_over4 port map (bcd_in => s2(19 downto 16), bcd_out => c3_c);
    temp3 <= c3_c & d3_c & u3_c & s2(7 downto 0);
    s3 <= temp3(18 downto 0) & '0';

    -- Etapa 4: Corrigir nibbles de s3, depois deslocar para s4
    U4_corr: add3_if_over4 port map (bcd_in => s3(11 downto 8),  bcd_out => u4_c);
    D4_corr: add3_if_over4 port map (bcd_in => s3(15 downto 12), bcd_out => d4_c);
    C4_corr: add3_if_over4 port map (bcd_in => s3(19 downto 16), bcd_out => c4_c);
    temp4 <= c4_c & d4_c & u4_c & s3(7 downto 0);
    s4 <= temp4(18 downto 0) & '0';

    -- Etapa 5: Corrigir nibbles de s4, depois deslocar para s5
    U5_corr: add3_if_over4 port map (bcd_in => s4(11 downto 8),  bcd_out => u5_c);
    D5_corr: add3_if_over4 port map (bcd_in => s4(15 downto 12), bcd_out => d5_c);
    C5_corr: add3_if_over4 port map (bcd_in => s4(19 downto 16), bcd_out => c5_c);
    temp5 <= c5_c & d5_c & u5_c & s4(7 downto 0);
    s5 <= temp5(18 downto 0) & '0';

    -- Etapa 6: Corrigir nibbles de s5, depois deslocar para s6
    U6_corr: add3_if_over4 port map (bcd_in => s5(11 downto 8),  bcd_out => u6_c);
    D6_corr: add3_if_over4 port map (bcd_in => s5(15 downto 12), bcd_out => d6_c);
    C6_corr: add3_if_over4 port map (bcd_in => s5(19 downto 16), bcd_out => c6_c);
    temp6 <= c6_c & d6_c & u6_c & s5(7 downto 0);
    s6 <= temp6(18 downto 0) & '0';

    -- Etapa 7: Corrigir nibbles de s6, depois deslocar para s7
    U7_corr: add3_if_over4 port map (bcd_in => s6(11 downto 8),  bcd_out => u7_c);
    D7_corr: add3_if_over4 port map (bcd_in => s6(15 downto 12), bcd_out => d7_c);
    C7_corr: add3_if_over4 port map (bcd_in => s6(19 downto 16), bcd_out => c7_c);
    temp7 <= c7_c & d7_c & u7_c & s6(7 downto 0);
    s7 <= temp7(18 downto 0) & '0';

    -- Etapa 8: Corrigir nibbles de s7, depois deslocar para s8 (Última etapa)
    U8_corr: add3_if_over4 port map (bcd_in => s7(11 downto 8),  bcd_out => u8_c);
    D8_corr: add3_if_over4 port map (bcd_in => s7(15 downto 12), bcd_out => d8_c);
    C8_corr: add3_if_over4 port map (bcd_in => s7(19 downto 16), bcd_out => c8_c);
    temp8 <= c8_c & d8_c & u8_c & s7(7 downto 0);
    s8 <= temp8(18 downto 0) & '0';

    -- --- Fim das 8 Etapas ---

    -- Atribuição das Saídas BCD Finais
    -- Após 8 etapas, os bits [19 downto 8] de s8 contêm o resultado BCD
    BCD_U <= s8(11 downto 8);  -- Unidades BCD
    BCD_D <= s8(15 downto 12); -- Dezenas BCD
    BCD_C <= s8(19 downto 16); -- Centenas BCD

end architecture Structural_Boolean;
