WITH tb_transacoes AS (

    SELECT IdTransacao,
            IdCliente,
            QtdePontos,
            datetime(substr(DtCriacao, 1, 19)) AS DtCriacao,
            julianday('now') - julianday(substr(DtCriacao, 1, 10)) AS diffDate

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
            sum(QtdePontos) AS saldoPontos

    FROM tb_transacoes

    GROUP BY idCliente
)

SELECT t1.*,
        t2.idadeBase

FROM tb_sumario_transacoes AS t1

LEFT JOIN tb_cliente AS t2
ON t1.IdCliente = t2.IdCliente