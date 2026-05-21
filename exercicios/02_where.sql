-- Lista de pedidos realizados no fim de semana;

SELECT  IdTransacao,
        DtCriacao,
        strftime('%w', datetime(substr(DtCriacao, 1, 19))) AS DiaSemana
        

FROM transacoes
WHERE DiaSemana IN ('6', '0')
