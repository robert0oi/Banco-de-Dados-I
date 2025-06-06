-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 06/06/2025 às 16:47
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `loja`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `categoria`
--

CREATE TABLE `categoria` (
  `idCategoria` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `categoria`
--

INSERT INTO `categoria` (`idCategoria`, `nome`) VALUES
(1, 'Bebidas'),
(2, 'Alimentos'),
(3, 'Limpeza');

-- --------------------------------------------------------

--
-- Estrutura para tabela `categoria_produto`
--

CREATE TABLE `categoria_produto` (
  `codCategoria` int(11) NOT NULL,
  `codProduto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `categoria_produto`
--

INSERT INTO `categoria_produto` (`codCategoria`, `codProduto`) VALUES
(1, 1),
(1, 2),
(1, 6),
(2, 3),
(2, 4),
(2, 5);

-- --------------------------------------------------------

--
-- Estrutura para tabela `cidade`
--

CREATE TABLE `cidade` (
  `idCidade` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `cidade`
--

INSERT INTO `cidade` (`idCidade`, `nome`) VALUES
(1, 'Porto Alegre'),
(2, 'Canoas'),
(3, 'Cachoeirinha'),
(4, 'Alvorada'),
(5, 'Viamão'),
(6, 'Guaíba'),
(7, 'São Paulo'),
(8, 'Florianópolis');

-- --------------------------------------------------------

--
-- Estrutura para tabela `eletronico`
--

CREATE TABLE `eletronico` (
  `codProduto` int(11) NOT NULL,
  `amperagem` double DEFAULT NULL,
  `voltagem` double DEFAULT NULL,
  `bivolt` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pedido`
--

CREATE TABLE `pedido` (
  `idPedido` int(11) NOT NULL,
  `horario` datetime DEFAULT current_timestamp(),
  `endereco` text DEFAULT NULL,
  `codCliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `pedido`
--

INSERT INTO `pedido` (`idPedido`, `horario`, `endereco`, `codCliente`) VALUES
(1, '2024-10-17 18:10:30', 'Rua A, 100', 2),
(2, '2025-05-23 11:57:03', 'Rua B, 200', 1),
(3, '2025-05-23 11:57:03', NULL, 2);

-- --------------------------------------------------------

--
-- Estrutura para tabela `pedido_produto`
--

CREATE TABLE `pedido_produto` (
  `codPedido` int(11) NOT NULL,
  `codProduto` int(11) NOT NULL,
  `precoVendido` double DEFAULT NULL,
  `quantidadeVendida` double DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `pedido_produto`
--

INSERT INTO `pedido_produto` (`codPedido`, `codProduto`, `precoVendido`, `quantidadeVendida`) VALUES
(1, 1, 8, 4),
(1, 3, 3.95, 1),
(1, 5, 11.99, 2),
(2, 1, 9.89, 0),
(2, 4, 3.99, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `perecivel`
--

CREATE TABLE `perecivel` (
  `codProduto` int(11) NOT NULL,
  `temperaturaMinima` double DEFAULT NULL,
  `temperaturaMaxima` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pessoa`
--

CREATE TABLE `pessoa` (
  `idPessoa` int(11) NOT NULL,
  `nomePessoa` varchar(100) NOT NULL,
  `altura` double DEFAULT 1.76,
  `nascimento` date DEFAULT '1989-12-19',
  `endereco` text DEFAULT NULL,
  `codCidade` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `pessoa`
--

INSERT INTO `pessoa` (`idPessoa`, `nomePessoa`, `altura`, `nascimento`, `endereco`, `codCidade`) VALUES
(1, 'João', 1.85, '1985-05-20', 'Rua A, 100', 3),
(2, 'Maria', 1.68, '1989-12-19', NULL, 1),
(3, 'José', 1.58, '1994-02-05', 'Rua C, 200', 1),
(4, 'Julia', 1.5, '2005-10-18', 'Rua Abaeté, 199', 4),
(5, 'Renata', 1.76, '1989-12-19', NULL, NULL),
(6, 'Roberto Carlos', 1.68, '1989-12-19', 'Av Ipiranga, 1000', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `produto`
--

CREATE TABLE `produto` (
  `idProduto` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `preco` double DEFAULT 10,
  `quantidade` double DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `produto`
--

INSERT INTO `produto` (`idProduto`, `nome`, `preco`, `quantidade`) VALUES
(1, 'Coca-cola', 9.89, 100),
(2, 'Pepsi', 6.99, 80),
(3, 'Trakinas', 3.95, 50),
(4, 'Arroz', 3.99, 100),
(5, 'Doritos', 11.99, 60),
(6, 'Fanta', 7.99, 180),
(7, 'Pinho Sol', 6.95, 10);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idCategoria`);

--
-- Índices de tabela `categoria_produto`
--
ALTER TABLE `categoria_produto`
  ADD PRIMARY KEY (`codCategoria`,`codProduto`),
  ADD KEY `codProduto` (`codProduto`);

--
-- Índices de tabela `cidade`
--
ALTER TABLE `cidade`
  ADD PRIMARY KEY (`idCidade`);

--
-- Índices de tabela `eletronico`
--
ALTER TABLE `eletronico`
  ADD PRIMARY KEY (`codProduto`);

--
-- Índices de tabela `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`idPedido`),
  ADD KEY `codCliente` (`codCliente`);

--
-- Índices de tabela `pedido_produto`
--
ALTER TABLE `pedido_produto`
  ADD PRIMARY KEY (`codPedido`,`codProduto`),
  ADD KEY `codProduto` (`codProduto`);

--
-- Índices de tabela `perecivel`
--
ALTER TABLE `perecivel`
  ADD PRIMARY KEY (`codProduto`);

--
-- Índices de tabela `pessoa`
--
ALTER TABLE `pessoa`
  ADD PRIMARY KEY (`idPessoa`),
  ADD KEY `codCidade` (`codCidade`);

--
-- Índices de tabela `produto`
--
ALTER TABLE `produto`
  ADD PRIMARY KEY (`idProduto`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idCategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `cidade`
--
ALTER TABLE `cidade`
  MODIFY `idCidade` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de tabela `pedido`
--
ALTER TABLE `pedido`
  MODIFY `idPedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `pessoa`
--
ALTER TABLE `pessoa`
  MODIFY `idPessoa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de tabela `produto`
--
ALTER TABLE `produto`
  MODIFY `idProduto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `categoria_produto`
--
ALTER TABLE `categoria_produto`
  ADD CONSTRAINT `categoria_produto_ibfk_1` FOREIGN KEY (`codCategoria`) REFERENCES `categoria` (`idCategoria`),
  ADD CONSTRAINT `categoria_produto_ibfk_2` FOREIGN KEY (`codProduto`) REFERENCES `produto` (`idProduto`);

--
-- Restrições para tabelas `eletronico`
--
ALTER TABLE `eletronico`
  ADD CONSTRAINT `eletronico_ibfk_1` FOREIGN KEY (`codProduto`) REFERENCES `produto` (`idProduto`);

--
-- Restrições para tabelas `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`codCliente`) REFERENCES `pessoa` (`idPessoa`);

--
-- Restrições para tabelas `pedido_produto`
--
ALTER TABLE `pedido_produto`
  ADD CONSTRAINT `pedido_produto_ibfk_1` FOREIGN KEY (`codPedido`) REFERENCES `pedido` (`idPedido`),
  ADD CONSTRAINT `pedido_produto_ibfk_2` FOREIGN KEY (`codProduto`) REFERENCES `produto` (`idProduto`);

--
-- Restrições para tabelas `perecivel`
--
ALTER TABLE `perecivel`
  ADD CONSTRAINT `perecivel_ibfk_1` FOREIGN KEY (`codProduto`) REFERENCES `produto` (`idProduto`);

--
-- Restrições para tabelas `pessoa`
--
ALTER TABLE `pessoa`
  ADD CONSTRAINT `pessoa_ibfk_1` FOREIGN KEY (`codCidade`) REFERENCES `cidade` (`idCidade`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
