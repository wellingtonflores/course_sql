-- Quantidade de transações Acumuladas ao longo do tempo?

DROP TABLE IF EXISTS relatorio_diaria;

CREATE TABLE IF NOT EXISTS relatorio_diaria AS

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

SELECT * FROM tb_acum;

select * from relatorio_diaria;