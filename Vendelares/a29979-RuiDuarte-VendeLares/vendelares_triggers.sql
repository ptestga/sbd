--Tentei implementar inicialmente o trigger com esta função mas sem grande exito 
/*CREATE OR REPLACE FUNCTION f_compra (id integer,estado text)
RETURNS void AS $f_compra$
UPDATE imovel SET estado='comprado'
FROM operacoes
WHERE operacoes.tipo=$2 AND imovel.idimovel=$1
$f_compra$ LANGUAGE SQL;*/

DROP TRIGGER tg_estado ON operacoes;
DROP FUNCTION func_estado();

CREATE FUNCTION func_estado() RETURNS trigger AS $$
BEGIN
SELECT o.imovel,o.tipo,i.estado
FROM operacoes o left join imovel i ON o.imovel=i.idimovel;
IF NEW.tipo='compra' THEN 
	UPDATE estadoimovel SET estado='comprado';
END IF;
IF NEW.tipo='venda' THEN 
	UPDATE estadoimovel SET estado='vendido';
END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_estado BEFORE INSERT OR UPDATE ON operacoes
FOR EACH ROW EXECUTE PROCEDURE func_estado();