-- 13. Qual o dia com maior engajamento de cada aluno que iniciou o curso no dia 01?


SELECT *, date(DtCriacao) 

FROM transacoes 


LIMIT 10