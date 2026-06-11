-- Quantidade de transações Acumuladas ao longo do tempo?


WITH tb_diario AS (
    SELECT substr(DtCriacao, 1,10) as dtDia,
            count(DISTINCT IdTransacao) AS qtdeTransacao

    FROM transacoes

    GROUP BY dtDia
    ORDER BY dtDia
),


tb_acum AS (
    SELECT *,
            sum(qtdeTransacao) OVER (ORDER BY dtDia) AS qtdeTransacaoAcum

    FROM tb_diario
)

-- SELECT * 
-- FROM tb_acum
-- WHERE qtdeTransacaoAcum >= 100000
-- ORDER BY qtdeTransacaoAcum
-- LIMIT 1

SELECT * FROM tb_acum