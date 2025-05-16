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
