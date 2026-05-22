SELECT *,
    CASE
        WHEN qtdePontos < 10 THEN 'baixo'
        WHEN qtdePontos < 500 THEN 'médio'
        WHEN qtdePontos >= 500 THEN 'alto'
    END AS pontuação
FROM transacoes

ORDER BY qtdePontos DESC