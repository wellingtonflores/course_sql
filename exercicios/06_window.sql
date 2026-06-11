-- Quantidade de usuários cadastrados (absoluto e acumulado) ao longo do tempo?

WITH tb_qtdeCliente AS (

    SELECT substr(DtCriacao,1,10) AS dtDia,
            count(IdCliente) AS qtdeCliente


    FROM clientes


    GROUP BY dtDia
    ORDER BY dtDia

),

tb_acum AS (

    SELECT *,
            sum(qtdeCliente) OVER (ORDER BY dtDia) as qtdeClienteAcum

    FROM tb_qtdeCliente
)

SELECT * FROM tb_acum WHERE qtdeClienteAcum >= 3000 
ORDER BY dtDia

LIMIT 1