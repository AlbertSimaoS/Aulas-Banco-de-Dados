create database db_InnerJoin;

use db_InnerJoin;

Create table tb_Fornecedores
(
  Cod_Fornec    varchar(04),
  Nome_Fornec   Varchar(30) not null,
  End_Fornec    Varchar(30),
  Bairro_Fornec Varchar(20),
  Contato_Fornec Varchar(30),
  Fone_Fornec    Varchar(30)  null,
   primary key(Cod_Fornec)
);

Insert into tb_Fornecedores values 
('F001','Fabricas Matara ZZ','R. Lapa ,125','Centro','João Meirelles','11-4123-6565'),
('F002','Distribuidora Lenz','R. Margarida Lis ,12','Santa Barbara','Mario Bora','12-3423-4576'),
('F0032','Fabrica da Felicidade','R. do Contorno s/n','Guarulhos','Franz Bauer','11-4523-5467');


Create Table tb_Produtos
(
Cod_Prod    Varchar(05),
Nome_Prod   Varchar(30),
Tipo_Prod   Char   Check(Tipo_Prod in('P','N')), 
Qtde_Estoque   Int,
Qtde_Minima  int,
Unidade      Varchar(05),
Vl_Venda    Decimal(12,2),
Vl_Compra   Decimal (12,2),
Cod_Fornec  Varchar(04),
  primary key(Cod_Prod),
 Constraint FK_Fornec_Produtos  foreign key (Cod_Fornec) 
 references TB_Fornecedores(Cod_Fornec)
 );

insert into tb_produtos values
 ('P01','Leite Desnatado','P',100,50,'Un',1.27,0.60,'F001');

insert into tb_produtos values
 ('P10','Macarrão Letra','P',150,150,'Un',1.70,0.70,'F001');

insert into tb_produtos values
 ('P20','Spaguetti','P',100,250,'Un',1.75,0.75,'F001');

insert into tb_produtos values
 ('P30','Geleia Uvao','P',100,50,'Un',4.30,1.90,'F002');

insert into tb_produtos values
 ('P40','Leite Integral','P',200,150,'Un',1.78,0.90,'F002');

insert into tb_produtos values
 ('P02','DVD-Virgem','N',100,200,'Un',0.50,0.10,'F001');

insert into tb_produtos values
 ('P03','Capacete','N',100,50,'Un',70.00,20.00,'F002');


Create Table tb_Pereciveis
(
 Cod_Prod   Varchar(05),
 Data_Compra datetime,
 Data_Vencimento Datetime,
 Primary key(Cod_Prod),
 Constraint FK_Pereciveis_Produtos  foreign key (Cod_Prod) references TB_Produtos(Cod_Prod)
);

insert into tb_Pereciveis values
 ('P01','2022-03-25','2024-06-24');

insert into tb_Pereciveis values
 ('P10','2022-04-26','2023-06-25');

insert into tb_Pereciveis values
 ('P20','2021-05-06','2023-08-03');

insert into tb_Pereciveis values
 ('P30','2021-02-25','2023-07-09');

insert into tb_Pereciveis values
 ('P40','2022-05-06','2023-01-09');






-- 1) Selecionar o código do Fornecedor,nome do fornecedor e  Nome do produtos e valor da compra e valor da venda 

SELECT 
    tb_fornecedores.Cod_Fornec, 
    tb_fornecedores.Nome_Fornec, 
    tb_produtos.Nome_Prod, 
    tb_produtos.Vl_Compra, 
    tb_produtos.Vl_Venda
FROM tb_fornecedores
INNER JOIN tb_produtos ON tb_fornecedores.Cod_Fornec = tb_produtos.Cod_Fornec;

 
 

-- 2) Selecionar o Codigo do Fornecedor, Nome do Fornecedor, Codigo do Produto,
      -- Nome do Produto que são Perecíveis
      
	select 
    tb_fornecedores.Cod_Fornec,
    tb_fornecedores.Nome_Fornec,
    tb_produtos.Cod_Prod,
    tb_produtos.Nome_Prod
    from tb_fornecedores
    inner join tb_produtos on tb_fornecedores.Cod_Fornec = tb_produtos.Cod_Fornec
    inner join tb_pereciveis on tb_produtos.Cod_Prod = tb_pereciveis.Cod_Prod;
    

 
-- 3) Selecionar o Nome do Fornecedor, Nome do Contato, Fone e Codigo do Produto e Nome dos Produtos, quantidade Minima e quantidade em estoque  que estão com a
   --  quantidade abaixo do estoque
	select 
    F.Nome_Fornec,
    F.Contato_Fornec,
    F.Fone_Fornec,
    P.Cod_Prod,
    P.Nome_Prod,
    P.Qtde_Minima,
    P.Qtde_Estoque
    from tb_fornecedores F
    inner join tb_produtos P on F.Cod_Fornec = P.Cod_Fornec
    where (P.Qtde_Minima > P.Qtde_Estoque);
    
  

-- 4) Selecionar o  Codigo do Produto e Nome do Produto, 
    -- data vencimento dos produtos perecíveis
    
    select
    P.Cod_Prod,
    P.Nome_Prod,
    PE.Data_Vencimento
    from tb_produtos P
    inner join tb_pereciveis PE on P.Cod_Prod = PE.Cod_Prod;
  

-- 5) Selecionar o  Codigo do Produto e Nome do Produto, data vencimento
     --  dos produtos perecíveis que irão vencer em 30 dias.
     select
    P.Cod_Prod,
    P.Nome_Prod,
    PE.Data_Vencimento
    from tb_produtos P
    inner join tb_pereciveis PE on P.Cod_Prod = PE.Cod_Prod
    where (PE.Data_Vencimento - PE.Data_Compra) <= 30;

 

-- 6) Selecionar o  Codigo do Produto e Nome do Produto, data vencimento, qtde de dias a vencer 
     --  dos produtos perecíveis
     
     select
    P.Cod_Prod,
    P.Nome_Prod,
    PE.Data_Vencimento,
    DATEDIFF(PE.Data_Vencimento, PE.Data_Compra) as Dias_A_Vencer
    from tb_produtos P
    inner join tb_pereciveis PE on P.Cod_Prod = PE.Cod_Prod;

 
-- 7) Selecionar o  Codigo do Fornecedor, Nome do Fornecedor, total de Venda do estoque por fornecedor referente aos produtos perecíveis
select
F.Cod_Fornec,
F.Nome_Fornec,
count(P.Vl_Venda) as Total_Vendas
from tb_fornecedores F
inner join tb_produtos P on F.Cod_Fornec = P.Cod_Fornec
inner join tb_pereciveis PE on P.Cod_Prod = PE.Cod_Prod
group by F.Cod_Fornec;  

-- 8) Selecionar o  Codigo do Fornecedor, Nome do Fornecedor, Total de Compra do estoque por fornecedor referente aos produtos perecíveis
 select
F.Cod_Fornec,
F.Nome_Fornec,
count(P.Vl_Compra) as Total_Compras
from tb_fornecedores F
inner join tb_produtos P on F.Cod_Fornec = P.Cod_Fornec
inner join tb_pereciveis PE on P.Cod_Prod = PE.Cod_Prod
group by F.Cod_Fornec;  

-- 9) Selecionar o código,Nome, Contato e  Fone do Fornecedor, Código,Nome, Qtde Minima e Qtde em Estoque  dos Produtos 
       -- cuja  Qtde em estoque é menor ou igual a  qtde Mínima 
	 select
F.Cod_Fornec,
F.Nome_Fornec,
F.Contato_Fornec,
F.Fone_Fornec,
P.Cod_Prod,
P.Nome_Prod,
P.Qtde_Minima,
P.Qtde_Estoque
from tb_fornecedores F
inner join tb_produtos P on F.Cod_Fornec = P.Cod_Fornec
where (Qtde_Estoque <= Qtde_Minima);

  
-- 10) Selecionar o código,Nome, Contato e  Fone do Fornecedor, Código,Nome, Qtde Minima e Qtde em Estoque  dos Produtos, reposição (o dobro da diferença entre 
       -- a quantidade minima e estoque) para os produtos onde a  Qtde em estoque é menor ou igual a  qtde Mínima 
        select
F.Cod_Fornec,
F.Nome_Fornec,
F.Contato_Fornec,
F.Fone_Fornec,
P.Cod_Prod,
P.Nome_Prod,
P.Qtde_Minima,
P.Qtde_Estoque,
((P.Qtde_Minima-P.Qtde_Estoque) * 2) as Reposicao
from tb_fornecedores F
inner join tb_produtos P on F.Cod_Fornec = P.Cod_Fornec
where (Qtde_Estoque <= Qtde_Minima);
	

-- 11 Use de criatividade.  crie 6 consultas usando: função de agrupamento/join (Coloque o enunciado e a resposta) .  
-- Total de vendas por fornecedor
select
count(P.Vl_Venda) as total_vendas,
F.Nome_Fornec
from tb_fornecedores F
inner join tb_produtos P on F.Cod_Fornec = P.Cod_Fornec
GROUP BY 
	F.Nome_Fornec;

-- Média de venda dos produtos por tipo
SELECT 
    P.Tipo_Prod, 
    AVG(P.Vl_Venda) AS Media_Venda
FROM 
    tb_Produtos P
GROUP BY 
    P.Tipo_Prod;


-- Contagem de produtos por fornecedor
select 
	F.Nome_Fornec,
    COUNT(P.Cod_Prod) AS Total_Produtos
	from tb_fornecedores F
    inner join tb_produtos P on F.Cod_Fornec = P.Cod_Fornec
    group by 
    F.Nome_Fornec;

-- Produto com o maior valor de venda por fornecedor
SELECT 
    tb_Fornecedores.Cod_Fornec, 
    tb_Fornecedores.Nome_Fornec, 
    tb_Produtos.Cod_Prod, 
    tb_Produtos.Nome_Prod,
    MAX(tb_Produtos.Vl_Venda) AS Maior_Valor_Venda
FROM 
    tb_Fornecedores
INNER JOIN 
    tb_Produtos 
    ON tb_Fornecedores.Cod_Fornec = tb_Produtos.Cod_Fornec
GROUP BY 
    tb_Fornecedores.Cod_Fornec, 
    tb_Fornecedores.Nome_Fornec, 
    tb_Produtos.Cod_Prod, 
    tb_Produtos.Nome_Prod;


-- Total de compras e total de vendas por fornecedor
SELECT 
    tb_Fornecedores.Cod_Fornec,
    tb_Fornecedores.Nome_Fornec,
    SUM(tb_Produtos.Vl_Compra * tb_Produtos.Qtde_Estoque) AS Total_Compra,
    SUM(tb_Produtos.Vl_Venda * tb_Produtos.Qtde_Estoque) AS Total_Venda
FROM 
    tb_Fornecedores
INNER JOIN 
    tb_Produtos 
    ON tb_Fornecedores.Cod_Fornec = tb_Produtos.Cod_Fornec
GROUP BY 
    tb_Fornecedores.Cod_Fornec, tb_Fornecedores.Nome_Fornec;


-- Quantidade de produtos em estoque por tipo de produto
SELECT 
    tb_Produtos.Tipo_Prod, 
    SUM(tb_Produtos.Qtde_Estoque) AS Total_Estoque
FROM 
    tb_Produtos
GROUP BY 
    tb_Produtos.Tipo_Prod;
