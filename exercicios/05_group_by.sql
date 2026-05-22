-- Qual o valor médio de pontos positivos por dia?

SELECT sum(QtdePontos) AS totalpontos,
        count(DISTINCT datetime(DtCriacao)) AS qtdeDiasUnicos

FROM transacoes

WHERE QtdePontos > 0

GROUP BY DtCriacao