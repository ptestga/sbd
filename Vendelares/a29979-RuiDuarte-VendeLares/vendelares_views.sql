-- VISTAS IMPLEMENTADAS
--Informacoes detalhadas dos imoveis vendidos
CREATE OR REPLACE VIEW imovendidos AS
SELECT i.*, m.*
FROM imovel i LEFT JOIN morada m ON i.morada=m.idmorada
WHERE i.estado='vendido'
;
-- Lista de lucros, numero de vendas e numero de visitas dos agentes
CREATE OR REPLACE VIEW agentelucro AS
SELECT o.agente "Agente", count(v.idvisita) "Num Visitas", count(o.idoper) "Num Vendas", sum(o.valor) "Total Vendas", sum(o.valor-i.valor) AS "Lucro"
FROM operacoes o INNER JOIN imovel i ON o.imovel=i.idimovel INNER JOIN visitas v on i.idimovel=v.imovel
WHERE o.tipo='venda'
GROUP BY o.agente
ORDER BY "Lucro" DESC
;
--Compras e vendas por cliente
CREATE OR REPLACE VIEW clienteHist AS
SELECT c.Nome, o.tipo, o.imovel, o.valor, o.data
FROM cliente c INNER JOIN operacoes o ON c.idcliente=o.cliente
ORDER BY c.Nome,o.tipo
;


-- QUERIES IMPLEMENTADAS
--Resumo faturacao vendelares
SELECT tipo,sum(valor) AS "Valor", count(idoper) AS "Unidades"
FROM OPERACOES
GROUP BY tipo
;

--Numero de visitas por imovel
SELECT imovel,COUNT(idvisita) AS "Num Visitas"
FROM visitas
GROUP BY imovel

