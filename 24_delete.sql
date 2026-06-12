DELETE FROM relatorio_diaria
WHERE strftime('%w', dtDia) = '0';

SELECT * FROM relatorio_diaria;