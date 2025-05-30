									-- Pesquisa Banco de Dados(Comandos DDL)

/*	Os comandos DDL (Data Definition Language) são um subconjunto de comandos SQL usados para definir e gerenciar estruturas de banco de dados, como tabelas, 
índices, esquemas e outros objetos. Eles não lidam diretamente com os dados armazenados nas tabelas, mas sim com a definição e modificação da estrutura do banco de dados, ou seja, 
criar, alterar e excluir objetos do banco, como tabelas, colunas e até mesmo o banco de dados em si.

Os comandos DDL são os seguintes:

1 - CREATE
2 - ALTER
3 - DROP
4 - RENAME
5 - TRUNCATE
6 - COMMENT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
1 - CREATE
Este comando permite criar um objeto no banco, como uma nova tabela, visão, índice ou outro elemento estrutural.
$$Exp:
*Criar uma tabela:
CREATE TABLE clientes (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    idade INT
);

2 - ALTER
Com a declaração ALTER podemos adicionar, modificar ou excluir colunas em uma tabela. Também é possível alterar outros objetos do banco de dados, como procedimentos armazenados.
$$Exp:
*Adicionar uma coluna:
	ALTER TABLE clientes ADD endereco VARCHAR(255);
*Modificar o tipo de dado de uma coluna:
	ALTER TABLE clientes MODIFY idade SMALLINT;
*Renomear uma tabela:
	ALTER TABLE clientes RENAME TO clientes_novo;


3 - DROP
O comando DROP permite excluir objetos do banco de dados (lida com a estrutura ou esquema, não com os registros).
$$Exp:
*Excluir uma tabela:
	DROP TABLE clientes;
*Excluir um índice:
	DROP INDEX idx_nome;

4 - RENAME
O comando RENAME é usado para renomear um objeto, como uma tabela ou uma coluna.
$$Exp:
*Renomear uma tabela:
	RENAME TABLE clientes TO clientes_novo;

5 - TRUNCATE
Permite excluir todas as linhas de uma tabela (todos os registros), sem no entanto excluir a tabela em si.
$$Exp:
*Adicionar uma coluna:
	ALTER TABLE clientes ADD endereco VARCHAR(255);
*Renomear uma tabela:
	ALTER TABLE clientes RENAME TO clientes_novo;

6 - COMMENT
O comando COMMENT é utilizado para adicionar um comentário a um objeto do banco de dados, como uma tabela ou coluna, para documentar seu uso ou fornecer informações adicionais.
$$Exp:
*Adicionar um comentário a uma tabela:
	COMMENT ON TABLE clientes IS 'Tabela que armazena informações dos clientes';
*/

-------------------------------------------------------------------------------------------------------------------
                        -- Exemplo prático do uso de DDL
-- criar databse
create database db_exemplos;
use db_exemplos;

-- *Criar uma tabela:
CREATE TABLE clientes (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    idade INT
);

-- Adicionar uma nova coluna
ALTER TABLE clientes ADD endereco VARCHAR(255);

-- Modificar o tipo de dado de uma coluna
ALTER TABLE clientes MODIFY idade SMALLINT;

-- Excluir todos os dados de uma tabela
TRUNCATE TABLE clientes;

-- Excluir a tabela completamente
DROP TABLE clientes;

---------------------------------------------------------------------------------------------------------

                                     -- Especificação sobre o ALTER
/*O comando ALTER é um dos comandos DDL (Data Definition Language) em SQL e é utilizado para modificar a estrutura de um objeto de banco de 
dados já existente, como tabelas, colunas e restrições. Através do ALTER, é possível fazer várias alterações na definição do banco de dados
 sem precisar recriar o objeto ou perder dados.

&ALTER ADD
O ADD é usado para adicionar novos elementos, como colunas, restrições ou índices a uma tabela existente.

& ALTER DROP
O DROP é usado para remover colunas, restrições, índices ou outras estruturas de uma tabela existente. Esse comando remove permanentemente o elemento da tabela.

&ALTER MODIFY
O comando MODIFY permite alterar as características de uma coluna existente, como seu tipo de dado, o tamanho ou outras propriedades. Ele é utilizado quando é necessário modificar a definição de uma coluna.

&ALTER RENAME TO
O comando RENAME TO é usado para renomear uma tabela ou coluna. Isso não altera o conteúdo, mas apenas o nome do objeto.
*/
-------------------------------------------------------------------------------------------------------------

              -- Exemplo:
-- Criar a tabela
CREATE TABLE produtos (
    id_produto INT PRIMARY KEY,
    nome_produto VARCHAR(100),
    preco DECIMAL(10, 2)
);

-- Adicionar novas colunas
ALTER TABLE produtos ADD estoque INT;
ALTER TABLE produtos ADD categoria VARCHAR(50);

-- Remover as colunas adicionadas
ALTER TABLE produtos DROP COLUMN categoria;
ALTER TABLE produtos DROP COLUMN estoque;

-- Modificar as colunas existentes
ALTER TABLE produtos MODIFY COLUMN preco DECIMAL(12, 4);
ALTER TABLE produtos MODIFY COLUMN nome_produto VARCHAR(200);

-- Renomear a tabela
ALTER TABLE produtos RENAME TO bens;

-- Renomear uma coluna
ALTER TABLE itens change COLUMN nome_produto descricao_produto VARCHAR(100);


