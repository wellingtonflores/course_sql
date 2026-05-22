-- Qual cliente juntou mais pontos positivos em 2025-05?

SELECT IdCliente

FROM transacoes

WHERE DtCriacao >= '2025-05-1'
AND DtCriacao < '2025-06-01'
AND QtdePontos > 0

GROUP BY IdCliente

ORDER BY sum(QtdePontos) DESC

LIMIT 1