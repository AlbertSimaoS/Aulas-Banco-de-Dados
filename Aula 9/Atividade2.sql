-- --------------------------------------------------------------------------------------------------------------------------
-- Conceito do Event Scheduler do MySQL
-- --------------------------------------------------------------------------------------------------------------------------
/*
é um recurso que permite a execução de tarefas agendadas em um servidor MySQL. Pense nele como um "cron job" ou "tarefa agendada" 
dentro do próprio banco de dados. Ele executa comandos SQL (como INSERT, UPDATE, DELETE, chamadas a stored procedures, etc.) em horários ou
intervalos específicos, sem a necessidade de um sistema operacional externo para agendar essas tarefas
*/
 -- --------------------------------------------------------------------------------------------------------------------------
-- Como ativar/desativar  o Evento 
-- --------------------------------------------------------------------------------------------------------------------------
/*
=> Ativar:
Você pode ativá-lo temporariamente (até a próxima reinicialização do MySQL) ou permanentemente
	Temporariamente
		//Via sessão MySQL (runtime):
			- SET GLOBAL event_scheduler = ON;
            
		//Via arquivo de configuração (my.cnf ou my.ini)
			- event_scheduler = ON
=> Desativar:
	Temporariamente (via sessão):
		- SET GLOBAL event_scheduler = OFF;

	Temporariamente (via sessão):
		- SET GLOBAL event_scheduler = OFF;
-- --------------------------------------------------------------------------------------------------------------------------
-- Como verificar se o evento está ativado ou desativado
-- --------------------------------------------------------------------------------------------------------------------------
	//Usando SHOW VARIABLES:
		- SHOW VARIABLES LIKE 'event_scheduler';
* O resultado mostrará o valor de event_scheduler. Se for ON, está ativado; se for OFF, está desativado.

	//Usando SELECT na tabela performance_schema.events_waits_summary_global_by_event_name (para versões mais recentes do MySQL):
Embora esta tabela não mostre diretamente "ON" ou "OFF", a presença de eventos e a sua execução podem indicar que o scheduler está ativo. A forma mais direta e confiável é usar SHOW VARIABLES.

-- --------------------------------------------------------------------------------------------------------------------------
-- Sintaxe da estrutura do Event Scheduler
-- --------------------------------------------------------------------------------------------------------------------------
CREATE EVENT [IF NOT EXISTS] nome_do_evento
ON SCHEDULE
    [AT timestamp | EVERY intervalo [STARTS timestamp] [ENDS timestamp]]
    DO
        comando_sql_a_ser_executado;
-- --------------------------------------------------------------------------------------------------------------------------
-- Opções de configuração para qual momento será a  execução do evento
-- --------------------------------------------------------------------------------------------------------------------------
Além do AT e EVERY, você pode controlar o comportamento do evento:
	//ON COMPLETION [NOT PRESERVE]: Opcional.
	//NOT PRESERVE: (Padrão para eventos AT ou eventos EVERY que têm ENDS) Significa que o evento será descartado (excluído) automaticamente após a sua última execução.
	(Se omitido em eventos EVERY sem ENDS): O evento permanecerá ativo e continuará executando indefinidamente.
	// ENABLE / DISABLE:
		- ENABLE: O evento é criado e imediatamente ativado (padrão).
		- DISABLE: O evento é criado, mas permanece desativado e não será executado até que seja explicitamente ativado com ALTER EVENT nome_do_evento ENABLE;.
	//COMMENT 'seu comentário': Adiciona um comentário ao evento, útil para documentação.
-- --------------------------------------------------------------------------------------------------------------------------
-- Como excluir um evento
-- --------------------------------------------------------------------------------------------------------------------------
DROP EVENT [IF EXISTS] nome_do_evento;
*/
-- --------------------------------------------------------------------------------------------------------------------------
-- Criar 4 exemplos de eventos (procure colocar MOMENTOS diferentes
-- --------------------------------------------------------------------------------------------------------------------------
		-- 1º
-- 1º
CREATE DATABASE Eventos;

USE Eventos;

CREATE TABLE log_acesso (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(50) NOT NULL,
    data_acesso DATETIME DEFAULT CURRENT_TIMESTAMP,
    pagina_acessada VARCHAR(255)
);

INSERT INTO log_acesso (usuario, data_acesso, pagina_acessada) VALUES
('joao.silva', '2025-04-01 10:00:00', '/dashboard'),
('maria.santos', '2025-04-15 11:30:00', '/profile'),
('carlos.almeida', '2025-04-20 14:45:00', '/settings'),
('joao.silva', '2025-05-01 09:15:00', '/reports'),
('ana.souza', '2025-05-10 16:00:00', '/products'),
('maria.santos', '2025-05-20 17:00:00', '/dashboard');

-- Corrected DELIMITER placement
DELIMITER $$

CREATE EVENT evento_limpeza_logs_diaria
ON SCHEDULE EVERY 1 DAY
STARTS '2025-05-24 00:00:00'
DO
    DELETE FROM log_acesso WHERE data_acesso < NOW() - INTERVAL 30 DAY;
$$ -- DELIMITER for the event creation

---

-- 2º
CREATE TABLE vendas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produto VARCHAR(100) NOT NULL,
    valor_venda DECIMAL(10, 2) NOT NULL,
    data_venda DATETIME DEFAULT CURRENT_TIMESTAMP,
    quantidade INT NOT NULL
);

CREATE TABLE relatorios_gerados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_relatorio VARCHAR(100) NOT NULL,
    data_geracao DATETIME DEFAULT CURRENT_TIMESTAMP,
    conteudo_relatorio JSON
);

INSERT INTO vendas (produto, valor_venda, data_venda, quantidade) VALUES
('Smartphone X', 1500.00, '2025-05-15 10:00:00', 1),
('Fone de ouvido Y', 250.00, '2025-05-16 11:00:00', 2),
('Notebook Z', 3000.00, '2025-05-18 14:00:00', 1),
('Webcam A', 150.00, '2025-05-20 09:00:00', 3),
('Mouse B', 80.00, '2025-05-22 16:00:00', 5);

CREATE PROCEDURE gerar_relatorio_vendas_semanal()
BEGIN
    INSERT INTO relatorios_gerados (tipo_relatorio, data_geracao, conteudo_relatorio)
    SELECT 'Vendas Semanais', NOW(), JSON_OBJECT('total_vendas', SUM(valor_venda), 'periodo', 'ultima_semana')
    FROM vendas
    WHERE data_venda >= CURDATE() - INTERVAL 7 DAY;
END$$

CREATE EVENT evento_relatorio_vendas_semanal
ON SCHEDULE EVERY 1 WEEK
STARTS '2025-05-26 08:00:00'
DO
    CALL gerar_relatorio_vendas_semanal();
$$

---

-- 3º
CREATE TABLE pedidos (
    id_pedido INT PRIMARY KEY,
    cliente_id INT NOT NULL,
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) NOT NULL DEFAULT 'pendente',
    valor_total DECIMAL(10, 2)
);

INSERT INTO pedidos (id_pedido, cliente_id, data_pedido, status, valor_total) VALUES
(123, 101, '2025-05-20 10:00:00', 'pendente', 1200.50),
(124, 102, '2025-05-21 14:30:00', 'processando', 850.00),
(125, 101, '2025-05-22 09:00:00', 'enviado', 300.75);

CREATE EVENT evento_atualizar_pedido_123
ON SCHEDULE AT '2025-06-15 10:30:00'
ON COMPLETION NOT PRESERVE
DO
    UPDATE pedidos SET status = 'processado' WHERE id_pedido = 123;
$$ -- Added DELIMITER for this event

---

-- 4º
CREATE TABLE transacoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_transacao VARCHAR(50) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    data_transacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    descricao VARCHAR(255)
);

CREATE TABLE transacoes_arquivadas (
    id INT PRIMARY KEY,
    tipo_transacao VARCHAR(50) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    data_transacao DATETIME,
    descricao VARCHAR(255)
);

INSERT INTO transacoes (tipo_transacao, valor, data_transacao, descricao) VALUES
('compra', 50.00, '2025-02-01 08:00:00', 'Café da manhã'),
('venda', 150.00, '2025-02-10 10:00:00', 'Venda de produto A'),
('pagamento', 200.00, '2025-03-05 14:00:00', 'Pagamento de conta'),
('compra', 75.00, '2025-04-15 11:00:00', 'Almoço'),
('venda', 300.00, '2025-05-01 16:00:00', 'Venda de produto B'),
('recebimento', 100.00, '2025-05-20 09:00:00', 'Recebimento de cliente');

CREATE EVENT evento_arquivamento_mensal
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-06-01 01:00:00'
ENDS '2025-12-01 01:00:00'
DO
BEGIN
    INSERT INTO transacoes_arquivadas SELECT * FROM transacoes WHERE data_transacao < CURDATE() - INTERVAL 3 MONTH;
    DELETE FROM transacoes WHERE data_transacao < CURDATE() - INTERVAL 3 MONTH;
END$$

DELIMITER ; -- Reset DELIMITER at the end
