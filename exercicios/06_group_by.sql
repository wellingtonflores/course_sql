SELECT 
        strftime('%w', DtCriacao) AS DiaSemana,
        count(DISTINCT IdTransacao) AS qtdeTransacao

FROM transacoes

WHERE substring(DtCriacao,1,4) = '2025'

GROUP BY 1
ORDER BY 2 DESC

LIMIT 1