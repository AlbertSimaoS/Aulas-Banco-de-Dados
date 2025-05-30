CREATE DATABASE db_controle_de_produtos;

USE db_controle_de_produtos;

CREATE TABLE tb_fornecedores (
    Cod_Fornec VARCHAR(15),
    Nome_Fantasia VARCHAR(30),
    Razao_Social VARCHAR(30),
    Fone_Contato VARCHAR(15),
    Endereco VARCHAR(30),
    PRIMARY KEY (Cod_Fornec)
);

CREATE TABLE tb_produtos (
    Cod_Prod VARCHAR(13),
    Nome_Prod VARCHAR(25),
    Tipo_Prod VARCHAR(20),
    Perecivel CHAR(1),
    Unidade VARCHAR(10),
    Qtde_Unidade INT,
    Cod_Fornec VARCHAR(15),
    PRIMARY KEY (Cod_Prod),
    CONSTRAINT FK_produtos_fornecedores FOREIGN KEY (Cod_Fornec) REFERENCES tb_fornecedores(Cod_Fornec)
);

CREATE TABLE tb_perecivel (
    Cod_Prod VARCHAR(13),
    Lote_Prod VARCHAR(5),
    Data_Compra TIMESTAMP,
    Data_Vencto DATETIME,
    Qtde_deUnidade INT,
    Cod_Fornec VARCHAR(15),
    Vl_Compra DECIMAL(12,2),
    Vl_Venda DECIMAL(12,2),
    PRIMARY KEY (Cod_Prod, Lote_Prod),
    CONSTRAINT FK_perecivel_fornecedores FOREIGN KEY (Cod_Fornec) REFERENCES tb_fornecedores(Cod_Fornec),
    CONSTRAINT FK_perecivel_produtos FOREIGN KEY (Cod_Prod) REFERENCES tb_produtos(Cod_Prod)
);

CREATE TABLE tb_NaoPerecivel (
    Cod_Prod VARCHAR(13),
    Lote_Prod VARCHAR(5),
    Data_Compra TIMESTAMP,
    Qtde_deUnidade INT,
    Cod_Fornec VARCHAR(15),
    Vl_Compra DECIMAL(12,2),
    Vl_Venda DECIMAL(12,2),
    PRIMARY KEY (Cod_Prod, Lote_Prod),
    CONSTRAINT FK_Nperecivel_fornecedores FOREIGN KEY (Cod_Fornec) REFERENCES tb_fornecedores(Cod_Fornec),
    CONSTRAINT FK_Nperecivel_produtos FOREIGN KEY (Cod_Prod) REFERENCES tb_produtos(Cod_Prod)
);


insert into tb_fornecedores(Cod_Fornec, Nome_Fantasia, Razao_Social, Fone_Contato, Endereco) values ( 'F001', 'Lactnícios Delicia', 'Fazeda Criação ltda', '(11) 9566-4567', 'Estrada das Oliveiras');

insert into tb_fornecedores(Cod_Fornec, Nome_Fantasia, Razao_Social, Fone_Contato, Endereco) values ( 'F002', 'Iogourt Nestla', 'Lactiníos da Nestla s/a', '(15) 7899-43344', 'Rodovia Quintino');

insert into tb_fornecedores(Cod_Fornec, Nome_Fantasia, Razao_Social, Fone_Contato, Endereco) values ( 'F003', 'Bombrel', 'Bombrel limpeza s/a', '(11) 8765-7856', 'Estrada do Contorno');

insert into tb_fornecedores(Cod_Fornec, Nome_Fantasia, Razao_Social, Fone_Contato, Endereco) values ( 'F004', 'Palha da Limpeza', 'Fabrica da limpeza', '(11) 9987-6754', 'Rua Quintino');

SELECT * FROM tb_fornecedores;



insert into tb_produtos (Cod_Prod, Nome_Prod, Tipo_Prod, Perecivel, Unidade, Qtde_Unidade, Cod_Fornec) values ('2737547', 'Iougurt', 'Lactea', 'S', 'cx', '20', 'F001');

insert into tb_produtos (Cod_Prod, Nome_Prod, Tipo_Prod, Perecivel, Unidade, Qtde_Unidade, Cod_Fornec) values ('374855', 'Iougurt', 'Lactea', 'S', 'cx', '20', 'F002');

insert into tb_produtos (Cod_Prod, Nome_Prod, Tipo_Prod, Perecivel, Unidade, Qtde_Unidade, Cod_Fornec) values ('394377', 'Palha de aço', 'Limpeza', 'N', 'Pcte', '30', 'F003');

insert into tb_produtos (Cod_Prod, Nome_Prod, Tipo_Prod, Perecivel, Unidade, Qtde_Unidade, Cod_Fornec) values ('438765', 'Palha de Aço', 'Limpeza', 'N', 'pcte', '20', 'F004');

insert into tb_produtos (Cod_Prod, Nome_Prod, Tipo_Prod, Perecivel, Unidade, Qtde_Unidade, Cod_Fornec) values ('567890', 'Pano de Limpeza', 'Limpeza', 'N', 'pcte', '30', 'F004');

SELECT * FROM tb_produtos;

INSERT INTO tb_perecivel (Cod_Prod, Lote_Prod, Data_Compra, Data_Vencto, Qtde_deUnidade, Cod_Fornec, Vl_Compra, Vl_Venda)
VALUES ('2737547', 'L001', '2024-03-10', '2024-08-10', 50, 'F001', 5.00, 15.50);

INSERT INTO tb_perecivel (Cod_Prod, Lote_Prod, Data_Compra, Data_Vencto, Qtde_deUnidade, Cod_Fornec, Vl_Compra, Vl_Venda)
VALUES ('2737547', 'L001', '2024-03-11', '2024-08-11', 100, 'F002', 6.00, 17.50);

SELECT * FROM tb_perecivel;



INSERT INTO tb_naoperecivel (Cod_Prod, Lote_Prod, Data_Compra, Qtde_deUnidade, Cod_Fornec, Vl_Compra, Vl_Venda)
VALUES ('394377', 'L002', '2024-03-11', 50, 'F003', 9.00, 16.50);

INSERT INTO tb_naoperecivel (Cod_Prod, Lote_Prod, Data_Compra, Qtde_deUnidade, Cod_Fornec, Vl_Compra, Vl_Venda)
VALUES ('438765', 'L001', '2024-03-11', 150, 'F004', 7.00, 18.50);

INSERT INTO tb_naoperecivel (Cod_Prod, Lote_Prod, Data_Compra, Qtde_deUnidade, Cod_Fornec, Vl_Compra, Vl_Venda)
VALUES ('567890', 'L004', '2024-02-09', 100, 'F004', 2.00, 5.00 );

SELECT * FROM tb_naoperecivel;







