-- Saldo de pontos acumulado de cada usuário

WITH tb_qtdePontos AS (

   SELECT IdCliente,
            substr(DtCriacao, 1,10) AS dtDia,
            sum(QtdePontos) AS totalPontos,
            sum(CASE WHEN QtdePontos > 0 THEN QtdePontos ELSE 0 END) AS pontosPositivos

    FROM transacoes

    GROUP BY IdCliente, dtDia
)

SELECT *,
        sum(totalPontos) OVER (PARTITION BY IdCliente ORDER BY dtDia) AS saldoPontos,
        sum(pontosPositivos) OVER (PARTITION BY IdCliente ORDER BY dtDia) AS totalPontosPos

FROM tb_qtdePontos
