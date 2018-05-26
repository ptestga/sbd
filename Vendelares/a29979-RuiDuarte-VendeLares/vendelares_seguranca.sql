REVOKE ALL ON cliente,imovel,morada,operacoes,visitas,agente FROM gerente;
REVOKE INSERT,UPDATE,DELETE ON cliente,imovel,morada,operacoes,visitas FROM agente;
DROP ROLE agente,administrador,gerente;
CREATE ROLE administrador SUPERUSER; CREATE ROLE gerente; CREATE ROLE agente;
GRANT ALL ON cliente,imovel,morada,operacoes,visitas,agente TO gerente;
GRANT INSERT,UPDATE ON cliente,imovel,morada,visitas TO agente;