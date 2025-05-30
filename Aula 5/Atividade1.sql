-- criar database --
create database db_loja;
use db_loja;

-- criar tabelas --
create table tb_Cliente (
	cliente_id varchar(04) primary key,
    nome Varchar(30) not null,
    endereco varchar(30),
    data_cadastro date,
    data_nascimento date,
    telefone varchar(30) not null,
    cpf varchar(30) not null    
);

create table tb_Produto (
	produto_id varchar(04) primary key,
    produto_nome varchar(30),
    descricao varchar(100),
    preco Decimal(12,2),
    quantido_estoque int,
    ativo Char Check(ativo in('S','N'))
);

create table tb_Pedidos (
    pedido_id varchar(04) primary key,
    cliente_id varchar(04),
    data_pedido date,
    produto_nome varchar(30),  -- Corrigido, removido o ponto e vírgula errado
    status varchar(30),
    forma_pagamento varchar(30),
    endereco_entrega varchar(30),
    foreign key (cliente_id) references tb_Cliente(cliente_id)
);



-- inserir dados tabela cliente --
insert into tb_Cliente (cliente_id, nome, endereco, data_cadastro, data_nascimento, telefone, cpf) values
('0001', 'João Silva', 'Rua A, 123', '2023-01-15', '1990-05-25', '(11) 98765-4321', '123.456.789-00'),
('0002', 'Maria Oliveira', 'Rua B, 456', '2023-02-18', '1985-08-30', '(11) 91234-5678', '987.654.321-00'),
('0003', 'Carlos Santos', 'Rua C, 789', '2023-03-05', '1980-11-10', '(21) 99876-5432', '111.222.333-44'),
('0004', 'Ana Costa', 'Rua D, 101', '2023-04-20', '1995-07-15', '(21) 93210-1234', '222.333.444-55'),
('0005', 'Fernanda Almeida', 'Rua E, 102', '2023-05-10', '1992-01-25', '(31) 98765-5432', '333.444.555-66'),
('0006', 'Roberto Souza', 'Rua F, 103', '2023-06-01', '1993-04-20', '(31) 99887-6543', '444.555.666-77'),
('0007', 'Paula Lima', 'Rua G, 104', '2023-07-15', '1988-03-22', '(41) 91928-7364', '555.666.777-88'),
('0008', 'Ricardo Pereira', 'Rua H, 105', '2023-08-10', '1996-06-18', '(41) 91234-6789', '666.777.888-99'),
('0009', 'Juliana Rocha', 'Rua I, 106', '2023-09-12', '2000-12-03', '(51) 93567-8921', '777.888.999-00'),
('0010', 'Felipe Costa', 'Rua J, 107', '2023-10-25', '1983-09-14', '(51) 93456-7890', '888.999.000-11');

-- inserir dados tabela produto --
insert into tb_Produto (produto_id, produto_nome, descricao, preco, quantido_estoque, ativo) values
('0001', 'Camiseta', 'Camiseta de algodão', 49.90, 100, 'S'),
('0002', 'Tênis Esportivo', 'Tênis confortável para esportes', 199.90, 50, 'S'),
('0003', 'Calça Jeans', 'Calça jeans masculina', 89.90, 80, 'S'),
('0004', 'Blusa de Frio', 'Blusa de frio estilo moletom', 119.90, 60, 'S'),
('0005', 'Tênis Casual', 'Tênis casual para uso diário', 129.90, 70, 'S'),
('0006', 'Jaqueta', 'Jaqueta de couro', 249.90, 40, 'S'),
('0007', 'Bermuda', 'Bermuda para o verão', 39.90, 120, 'S'),
('0008', 'Sapatênis', 'Sapatênis para diversas ocasiões', 159.90, 55, 'S'),
('0009', 'Boné', 'Boné estilo esportivo', 29.90, 150, 'S'),
('0010', 'Mochila', 'Mochila para viagem e uso diário', 89.90, 90, 'S');

-- Inserir dados na tabela pedidos --
insert into tb_Pedidos (pedido_id, cliente_id, data_pedido, produto_nome, status, forma_pagamento, endereco_entrega) values
('0001', '0001', '2025-03-01', 'Camiseta', 'Pendente', 'Crédito', 'Rua A, 123'),
('0002', '0002', '2025-03-02', 'Tênis Esportivo', 'Entregue', 'Debito', 'Rua B, 456'),
('0003', '0003', '2025-03-03', 'Calça Jeans', 'Cancelado', 'Pix', 'Rua C, 789'),
('0004', '0001', '2025-03-04', 'Blusa de Frio', 'Pendente', 'Boleto', 'Rua D, 101'),
('0005', '0004', '2025-03-05', 'Tênis Casual', 'Entregue', 'Crédito', 'Rua E, 102'),
('0006', '0005', '2025-03-06', 'Jaqueta', 'Pendente', 'Debito', 'Rua F, 103'),
('0007', '0002', '2025-03-07', 'Bermuda', 'Cancelado', 'Pix', 'Rua G, 104'),
('0008', '0003', '2025-03-08', 'Sapatênis', 'Entregue', 'Boleto', 'Rua H, 105'),
('0009', '0006', '2025-03-09', 'Boné', 'Pendente', 'Crédito', 'Rua I, 106'),
('0010', '0007', '2025-03-10', 'Mochila', 'Entregue', 'Debito', 'Rua J, 107'),
('0011', '0008', '2025-03-11', 'Camiseta', 'Cancelado', 'Pix', 'Rua K, 108'),
('0012', '0004', '2025-03-12', 'Tênis Esportivo', 'Entregue', 'Boleto', 'Rua L, 109'),
('0013', '0005', '2025-03-13', 'Calça Jeans', 'Pendente', 'Crédito', 'Rua M, 110'),
('0014', '0009', '2025-03-14', 'Blusa de Frio', 'Entregue', 'Debito', 'Rua N, 111'),
('0015', '00010', '2025-03-15', 'Tênis Casual', 'Cancelado', 'Pix', 'Rua O, 112'),
('0016', '0001', '2025-03-16', 'Jaqueta', 'Entregue', 'Boleto', 'Rua P, 113'),
('0017', '0002', '2025-03-17', 'Bermuda', 'Pendente', 'Crédito', 'Rua Q, 114'),
('0018', '0003', '2025-03-18', 'Sapatênis', 'Entregue', 'Debito', 'Rua R, 115'),
('0019', '0006', '2025-03-19', 'Boné', 'Cancelado', 'Pix', 'Rua S, 116'),
('0020', '0007', '2025-03-20', 'Mochila', 'Pendente', 'Boleto', 'Rua T, 117');



-- Criar views --
create view v_1 
	as select 
		nome 
	from 
		tb_cliente;
select * from v_1;

create view v_2 
	as select 
		produto_nome 
	from 
		tb_produto;
select * from v_2;

create view v_3 
	as select 
		produto_nome 
	from 
		tb_pedidos;
select * from v_3;

create view v_4 
	as select 
		p.pedido_id,
		c.nome as cliente_nome,
		p.data_pedido,
		p.produto_nome,
		pr.produto_nome as nome_produto,
		p.status,
		p.forma_pagamento,
		p.endereco_entrega
	from 
		tb_Pedidos p 
	join 
		tb_Cliente c on p.cliente_id = c.cliente_id
	join 
		tb_Produto pr on p.produto_nome = pr.produto_nome;
select * from v_4;


create view v_5 
	as select 
		quantido_estoque, 
		ativo as tem_no_estoque
	from 
		tb_produto;
select * from v_5;

create view v_6 as
	select 
		c.cliente_id,
		c.nome as cliente_nome,
		count(p.pedido_id) as total_pedidos
	from 
		tb_Cliente c
	left join 
		tb_Pedidos p on c.cliente_id = p.cliente_id
	group by 
		c.cliente_id, c.nome;
select * from v_6;

create view v_7 
	as select 
		count(pedido_id) as total_pedidos
	from 
		tb_pedidos;
select * from v_7;



create view v_8 
	as select
		c.cliente_id,
		c.nome as cliente_nome,
		count(p.pedido_id) as total_pedidos
	from 
		tb_Cliente c
	join 
		tb_Pedidos p on c.cliente_id = p.cliente_id
	group by 
		c.cliente_id, c.nome;
select * from v_8;

create view v_9 
	as select
		c.cliente_id,
		c.nome as cliente_nome
	from 
		tb_Cliente c
	left join 
		tb_Pedidos p on c.cliente_id = p.cliente_id
	where 
		p.pedido_id IS NULL;
select * from v_9;

create view v_10 
	as select 
		p.pedido_id,
		c.nome as cliente_nome,
		p.data_pedido,
		pr.produto_nome as nome_produto,
		p.status,
		p.forma_pagamento,
		p.endereco_entrega
    from 
		tb_Pedidos p 
	join 
		tb_Cliente c on p.cliente_id = c.cliente_id
	join 
		tb_Produto pr on p.produto_nome = pr.produto_nome
	where month
		(data_pedido) = 03;
select * from v_10;

create view v_11 
	as select 
		produto_nome as nome_do_produto,
		quantido_estoque, 
		ativo as tem_no_estoque
	from 
		tb_produto 
	where 
		(quantido_estoque) < 30;
select * from v_11;

CREATE VIEW v_12 AS
	SELECT 
		c.cliente_id, 
		c.nome, 
		SUM(p.preco) AS total_gasto
	FROM 
		tb_Pedidos pd
	JOIN 
		tb_Cliente c ON pd.cliente_id = c.cliente_id
	JOIN 
		tb_Produto p ON pd.produto_nome = p.produto_nome
	GROUP BY 
		c.cliente_id, c.nome;
select * from v_12;

CREATE VIEW v_13 AS
	SELECT 
		COUNT(p.pedido_id) AS total_pedidos,
		COUNT(DISTINCT c.cliente_id) AS total_clientes,
		(COUNT(p.pedido_id) * 1.0 / NULLIF(COUNT(DISTINCT c.cliente_id), 0)) AS media_pedidos_por_cliente
	FROM 
		tb_Cliente c
	LEFT JOIN 
		tb_Pedidos p ON c.cliente_id = p.cliente_id;
select * from v_13;

CREATE VIEW v_14 
	AS SELECT 
		produto_nome,
		COUNT(pedido_id) AS total_vendas
	FROM 
		tb_Pedidos
	GROUP BY 
		produto_nome;
select * from v_14;

CREATE VIEW v_15 AS
	SELECT 
		c.cliente_id, 
		c.nome, 
		SUM(p.preco) AS total_gasto
	FROM 
		tb_Pedidos pd
	JOIN 
		tb_Cliente c ON pd.cliente_id = c.cliente_id
	JOIN 
		tb_Produto p ON pd.produto_nome = p.produto_nome
	GROUP BY 
		c.cliente_id, c.nome
	ORDER BY 
		total_gasto DESC;
select * from v_15;


