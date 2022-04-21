CREATE DATABASE uvv
     WITH 
     OWNER = marialuiza
     ENCODING = 'UTF8'
     template = template0
     LC_COLLATE = 'pt_BR.UTF-8'
     LC_CTYPE = 'pt_BR.UTF-8'
   	 ALLOW_CONNECTIONS = true;
   	
\c uvv;

CREATE SCHEMA IF NOT EXISTS elmasri
     AUTHORIZATION marialuiza;

set search_path to elmasri, "\$user", public;


CREATE TABLE IF NOT EXISTS elmasri.departamento(
    numero_departamento integer NOT NULL,
    nome_departamento character varying(15) COLLATE pg_catalog."default" NOT NULL,
    cpf_gerente character(11) COLLATE pg_catalog."default" NOT NULL,
    data_inicio_gerente date NOT NULL,
    CONSTRAINT departamento_pkey PRIMARY KEY (numero_departamento),
    CONSTRAINT departamento_nome_departamento_key UNIQUE (nome_departamento)
);

ALTER TABLE IF EXISTS elmasri.departamento
    OWNER to marialuiza;
   
CREATE INDEX IF NOT EXISTS funcionario_departamento_fk
    ON elmasri.departamento USING btree
    (cpf_gerente COLLATE pg_catalog."default" ASC NULLS LAST);

insert into elmasri.departamento (nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente) values (
     'Pesquisa', '5', '33344555587', '1988-05-22'),
     ('Administração', '4', '98765432168', '1995-01-01'),
     ('Matriz', '1', '88866555576', '1981-06-19');
    
ALTER TABLE elmasri.departamento COMMENT 'Tabela que armazena as informaçoẽs dos departamentos.';

ALTER TABLE elmasri.departamento MODIFY COLUMN numero_departamento INTEGER COMMENT 'Número do departamento. É a PK desta tabela.';

ALTER TABLE elmasri.departamento MODIFY COLUMN nome_departamento VARCHAR(15) COMMENT 'Nome do departamento. Deve ser único.';

ALTER TABLE elmasri.departamento MODIFY COLUMN cpf_gerente CHAR(11) COMMENT 'É uma FK para a tabela funcionários.';

ALTER TABLE elmasri.departamento MODIFY COLUMN data_inicio_gerente DATE COMMENT 'Data do início do gerente no departamento.';


CREATE TABLE IF NOT EXISTS elmasri.dependente(
    cpf_funcionario character(11) COLLATE pg_catalog."default" NOT NULL,
    nome_dependente character varying(15) COLLATE pg_catalog."default" NOT NULL,
    sexo character(1) COLLATE pg_catalog."default",
    data_nascimento date,
    parentesco character varying(15) COLLATE pg_catalog."default",
    CONSTRAINT dependente_pkey PRIMARY KEY (cpf_funcionario, nome_dependente)
);

ALTER TABLE IF EXISTS elmasri.dependente
    OWNER to marialuiza;

CREATE INDEX IF NOT EXISTS funcionario_dependente_fk
    ON elmasri.dependente USING btree
    (cpf_funcionario COLLATE pg_catalog."default" ASC NULLS LAST);

insert into elmasri.dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco) values (
     '33344555587', 'Alicia', 'F', '1986-04-05', 'Filha'),
     ('33344555587', 'Tiago', 'M', '1983-10-25', 'Filho'),
     ('33344555587', 'Janaina', 'F', '1958-05-03', 'Esposa'),
     ('98765432168', 'Antonio', 'M', '1942-02-28', 'Marido'),
     ('12345678966', 'Michael', 'M', '1988-01-04', 'Filho'),
     ('12345678966', 'Alicia', 'F', '1988-12-30', 'Filha'), 
     ('12345678966', 'Elizabeth', 'F', '1967-05-05', 'Esposa');
    
ALTER TABLE elmasri.dependente COMMENT 'Tabela que armazena as informações dos dependentes dos funcionários.';

ALTER TABLE elmasri.dependente MODIFY COLUMN cpf_funcionario CHAR(11) COMMENT 'Faz parte da PK desta tabela e é a FK para a tabela funcionário.';

ALTER TABLE elmasri.dependente MODIFY COLUMN nome_dependente VARCHAR(15) COMMENT 'Nome do dependente. Faz parte da PK desta tabela.';

ALTER TABLE elmasri.dependente MODIFY COLUMN sexo CHAR(1) COMMENT 'Sexo do dependente.';

ALTER TABLE elmasri.dependente MODIFY COLUMN data_nascimento DATE COMMENT 'Data de nascimento do dependente.';

ALTER TABLE elmasri.dependente MODIFY COLUMN parentesco VARCHAR(15) COMMENT 'Descrição do parentesco do dependente com o funcionário.';

   
CREATE TABLE IF NOT EXISTS elmasri.funcionario(
    cpf character(11) COLLATE pg_catalog."default" NOT NULL,
    primeiro_nome character varying(15) COLLATE pg_catalog."default" NOT NULL,
    nome_meio character(1) COLLATE pg_catalog."default",
    ultimo_nome character varying(15) COLLATE pg_catalog."default" NOT NULL,
    data_nascimento date,
    endereco character varying(40) COLLATE pg_catalog."default",
    sexo character(1) COLLATE pg_catalog."default",
    salario numeric(10,2),
    cpf_supervisor character(11) COLLATE pg_catalog."default" NOT NULL,
    numero_departamento integer NOT NULL,
    CONSTRAINT funcionario_pkey PRIMARY KEY (cpf)
);

ALTER TABLE IF EXISTS elmasri.funcionario
    OWNER to marialuiza;

CREATE INDEX IF NOT EXISTS fki_cpf_supervisor_fk
    ON elmasri.funcionario USING btree
    (cpf_supervisor COLLATE pg_catalog."default" ASC NULLS LAST);

insert into elmasri.funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento) values (
     'João', 'B', 'Silva', '12345678966', '1965-01-09', 'Rua das Flores, 751, São Paulo, SP','M','30000', '33344555587', '5'),
     ('Fernando', 'T', 'Wong', '33344555587', '1955-12-08', 'Rua da Lapa, 34, São Paulo, SP', 'M','40000','33344555587', '5'),
     ('Alice', 'J', 'Zelaya', '99988777767', '1968-01-19', 'Rua Souza Lima, 35, Curitiba, PR', 'F', '25000', '98765432168', '4'),
     ('Jennifer', 'S', 'Souza', '98765432168', '1941-06-20', 'Av.Arthur de Lima, 54, Santo André, SP', 'F', '43000', '98765432168', '4'),
     ('Ronaldo', 'K', 'Lima', '66688444476', '1962-09-15', 'Rua Rebouças, 65, Piracicaba, SP', 'M', '38000', '33344555587', '5'),
     ('Joice', 'A', 'Leite', '45345345376', '1972-07-31', 'Av.Lucas Obes, 74, São Paulo, SP', 'F', '25000', '33344555587', '5'),
     ('André', 'V', 'Pereira', '98798798733', '1969-03-29', 'Rua Timbira, 35, São Paulo, SP', 'M', '25000', '98765432168', '4'),
     ('Jorge', 'E', 'Brito', '88866555576', '1937-11-10', 'Rua do Horto, 35, São Paulo, SP', 'M', '55000', '88866555576', '1');

ALTER TABLE elmasri.funcionario COMMENT 'Tabela que armazena as informações dos funcionários.';

ALTER TABLE elmasri.funcionario MODIFY COLUMN cpf CHAR(11) COMMENT 'CPF do funcionário. Será a PK da tabela.';

ALTER TABLE elmasri.funcionario MODIFY COLUMN primeiro_nome VARCHAR(15) COMMENT 'Primeiro nome do funcionário.';

ALTER TABLE elmasri.funcionario MODIFY COLUMN nome_meio CHAR(1) COMMENT 'Inicial do nome do meio.';

ALTER TABLE elmasri.funcionario MODIFY COLUMN ultimo_nome VARCHAR(15) COMMENT 'Sobrenome do funcionário.';

ALTER TABLE elmasri.funcionario MODIFY COLUMN endereco VARCHAR(40) COMMENT 'Endereço do funcionário.';

ALTER TABLE elmasri.funcionario MODIFY COLUMN sexo CHAR(1) COMMENT 'Sexo do funcionário.';

ALTER TABLE elmasri.funcionario MODIFY COLUMN salario DECIMAL(10, 2) COMMENT 'Salário do funcionário.';    

ALTER TABLE elmasri.funcionario MODIFY COLUMN cpf_supervisor CHAR(11) COMMENT 'Será uma FK para a própria tabela (um auto-relacionamento).';

ALTER TABLE elmasri.funcionario MODIFY COLUMN numero_departamento INTEGER COMMENT 'Número do departamento do funcionário.';

    
CREATE TABLE IF NOT EXISTS elmasri.localizacoes_departamento(
    numero_departamento integer NOT NULL,
    local character varying(15) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT localizacoes_departamento_pkey PRIMARY KEY (numero_departamento, local)
);

ALTER TABLE IF EXISTS elmasri.localizacoes_departamento
    OWNER to marialuiza;

CREATE INDEX IF NOT EXISTS departamento_localizacoes_departamento_fk
    ON elmasri.localizacoes_departamento USING btree
    (numero_departamento ASC NULLS last);
   
insert into elmasri.localizacoes_departamento (numero_departamento, local) values (
     '1', 'São Paulo'),
     ('4', 'Mauá'),
     ('5', 'Santo André'),
     ('5', 'Itu'),
     ('5', 'São Paulo');
    
ALTER TABLE elmasri.localizacoes_departamento COMMENT 'Tabela que armazena as possíveis localizações dos departamentos.';

ALTER TABLE elmasri.localizacoes_departamento MODIFY COLUMN numero_departamento INTEGER COMMENT 'Faz parte da PK desta tabela e é uma FK para a tabela departamento.';

ALTER TABLE elmasri.localizacoes_departamento MODIFY COLUMN local VARCHAR(15) COMMENT 'Localização do departamento. Faz parte da PK desta tabela.';
   
CREATE TABLE IF NOT EXISTS elmasri.projeto(
    numero_projeto integer NOT NULL,
    nome_projeto character varying(15) COLLATE pg_catalog."default" NOT NULL,
    local_projeto character varying(15) COLLATE pg_catalog."default" NOT NULL,
    numero_departamento integer NOT NULL,
    CONSTRAINT projeto_pkey PRIMARY KEY (numero_projeto),
    CONSTRAINT projeto_nome_projeto_key UNIQUE (nome_projeto)
);

ALTER TABLE IF EXISTS elmasri.projeto
    OWNER to marialuiza;
   
CREATE INDEX IF NOT EXISTS departamento_projeto_fk
    ON elmasri.projeto USING btree
    (numero_departamento ASC NULLS LAST);
   
insert into elmasri.projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento) values (
     'ProdutoX', '1', 'Santo André', '5'),
     ('ProdutoY', '2', 'Itu', '5'),
     ('ProdutoZ', '3', 'São Paulo', '1'),
     ('Informação', '10', 'Mauá', '4'),
     ('Reorganização', '20', 'São Paulo', '1'),
     ('Novosbeneficios','30', 'Mauá', '4');
    
ALTER TABLE elmasri.projeto COMMENT 'Tabela que armazena as informações sobre os projetos dos departamentos.';

ALTER TABLE elmasri.projeto MODIFY COLUMN numero_projeto INTEGER COMMENT 'Número do projeto. É a PK desta tabela.';

ALTER TABLE elmasri.projeto MODIFY COLUMN nome_projeto VARCHAR(15) COMMENT 'Nome do projeto. Deve ser único.';

ALTER TABLE elmasri.projeto MODIFY COLUMN local_projeto VARCHAR(15) COMMENT 'Localização do projeto.';

ALTER TABLE elmasri.projeto MODIFY COLUMN numero_departamento INTEGER COMMENT 'Número do departamento. É uma FK para a tabela departamento.';
   

CREATE TABLE IF NOT EXISTS elmasri.trabalha_em(
    cpf_funcionario character(11) COLLATE pg_catalog."default" NOT NULL,
    numero_projeto integer NOT NULL,
    horas numeric(3,1) NOT NULL,
    CONSTRAINT trabalha_em_pkey PRIMARY KEY (cpf_funcionario, numero_projeto)
);
   
ALTER TABLE IF EXISTS elmasri.trabalha_em
    OWNER to marialuiza;
   
CREATE INDEX IF NOT EXISTS funcionario_trabalha_em_fk
    ON elmasri.trabalha_em USING btree
    (cpf_funcionario COLLATE pg_catalog."default" ASC NULLS LAST);
   
CREATE INDEX IF NOT EXISTS projeto_trabalha_em_fk
    ON elmasri.trabalha_em USING btree
    (numero_projeto ASC NULLS LAST);
   
insert into elmasri.trabalha_em (cpf_funcionario, numero_projeto, horas) values (
     '12345678966', '1', '32.5'),
     ('12345678966', '2', '7.5'),
     ('66688444476', '3', '40'),
     ('45345345376', '1', '20'),
     ('45345345376', '2', '20'),
     ('33344555587', '2', '10'),
     ('33344555587', '3', '10'),
     ('33344555587', '10', '10'),
     ('33344555587', '20', '10'),
     ('99988777767', '30', '30'),
     ('99988777767', '10', '10'),
     ('98798798733', '10', '35'),
     ('98798798733', '30', '5'),
     ('98765432168', '30', '20'),
     ('98765432168', '20', '15'),
     ('88866555576', '20', '0');
    
ALTER TABLE elmasri.trabalha_em COMMENT 'Tabela para armazenar quais funcionários trabalham em quais projetos.';

ALTER TABLE elmasri.trabalha_em MODIFY COLUMN cpf_funcionario CHAR(11) COMMENT 'Faz parte da PK desta tabela e é a FK para tabela funcionário.';

ALTER TABLE elmasri.trabalha_em MODIFY COLUMN numero_projeto INTEGER COMMENT 'Faz parte da PK desta tabela e é a FK para tabela projeto.';

ALTER TABLE elmasri.trabalha_em MODIFY COLUMN horas DECIMAL(3, 1) COMMENT 'Horas trabalhadas pelo funcionário neste projeto.';
   

ALTER TABLE elmasri.departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES elmasri.projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;  

alter table elmasri.dependente add constraint sexo_dependente check (sexo in ('F','M'));

alter table elmasri.funcionario add constraint sexo_funcionario check (sexo in ('F','M'));

alter table elmasri.funcionario add constraint salario_funcionario check (salario between '1212' and '70000');

alter table elmasri.trabalha_em add constraint horas_trabalhadas check (horas between '0' and '48');

alter table elmasri.funcionario add constraint numero_departamento check (numero_departamento between '1' and '10');

alter table elmasri.departamento add constraint numero_departamento_localizacoes_departamento check (numero_departamento between '1' and '10');

alter table elmasri.projeto add constraint numero_departamento_projeto check (numero_departamento between '1' and '10');

alter table elmasri.localizacoes_departamento add constraint numero_departamento_localizacoes_departamento check (numero_departamento between '1' and '10');


