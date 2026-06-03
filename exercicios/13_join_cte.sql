-- 13. Qual o dia com maior engajamento de cada aluno que iniciou o curso no dia 01?


SELECT DISTINCT substr(DtCriacao, 1, 10) AS datasCurso

FROM transacoes

WHERE DtCriacao >= '2025-08-25'
AND DtCriacao < '2025-08-30'

ORDER BY 1
