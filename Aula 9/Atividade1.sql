									-- Pesquisa sobre SUBQUERY --
-- ---------------------------------------------------------------------------------------------------------------------------------------------

-- 1- Conceito de SUBQUERY
/*ma Subquery (também conhecida como SUBCONSULTA ou SUBSELECT) é uma instrução do tipo SELECT dentro de outra instrução SQL, 
que efetua consultas que, de outra forma, seriam extremamente complicadas ou impossíveis de serem feitas.*/
-- ---------------------------------------------------------------------------------------------------------------------------------------------
-- 2- Sintaxe da SUBQUERY
/*
SELECT
    *
FROM
    tabela(s)
WHERE
    coluna operador
    (
        SELECT
            coluna
        FROM
            tabela
        WHERE
            condições
    )
*/
-- ---------------------------------------------------------------------------------------------------------------------------------------------
-- 3 - Tipos de SUBQUERY  
/*
 //Subquery Escalar (Scalar Subquery)
Retorna um único valor (uma única linha e uma única coluna). Este valor pode ser usado em qualquer lugar da consulta externa onde um valor 
único é permitido (por exemplo, na cláusula WHERE, SELECT, HAVING).

 //Subquery de Múltiplas Linhas (Multi-row Subquery)
Retorna uma lista de valores (uma única coluna com múltiplas linhas). É frequentemente usada com operadores como IN, NOT IN, ANY, ALL ou SOME.

 //Subquery de Múltiplas Colunas (Multi-column Subquery)
Retorna múltiplas colunas em cada linha, mas ainda é limitada a um conjunto de linhas. É menos comum que as subqueries escalares ou de múltiplas 
linhas e é usada para comparar múltiplas colunas simultaneamente.

 //Subquery Correlacionada (Correlated Subquery)
Uma subquery correlacionada é aquela em que a consulta interna depende de informações da consulta externa. Ela é executada uma vez para cada linha
 processada pela consulta externa. Isso significa que a subquery não pode ser executada independentemente da consulta externa. Elas são úteis para 
 comparações linha a linha.

 //Subquery na Cláusula FROM (Derived Table / Inline View)
O resultado de uma subquery é tratado como uma tabela temporária (ou view embutida) na cláusula FROM da consulta externa. Isso permite que você realize 
operações adicionais sobre o subconjunto de dados gerado pela subquery.
*/
-- ---------------------------------------------------------------------------------------------------------------------------------------------
-- 4- EXEMPLOS  DE SUBQUERY (3 EXEMPLOS DE CADA TIPO)
-- Banco de Dados
create database subquery;

use subquery;

-- Tabelas e Inserts
CREATE TABLE Produtos (
    ID_Produto INT PRIMARY KEY,
    Nome_Produto VARCHAR(100) NOT NULL,
    Preco DECIMAL(10, 2) NOT NULL,
    ID_Categoria INT
);

INSERT INTO Produtos (ID_Produto, Nome_Produto, Preco, ID_Categoria) VALUES
(1, 'Notebook', 3500.00, 1),
(2, 'Mouse', 50.00, 2),
(3, 'Teclado', 150.00, 2),
(4, 'Monitor', 1200.00, 1),
(5, 'Impressora', 800.00, 3);

CREATE TABLE Clientes (
    ID_Cliente INT PRIMARY KEY,
    Nome_Cliente VARCHAR(100) NOT NULL,
    Cidade VARCHAR(100)
);

INSERT INTO Clientes (ID_Cliente, Nome_Cliente, Cidade) VALUES
(1, 'Ana', 'São Paulo'),
(2, 'Bruno', 'Rio'),
(3, 'Carla', 'São Paulo');

CREATE TABLE Pedidos (
    ID_Pedido INT PRIMARY KEY,
    ID_Cliente INT NOT NULL,
    ID_Produto INT NOT NULL,
    Quantidade INT NOT NULL,
    Data_Pedido DATE,
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente),
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID_Produto)
);

INSERT INTO Pedidos (ID_Pedido, ID_Cliente, ID_Produto, Quantidade, Data_Pedido) VALUES
(101, 1, 1, 1, '2024-01-15'),
(102, 2, 2, 2, '2024-01-16'),
(103, 1, 3, 1, '2024-01-16'),
(104, 3, 1, 1, '2024-01-17'),
(105, 2, 5, 1, '2024-01-18');

-- Subquery Escalar (Scalar Subquery)
			-- 1
	SELECT Nome_Produto, Preco
	FROM Produtos
	WHERE Preco > (SELECT AVG(Preco) FROM Produtos);
			-- 2
	SELECT Nome_Produto, Preco
	FROM Produtos
	WHERE Preco = (SELECT MAX(Preco) FROM Produtos WHERE ID_Categoria = 1);
			-- 3
	SELECT
		Nome_Cliente,
		(SELECT COUNT(ID_Pedido) FROM Pedidos WHERE ID_Cliente = Clientes.ID_Cliente) AS Total_Pedidos
	FROM Clientes;

-- Subquery de Múltiplas Linhas (Multi-row Subquery)
			-- 1
	SELECT ID_Cliente, Nome_Cliente
	FROM Clientes
	WHERE ID_Cliente IN (SELECT ID_Cliente FROM Pedidos);
			-- 2
	SELECT ID_Produto, Nome_Produto
	FROM Produtos
	WHERE ID_Produto NOT IN (SELECT ID_Produto FROM Pedidos);
			-- 3
	SELECT DISTINCT C.Nome_Cliente
	FROM Clientes C
	WHERE C.ID_Cliente IN (
		SELECT P.ID_Cliente
		FROM Pedidos P
		JOIN Produtos Pr ON P.ID_Produto = Pr.ID_Produto
		WHERE Pr.Preco > 1000
	);

-- Subquery de Múltiplas Colunas (Multi-column Subquery)
			-- 1
	SELECT ID_Cliente, Nome_Cliente
	FROM Clientes
	WHERE ID_Cliente IN (
		SELECT ID_Cliente
		FROM Pedidos
		WHERE ID_Produto = 1 AND Quantidade = 1
	);
			-- 2
	SELECT Nome_Produto, Preco, ID_Categoria
	FROM Produtos
	WHERE (ID_Categoria, Preco) IN (
		SELECT ID_Categoria, MAX(Preco)
		FROM Produtos
		GROUP BY ID_Categoria
	);
			-- 3
	SELECT ID_Pedido, ID_Cliente, ID_Produto, Quantidade
	FROM Pedidos
	WHERE (ID_Cliente, ID_Produto) IN (
		SELECT 1, 1  -- Combinação Cliente 1, Produto 1
		UNION ALL
		SELECT 2, 5  -- Combinação Cliente 2, Produto 5
	);

-- Subquery Correlacionada (Correlated Subquery)
			-- 1
	SELECT
		P.Nome_Produto,
		P.Preco,
		(SELECT SUM(Quantidade) FROM Pedidos WHERE ID_Produto = P.ID_Produto) AS Quantidade_Total_Pedida
	FROM Produtos P;
			-- 2
	SELECT C.Nome_Cliente
	FROM Clientes C
	WHERE EXISTS (
		SELECT 1
		FROM Pedidos P
		WHERE P.ID_Cliente = C.ID_Cliente
		GROUP BY P.ID_Cliente
		HAVING COUNT(P.ID_Pedido) > 1
	);
			-- 3
	SELECT C.Nome_Cliente, C.Cidade
	FROM Clientes C
	WHERE EXISTS (
		SELECT 1
		FROM Pedidos P
		WHERE P.ID_Cliente = C.ID_Cliente
	);

-- Subquery na Cláusula FROM (Derived Table / Inline View)
			-- 1
	SELECT
		Produtos.Nome_Produto,
		MediaPedidos.Media_Quantidade
	FROM Produtos
	JOIN (
		SELECT ID_Produto, AVG(Quantidade) AS Media_Quantidade
		FROM Pedidos
		GROUP BY ID_Produto
	) AS MediaPedidos ON Produtos.ID_Produto = MediaPedidos.ID_Produto;
			-- 2
	SELECT
		C.Nome_Cliente,
		PedidosCliente.Total_Pedidos
	FROM Clientes C
	JOIN (
		SELECT ID_Cliente, COUNT(ID_Pedido) AS Total_Pedidos
		FROM Pedidos
		GROUP BY ID_Cliente
		HAVING COUNT(ID_Pedido) > 1
	) AS PedidosCliente ON C.ID_Cliente = PedidosCliente.ID_Cliente;
			-- 3
	SELECT CategoriaComMaiorMedia.ID_Categoria, CategoriaComMaiorMedia.Media_Preco
	FROM (
		SELECT ID_Categoria, AVG(Preco) AS Media_Preco
		FROM Produtos
		GROUP BY ID_Categoria
	) AS CategoriaComMaiorMedia
	ORDER BY CategoriaComMaiorMedia.Media_Preco DESC
LIMIT 1;


