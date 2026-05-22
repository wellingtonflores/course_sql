-- Qual cliente fez mais transações no ano de 2024?

SELECT idCliente,
        count(DISTINCT IdTransacao)

FROM transacoes

WHERE strftime('%Y' ,substr(DtCriacao, 1, 19)) = '2024'

GROUP BY idCliente

ORDER BY count(DISTINCT IdTransacao) DESC

LIMIT 1
