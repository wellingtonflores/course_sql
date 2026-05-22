-- Intervalos
-- De 0 a 500 -> Ponei
-- de 501 a 1000 -> Ponei premium
-- de 1001 a 5000 -> Mago aprendiz
-- de 5001 a 10000 -> Mago Mestre
-- + 10001 -> Mago Supremo

SELECT  IdCliente, 
        qtdePontos,
        CASE
            WHEN qtdePontos <= 500 THEN 'Ponei'
            WHEN qtdePontos <= 1000 THEN 'Ponei Premium'
            WHEN qtdePontos <= 5000 THEN 'Mago Aprendiz'
            WHEN qtdePontos <= 10000 THEN 'Mago Mestre'
            ELSE 'Mago Supremo'
        END AS nomeGrupo,

        CASE
            WHEN qtdePontos <= 1000 THEN 1
            ELSE '0'
        END as flPonei,

        CASE
            WHEN qtdePontos > 1000 THEN 1
            ELSE '0'
        END as flMago
FROM clientes

WHERE flPonei = 1

ORDER BY qtdePontos DESC
