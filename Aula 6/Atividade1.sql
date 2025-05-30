-- Criar as Procedures para :

-- a)  receber dois Números e mostrar o produto deles.
            delimiter // 
			create procedure sp_produto(in num1 int, in num2 int)
            begin
				declare res int;
				set res = num1 * num2;
				select res;
			end //
			delimiter ;
            
            call sp_produto(2, 5);

                 
          
-- b) Receber dois  Números inteiros e mostrar em ordem     decrescente
			delimiter  //
			create procedure SP_ordenar(in num1 int, in num2 int)
            begin
				if(num1 > num2) then
					select num1, num2;
				else
					select num2, num1; 
			end if;
			end //
            delimiter ;
            
            call SP_ordenar(2, 5);
            
            
             
-- c)Receber três   Números  inteiros e mostrar em ordem     crescente
		delimiter  //
					create procedure SP_ordenar2(in a int, in b int, in c int)
					begin
						if a > b then
							set @novo = a;
                            set a = b;
                            set b = @novo;
						end if;
						if a > c then
							set @novo = a;
                            set a = c;
                            set c = @novo;
						end if;
                        if b > c then
							set @novo = b;
                            set b = c;
                            set c = @novo;
						end if;
						select a, b, c;
				end //
			delimiter ;
			
            call SP_ordenar2(2, 5, 9);
            

-- d) Receber um Nº Inteiro menor  que 100 e mostrar os seus divisores. (NOTA: % retorna o resto de uma divisão inteira   6 % 2 --> 0
	delimiter //
		create procedure sp_atvd(in a int)
		begin
			declare i int;
			
			if a < 100  then 
				set i = 1;
				while i <= a do
					if a % i = 0 then
						select i as 'Divisor';
					end if;
					set i = i + 1;
				end while;
            else
				select 'Numero invalido';
			end if;
	end //
	delimiter ;
    
    call sp_atvd(9);


--  e) Criar o banco de dados com o Nome Bd_Teste
		create database Bd_teste;

		use Bd_teste;
                  
/*
f) Criar a tabela abaixo  no Banco de Dados Bd_Teste
      Tabela de Funcionarios : (Nome = Tb_Funcionario )
       
           Campos       
       codfunc smallint primary key not null,
       nomsalariofunc smallmoney not null,
       CodDeptosmallintefunc varchar(30) not null,
         
*/            

	create table Tb_Funcionario(
		codfunc smallint primary key not null,
		nomefunc varchar(30) not null,
		salariofunc decimal(10,2)  not null,
		CodDepto smallint
		);


/*
g) Criar a tabela abaixo  no Banco de Dados Bd_Teste
   Tabela de Funcionarios : (Nome = Tb_Morto )
            
             Campos
   codfunc smallint primary key not null,
   nomefunc varchar(30) not null,
   salariofunc smallmoney not null,
   CodDepto smallint 
   DataDemissao   date  -- obs. data atual (sistema)

*/
	create table Tb_Morto(
		codfunc smallint primary key not null,
		nomefunc varchar(30) not null,
		salariofunc decimal(10, 2) not null,
		CodDepto smallint,
		DataDemissao   date  -- obs. data atual (sistema)
   );


/*
h) Criar a tabela abaixo  no Banco de Dados Bd_Teste
            Tabela de Depto : (Nome = Tb_Depto )

                       campos 
                Coddep  smallint primary key not null,
                nomedep varchar(30) not null,
*/
	create table tb_depto(
		Coddep  smallint primary key not null,
		nomedep varchar(30) not null
	);

-- i) Fazer inclusão de dados na tabela d  Depto      
	insert into tb_depto(coddep, nomedep) values 
    (122, "RG"),
	(356, "diretor"),
	(555, "programador");

-- j)  Fazer inclusão de dados na tabela Funcionários.
	insert into Tb_Funcionario (codfunc, nomefunc, salariofunc, coddepto) values
	(1, 'Ana', 3200.50, 10),
	(2, 'Albert', 4500.00, 20),
	(3, 'Dandara', 3900.75, 10),
	(4, 'Rayssa', 2800.00, 30),
	(5, 'Pedro', 5100.25, 20);

 -- k) Fazer a  consulta de todos os dados do funcionário, passando como parâmetro o código do   funcionário.
	delimiter //
		create procedure sp_consulta(in cod int)
        begin 
        select  * from Tb_Funcionario where codfunc = cod;
        end //
	delimiter ;
    
    call sp_consulta(2);
    
  
-- l)  Fazer a alteração dos dados  do funcionário, passando como parâmetro o código do funcionário.
	delimiter //
		create procedure sp_alterDados(in cod int)
		begin
			update tb_funcionario
			set 
				nomefunc = 'josé',
				salariofunc = 9999.99,
				coddepto = 555
			where codfunc = cod;
		end //
	delimiter ;
    
    select * from tb_funcionario where codfunc = 1;

	call sp_alterDados(1);
    
    select * from tb_funcionario where codfunc = 1;


-- m) Fazer a exclusão de um registro, passando como como parâmetro o código do funcionário.
	delimiter //
		create procedure sp_exclui(in cod int)
        begin
			delete from tb_funcionario where codfunc = cod;
		end //
	delimiter ;
	
    select * from tb_funcionario;
    
    call sp_exclui(2);

	select * from tb_funcionario;

-- n) Fazer a consulta selecionando o código, nome e salário dos funcionários, passando como parâmetro o  código do funcionário 
	delimiter //
		create procedure sp_consulta2(in cod int)
        begin
			select nomefunc,salariofunc,codDepto from tb_funcionario where codfunc = cod;
		end //
	delimiter ;
    
    call sp_consulta2(3);

-- o) Fazer a consulta de todos os registros e  dados do funcionário, listando em ordem crescente de nome
	delimiter //
		create procedure sp_consulta3()
        begin
			select * from tb_funcionario order by nomefunc asc;
		end //
	delimiter ;
    
    call sp_consulta3();

-- p) Retornar a quantidade de funcionários cadastrado por depto.
	delimiter //
		create procedure sp_quant()
        begin
			select CodDepto, count(*) as 'Quantidade de Func'
			from tb_funcionario
			group by CodDepto
			order by CodDepto;
		end //
	delimiter ;
    
    call sp_quant();
    
    insert into Tb_Funcionario (codfunc, nomefunc, salariofunc, coddepto) values (7, 'Mateus', 3500, 10);
    
    select * from tb_funcionario;


-- q) Retornar  total de salário dos funcionários
	delimiter //
		create procedure sp_totalSal()
        begin
			select sum(salariofunc) as 'Total do Salario'
            from tb_funcionario;
		end //
	delimiter ;
    
    call sp_totalSal();

-- r) Retornar o total de salário dos funcionários agrupapos por depto.
	delimiter //
    create procedure sp_total()
		begin 
        select CodDepto, sum(salariofunc) as 'Total do Salario' 
        from tb_funcionario
        group by CodDepto;
        end //
	delimiter ;
    
    call sp_total();


-- s) Retornar  o código do depto, a quantidade de funcionário e o total de salário por depto
	delimiter //
		create procedure sp_atvs()
        begin
        select CodDepto, count(*) as 'Total de Funcionarios', sum(salariofunc) as 'Total do Salario'
        from tb_funcionario
        group by CodDepto;
        end //
	delimiter ;
    
    call sp_atvs();

-- t) Para aumentar o salário dos funcionários em x% , passando como parâmetro o valor da porcentagem   
	delimiter //
		create procedure sp_reajuste(in porc decimal(5,2))
        begin
        select nomefunc as 'Funcionario', salariofunc as 'Salario Antes', (salariofunc * (1 + porc)) as 'Salario Depois' from tb_funcionario;
        end //
	delimiter ;
	
    call sp_reajuste(0.10);
        
                     
-- u) Para excluir um funcionário passando como parâmetro o código do func. e fazer uma cópia do seu registro na tabela do arquivo morto. 
	delimiter //
		create procedure sp_exclui2(in cod int)
		begin
		insert into tb_morto (codfunc, nomefunc, salariofunc, CodDepto, DataDemissao)
		select codfunc, nomefunc, salariofunc, CodDepto, current_date() 
		from tb_funcionario
		where codfunc = cod;
		delete from tb_funcionario
		where codfunc = cod;
		end //
    delimiter ;
    
    select * from tb_funcionario;
    
    call sp_exclui2(1);

	select * from tb_funcionario;
    
    select * from tb_morto;
    
-- v) Receber um CPF completo e retornar a mensagem 'CPF VÁLIDO' ou  'CPF INVÁLIDO'. - NOTA ALGORIRITMO ESTÁ NO ARQUIVO ANEXO
	delimiter //
			create procedure sp_validaCPF(in cpf decimal(11))
			begin
				DECLARE i INT;
				DECLARE soma INT;
				DECLARE resto INT;
				DECLARE dig1 INT;
				DECLARE dig2 INT;
				DECLARE cpf_temp BIGINT;
			
				if cpf < 10000000000 OR cpf > 99999999999 THEN
					select 'CPF INVÁLIDO' AS Resultado;
				else 
	
					set soma = 0;
					set cpf_temp = cpf DIV 100;
					set i = 2; 
					while i <= 10 do
						set soma = soma + (cpf_temp MOD 10) * i;
						set cpf_temp = cpf_temp DIV 10; 
						set i = i + 1;
					end while;
					
					set resto = soma % 11;
					if resto < 2 THEN
						set dig1 = 0;
					else
						set dig1 = 11 - resto;
					end if;
					
					set soma = dig1 * 2;
					set cpf_temp = cpf DIV 100;
					set i = 3; 
					while i <= 11 do
						set soma = soma + (cpf_temp MOD 10) * i;
						set cpf_temp = cpf_temp DIV 10;
						set i = i + 1;
					end while;
					
					set resto = soma % 11;
					if resto < 2 THEN
						set dig2 = 0;
					else
						set dig2 = 11 - resto;
					end if;
					
					if dig1 = (cpf DIV 10) MOD 10 AND dig2 = cpf MOD 10 THEN
						select 'CPF VÁLIDO' AS Resultado;
					else
						select 'CPF INVÁLIDO' AS Resultado;
					end if;
				end if;
			end //
	delimiter ;
    
    call sp_validaCPF(79745307408); -- válido
    
    call sp_validaCPF(78381152192); -- inválido
