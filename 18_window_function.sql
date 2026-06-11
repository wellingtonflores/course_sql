WITH tb_sumario_dias AS(

    SELECT substr(DtCriacao,1,10) AS dtDia, count(IdTransacao) AS qtdeTransacoes

    FROM transacoes

    WHERE DtCriacao >= '2025-08-25'
    AND DtCriacao < '2025-08-30'

    GROUP BY dtDia
)

SELECT *,
        sum(qtdeTransacoes) OVER (ORDER BY dtDia) AS qtdeTransacaoAcumulada

FROM tb_sumario_dias