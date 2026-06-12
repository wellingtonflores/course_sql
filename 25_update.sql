SELECT * 
FROM relatorio_diaria;

UPDATE relatorio_diaria
SET qtdeTransacao = 10000
WHERE dtDia >= '2025-08-25'
;

SELECT * FROM relatorio_diaria;
