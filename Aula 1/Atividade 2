CREATE DATABASE db_shopping;


USE db_shopping;

CREATE TABLE tb_shopping (
	Codigo_Shopping varchar(3),
	Nome_Shopping varchar(40) NOT NULL,
	Endereco_Shopping Varchar(30) NOT NULL,
	Bairro_Shopping Varchar(30),
	Cidade_Shopping Varchar(30),
	Uf_Shopping Varchar(2),
	Fone_Adminstrativo Varchar(13),
	PRIMARY KEY (Codigo_Shopping)
);

CREATE TABLE tb_loja (
    Codigo_Loja VARCHAR(3) PRIMARY KEY,
    Nome_Loja VARCHAR(30) NOT NULL,
    Codigo_Shopping VARCHAR(3),
    CNPJ_Loja VARCHAR(17) UNIQUE,
    FOREIGN KEY (Codigo_Shopping) REFERENCES tb_shopping(Codigo_Shopping)
);

CREATE TABLE tb_cargo (
	Codigo_Cargo VARCHAR(5) PRIMARY KEY,
    Nome_do_Cargo varchar(05)  NOT NULL,
    Comissao_Cargo real
);

CREATE TABLE tb_funcionarios (
	Codigo_Funcionario VARCHAR(3) PRIMARY KEY,
    Nome_do_Funcionario VARCHAR(40) NOT NULL,
    Sexo CHAR(1) CHECK (Sexo IN ('F', 'M')),
    Data_Nascimento DATE,
    CPF VARCHAR(12) UNIQUE,
    Cod_Cargo VARCHAR(5),
    Cod_Loja VARCHAR(3),
    Data_Admissao DATE,
    FOREIGN KEY (Cod_Cargo) REFERENCES tb_cargo(Codigo_Cargo),
    FOREIGN KEY (Cod_Loja) REFERENCES tb_loja(Codigo_Loja)
);


