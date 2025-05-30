create database db_compras;

use db_compras;

create table tb_forma_pagto (
FormaPagto  Varchar(1) primary KEY,
Descricao_Pagto varchar(20)
);

insert into tb_forma_pagto (FormaPagto,Descricao_Pagto) values
 ('1','A vista Dinheiro'), 
 ('2','Débito no Cartão'),
 ('3','Crédito no Cartão');

Create table tb_compras
(
    cod_cliente  varchar(4),
	Forma_Pagto   varchar(1),
	comprador     varchar(30),
	Data_Compra timestamp default CURRENT_TIMESTAMP(),
	Vl_compra   Decimal(13,2),
    constraint FK_Cliente_Compra foreign key (Forma_Pagto) references tb_forma_pagto(FormaPagto)
);


select cod_cliente, comprador , count(vl_compra) from tb_compras group by cod_cliente having cod_cliente = 'c01';

insert into tb_compras values ('C01','1','Ana Maria da Cruz',str_to_date('31-12-2022','%d-%m-%Y'),500);

insert into tb_compras values ('C01','1','Ana Maria da Cruz',str_to_date('23/03/2023','%d/%m/%Y') ,500);
insert into tb_compras values ('C01','2','Ana Maria da Cruz',str_to_date('24/03/2023','%d/%m/%Y'),1500);
insert into tb_compras values ('C01','3','Ana Maria da Cruz',str_to_date('20/02/2023','%d/%m/%Y'),2500);
insert into tb_compras values ('C01','3','Ana Maria da Cruz',str_to_date('25/01/2023','%d/%m/%Y'),500);

insert into tb_compras values ('C02','1', 'Maria de Sousa',str_to_date('23/02/2023','%d/%m/%Y'),7500);
insert into tb_compras values ('C02','1', 'Maria de Sousa',str_to_date('03/05/2023','%d/%m/%Y'),3500);
insert into tb_compras values ('C02','2', 'Maria de Sousa',str_to_date('03/05/2023','%d/%m/%Y'),5500);
insert into tb_compras values ('C02','2', 'Maria de Sousa',str_to_date('05/03/2023','%d/%m/%Y'),6500);
insert into tb_compras values ('C02','2', 'Maria de Sousa',str_to_date('23/02/2023','%d/%m/%Y'),7500);

insert into tb_compras values ('C03','1','Amelia da Paz',str_to_date('01/02/2023','%d/%m/%Y'),4500);
insert into tb_compras values ('C03','1','Amelia da Paz',str_to_date('02/02/2023','%d/%m/%Y'),600);
insert into tb_compras values ('C03','1','Amelia da Paz',str_to_date('21/03/2023','%d/%m/%Y'),780);
insert into tb_compras values ('C03','2','Amelia da Paz',str_to_date('04/04/2023','%d/%m/%Y'),1500);
insert into tb_compras values ('C03','2','Amelia da Paz',str_to_date('23/04/2023','%d/%m/%Y'),3500);
insert into tb_compras values ('C03','3','Amelia da Paz',str_to_date('25/04/2023','%d/%m/%Y'),7500);
insert into tb_compras values ('C03','3','Amelia da Paz',str_to_date('27/04/2023','%d/%m/%Y'),5500);
insert into tb_compras values ('C03','3','Amelia da Paz',str_to_date('30/01/2023','%d/%m/%Y'),8500);

insert into tb_compras values ('C04','2','Americo Antonio',str_to_date('03/01/2023','%d/%m/%Y'),12500);
insert into tb_compras values ('C04','2','Americo Antonio',str_to_date('23/02/2023','%d/%m/%Y'),1500);
insert into tb_compras values ('C04','2','Americo Antonio',str_to_date('25/02/2023','%d/%m/%Y'),15500);
insert into tb_compras values ('C04','3','Americo Antonio',str_to_date('26/02/2023','%d/%m/%Y'),22500);
insert into tb_compras values ('C04','3','Americo Antonio',str_to_date('23/03/2023','%d/%m/%Y'),32500);
insert into tb_compras values ('C04','3','Americo Antonio',str_to_date('30/03/2023','%d/%m/%Y'),25000);
insert into tb_compras values ('C04','3','Americo Antonio',str_to_date('30/03/2023','%d/%m/%Y'),500);
insert into tb_compras values ('C04','1','Americo Antonio',str_to_date('30/03/2023','%d/%m/%Y'),4500);
insert into tb_compras values ('C04','1','Americo Antonio',str_to_date('04/04/2023','%d/%m/%Y'),2500);
insert into tb_compras values ('C04','2','Americo Antonio',str_to_date('30/04/2023','%d/%m/%Y'),7500);

insert into tb_compras values ('C05','3', 'Elizabeth Mangaduba',str_to_date('30/03/2023','%d/%m/%Y'),8500);
insert into tb_compras values ('C05','3', 'Elizabeth Mangaduba',str_to_date('05/04/2023','%d/%m/%Y'),3500);

insert into tb_compras values ('C06','1','Mario Brosser',str_to_date('23/03/2023','%d/%m/%Y'),8900);
insert into tb_compras values ('C06','2','Mario Brosser',str_to_date('05/04/2023','%d/%m/%Y'),15500);
insert into tb_compras values ('C06','1','Mario Brosser',str_to_date('30/04/2023','%d/%m/%Y'),10500);

insert into tb_compras values ('C07','1','Carlos Magdo de Souza',str_to_date('23/02/2023','%d/%m/%Y'),7500);
insert into tb_compras values ('C07','2','Carlos Magdo de Souza',str_to_date('26/02/2023','%d/%m/%Y'),890);
insert into tb_compras values ('C07','3','Carlos Magdo de Souza',str_to_date('27/02/2023','%d/%m/%Y'),980);
insert into tb_compras values ('C07','2','Carlos Magdo de Souza',str_to_date('28/02/2023','%d/%m/%Y'),7500);
insert into tb_compras values ('C07','2','Carlos Magdo de Souza',str_to_date('30/03/2023','%d/%m/%Y'),4500);
insert into tb_compras values ('C07','1','Carlos Magdo de Souza',str_to_date('30/04/2023','%d/%m/%Y'),2500);

insert into tb_compras values ('C08','1', 'Bianca Souza',str_to_date('23/02/2023','%d/%m/%Y'),6500);
insert into tb_compras values ('C08','2', 'Bianca Souza',str_to_date('01/04/2023','%d/%m/%Y'),500);
insert into tb_compras values ('C08','3', 'Bianca Souza',str_to_date('05/04/2023','%d/%m/%Y'),9500);
insert into tb_compras values ('C08','3', 'Bianca Souza',str_to_date('09/04/2023','%d/%m/%Y'),15500);

insert into tb_compras values ('C09','1','Maria Silva e Sousa',str_to_date('23/01/2023','%d/%m/%Y'),7500);
insert into tb_compras values ('C09','1','Maria Silva e Sousa',str_to_date('03/03/2023','%d/%m/%Y'),17500);
insert into tb_compras values ('C09','1','Maria Silva e Sousa',str_to_date('04/03/2023','%d/%m/%Y'),37500);
insert into tb_compras values ('C09','1','Maria Silva e Sousa',str_to_date('13/04/2023','%d/%m/%Y'),550);
insert into tb_compras values ('C09','1','Maria Silva e Sousa',str_to_date('23/04/2023','%d/%m/%Y'),8500);

insert into tb_compras values ('C10','1', 'Amalia Suzete da Costa',str_to_date('03/01/2023','%d/%m/%Y'),2500);

insert into tb_compras values ('C11','1','Maria Catarina da silva',str_to_date('13/02/2023','%d/%m/%Y'),3500);

insert into tb_compras values ('C12','3', 'Catarina do Branco',str_to_date('17/04/2023','%d/%m/%Y'),2500);

insert into tb_compras values ('C13','3','Juca Xaves',str_to_date('13/01/2023','%d/%m/%Y'),3700);
insert into tb_compras values ('C13','3','Juca Xaves',str_to_date('23/04/2023','%d/%m/%Y'),3700);

insert into tb_compras values ('C14','1','Mariano Chaves',str_to_date('30/04/2023','%d/%m/%Y'),3700);
insert into tb_compras values ('C14','1','Mariano Chaves',str_to_date('03/05/2023','%d/%m/%Y'),3700);
--#1
select cod_cliente, comprador, Descricao_Pagto, vl_compra from tb_compras
inner join tb_forma_pagto on tb_compras.Forma_Pagto = tb_forma_pagto.Formapagto 
 where vl_compra between 3000.00 and 5500.00  order by comprador; 
 --#2
select cod_cliente, comprador, Data_Compra, Descricao_Pagto, vl_compra from tb_compras
inner join tb_forma_pagto on tb_compras.Forma_Pagto = tb_forma_pagto.Formapagto 
where vl_compra between 6000.00 and 15000.00 order by vl_compra ASC;
--#3
SELECT * FROM tb_compras WHERE Forma_Pagto = '1';
--#4
SELECT * FROM tb_compras WHERE Forma_Pagto = '1' or Forma_Pagto = '2';
--#5
select (SUM(vl_compra)) as Total_Compras, Descricao_Pagto from tb_compras
inner join tb_forma_pagto on tb_compras.Forma_Pagto = tb_forma_pagto.Formapagto
group by Descricao_Pagto
order by Forma_Pagto;
--#6
select * from tb_compras where comprador like 'A%';
--#7
select * from tb_compras where comprador like '%A' order by comprador desc;
--#8
select * from tb_compras where comprador like 'AM%' order by vl_compra desc;
--#9
select * from tb_compras where comprador like 'AM_l%';
--#10
select * from tb_compras where comprador like '%D%';
--#11
select * from tb_compras WHERE comprador LIKE 'A%' OR comprador LIKE 'E%' ORDER BY comprador ASC;
--#12
SELECT * FROM tb_compras WHERE comprador LIKE 'A%' 
   OR comprador LIKE 'B%' 
   OR comprador LIKE 'C%' 
   OR comprador LIKE 'D%' 
   OR comprador LIKE 'E%';
--#13
SELECT * FROM tb_compras WHERE (comprador LIKE 'A%' 
   OR comprador LIKE 'C%' 
   OR comprador LIKE 'E%') 
   AND vl_compra > 5000.00;
--#14
SELECT cod_cliente, COUNT(*) AS Quant_Compras FROM tb_compras GROUP BY cod_cliente;
--#15
SELECT COUNT(*) AS Quant_Compras FROM tb_compras;
--#16
select MAX(Vl_compra) AS Maior_Compra FROM tb_compras;
--#17
select min(Vl_compra) AS Maior_Compra FROM tb_compras;
--#18
select AVG(Vl_compra) AS Media_Compras FROM tb_compras;
--#19
SELECT cod_cliente, comprador, Vl_compra, Data_Compra FROM tb_compras WHERE cod_cliente = 'C02' 
AND Vl_compra = (SELECT MAX(Vl_compra) FROM tb_compras WHERE cod_cliente = 'C02');
--#20
SELECT cod_cliente, MAX(Vl_compra) AS Maior_Compra
FROM tb_compras
GROUP BY cod_cliente;
--#21
SELECT comprador, MAX(Vl_compra) AS Maior_Compra
FROM tb_compras
GROUP BY comprador;
--#22
select cod_cliente, comprador, count(*) as Quant_compras, sum(Vl_compra) AS Total_Compras from tb_compras
GROUP BY cod_cliente, comprador
order by comprador asc;
--#23
select cod_cliente, comprador, count(*) as Quant_Compras, max(vl_compra), min(vl_compra), sum(vl_compra) as Total_Compras, AVG(Vl_compra) AS Media_Compras
FROM tb_compras
GROUP BY cod_cliente, comprador
ORDER BY cod_cliente ASC;
--#24
select (SUM(vl_compra)) as Total_Compras, Descricao_Pagto from tb_compras
inner join tb_forma_pagto on tb_compras.Forma_Pagto = tb_forma_pagto.Formapagto
group by Descricao_Pagto
order by Forma_Pagto;
--#25
select  cod_cliente, (SUM(vl_compra)) as Total_Compras, Descricao_Pagto from tb_compras
inner join tb_forma_pagto on tb_compras.Forma_Pagto = tb_forma_pagto.Formapagto  where cod_cliente = 'C03' group by Forma_Pagto;
--#26
select (SUM(vl_compra)) as Total_Compras, Descricao_Pagto from tb_compras
inner join tb_forma_pagto on tb_compras.Forma_Pagto = tb_forma_pagto.Formapagto  where Forma_Pagto = '2' or Forma_Pagto = '3' group by Forma_Pagto;
--#26.5
select count(*) as Quant_Compras, (SUM(vl_compra)) as Total_Compras, Descricao_Pagto from tb_compras
inner join tb_forma_pagto on tb_compras.Forma_Pagto = tb_forma_pagto.Formapagto  where Forma_Pagto = '2' group by Forma_Pagto;
--#27
select count(DISTINCT cod_cliente) as Quant_Clientes, (SUM(vl_compra)) as Total_Compras from tb_compras
inner join tb_forma_pagto on tb_compras.Forma_Pagto = tb_forma_pagto.Formapagto  where Forma_Pagto = '3' group by Forma_Pagto;
--#28
select cod_cliente, count(*) as Quant_Compras, avg(vl_compra) as Media_Compras, (SUM(vl_compra)) as Total_Compras from tb_compras where Forma_Pagto = '3' group by cod_cliente order by cod_cliente;
--#29
select max(vl_compra) as Compra_Max, min(vl_compra) as Compra_Min from tb_compras group by cod_cliente order by cod_cliente;
--#30
select cod_cliente, max(vl_compra) as Compra_Max, min(vl_compra) as Compra_Min from tb_compras group by cod_cliente order by cod_cliente;
--#31
select * from tb_compras where comprador LIKE '%Souza' OR comprador LIKE '%Sousa';

