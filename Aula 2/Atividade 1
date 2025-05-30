CREATE DATABASE db_turma;

USE db_turma;

CREATE TABLE tb_depto(
DEPTO CHAR(3) PRIMARY KEY,
DESC_DEPTO VARCHAR(20)  NOT NULL
);

CREATE TABLE tb_funcionario (
    NUM_FUNC CHAR(6) PRIMARY KEY,
    NOME VARCHAR(12),
    SOBRENOME VARCHAR(25) NOT NULL,
    DEPT CHAR(3),
    FONE CHAR(14),
    DTADIM DATE,
    NIVEL INT,
    SEXO CHAR(1),
    DATANAS DATE,
    SALARIO DECIMAL(10,2),
    BONUS DECIMAL(10,2),
    COMIS DECIMAL(10,2),
    constraint FK_funcdepto FOREIGN KEY (DEPT) REFERENCES tb_depto(DEPTO)
);

INSERT INTO tb_depto (DEPTO, DESC_DEPTO) VALUES
('001', 'DIRETORIA'),
('002', 'GERÊNCIA'),
('003', 'ENGENHARIA'),
('004', 'PRODUÇÃO'),
('005', 'INFORMÁTICA'),
('006', 'GERENCIA INFORMATICA');

INSERT INTO tb_funcionario (NUM_FUNC, NOME, SOBRENOME, DEPT, FONE, DTADIM, DATANAS, SALARIO, NIVEL, SEXO, COMIS) VALUES
('F001', 'João', 'Silva', '001', '1234-5678', '1980-05-10', '1990-10-20', 5000.00, 3, 'M', 1000.00),
('F002', 'Maria', 'Oliveira', '001', '2345-6789', '1985-07-15', '1990-10-20', 5500.00, 4, 'F', 1200.00),
('F003', 'Carlos', 'Pereira', '002', '3456-7890', '1990-10-20', '1990-10-20', 4500.00, 3, 'M', 800.00),
('F004', 'Ana', 'Costa', '002', '4567-8901', '1992-12-25', '1990-10-20', 4700.00, 3, 'F', 900.00),
('F005', 'Pedro', 'Almeida', '002', '5678-9012', '1988-03-30','1990-10-20', 4800.00, 2, 'M', 850.00),
('F006', 'Fernanda', 'Souza', '003', '6789-0123', '1995-06-18','1990-10-20', 5200.00, 4, 'F', 1100.00),
('F007', 'Ricardo', 'Lima', '003', '7890-1234', '1982-09-12','1990-10-20', 5000.00, 3, 'M', 950.00),
('F008', 'Juliana', 'Martins', '003', '8901-2345', '1991-11-22','1990-10-20', 5300.00, 4, 'F', 1150.00),
('F009', 'Lucas', 'Fernandes', '004', '9012-3456', '1993-02-14','1990-10-20', 3000.00, 2, 'M', 500.00),
('F010', 'Patrícia', 'Barbosa', '004', '0123-4567', '1994-04-17','1990-10-20', 3200.00, 2, 'F', 550.00),
('F011', 'Marcos', 'Ramos', '004', '1234-5678', '1996-07-29','1990-10-20', 3100.00, 2, 'M', 520.00),
('F012', 'Gabriela', 'Melo', '004', '2345-6789', '1997-08-23','1990-10-20', 3400.00, 2, 'F', 600.00),
('F013', 'Rafael', 'Santos', '004', '3456-7890', '1998-09-01','1990-10-20', 3500.00, 2, 'M', 650.00),
('F014', 'Bianca', 'Teixeira', '004', '4567-8901', '1992-05-05','1990-10-20', 3600.00, 3, 'F', 700.00),
('F015', 'Eduardo', 'Cardoso', '004', '5678-9012', '1989-11-11','1990-10-20', 3700.00, 3, 'M', 750.00),
('F016', 'Tatiane', 'Rodrigues', '005', '6789-0123', '1993-03-28','1990-10-20', 4000.00, 3, 'F', 800.00),
('F017', 'André', 'Ferreira', '005', '7890-1234', '1987-06-15','1990-10-20', 4100.00, 3, 'M', 850.00),
('F018', 'Camila', 'Nunes', '005', '8901-2345', '1990-09-07','1990-10-20', 4200.00, 3, 'F', 900.00),
('F019', 'Roberto', 'Dias', '005', '9012-3456', '1995-12-30','1990-10-20', 4300.00, 4, 'M', 950.00),
('F020', 'Elaine', 'Gonçalves', '005', '0123-4567', '1986-08-08','1990-10-20', 4400.00, 4, 'F', 1000.00);

UPDATE tb_funcionario SET DEPT = '003' WHERE NUM_FUNC = 'F016';

UPDATE tb_depto SET DESC_DEPTO = 'INFORMÁTICA' WHERE DEPTO = '005';

SET SQL_SAFE_UPDATES = 0;

UPDATE tb_funcionario SET SALARIO = SALARIO * 1.17;

UPDATE tb_funcionario SET BONUS = SALARIO * 0.05;

UPDATE tb_funcionario SET BONUS = SALARIO * 0.15 WHERE DEPT = '003';

UPDATE tb_funcionario SET SALARIO = SALARIO * 1.05;

ALTER TABLE tb_funcionario MODIFY COLUMN SALARIO DECIMAL(12,4);

UPDATE tb_funcionario SET SALARIO = SALARIO * 1.06 WHERE DEPT = '002';

UPDATE tb_funcionario SET SALARIO = SALARIO * 0.98 WHERE DEPT = '003';

UPDATE tb_funcionario SET FONE = '3643-4576' WHERE NUM_FUNC = 'F004';


DELETE FROM tb_depto;

DELETE FROM tb_depto WHERE DEPTO = '006';

DELETE FROM tb_funcionario

DELETE FROM tb_funcionario WHERE DEPT = '005';

DELETE FROM tb_depto WHERE DEPTO = '006';

SELECT * FROM tb_funcionario;

SELECT * FROM tb_depto;

SELECT NUM_FUNC AS "Número", NOME AS "Nome", SALARIO AS "Salário" FROM tb_funcionario;

SELECT NUM_FUNC AS "Número", NOME AS "Nome", SALARIO AS "Salário" FROM tb_funcionario WHERE DEPT = '005';

SELECT NUM_FUNC AS "Número", NOME AS "Nome", SALARIO AS "Salário" FROM tb_funcionario WHERE DEPT = '004' AND SALARIO > 2000;

SELECT NUM_FUNC AS "Número", NOME AS "Nome", SALARIO AS "Salário" FROM tb_funcionario WHERE DEPT = '004' AND SALARIO < 20000;

SELECT NUM_FUNC AS "Número", NOME AS "Nome", SALARIO AS "Salário" FROM tb_funcionario WHERE DEPT = '005' AND SALARIO <= 7000;

SELECT NUM_FUNC AS "Número", NOME AS "Nome", SALARIO AS "Salário" FROM tb_funcionario WHERE DEPT = '004' AND SALARIO BETWEEN 600 AND 2000;

SELECT NUM_FUNC AS "Número", NOME AS "Nome", SALARIO AS "Salário" FROM tb_funcionario WHERE DEPT = '004';

SELECT NUM_FUNC AS "Número", NOME AS "Nome", SALARIO AS "Salário" FROM tb_funcionario ORDER BY SALARIO ASC;

SELECT NUM_FUNC AS "Número", NOME AS "Nome", SALARIO AS "Salário" FROM tb_funcionario WHERE DEPT = '004' ORDER BY SALARIO DESC;

SELECT NUM_FUNC AS "Número", NOME AS "Nome", DATANAS AS "Data de Nascimento", BONUS AS "Bonus" FROM tb_funcionario WHERE DEPT = '005';

select 
	NUM_FUNC as NUM,
	NOME as N,
    SOBRENOME as SN,
    DEPT as DEPART,
    FONE as TEL,
    DTADIM as INGRESSO,
    NIVEL as NIV,
    SEXO as SEX,
    DATANAS as NASC,
    SALARIO as SAL,
    BONUS as BON,
    COMIS as COM
from tb_funcionario where NIVEL = 3 order by NOME asc;

select * from tb_funcionario where NIVEL = 4 order by NOME desc;

SELECT * FROM tb_funcionario WHERE DEPT = '005' AND SALARIO BETWEEN 5600 AND 8000;
