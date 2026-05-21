-- Selecione produtos que contêm 'churn' no nome

SELECT * 

FROM produtos

-- WHERE DescNomeProduto IN ('Churn_10pp', 'Churn_2pp', 'Churn_5pp')

-- WHERE DescNomeProduto LIKE 'churn%'

WHERE DescCategoriaProduto = 'churn_model'