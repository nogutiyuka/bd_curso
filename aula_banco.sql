DROP DATABASE IF EXISTS aula_banco;

CREATE DATABASE aula_banco;

USE aula_banco;

DROP TABLE IF EXISTS estado;

CREATE TABLE estado(
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200) NOT NULL UNIQUE
,sigla CHAR(2) NOT NULL UNIQUE
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,CONSTRAINT pk_estado PRIMARY KEY (id)
,CONSTRAINT estado_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N'))
);

INSERT INTO estado (nome, sigla)
VALUES ('PARANÁ', 'PR');

INSERT INTO estado (nome, sigla)
VALUES ('SÃO PAULO', 'SP');

SELECT id, nome, sigla, ativo, data_cadastro FROM estado;

DROP TABLE IF EXISTS cidade;

CREATE TABLE cidade (
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200)  NOT NULL
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,estado_id INT NOT NULL
,CONSTRAINT pl_cidade PRIMARY KEY (id)
,CONSTRAINT fk_cidade_estado FOREIGN KEY (estado_id) REFERENCES estado (id)
,CONSTRAINT cidade_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N'))
,CONSTRAINT cidade_unica UNIQUE (nome, estado_id)
);

INSERT INTO cidade (nome, estado_id)
VALUES ('CURITIBA', 1);

SELECT * FROM cidade;




