SELECT 
        sum(QtdePontos) AS qtdePontosAtual,
        sum(CASE
            WHEN QtdePontos > 0 THEN QtdePontos
        END) AS qtdePontosPositivos,

        count(CASE
            WHEN QtdePontos > 0 THEN QtdePontos
        END) AS qtdeTransacoesPositivos,

        sum(CASE
            WHEN QtdePontos < 0 THEN QtdePontos
        END) AS qtdePontosNegativos,

        count(CASE
            WHEN QtdePontos < 0 THEN QtdePontos
        END) AS qtdeTransacoesNegativos


FROM transacoes

WHERE DtCriacao >= '2025-07-01'
AND DtCriacao < '2025-08-01'
