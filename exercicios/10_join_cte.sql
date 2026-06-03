-- 10. Como foi a curva de Churn do Curso de SQL?

-- SELECT 
--         substr(DtCriacao, 1, 10) AS dtDia,
--         count(DISTINCT idCliente) AS qtdeClientes

-- FROM transacoes

-- WHERE DtCriacao >= '2025-08-25'
-- AND DtCriacao < '2025-08-30'

-- GROUP BY 1

WITH tb_clientes_d1 AS (

    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE DtCriacao >= '2025-08-25'
    AND DtCriacao < '2025-08-26'
),


tb_join AS (
SELECT 
        substr(t2.DtCriacao,1,10) AS dtDia,
        count(DISTINCT t1.idCliente) AS qtdeCliente,
        1.* count(DISTINCT t1.IdCliente) / (select count(*) from tb_clientes_d1)  AS pctRetencao,
        1 - 1.* count(DISTINCT t1.IdCliente) / (select count(*) from tb_clientes_d1)  AS pctChurn

FROM tb_clientes_d1 AS t1

LEFT JOIN transacoes AS t2
ON t1.idCliente = t2.idCliente

WHERE t2.DtCriacao >= '2025-08-25'
AND t2.DtCriacao < '2025-08-30'

GROUP BY 1
)

SELECT * FROM tb_join