DROP TABLE Operacoes,Visitas;
DROP TABLE Cliente,Agente,Imovel,Morada;
DROP DOMAIN GENERO,SIMNAO;
CREATE DOMAIN GENERO AS CHAR(1) NOT NULL CHECK (VALUE IN('M','F'));
CREATE DOMAIN SIMNAO AS CHAR(1) DEFAULT ('N') NOT NULL CHECK (VALUE IN('S','N'));

CREATE TABLE Morada (
idmorada SERIAL PRIMARY KEY,
rua VARCHAR NOT NULL,
porta VARCHAR(3),
andar VARCHAR(3),
fracao VARCHAR(3),
codpostal CHAR(8) NOT NULL,
freguesia VARCHAR NOT NULL,
concelho VARCHAR NOT NULL,
distrito  VARCHAR NOT NULL
);

CREATE TABLE Cliente (
idcliente SERIAL PRIMARY KEY, 
nome VARCHAR NOT NULL, 
morada SERIAL REFERENCES Morada(idmorada),
nacionalidade VARCHAR NOT NULL,
cc CHAR(11) UNIQUE NOT NULL,
nif CHAR (9) UNIQUE NOT NULL,
sexo GENERO,
contacto CHAR (9) UNIQUE NOT NULL, 
mail VARCHAR
);

CREATE TABLE Agente (
idagente SERIAL PRIMARY KEY, 
nome VARCHAR NOT NULL, 
morada SERIAL REFERENCES Morada(idmorada),
nacionalidade VARCHAR NOT NULL,
cc CHAR(11) UNIQUE NOT NULL,
nif CHAR (9) UNIQUE NOT NULL,
sexo GENERO,
contacto CHAR(9) NOT NULL, 
mail VARCHAR,
dataadmissao DATE NOT NULL,
salario REAL NOT NULL CHECK(salario>0)
);

CREATE TABLE Imovel (
idimovel SERIAL PRIMARY KEY,
morada SERIAL REFERENCES Morada(idmorada),
area INT NOT NULL CHECK(area>0),
valor REAL  NOT NULL CHECK(valor>0),
natureza VARCHAR NOT NULL CHECK (natureza IN ('apartamento','moradia','garagem','loja')),
estado VARCHAR NOT NULL CHECK (estado IN ('compra','venda','comprado','vendido')),
numquartos SMALLINT CHECK (numquartos>=0) CHECK (natureza IN ('apartamento','moradia')),
piscina SIMNAO, 
varanda SIMNAO,
dispensa SIMNAO,
garagem SIMNAO,
aquecimento SIMNAO
);

CREATE TABLE Operacoes (
idoper SERIAL PRIMARY KEY,
tipo VARCHAR NOT NULL CHECK(tipo IN ('compra','venda')),
cliente SERIAL,
agente SERIAL,
imovel SERIAL,
data DATE NOT NULL,
valor REAL NOT NULL CHECK(valor>0),
FOREIGN KEY(cliente) REFERENCES Cliente(idcliente),
FOREIGN KEY(agente) REFERENCES Agente(idagente),
FOREIGN KEY(imovel) REFERENCES Imovel(idimovel)
);

CREATE TABLE Visitas (
idvisita SERIAL PRIMARY KEY,
cliente SERIAL,
agente SERIAL,
imovel SERIAL,
data DATE NOT NULL,
FOREIGN KEY(cliente) REFERENCES Cliente(idcliente),
FOREIGN KEY(agente) REFERENCES Agente(idagente),
FOREIGN KEY(imovel) REFERENCES Imovel(idimovel)
);
