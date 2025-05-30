CREATE DATABASE db_comercio;

USE db_comercio;

CREATE TABLE tb_Fornecedores
(
  Cod_Fornec    VARCHAR(04),
  Nome_Fornec   VARCHAR(30) NOT NULL,
  End_Fornec    VARCHAR(30),
  Bairro_Fornec VARCHAR(20),
  Contato_Fornec VARCHAR(30),
  Fone_Fornec   VARCHAR(30) NULL,
  PRIMARY KEY(Cod_Fornec)
);

CREATE TABLE tb_Produtos
(
  Cod_Prod      VARCHAR(05),
  Nome_Prod     VARCHAR(30),
  Tipo_Prod     CHAR CHECK(Tipo_Prod IN ('P', 'N')), 
  Qtde_Estoque  INT,
  Qtde_Minima   INT,
  Unidade       VARCHAR(05),
  Vl_Venda      DECIMAL(12,2),
  Vl_Compra     DECIMAL(12,2),
  Cod_Fornec    VARCHAR(04),
  PRIMARY KEY(Cod_Prod),
  CONSTRAINT FK_Fornec_Produtos FOREIGN KEY (Cod_Fornec) REFERENCES tb_Fornecedores(Cod_Fornec)
);

CREATE TABLE tb_Pereciveis
(
  Cod_Prod       VARCHAR(05),
  Data_Compra    DATETIME,
  Data_Vencimento DATETIME,
  PRIMARY KEY(Cod_Prod),
  CONSTRAINT FK_Pereciveis_Produtos FOREIGN KEY (Cod_Prod) REFERENCES tb_Produtos(Cod_Prod)
);

CREATE TABLE tb_Vendas
(
  Cod_Venda      VARCHAR(10) NOT NULL,      
  Data_Venda     DATETIME NOT NULL,        
  Cod_Prod       VARCHAR(05),              
  Qtde_Vendida   INT NOT NULL,              
  Vl_Venda       DECIMAL(12,2) NOT NULL,    
  Cod_Cliente    VARCHAR(10),               
  PRIMARY KEY (Cod_Venda), 
  CONSTRAINT FK_Produto_Venda FOREIGN KEY (Cod_Prod) REFERENCES tb_Produtos(Cod_Prod)
);

INSERT INTO tb_Fornecedores(Cod_Fornec, Nome_Fornec, End_Fornec, Bairro_Fornec, Contato_Fornec, Fone_Fornec) VALUES
('F001', 'Fornecedor 1', 'Rua 1', 'Cumbica', '82955649564', '156666345'),
('F002', 'Fornecedor A', 'Av. Central, 123', 'Centro', '1122334455', '11987654321'),
('F003', 'Fornecedor B', 'Rua das Flores, 45', 'Jardim São Paulo', '2133445566', '21999887766'),
('F004', 'Fornecedor C', 'Rua do Comércio, 789', 'Vila Nova', '3144556677', '31988776655'),
('F005', 'Fornecedor D', 'Travessa do Sol, 12', 'Bairro Verde', '4155667788', '41999887777'),
('F006', 'Fornecedor E', 'Rua Nova, 34', 'Vila Industrial', '5166778899', '51998877666');

INSERT INTO tb_Produtos(Cod_Prod, Nome_Prod, Tipo_Prod, Qtde_Estoque, Qtde_Minima, Unidade, Vl_Venda, Vl_Compra, Cod_Fornec) VALUES
('P01', 'Leite Desnatado', 'P', 100, 50, 'Un', 1.27, 0.60, 'F001'),
('P02', 'Arroz Integral', 'P', 150, 70, 'Kg', 3.49, 2.10, 'F002'),
('P03', 'Feijão Preto', 'P', 200, 80, 'Kg', 4.99, 3.50, 'F003'),
('P04', 'Macarrão Espaguete', 'P', 120, 60, 'Un', 2.99, 1.80, 'F004'),
('P05', 'Sabonete Líquido', 'N', 300, 150, 'Un', 5.99, 3.20, 'F005'),
('P06', 'Café Torrado', 'P', 80, 40, 'Pac', 7.99, 5.50, 'F006');

INSERT INTO tb_Pereciveis(Cod_Prod, Data_Compra, Data_Vencimento) VALUES
('P01', '2025-03-01 10:00:00', '2025-05-01 10:00:00'),
('P02', '2025-03-10 09:30:00', '2025-06-10 09:30:00'),
('P03', '2025-03-15 14:00:00', '2025-07-15 14:00:00'),
('P04', '2025-03-20 13:15:00', '2025-06-20 13:15:00'),
('P05', '2025-03-25 11:45:00', '2025-08-25 11:45:00');

INSERT INTO tb_Vendas(Cod_Venda, Data_Venda, Cod_Prod, Qtde_Vendida, Vl_Venda, Cod_Cliente) VALUES
('V001', '2025-04-01 15:00:00', 'P01', 10, 12.70, 'C001'),
('V002', '2025-04-02 16:30:00', 'P02', 20, 69.80, 'C002'),
('V003', '2025-04-03 11:00:00', 'P03', 15, 74.85, 'C003'),
('V004', '2025-04-04 09:30:00', 'P04', 8, 23.92, 'C004'),
('V005', '2025-04-05 10:15:00', 'P05', 5, 29.95, 'C005');

select * from tb_fornecedores;

select * from tb_pereciveis;

select * from tb_produtos;

select * from tb_vendas;

SELECT f.Nome_Fornec, p.Nome_Prod, p.Vl_Compra 
FROM tb_Produtos p
JOIN tb_Fornecedores f ON p.Cod_Fornec = f.Cod_Fornec;


SELECT p.Nome_Prod, p.Qtde_Estoque, p.Vl_Venda, f.Nome_Fornec 
FROM tb_Produtos p
JOIN tb_Fornecedores f ON p.Cod_Fornec = f.Cod_Fornec;

SELECT Nome_Prod, Qtde_Estoque, Qtde_Minima 
FROM tb_Produtos 
WHERE Qtde_Estoque < Qtde_Minima;

SELECT p.Nome_Prod, pe.Data_Vencimento 
FROM tb_Pereciveis pe
JOIN tb_Produtos p ON pe.Cod_Prod = p.Cod_Prod
WHERE pe.Data_Vencimento BETWEEN NOW() AND DATE_ADD(NOW(), INTERVAL 30 DAY);

SELECT v.Cod_Venda, p.Nome_Prod, v.Qtde_Vendida, v.Vl_Venda
FROM tb_Vendas v
JOIN tb_Produtos p ON v.Cod_Prod = p.Cod_Prod
WHERE v.Data_Venda = '2025-04-01';

SELECT p.Nome_Prod, SUM(v.Qtde_Vendida) AS Total_Vendido
FROM tb_Vendas v
JOIN tb_Produtos p ON v.Cod_Prod = p.Cod_Prod
GROUP BY p.Nome_Prod;

SELECT f.Nome_Fornec, SUM(p.Qtde_Estoque) AS Total_Estoque
FROM tb_Produtos p
JOIN tb_Fornecedores f ON p.Cod_Fornec = f.Cod_Fornec
GROUP BY f.Nome_Fornec;

SELECT v.Cod_Venda, v.Data_Venda, p.Nome_Prod, v.Qtde_Vendida, v.Vl_Venda
FROM tb_Vendas v
JOIN tb_Produtos p ON v.Cod_Prod = p.Cod_Prod
WHERE v.Cod_Cliente = 'C001';  -- Substitua C001 pelo código do cliente

SELECT p.Nome_Prod, SUM(v.Qtde_Vendida) AS Total_Vendido
FROM tb_Vendas v
JOIN tb_Produtos p ON v.Cod_Prod = p.Cod_Prod
WHERE v.Data_Venda >= '2025-04-01'
GROUP BY p.Nome_Prod;

SELECT p.Nome_Prod, COUNT(DISTINCT p.Cod_Fornec) AS Fornecedores_Distintos
FROM tb_Produtos p
GROUP BY p.Nome_Prod
HAVING COUNT(DISTINCT p.Cod_Fornec) > 1;

SELECT f.Nome_Fornec, COUNT(p.Cod_Prod) AS Total_Produtos
FROM tb_Fornecedores f
JOIN tb_Produtos p ON f.Cod_Fornec = p.Cod_Fornec
GROUP BY f.Nome_Fornec
HAVING COUNT(p.Cod_Prod) > 3;

SELECT p.Nome_Prod, SUM(v.Qtde_Vendida) AS Total_Vendido
FROM tb_Vendas v
JOIN tb_Produtos p ON v.Cod_Prod = p.Cod_Prod
WHERE v.Data_Venda BETWEEN '2025-04-01' AND '2025-04-04'
GROUP BY p.Nome_Prod;

SELECT p.Nome_Prod, f.Nome_Fornec, p.Vl_Venda
FROM tb_Produtos p
JOIN tb_Fornecedores f ON p.Cod_Fornec = f.Cod_Fornec
ORDER BY p.Vl_Venda DESC;

SELECT v.Cod_Cliente, SUM(v.Vl_Venda) AS Total_Vendas
FROM tb_Vendas v
GROUP BY v.Cod_Cliente;

SELECT f.Nome_Fornec, COUNT(p.Cod_Prod) AS Total_Produtos
FROM tb_Fornecedores f
LEFT JOIN tb_Produtos p ON f.Cod_Fornec = p.Cod_Fornec
GROUP BY f.Nome_Fornec;

SELECT Nome_Prod 
FROM tb_Produtos
WHERE Cod_Fornec IS NULL;

UPDATE tb_Fornecedores
SET Fone_Fornec = '11998877788'
WHERE Cod_Fornec = 'F001';

UPDATE tb_Produtos
SET Vl_Venda = 1.50
WHERE Cod_Prod = 'P01';

UPDATE tb_Produtos
SET Qtde_Minima = 60
WHERE Cod_Prod = 'P02';

UPDATE tb_Produtos
SET Nome_Prod = 'Arroz Integral Premium', Tipo_Prod = 'P'
WHERE Cod_Prod = 'P02';

UPDATE tb_Pereciveis
SET Data_Vencimento = '2025-06-01 10:00:00'
WHERE Cod_Prod = 'P03';

DELETE FROM tb_Fornecedores x
WHERE Cod_Fornec = 'F001';

DELETE FROM tb_Produtos
WHERE Cod_Prod = 'P06';

DELETE FROM tb_Produtos
WHERE Tipo_Prod = 'N';

DELETE FROM tb_Vendas
WHERE Cod_Venda = 'V005';

DELETE FROM tb_Pereciveis
WHERE Data_Vencimento < NOW();

CREATE VIEW vw_Produtos_Estoque_Baixo AS
SELECT Nome_Prod, Qtde_Estoque, Qtde_Minima
FROM tb_Produtos
WHERE Qtde_Estoque < Qtde_Minima;

CREATE VIEW vw_Vendas_Cliente AS
SELECT v.Cod_Venda, v.Data_Venda, p.Nome_Prod, v.Qtde_Vendida, v.Vl_Venda
FROM tb_Vendas v
JOIN tb_Produtos p ON v.Cod_Prod = p.Cod_Prod
WHERE v.Cod_Cliente = 'C001';

CREATE VIEW vw_Vendas_Produtos AS
SELECT p.Nome_Prod, SUM(v.Qtde_Vendida) AS Total_Vendido
FROM tb_Vendas v
JOIN tb_Produtos p ON v.Cod_Prod = p.Cod_Prod
GROUP BY p.Nome_Prod;

CREATE VIEW vw_Produtos_Fornecedores AS
SELECT p.Nome_Prod, p.Qtde_Estoque, f.Nome_Fornec
FROM tb_Produtos p
JOIN tb_Fornecedores f ON p.Cod_Fornec = f.Cod_Fornec;

CREATE VIEW vw_Fornecedores_Produtos AS
SELECT f.Nome_Fornec, COUNT(p.Cod_Prod) AS Total_Produtos
FROM tb_Fornecedores f
LEFT JOIN tb_Produtos p ON f.Cod_Fornec = p.Cod_Fornec
GROUP BY f.Nome_Fornec;

CREATE VIEW vw_Produtos_Com_Vendas AS
SELECT p.Nome_Prod, SUM(v.Qtde_Vendida) AS Total_Vendido
FROM tb_Vendas v
JOIN tb_Produtos p ON v.Cod_Prod = p.Cod_Prod
GROUP BY p.Nome_Prod
HAVING SUM(v.Qtde_Vendida) > 0;

CREATE VIEW vw_Produtos_Validade AS
SELECT p.Nome_Prod, pe.Data_Vencimento
FROM tb_Pereciveis pe
JOIN tb_Produtos p ON pe.Cod_Prod = p.Cod_Prod
WHERE pe.Data_Vencimento BETWEEN NOW() AND DATE_ADD(NOW(), INTERVAL 30 DAY);


CREATE VIEW vw_Total_Vendas_Cliente AS
SELECT v.Cod_Cliente, SUM(v.Vl_Venda) AS Total_Vendas
FROM tb_Vendas v
GROUP BY v.Cod_Cliente;

CREATE VIEW vw_Produtos_Com_Fornecedor AS
SELECT p.Nome_Prod, f.Nome_Fornec
FROM tb_Produtos p
JOIN tb_Fornecedores f ON p.Cod_Fornec = f.Cod_Fornec;

CREATE VIEW vw_Vendas_Periodo AS
SELECT v.Cod_Venda, v.Data_Venda, p.Nome_Prod, v.Qtde_Vendida, v.Vl_Venda
FROM tb_Vendas v
JOIN tb_Produtos p ON v.Cod_Prod = p.Cod_Prod
WHERE v.Data_Venda BETWEEN '2025-04-01' AND '2025-04-04';





