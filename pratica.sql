DROP DATABASE IF EXISTS pratica;

CREATE DATABASE pratica;

USE pratica;

DROP TABLE IF EXISTS estado1;

CREATE TABLE estado1(
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200) NOT NULL UNIQUE
,sigla CHAR(2) NOT NULL UNIQUE
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,CONSTRAINT pk_estado PRIMARY KEY (id)
,CONSTRAINT estado_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N'))
);

INSERT INTO estado1 (nome, sigla)
VALUES ('PARANÁ', 'PR');

INSERT INTO estado1 (nome, sigla)
VALUES ('SÃO PAULO', 'SP');

INSERT INTO estado1 (nome,sigla) 
VALUES ('MATO GROSSO','MT');

INSERT INTO estado1 (nome,sigla) 
VALUES ('SANTA CATARINA','SC');

INSERT INTO estado1 (nome,sigla) 
VALUES ('RIO GRANDE DO SUL','RS');

SELECT id, nome, sigla, ativo, data_cadastro FROM estado1;

DROP TABLE IF EXISTS cidade1;

CREATE TABLE cidade1 (
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200)  NOT NULL
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,estado1_id INT NOT NULL
,CONSTRAINT pl_cidade PRIMARY KEY (id)
,CONSTRAINT fk_cidade_estado FOREIGN KEY (estado1_id) REFERENCES estado1 (id)
,CONSTRAINT cidade_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N'))
,CONSTRAINT cidade_unica UNIQUE (nome, estado1_id)
);

INSERT INTO cidade1 (nome, estado1_id)
VALUES ('CURITIBA', 1);

INSERT INTO cidade1 (nome, estado1_id) 
VALUES ('BAURU',2);

INSERT INTO cidade1 (nome, estado1_id) 
VALUES ('MARINGÁ',1);

INSERT INTO cidade1 (nome, estado1_id) 
VALUES ('GUARULHOS',2);

INSERT INTO cidade1 (nome, estado1_id) 
VALUES ('CAMPINAS',2);

INSERT INTO cidade1 (nome, estado1_id) 
VALUES ('FLORIANÓPOLIS',4);

INSERT INTO cidade1 (nome, estado1_id) 
VALUES ('PARANAVAÍ',1);

INSERT INTO cidade1 (nome, estado1_id) 
VALUES ('CUIABA',3);

INSERT INTO cidade1 (nome, estado1_id) 
VALUES ('BALNEÁRIO CAMBORIÚ',4);

INSERT INTO cidade1 (nome, estado1_id) 
VALUES ('LONDRINA',1);

INSERT INTO cidade1 (nome, estado1_id) 
VALUES ('CASCAVEL',1);

INSERT INTO cidade1 (nome, estado1_id) 
VALUES ('JOINVILLE',4);

INSERT INTO cidade1 (nome, estado1_id) 
VALUES ('PORTO ALEGRE',5);

INSERT INTO cidade1 (nome, estado1_id) 
VALUES ('BLUMENAL',4);

INSERT INTO cidade1 (nome, estado1_id) 
VALUES ('BARRA DOS GARÇAS',3);

INSERT INTO cidade1 (nome, estado1_id) 
VALUES ('CHAPECÓ',4);

INSERT INTO cidade1 (nome, estado1_id) 
VALUES ('ITAJAÍ',4);

-- 1) Na inserção do estado, o usuário cometeu um erro, esquecendo de colocar acento. 
-- Neste contexto, escreva o comando para alterar o registro colocando acento. Sabe-se que o “id” do registro é “57”.
-- EXERCÍCIO PARA ALTERAR UMA COLUNA DE UM REGISTRO PELO ID
UPDATE estado1 SET nome = 'PARANÁ' WHERE id = 57;


-- 2) Faça o mesmo exercício anterior, porém, considerando que você não saiba do “id”.
-- EXERCÍCIO PARA ALTERAR O DADO DE UMA COLUNA DE UM REGISTRO PELO NOME
UPDATE estado1 SET nome = 'PARANÁ' WHERE estado1.nome = 'PARANA';

-- 4) Devido à falha de funcionamento do teclado, o registro com “id” 97 da tabela “cidade” ficou totalmente errado. Neste contexto, altere o registro com os seguintes dados: cidade → MARINGÁ, estado → PARANÁ, não é ATIVO e foi registrado em 15/11/2020.
-- EXERCÍCIO PARA ALTERAR VÁRIAS COLUNAS DE UM REGISTRO

-- verificando o id do paraná
SELECT id FROM estado1 WHERE nome = 'PARANÁ'; 

-- comando para alterar
UPDATE cidade1 SET
nome = 'MARINGÁ'
, estado1_id = 15
, ativo = 'N'
, data_cadastro = '2020-11-15'
WHERE id = 97;

SELECT * FROM cidade1 WHERE id = 97; -- conferindo se deu certo

-- 5) Escreva o comando para excluir o registro do estado com o nome “PARANÁ”. Sabe-se que o “id” do registro é “57”.
-- EXERCÍCIO PARA EXCLUIR UM REGISTRO PELO ID
DELETE FROM estado1 WHERE id = 57;

-- agora sim, eliminando o estado com id 23
DELETE FROM estado1 WHERE id = 23;

 
-- 7. Escreva o comando para inserir 2 registros da tabela estado, definindo somente os dados necessários. 
INSERT INTO estado1 (nome, sigla)
VALUES ('DISTRÍTO FEDERAL', 'DF'), ('ESPÍRITO SANTO', 'ES');

-- 6.	Escreva o comando para seleccionar todos os registros da tabela cidade com todas as colunas.
SELECT * FROM cidade1; 

-- 7.	Escreva o comando para seleccionar o nome de todos os registros da tabela cidade.
SELECT nome FROM cidade1;

-- 9.	Escreva o comando para alterar o valor de uma coluna de um único registro de uma tabela utilizando como filtro, o Primary Key.
UPDATE cidade1 SET nome = 'MARINGA' WHERE id = 3;

-- 10.	Refaça o exercício anterior alterando os dados de mais que uma coluna de um único registro sem utilizar como filtro a chave primária. A escolha da coluna do filtro é muito importante – TOME CUIDADO;
UPDATE cidade1 SET nome = 'MARINGÁ', ativo = 'N' WHERE nome = 'MARINGA';

-- 5. Escreva o comando para inserir 3 registros da tabela estado com todas as colunas. 
INSERT INTO estado1 
VALUES (DEFAULT, 'RIO DE JANEIRO', 'RJ', DEFAULT, DEFAULT), (DEFAULT, 'ALAGOAS', 'AL', DEFAULT, DEFAULT), (DEFAULT, 'AMAPÁ', 'AM', DEFAULT, DEFAULT);

-- 6. Escreva o comando para inserir 2 registros da tabela estado, definindo todos os dados, exceto a chave  primária que é auto incremento.
INSERT INTO estado1 (nome, sigla, ativo, data_cadastro)
VALUES ('BAHIA', 'BA', DEFAULT, DEFAULT), ('CEARÁ', 'CE', DEFAULT, DEFAULT); 

-- 01 - Liste o id e o nome de todas as cidades e as respectivas siglas do estado.
SELECT * 
FROM estado1, cidade1;

-- 02 - Em relação ao resultado do exercício anterior,note que os nomes das colunas não estão claras. Refaça o comando para que torne mais claras.
SELECT * 
FROM estado1, cidade1
WHERE cidade1.estado1_id = estado1.id;

-- 03 - Refaça o exercício anterior atribuindo o nome completo da tabela em todos os atributos.
SELECT 
	estado1.id
    ,estado1.nome
    ,estado1.sigla
    ,estado1.ativo
    ,estado1.data_cadastro
    ,cidade1.id
    ,cidade1.nome
    ,cidade1.ativo
    ,cidade1.data_cadastro
    ,cidade1.estado1_id
FROM estado1, cidade1
WHERE cidade1.estado1_id = estado1.id;

-- 04 - Refaça o exercício anterior definindo o apelido na tabela.
SELECT 
	estado1.id 'ID do Estado'
    ,estado1.nome 'Nome do Estado'
    ,estado1.sigla 'Sigla'
    ,estado1.ativo 'O Estado está ATIVO?'
    ,estado1.data_cadastro 'Data do cadastro'
    ,cidade1.id 'ID da cidade'
    ,cidade1.nome 'Nome da cidade'
    ,cidade1.ativo 'A cidade está ATIVA?'
    ,cidade1.data_cadastro 'Data do cadastro'
    ,cidade1.estado1_id 'ID referencia do Estado'
FROM estado1, cidade1
WHERE cidade1.estado1_id = estado1.id;

