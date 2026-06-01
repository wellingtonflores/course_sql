-- Lista de tramsações com o produto "Resgatar Ponei";

SELECT *

FROM transacao_produto AS t1

WHERE t1.IdProduto IN (
    SELECT IdProduto
    FROM produtos
    WHERE DescNomeProduto = 'Resgatar Ponei'
)