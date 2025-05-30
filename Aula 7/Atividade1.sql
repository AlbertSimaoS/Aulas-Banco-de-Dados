-- Objetivo --
/*
Funciona como um mecanismo automático que depende de algum gatilho para disparar. Depende, portanto, de manipulações na tabela. 

Nesse sentido, existem dois tipos principais: o AFTER e o INSTEAD OF.

O AFTER é executado depois do evento que disparou o trigger. Ao passo que o INSTEAD OF executa algo no lugar do evento inicial, quando este é detectado. 
*/

-- Sintaxe --
/*
CREATE TRIGGER [Nome] 

    ON [Nome_da_tabela] 

    AFTER/BEFORE {[Operação-gatilho]} 

    AS 

    {lógica de comandos}
*/

-- banco de dados --
create database db_loja;

use db_loja;

CREATE TABLE produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(100),
    preco DECIMAL(10, 2),
    estoque INT,
    ultima_venda DATE
);

CREATE TABLE vendas (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    data_venda DATE,
    id_produto INT,
    quantidade INT,
    valor_total DECIMAL(10, 2),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

CREATE TABLE vendas_canceladas (
    id_venda INT,
    data_venda DATE,
    id_produto INT,
    quantidade INT,
    valor_total DECIMAL(10, 2),
    data_cancelamento DATETIME
);

CREATE TABLE historico_precos (
    id_produto INT,
    preco_antigo DECIMAL(10, 2),
    preco_novo DECIMAL(10, 2),
    data_alteracao DATETIME
);

CREATE TABLE alertas_estoque (
    id_produto INT,
    estoque_atual INT,
    data_alerta DATETIME
);

CREATE TABLE log_estoque (
    id_produto INT,
    estoque_antigo INT,
    estoque_novo INT,
    data_ajuste DATETIME
);
    

-- Triggers --
-- 1
DELIMITER //
CREATE TRIGGER trg_atualizar_estoque_after_venda
AFTER INSERT ON vendas
FOR EACH ROW
BEGIN
    UPDATE produtos
    SET estoque = estoque - NEW.quantidade
    WHERE id_produto = NEW.id_produto;
END;
//

-- 2
DELIMITER //
CREATE TRIGGER trg_checar_estoque_before_venda
BEFORE INSERT ON vendas
FOR EACH ROW
BEGIN
    DECLARE estoque_atual INT;
    SELECT estoque INTO estoque_atual FROM produtos WHERE id_produto = NEW.id_produto;
    IF estoque_atual < NEW.quantidade THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Estoque insuficiente para realizar a venda.';
    END IF;
END;
//

-- 3
DELIMITER //
CREATE TRIGGER trg_registrar_venda_cancelada
BEFORE DELETE ON vendas
FOR EACH ROW
BEGIN
    INSERT INTO vendas_canceladas (id_venda, data_venda, id_produto, quantidade, valor_total, data_cancelamento)
    VALUES (OLD.id_venda, OLD.data_venda, OLD.id_produto, OLD.quantidade, OLD.valor_total, NOW());
END;
//

-- 4
DELIMITER //
CREATE TRIGGER trg_atualizar_ultima_venda
AFTER INSERT ON vendas
FOR EACH ROW
BEGIN
    UPDATE produtos
    SET ultima_venda = NEW.data_venda
    WHERE id_produto = NEW.id_produto;
END;
//

-- 5
DELIMITER //
CREATE TRIGGER trg_preco_negativo
BEFORE UPDATE ON produtos
FOR EACH ROW
BEGIN
    IF NEW.preco < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Preço não pode ser negativo.';
    END IF;
END;
//

-- 6
DELIMITER //
CREATE TRIGGER trg_log_alteracao_preco
AFTER UPDATE ON produtos
FOR EACH ROW
BEGIN
    IF OLD.preco <> NEW.preco THEN
        INSERT INTO historico_precos (id_produto, preco_antigo, preco_novo, data_alteracao)
        VALUES (NEW.id_produto, OLD.preco, NEW.preco, NOW());
    END IF;
END;
//

-- 7
DELIMITER //
CREATE TRIGGER trg_alerta_estoque_minimo
AFTER INSERT ON vendas
FOR EACH ROW
BEGIN
    DECLARE estoque_atual INT;
    SELECT estoque INTO estoque_atual FROM produtos WHERE id_produto = NEW.id_produto;
    IF estoque_atual < 5 THEN
        INSERT INTO alertas_estoque (id_produto, estoque_atual, data_alerta)
        VALUES (NEW.id_produto, estoque_atual, NOW());
    END IF;
END;
//

-- 8
DELIMITER //

CREATE TRIGGER trg_impedir_exclusao_produto
BEFORE DELETE ON produtos
FOR EACH ROW
BEGIN
    DECLARE qtd_vendas INT;

    SELECT COUNT(*) INTO qtd_vendas
    FROM vendas
    WHERE id_produto = OLD.id_produto;

    IF qtd_vendas > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Não é possível excluir um produto com vendas registradas.';
    END IF;
END;
//

-- 9
DELIMITER //
CREATE TRIGGER trg_calcular_valor_total
BEFORE INSERT ON vendas
FOR EACH ROW
BEGIN
    DECLARE preco_produto DECIMAL(10,2);

    SELECT preco INTO preco_produto
    FROM produtos
    WHERE id_produto = NEW.id_produto;

    SET NEW.valor_total = preco_produto * NEW.quantidade;
END;
//

-- 10
DELIMITER //
CREATE TRIGGER trg_log_ajuste_estoque
AFTER UPDATE ON produtos
FOR EACH ROW
BEGIN
    IF OLD.estoque <> NEW.estoque THEN
        INSERT INTO log_estoque (id_produto, estoque_antigo, estoque_novo, data_ajuste)
        VALUES (NEW.id_produto, OLD.estoque, NEW.estoque, NOW());
    END IF;
END;
//


