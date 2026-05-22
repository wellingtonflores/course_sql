-- Quantos clientes tem email cadastrado?

SELECT sum(flEmail)
FROM clientes;


SELECT count(*)
FROM clientes
WHERE flEmail = 1;