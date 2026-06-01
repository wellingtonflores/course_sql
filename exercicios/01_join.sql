-- Quais clientes mais perderam pontos por Lover?

SELECT 
        t3.IdCliente,
        sum(t1.vlProduto * t1.QtdeProduto) AS qtdePontosGastados
        


FROM transacao_produto AS t1

LEFT JOIN produtos AS t2
ON t1.IdProduto = t2.IdProduto

LEFT JOIN transacoes AS t3
ON t1.IdTransacao = t3.IdTransacao

WHERE t2.DescCategoriaProduto = 'lovers'

GROUP BY t3.IdCliente 
ORDER BY 2

LIMIT 5

