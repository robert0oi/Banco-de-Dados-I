SHOW DATABASES;

USE loja;

SHOW TABLES;

SELECT * FROM cidade;

CREATE TABLE pessoa (
	idPessoa INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nomePessoa VARCHAR(100) NOT NULL,
    altura DOUBLE DEFAULT 1.76, 
    nascimento DATE DEFAULT '1989-12-19', /* ANO-MÊS-DIA - FORMATO AMERICANO */
    endereco TEXT,
    codCidade INT,
    FOREIGN KEY (codCidade) REFERENCES cidade(idCidade)
    );
    
ALTER TABLE pessoa
ADD COLUMN telefone VARCHAR(20) NOT NULL;

ALTER TABLE pessoa
CHANGE telefone
fone VARCHAR(20) NOT NULL; /* Se colocar algo errado, como esquecer de digitar o "NOT NULL", a coluna deixará de ter o parâmetro "NOT NULL". */ 

DESCRIBE pessoa;

ALTER TABLE pessoa 
DROP fone;

CREATE TABLE pedido(
	idPedido INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    horario DATETIME DEFAULT NOW(), /* Função "NOW()" pega o dia, mês, ano e horário do momento. */
    endereco TEXT,
    codCliente INT NOT NULL,
    FOREIGN KEY (codCliente) REFERENCES pessoa(idPessoa)
    );
    
DESCRIBE pedido;

CREATE TABLE categoria(
	idCategoria INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL
	);
    
DESCRIBE categoria;
    
CREATE TABLE produto(
	idProduto INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
     nome VARCHAR(100) NOT NULL,
     preco DOUBLE DEFAULT 10,
     quantidade DOUBLE DEFAULT 0
     );

DESCRIBE produto;

CREATE TABLE eletronico (
	codProduto INT NOT NULL PRIMARY KEY ,
    amperagem DOUBLE ,
    voltagem DOUBLE ,
    bivolt BOOLEAN ,
    FOREIGN KEY (codProduto) REFERENCES produto(idProduto)
);
CREATE TABLE perecivel (
	codProduto INT NOT NULL PRIMARY KEY ,
    temperaturaMinima DOUBLE ,
    temperaturaMaxima DOUBLE ,
    FOREIGN KEY (codProduto) REFERENCES produto(idProduto)
);

SHOW TABLES;

DROP TABLE categoria_produto;

CREATE TABLE categoria_produto(
	codCategoria INT NOT NULL,
    codProduto INT NOT NULL,
    PRIMARY KEY (codCategoria, codProduto),
    FOREIGN KEY (codCategoria) REFERENCES categoria(idCategoria),
    FOREIGN KEY (codProduto) REFERENCES produto(idProduto)
    );
    
    CREATE TABLE pedido_produto(
	codPedido INT NOT NULL,
    codProduto INT NOT NULL,
    precoVendido DOUBLE,
    quantidadeVendida DOUBLE DEFAULT 0,
    PRIMARY KEY (codPedido, codProduto),
    FOREIGN KEY (codPedido) REFERENCES pedido(idPedido),
    FOREIGN KEY (codProduto) REFERENCES produto(idProduto)
    );
    
DESCRIBE cidade;
    
INSERT INTO cidade(idCidade, nome) VALUES (1, "Porto Alegre");
INSERT INTO cidade(nome, idCidade) VALUES ("Canoas", 2);
INSERT INTO cidade VALUES (NULL , "Cachoeirinha");
INSERT INTO cidade(nome) VALUES ("Alvorada"); -- Aproveita o autoincremento, assim o id será "4" automaticamente.
INSERT INTO cidade VALUES (5, "Viamão");
INSERT INTO cidade VALUES (6, "Guaíba");
    
INSERT INTO cidade(nome) VALUES
("São Paulo"),
("Florianópolis");
    
SELECT * FROM cidade;

-- Duas maneiras de excluir dados múltiplos.
DELETE FROM cidade WHERE ( ( idCidade = 13 )  OR ( idCidade = 14 ) );
DELETE FROM pessoa WHERE idPessoa IN (1, 2, 3);
    
DESCRIBE pessoa;
    
SELECT * FROM pessoa;
    
INSERT INTO pessoa VALUES ( NULL, "João", 1.85, "1985-05-20", "Rua A, 100", 3);
INSERT INTO pessoa(nomePessoa, altura, codCidade) VALUES ( "Maria", 1.68, 1);
INSERT INTO pessoa(nomePessoa, altura, codCidade, nascimento, endereco) VALUES
( "José", 1.58, 1, "1994-02-05", "Rua C, 200"),
( "Julia", 1.50, 4, "2005-10-18", "Rua Abaeté, 199");
INSERT INTO pessoa(nomePessoa) VALUES ("Renata"),("Roberto");



INSERT INTO categoria ( nome ) VALUES 
( "Bebidas" ) ,
( "Alimentos" ) ,
( "Limpeza" ) ;

INSERT INTO produto (nome, preco, quantidade) VALUES
( "Coca-cola" , 9.89 , 100  ) ,
( "Pepsi" , 6.99 , 80  ) ,
( "Trakinas" , 3.95 , 50  ) ,
( "Arroz" , 3.99 , 100 ) ,
( "Doritos" , 11.99 , 60 ) ,
( "Fanta" , 7.99 , 180  );

INSERT INTO categoria_produto VALUES 
( 1 , 1 ) , 
( 1 , 2 ) ,
( 2 , 3 ) ,
( 2 , 4 ) ,
( 2 , 5 ) ,
( 1 , 6 );

INSERT INTO pedido ( horario , endereco , codCliente) VALUES
( "2024-10-17 18:10:30" , "Rua A, 100" , 2 );

INSERT INTO pedido ( endereco , codCliente) VALUES
( "Rua B, 200" , 1 );

INSERT INTO pedido (codCliente) VALUES ( 2 );



INSERT INTO pedido_produto VALUES 
( 1 , 1 ,  8.00 , 4 ) , 
( 1 , 5 , 11.99 , 2 ) ,
( 1 , 3 ,  3.95 , 1 ) ;

INSERT INTO pedido_produto (codPedido, codProduto, precoVendido) VALUES 
( 2 , 1 ,  9.89 ) , 
( 2 , 4 ,  3.99 ) ;

DESCRIBE pedido;

SELECT * FROM categoria_produto;

-- Consultas

USE loja;

SELECT nomePessoa, altura,
	DATE_FORMAT(nascimento, '%d/%m/%Y') AS 'Data de Nascimento'
FROM pessoa;


-- Funções de Agregação

SELECT MIN(altura), MAX(altura), AVG(altura),
	SUM(altura), COUNT(altura)
FROM pessoa;

SELECT nome
FROM pessoa
WHERE altura > (SELECT AVG(altura) FROM pessoa); -- Subconsulta

SELECT nomePessoa, altura
FROM pessoa
WHERE nomePessoa LIKE '%o%' AND altura > 1.6;

-- PRIMEIRO EXERCÍCIO
-- Monte uma consulta que retorna os produtos que contenham a letra A no nome e que o preço seja maior que 5, ordenando pelo nome do produto
SELECT nome, preco
FROM produto
WHERE nome LIKE '%a%' AND preco > 5
ORDER BY nome;
-- ORDER BY sempre vem após o WHERE.

-- SEGUNDO EXERCÍCIO
-- Monte uma consulta que retorna o nome e a data de nascimento, somente das pessoas que nasceram até o dia 15.

-- SELECT nomePessoa, nascimento,
--	DATE_FORMAT(nascimento, '%d/%m/%Y') AS 'Data de Nascimento'
-- FROM pessoa
-- WHERE nascimento LIKE '%d' <= 15; -- <--- Errado, tem que corrigir!!!!!!
-- Correção:
SELECT nomePessoa, nascimento,
	DATE_FORMAT(nascimento, '%d/%m/%Y') AS 'Data de Nascimento'
FROM pessoa
WHERE DATE_FORMAT(nascimento, '%d') <= 15; -- També é possível utilizar as funções "EXTRACT()" e "DAY()"


-- TERCEIRO EXERCÍCIO
-- Monte uma consulta que retorna o nome do produto o valor em Reais de estoque de cada produto.
SELECT nome, preco, quantidade,
    (preco * quantidade) AS 'Valor em Reais de Estoque'
    -- concat( "R$ ",(preco * quantidade) ) AS R$ | Assim vem o "R$" concatenado ao valor do estoque. Ex.: Arroz | 3.99 | 100 | R$ 399
FROM produto
WHERE quantidade > 0
ORDER BY nome; -- Assim virá o valor de cada produto, em ordem alfabética.


-- QUARTO EXERCÍCIO
-- Monte uma consulta que retorna qual valor em Reais do estoque inteiro.
SELECT SUM(preco * quantidade) AS 'Valor Total em Estoque'
FROM produto
WHERE quantidade > 0; -- Para não puxar produto sem estoque

-- 06/06/2025 -------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO cidade (nome) VALUES ("Capão da Canoa");

SELECT DISTINCT * FROM cidade ORDER BY nome;

SELECT nome, preco
FROM produto
ORDER BY preco DESC
LIMIT 3;

SELECT nome, preco
FROM produto;

SELECT pessoa.idPessoa, pessoa.nomePessoa, pessoa.codCidade,
	cidade.idCidade, cidade.nome
FROM pessoa
INNER JOIN cidade ON pessoa.codCidade = cidade.idCidade;

SELECT pessoa.idPessoa, pessoa.nomePessoa, pessoa.codCidade,
	cidade.idCidade, cidade.nome
FROM pessoa
LEFT JOIN cidade ON pessoa.codCidade = cidade.idCidade;

SELECT pessoa.idPessoa, pessoa.nomePessoa, pessoa.codCidade,
	cidade.idCidade, cidade.nome
FROM pessoa
RIGHT JOIN cidade ON pessoa.codCidade = cidade.idCidade;

INSERT INTO produto(nome, preco, quantidade) VALUES ("Pinho Sol", 6.95, 10); -- add produto sem categoria

-- Construa uma consulta que retorne todos os produtos, juntamente com o nome da sua categoria, idependentemente se o produto possui categoria.
SELECT produto.idProduto, produto.nome, categoria.idCategoria, categoria.nome
FROM produto
JOIN categoria_produto ON categoria_produto.codProduto = produto.idProduto
JOIN categoria ON categoria_produto.codCategoria = categoria.Idcategoria;
-- Errado, pois nesta consulta, é retornado somente os produtos que possuem alguma categoria cadastrada.

-- Correção:
SELECT p.idProduto, p.nome, p.preco, c.nome
FROM produto p
LEFT JOIN categoria_produto cp ON p.idProduto = cp.codProduto
LEFT JOIN categoria c ON c.idCategoria = cp.codCategoria;

-- Procura somente os produtos que não possuem nenhuma categoria registrada.
--  |  |  |
--  ˇ  ˇ  ˇ
SELECT *
FROM produto p
LEFT JOIN categoria_produto cp ON p.idProduto = cp.codProduto
LEFT JOIN categoria c ON c.idCategoria = cp.codCategoria
WHERE c.idCategoria IS NULL;

-- Monte uma consulta que retorna as pessoa, juntamente com o nome da sua cidade, mas só das pessoas que moram en cidades que tenham a letra A no nome ordenando pelo nome das pessoas.

SELECT p.idPessoa, p.nomePessoa, c.nome
FROM pessoa p
INNER JOIN cidade c ON p.codCidade = c.idCidade
WHERE c.nome LIKE '%a%';


-- 13/06/2025 -------------------------------------------------------------------------------------------------------------------------------------------------------------------

USE loja;

SELECT idCidade, nome, 
	(select COUNT(idPessoa)
	 FROM pessoa
     WHERE codCidade = idCidade
    ) AS moradores
FROM cidade;

SELECT nome, preco
FROM produto
WHERE preco > (
	SELECT AVG(preco)
    FROM produto
--    WHERE nome LIKE 'a%'
);

-- Monte uma consulta que retorna uma lista de categorias com o IdCategoria, com o nome da categoria e o total de produtos que pertencem a cada categoria. INDEPENDENTEMENTE e a categoria possui produtos.

SELECT c.idCategoria, c.nome, (
	SELECT COUNT(p.idProduto)
	FROM produto p
    INNER JOIN categoria_produto cp
    ON p.idProduto = cp.codProduto
    WHERE cp.codCategoria = c.idCategoria
) AS totalProdutos
FROM categoria c;

-- Monte uma consulta que retorna a lista de pedidos com data do pedido, nome do cliente INDEPENDENTEMENTE se o pedido tem cliente e o valor total do pedido.

SELECT p.idPedido, DATE_FORMAT( p.horario, '%d/%m/%Y %H:%i:%s') AS data,
	c.nome AS cliente , 
			( 
				SELECT SUM(pp.precoVendido * pp.quantidadeVendida)  
				FROM pedido_produto pp
				WHERE pp.codPedido = p.idPedido
			) AS valorPedido

FROM pedido p
LEFT JOIN pessoa c ON p.codCliente = c.idPessoa;



-- 27/06/2025 ------------------------------------------------
-- VIEW 

CREATE VIEW listarPessoas AS
SELECT p.idPessoa, p.nomePessoa, p.altura, p.nascimento, c.nome AS nomeCidade
FROM pessoa p
LEFT JOIN cidade c ON c.idCidade = p.codCidade;

-- COMO CHAMAR UMA VIEW:
SELECT * FROM listarPessoas;

SELECT nomePessoa, DATE_FORMAT(nascimento, '%d/%m/%Y') AS nasceu, nomeCidade
FROM listarPessoas
-- WHERE nomePessoa LIKE 'j%'
ORDER BY nomePessoa;

-- Construa uma consulta que utiliza a tabela pedido e a view listarPessoas para retornar os pedidos, informando o nome do cliente e a cidade do cliente.
-- Minha resposta:
SELECT p.idPedido, l.nomePessoa, l.nomeCidade
FROM listarPessoas l, pedido p 
WHERE idPessoa = codCliente
ORDER BY nomePessoa;

-- Gabarito Professor:
SELECT p.*, lp.nomePessoa, lp.nomeCidade
FROM pedido p
LEFT JOIN listarPessoas lp ON lp.idPessoa = p.codCliente;

SELECT * FROM produto;
SELECT * FROM categoria_produto;
SELECT * FROM categoria;

INSERT INTO produto(nome, preco, quantidade) VALUES ('Iogurte', 2.99, 50);
INSERT INTO categoria_produto VALUES
(1, 8),
(2, 8); 

CREATE VIEW listarPessoas AS
SELECT p.idPessoa, p.nomePessoa, p.altura, p.nascimento, c.nome AS nomeCidade
FROM pessoa p
LEFT JOIN cidade c ON c.idCidade = p.codCidade;

-- Construa uma VIEW que retorne todos os produtos informando id, nome, preco, quantidade e nome da categoria.
CREATE VIEW listarProdutos AS
SELECT p.*, c.nome AS nomeCategoria
FROM produto p
LEFT JOIN categoria_produto cp ON cp.codProduto = p.idProduto
LEFT JOIN categoria c ON c.idCategoria = cp.codCategoria;

-- Comando para editar uma célula de uma VIEW
CREATE OR REPLACE VIEW listarProdutos AS
SELECT p.*, c.idCategoria, c.nome AS nomeCat
FROM produto p
LEFT JOIN categoria_produto cp ON cp.codProduto = p.idProduto
LEFT JOIN categoria c ON c.idCategoria = cp.codCategoria;

-- Comando para excluir uma VIEW
DROP VIEW listarProduto;

SELECT p.idProduto, p.nome, 
	(SELECT GROUP_CONCAT(c.nome SEPARATOR ' | ')
    FROM categoria c
    INNER JOIN categoria_produto cp ON cp.codCategoria = c.idCategoria
    WHERE cp.codProduto = p.idProduto
    ) AS Categoria
FROM produto p;