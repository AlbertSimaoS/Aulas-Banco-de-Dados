-- Banco de dados
CREATE DATABASE db_livraria;
USE db_livraria;

-- Tabelas
CREATE TABLE Usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE Autores (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    quantidade_obras INT DEFAULT 0
);

CREATE TABLE Livros (
    id_livro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    id_autor INT,
    FOREIGN KEY (id_autor) REFERENCES Autores(id_autor)
);

CREATE TABLE InventarioLivros (
    id_livro INT PRIMARY KEY,
    quantidade INT DEFAULT 0,
    FOREIGN KEY (id_livro) REFERENCES Livros(id_livro)
);

CREATE TABLE HistoricoUsuarios (
    id_usuario INT PRIMARY KEY,
    livros_em_emprestimo INT DEFAULT 0,
    status VARCHAR(20) DEFAULT 'LIVRE',
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

CREATE TABLE Emprestimos (
    id_emprestimo INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_livro INT,
    data_retorno_prevista DATE,
    data_devolucao DATE,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_livro) REFERENCES Livros(id_livro)
);

CREATE TABLE HistoricoEmprestimos (
    id_emprestimo INT PRIMARY KEY,
    id_usuario INT,
    id_livro INT,
    data_retorno_prevista DATE,
    data_devolucao DATE,
    status VARCHAR(20),
    emprestimo_vencido VARCHAR(3) DEFAULT 'NAO',
    dias_atraso INT DEFAULT 0,
    FOREIGN KEY (id_emprestimo) REFERENCES Emprestimos(id_emprestimo)
);

CREATE TABLE HistoricoMultas (
    id_multa INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_emprestimo INT,
    valor DECIMAL(10,2),
    status VARCHAR(10) DEFAULT 'PENDENTE',
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_emprestimo) REFERENCES Emprestimos(id_emprestimo)
);

CREATE TABLE Notificacoes (
    id_notificacao INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    mensagem TEXT,
    data_notificacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

-- 1
DELIMITER //
CREATE TRIGGER trg_insere_historico_usuarios
AFTER INSERT ON Usuarios
FOR EACH ROW
BEGIN
    INSERT INTO HistoricoUsuarios (id_usuario, livros_em_emprestimo, status)
    VALUES (NEW.id_usuario, 0, 'LIVRE');
END;
//
DELIMITER ;

-- 2
DELIMITER //
CREATE TRIGGER trg_insere_historico_emprestimos
AFTER INSERT ON Emprestimos
FOR EACH ROW
BEGIN
    INSERT INTO HistoricoEmprestimos (id_emprestimo, id_usuario, id_livro, data_retorno_prevista, status)
    VALUES (NEW.id_emprestimo, NEW.id_usuario, NEW.id_livro, NEW.data_retorno_prevista, 'EMPRESTADO');
END;
//
DELIMITER ;

-- 3
DELIMITER //
CREATE TRIGGER trg_contagem_obras_autor
AFTER INSERT ON Livros
FOR EACH ROW
BEGIN
    UPDATE Autores
    SET quantidade_obras = quantidade_obras + 1
    WHERE id_autor = NEW.id_autor;
END;
//
DELIMITER ;

-- 4
DELIMITER //
CREATE TRIGGER trg_atualiza_status_devolvido
AFTER UPDATE ON Emprestimos
FOR EACH ROW
BEGIN
    IF OLD.data_devolucao IS NULL AND NEW.data_devolucao IS NOT NULL THEN
        UPDATE HistoricoEmprestimos
        SET status = 'DEVOLVIDO'
        WHERE id_emprestimo = NEW.id_emprestimo;
    END IF;
END;
//
DELIMITER ;

-- 5
DELIMITER //
CREATE TRIGGER trg_aumenta_estoque_retorno
AFTER UPDATE ON Emprestimos
FOR EACH ROW
BEGIN
    IF OLD.data_devolucao IS NULL AND NEW.data_devolucao IS NOT NULL THEN
        UPDATE InventarioLivros
        SET quantidade = quantidade + 1
        WHERE id_livro = NEW.id_livro;
    END IF;
END;
//
DELIMITER ;

-- 6
DELIMITER //
CREATE TRIGGER trg_diminui_livros_usuario_retorno
AFTER UPDATE ON Emprestimos
FOR EACH ROW
BEGIN
    IF OLD.data_devolucao IS NULL AND NEW.data_devolucao IS NOT NULL THEN
        UPDATE HistoricoUsuarios
        SET livros_em_emprestimo = livros_em_emprestimo - 1
        WHERE id_usuario = NEW.id_usuario;
    END IF;
END;
//
DELIMITER ;

-- 7
DELIMITER //
CREATE TRIGGER trg_diminui_estoque_emprestimo
AFTER INSERT ON Emprestimos
FOR EACH ROW
BEGIN
    UPDATE InventarioLivros
    SET quantidade = quantidade - 1
    WHERE id_livro = NEW.id_livro;
END;
//
DELIMITER ;

-- 8
DELIMITER //
CREATE TRIGGER trg_aumenta_livros_usuario_emprestimo
AFTER INSERT ON Emprestimos
FOR EACH ROW
BEGIN
    UPDATE HistoricoUsuarios
    SET livros_em_emprestimo = livros_em_emprestimo + 1
    WHERE id_usuario = NEW.id_usuario;
END;
//
DELIMITER ;

-- 9 (implementei no de cima)

-- 10
DELIMITER //
CREATE TRIGGER trg_limite_emprestimos_simultaneos
BEFORE INSERT ON Emprestimos
FOR EACH ROW
BEGIN
    DECLARE qtd INT;
    SELECT livros_em_emprestimo INTO qtd 
      FROM HistoricoUsuarios WHERE id_usuario = NEW.id_usuario;
    IF qtd >= 5 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Limite de empréstimos simultâneos atingido.';
    END IF;
END;
//
DELIMITER ;

-- 11
DELIMITER //
CREATE TRIGGER trg_verifica_status_usuario
BEFORE INSERT ON Emprestimos
FOR EACH ROW
BEGIN
    DECLARE stat VARCHAR(20);
    SELECT status INTO stat 
      FROM HistoricoUsuarios WHERE id_usuario = NEW.id_usuario;
    IF stat = 'BANIDO' OR stat = 'RESTRITO' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Usuário não autorizado a emprestar livros.';
    END IF;
END;
//
DELIMITER ;

-- 12
DELIMITER //
CREATE TRIGGER trg_verifica_atraso_devolucao
AFTER UPDATE ON Emprestimos
FOR EACH ROW
BEGIN
    IF OLD.data_devolucao IS NULL AND NEW.data_devolucao IS NOT NULL THEN
        IF NEW.data_devolucao > NEW.data_retorno_prevista THEN
            UPDATE HistoricoEmprestimos
            SET emprestimo_vencido = 'SIM',
                dias_atraso = DATEDIFF(NEW.data_devolucao, NEW.data_retorno_prevista)
            WHERE id_emprestimo = NEW.id_emprestimo;
        END IF;
    END IF;
END;
//
DELIMITER ;

-- 13
DELIMITER //
CREATE TRIGGER trg_restringe_usuario_atraso
AFTER UPDATE ON Emprestimos
FOR EACH ROW
BEGIN
    IF OLD.data_devolucao IS NULL AND NEW.data_devolucao IS NOT NULL THEN
        IF NEW.data_devolucao > NEW.data_retorno_prevista THEN
            UPDATE HistoricoUsuarios
            SET status = 'RESTRITO'
            WHERE id_usuario = NEW.id_usuario;
        END IF;
    END IF;
END;
//
DELIMITER ;

-- 14
DELIMITER //
CREATE TRIGGER trg_registra_multa_atraso
AFTER UPDATE ON Emprestimos
FOR EACH ROW
BEGIN
    IF OLD.data_devolucao IS NULL AND NEW.data_devolucao IS NOT NULL THEN
        IF NEW.data_devolucao > NEW.data_retorno_prevista THEN
            INSERT INTO HistoricoMultas (id_usuario, id_emprestimo, valor, status)
            VALUES (NEW.id_usuario, NEW.id_emprestimo, 
                    DATEDIFF(NEW.data_devolucao, NEW.data_retorno_prevista) * 1.0, 'PENDENTE');
        END IF;
    END IF;
END;
//
DELIMITER ;

-- 15
DELIMITER //
CREATE TRIGGER trg_atualiza_status_multas
AFTER UPDATE ON HistoricoMultas
FOR EACH ROW
BEGIN
    DECLARE pend INT;

    IF OLD.status != 'PAGA' AND NEW.status = 'PAGA' THEN        
        SELECT COUNT(*) INTO pend 
        FROM HistoricoMultas 
        WHERE id_usuario = NEW.id_usuario AND status = 'PENDENTE';
        
        IF pend = 0 THEN
            UPDATE HistoricoUsuarios
            SET status = 'LIVRE'
            WHERE id_usuario = NEW.id_usuario;
        END IF;
    END IF;
END;
//

DELIMITER ;



-- 16
DELIMITER //
CREATE TRIGGER trg_limite_multa_banimento
AFTER INSERT ON HistoricoMultas
FOR EACH ROW
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(valor) INTO total 
      FROM HistoricoMultas 
      WHERE id_usuario = NEW.id_usuario AND status = 'PENDENTE';
    IF total > 50.0 THEN
        UPDATE HistoricoUsuarios
        SET status = 'BANIDO'
        WHERE id_usuario = NEW.id_usuario;
    END IF;
END;
//
DELIMITER ;

-- 17
DELIMITER //
CREATE TRIGGER trg_notifica_banimento
AFTER UPDATE ON HistoricoUsuarios
FOR EACH ROW
BEGIN
    IF OLD.status != 'BANIDO' AND NEW.status = 'BANIDO' THEN
        INSERT INTO Notificacoes (id_usuario, mensagem)
        VALUES (NEW.id_usuario, 'Você foi banido devido a multas pendentes.');
    END IF;
END;
//
DELIMITER ;

-- 18
DELIMITER //
CREATE TRIGGER trg_atualiza_emprestimos_vencidos
AFTER UPDATE ON Emprestimos
FOR EACH ROW
BEGIN
    IF NEW.data_devolucao IS NULL AND NEW.data_retorno_prevista < CURDATE() THEN
        UPDATE HistoricoEmprestimos
        SET status = 'ATRASADO', emprestimo_vencido = 'SIM'
        WHERE id_emprestimo = NEW.id_emprestimo;
    END IF;
END;
//
DELIMITER ;

-- 19
DELIMITER //
CREATE TRIGGER trg_notifica_emprestimo_vencido
AFTER UPDATE ON Emprestimos
FOR EACH ROW
BEGIN
    IF NEW.data_devolucao IS NULL AND NEW.data_retorno_prevista < CURDATE() THEN
        INSERT INTO Notificacoes (id_usuario, mensagem)
        VALUES (NEW.id_usuario, 'Seu empréstimo está vencido. Entre em contato para regularizar.');
        UPDATE HistoricoUsuarios
        SET status = 'RESTRITO'
        WHERE id_usuario = NEW.id_usuario;
    END IF;
END;
//
DELIMITER ;

-- 20
DELIMITER //
CREATE TRIGGER trg_notifica_proximo_vencimento
AFTER INSERT ON Emprestimos
FOR EACH ROW
BEGIN
    IF DATEDIFF(NEW.data_retorno_prevista, CURDATE()) = 3 THEN
        INSERT INTO Notificacoes (id_usuario, mensagem)
        VALUES (NEW.id_usuario, 'Lembrete: faltam 3 dias para a devolução do seu empréstimo.');
    END IF;
END;
//
DELIMITER ;
