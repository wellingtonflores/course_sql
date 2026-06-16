WITH tb_transacoes AS (

    SELECT IdTransacao,
            IdCliente,
            QtdePontos,
            datetime(substr(DtCriacao, 1, 19)) AS DtCriacao,
            julianday('now') - julianday(substr(DtCriacao, 1, 10)) AS diffDate,
            CAST(strftime('%H', DtCriacao) AS INTEGER) AS dtHora

    FROM transacoes
),

tb_cliente AS (
    SELECT IdCliente,
        datetime(substr(DtCriacao, 1, 19)) AS DtCriacao,
        julianday('now') - julianday(substr(DtCriacao, 1, 10)) AS idadeBase
    FROM clientes
),

tb_sumario_transacoes AS (

    SELECT IdCliente,
            count(IdTransacao) AS qtdeTransacaoVida,
            count(CASE WHEN diffDate <= 56 THEN IdTransacao END) AS qtdeTransacao56,
            count(CASE WHEN diffDate <= 28 THEN IdTransacao END) AS qtdeTransacao28,
            count(CASE WHEN diffDate <= 14 THEN IdTransacao END) AS qtdeTransacao14,
            count(CASE WHEN diffDate <= 7 THEN IdTransacao END) AS qtdeTransacao7,

            min(diffDate) AS diasUltimaInteracao,

            sum(QtdePontos) AS saldoPontos,

            sum(CASE WHEN QtdePontos > 0 THEN QtdePontos ELSE 0 END) AS qtdePontosPosVida,
            sum(CASE WHEN QtdePontos > 0 AND diffDate <= 56 THEN QtdePontos ELSE 0 END) AS qtdePontos56Pos,
            sum(CASE WHEN QtdePontos > 0 AND diffDate <= 28 THEN QtdePontos ELSE 0 END) AS qtdePontos28Pos,
            sum(CASE WHEN QtdePontos > 0 AND diffDate <= 14 THEN QtdePontos ELSE 0 END) AS qtdePontos14Pos,
            sum(CASE WHEN QtdePontos > 0 AND diffDate <=  7 THEN QtdePontos ELSE 0 END) AS qtdePontosPos7,

            sum(CASE WHEN QtdePontos  < 0 THEN QtdePontos ELSE 0 END) AS qtdePontosNegVida,
            sum(CASE WHEN QtdePontos  < 0 AND diffDate <= 56 THEN QtdePontos ELSE 0 END) AS qtdePontos56Neg,
            sum(CASE WHEN QtdePontos  < 0 AND diffDate <= 28 THEN QtdePontos ELSE 0 END) AS qtdePontos28Neg,
            sum(CASE WHEN QtdePontos  < 0 AND diffDate <= 14 THEN QtdePontos ELSE 0 END) AS qtdePontos14Neg,
            sum(CASE WHEN QtdePontos  < 0 AND diffDate <=  7 THEN QtdePontos ELSE 0 END) AS qtdePontosNeg7


    FROM tb_transacoes

    GROUP BY idCliente
),

tb_transacao_produto AS (

SELECT t1.*,
        t2.IdProduto,
        t3.DescNomeProduto,
        t3.DescCategoriaProduto

FROM tb_transacoes AS t1

LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto
),

tb_cliente_produto AS (
SELECT IdCliente, 
        DescNomeProduto,
        count(*) AS qtdeVida,
        count(CASE WHEN diffDate <= 56 THEN IdTransacao END) AS qtde56,
        count(CASE WHEN diffDate <= 28 THEN IdTransacao END) AS qtde28,
        count(CASE WHEN diffDate <= 14 THEN IdTransacao END) AS qtde14,
        count(CASE WHEN diffDate <=  7 THEN IdTransacao END) AS qtde7

FROM tb_transacao_produto
GROUP BY IdCliente, DescNomeProduto

ORDER BY IdCliente
),


tb_cliente_produto_rn AS (
SELECT *,
        row_number() OVER (PARTITION BY IdCliente ORDER BY qtdeVida DESC) AS rnVida,
        row_number() OVER (PARTITION BY IdCliente ORDER BY qtde56 DESC) AS rn56,
        row_number() OVER (PARTITION BY IdCliente ORDER BY qtde28 DESC) AS rn28,
        row_number() OVER (PARTITION BY IdCliente ORDER BY qtde14 DESC) AS rn14,
        row_number() OVER (PARTITION BY IdCliente ORDER BY qtde7 DESC) AS rn7

FROM tb_cliente_produto
),

tb_cliente_dia AS (

SELECT idCliente,
        strftime('%w', DtCriacao) AS dtDia,
        count(*) AS qtdeTransacao

FROM tb_transacoes

WHERE diffDate <= 28

GROUP BY IdCliente, dtDia
),

tb_cliente_dia_rn AS (
SELECT *,
        ROW_NUMBER() OVER (PARTITION BY IdCliente ORDER BY qtdeTransacao DESC) AS rnDia 
FROM tb_cliente_dia
),

tb_cliente_periodo AS (
SELECT IdTransacao, 
        IdCliente,
        DtCriacao,
        dtHora,
        CASE 
        WHEN dtHora BETWEEN 7 AND 12 THEN 'MANHÃ'
        WHEN dtHora BETWEEN 13 AND 18 THEN 'TARDE'
        WHEN dtHora BETWEEN 19 AND 23 THEN 'NOITE'
        ELSE 'MADRUGADA'
        END AS dtPeriodo,
        count(*) AS qtdeTransacao
        
FROM tb_transacoes

GROUP BY 1, 2
),

tb_cliente_periodo_rn AS (
SELECT *,
        ROW_NUMBER() OVER (PARTITION BY IdCliente ORDER BY qtdeTransacao DESC) AS rnPeriodo

FROM tb_cliente_periodo
),

tb_join AS (

SELECT t1.*,
        t2.idadeBase,
        t3.DescNomeProduto AS produtoVida,
        t4.DescNomeProduto AS produto56,
        t5.DescNomeProduto AS produto28,
        t6.DescNomeProduto AS produto14,
        t7.DescNomeProduto AS produto7,
        COALESCE(t8.dtDia, -1) AS dtDia,
        t9.dtPeriodo

FROM tb_sumario_transacoes AS t1

LEFT JOIN tb_cliente AS t2
ON t1.IdCliente = t2.IdCliente

LEFT JOIN tb_cliente_produto_rn AS t3
ON t1.IdCliente = t3.IdCliente
AND t3.rnVida = 1

LEFT JOIN tb_cliente_produto_rn AS t4
ON t1.IdCliente = t3.IdCliente
AND t3.rn56 = 1

LEFT JOIN tb_cliente_produto_rn AS t5
ON t1.IdCliente = t3.IdCliente
AND t3.rn28 = 1

LEFT JOIN tb_cliente_produto_rn AS t6
ON t1.IdCliente = t3.IdCliente
AND t3.rn14 = 1

LEFT JOIN tb_cliente_produto_rn AS t7
ON t1.IdCliente = t3.IdCliente
AND t3.rn7 = 1

LEFT JOIN tb_cliente_dia_rn AS t8
ON t1.IdCliente = t8.IdCliente
AND t8.rnDia = 1

LEFT JOIN tb_cliente_periodo_rn AS t9
ON t1.IdCliente = t9.IdCliente
AND t9.rnPeriodo = 1
)

SELECT IdCliente, dtDia, dtPeriodo
FROM tb_join

LIMIT 5
