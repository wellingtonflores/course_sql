DELETE FROM relatorio_diaria;

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

INSERT INTO relatorio_diaria

SELECT * FROM tb_acum;

SELECT * FROM relatorio_diaria;