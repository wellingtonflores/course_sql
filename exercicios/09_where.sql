-- Listar todas as transações adicionando uma coluna nova sinalizando “alto”, “médio” e “baixo” para o valor dos pontos [<10 ; <500; >=500]


SELECT *,
    CASE
        WHEN qtdePontos < 10 THEN 'baixo'
        WHEN qtdePontos < 500 THEN 'médio'
        ELSE 'alto'
    END AS flQtdePontos
FROM transacoes

ORDER BY qtdePontos DESC