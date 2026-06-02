-- 10. Como foi a curva de Churn do Curso de SQL?

SELECT 
        substr(DtCriacao, 1, 10) AS dtDia,
        count(DISTINCT idCliente) AS qtdeClientes

FROM transacoes

WHERE DtCriacao >= '2025-08-25'
AND DtCriacao < '2025-08-30'

GROUP BY 1