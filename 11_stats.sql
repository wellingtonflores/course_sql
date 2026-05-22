SELECT round(avg(QtdePontos), 2) AS mediaCarteira,
min(QtdePontos) AS minCarteira,
max(QtdePontos) AS maxCarteira,
sum(flTwitch),
sum(flEmail)

FROM clientes