-- Qual o produto mais transacionado?

SELECT 
        IdProduto,
        -- count(*),
        sum(QtdeProduto) AS qtdeProdutoSum

FROM transacao_produto

GROUP BY 1
ORDER BY 2 DESC

LIMIT 1