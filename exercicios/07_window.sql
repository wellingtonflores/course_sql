-- Qual o dia da semana mais ativo de cada usuário?

WITH tb_cliente_semana AS (
    SELECT IdCliente, 
    strftime('%w',substr(DtCriacao,1,10)) as dtDiaSemana,
    count(distinct IdTransacao) AS qtdeTransacao

    FROM transacoes AS dtDiaSemana

    GROUP BY IdCliente, dtDiaSemana
),


tb_rn AS (
SELECT *,
        CASE
            WHEN dtDiaSemana = '1' THEN 'SEGUNDA FEIRA'
            WHEN dtDiaSemana = '2' THEN 'TERÇA FEIRA'
            WHEN dtDiaSemana = '3' THEN 'QUARTA FEIRA'
            WHEN dtDiaSemana = '4' THEN 'QUINTA FEIRA'
            WHEN dtDiaSemana = '5' THEN 'SEXTA FEIRA'
            WHEN dtDiaSemana = '6' THEN 
            'SABADO'
            ELSE 'DOMINGO'
        END AS descDiaSemana,
        ROW_NUMBER() OVER (PARTITION BY IdCliente ORDER BY qtdeTransacao DESC) AS rn

FROM tb_cliente_semana
)

SELECT IdCliente, descDiaSemana FROM tb_rn WHERE rn = 1