
-- QUESTÃO DE NÚMERO 1:

SELECT numero_departamento, AVG(salario) AS media_por_departamento
FROM funcionario
WHERE numero_departamento = 5 OR numero_departamento = 4 OR numero_departamento =1
GROUP BY numero_departamento;

-- QUESTÃO DE NÚMERO 2:

SELECT AVG(salario) AS media_salarial, sexo
FROM funcionario 
WHERE sexo = 'F'
UNION 
SELECT AVG(salario) as media_salarial, sexo
FROM funcionario 
WHERE sexo = 'M';

-- QUESTÃO DE NÚMERO 3:

ALTER TABLE funcionario ADD COLUMN idade int;

SELECT datediff ('2022-05-02','1965-01-09')/365 AS 'idade do João';
UPDATE funcionario set idade = 57 WHERE primeiro_nome = 'João';

SELECT datediff ('2022-05-02','1955-12-08')/365 AS 'idade do fernando';
UPDATE funcionario set idade = 66 WHERE primeiro_nome = 'Fernando';

SELECT datediff ('2022-05-02','1968-01-19')/365 AS 'idade da Alice';
UPDATE funcionario set idade = 54 WHERE primeiro_nome = 'Alice';

SELECT datediff ('2022-05-02','1962-09-15')/365 AS 'idade do Ronaldo';
UPDATE funcionario set idade = 59 WHERE primeiro_nome = 'Ronaldo';

SELECT datediff ('2022-05-02','1972-07-31')/365 AS 'idade da Joice';
UPDATE funcionario set idade = 49 WHERE primeiro_nome = 'Joice';

SELECT datediff ('2022-05-02','1969-03-29')/365 AS 'idade do André';
UPDATE funcionario set idade = 53 WHERE primeiro_nome = 'André';

SELECT datediff ('2022-05-02','1937-11-10')/365 AS 'idade do Jorge';
UPDATE funcionario set idade = 84 WHERE primeiro_nome = 'Jorge';

SELECT  datediff ('2022-05-02','1941-06-20')/365 AS 'idade da Jennifer';
UPDATE funcionario set idade = 80 WHERE primeiro_nome = 'Jennifer';

SELECT departamento.nome_departamento, CONCAT(funcionario.primeiro_nome," ", funcionario.nome_meio,".", funcionario.ultimo_nome) AS nome_completo, funcionario.data_nascimento, funcionario.idade, funcionario.salario
FROM departamento 
INNER JOIN funcionario ON departamento.numero_departamento = funcionario.numero_departamento;

-- QUESTÃO DE NÚMERO 4:

SELECT CONCAT(funcionario.primeiro_nome, " ", funcionario.nome_meio, ".", funcionario.ultimo_nome) AS nome_funcionario, funcionario.idade, salario as salario_atual, salario * 1.20 as salario_aumento 
from funcionario 
where salario < 35000 
UNION 
SELECT CONCAT(funcionario.primeiro_nome, " ", funcionario.nome_meio, ".", funcionario.ultimo_nome), funcionario.idade, salario as salario_atual, salario * 1.15 as salario_aumento 
from funcionario 
where salario >= 35000;

-- QUESTÃO DE NÚMERO 5:

WITH gerente AS (SELECT fun.primeiro_nome AS nome_gerente,fun.cpf 
FROM funcionario fun)
SELECT dp.nome_departamento,concat(fun.primeiro_nome, " ", fun.nome_meio, ".", fun.ultimo_nome) AS nome_completo_funcionario,
g.nome_gerente
FROM departamento dp
INNER JOIN gerente g ON g.cpf = dp.cpf_gerente
INNER JOIN funcionario AS fun ON fun.numero_departamento = dp.numero_departamento
ORDER BY fun.salario DESC, dp.nome_departamento ASC;

-- QUESTÃO DE NÚMERO 6:

ALTER TABLE dependente ADD COLUMN idade_dependente int;

SELECT datediff ('2022-05-02','1986-04-05')/365 AS 'idade da Alicia';
UPDATE dependente set idade_dependente = 36 WHERE nome_dependente = 'Alicia';

SELECT datediff ('2022-05-02','1983-10-25')/365 AS 'idade do Tiago';
UPDATE dependente set idade_dependente = 38 WHERE nome_dependente = 'Tiago';

SELECT datediff ('2022-05-02','1958-05-03')/365 AS 'idade da Janaina';
UPDATE dependente set idade_dependente = 64 WHERE nome_dependente = 'Janaina';

SELECT datediff ('2022-05-02','1942-02-28')/365 AS 'idade do Antonio';
UPDATE dependente set idade_dependente = 80 WHERE nome_dependente = 'Antonio';

SELECT datediff ('2022-05-02','1988-01-04')/365 AS 'idade do Michael';
UPDATE dependente set idade_dependente = 34 WHERE nome_dependente = 'Michael';

SELECT datediff ('2022-05-02','1988-12-30')/365 AS 'idade da Alicia';
UPDATE dependente set idade_dependente = 33 WHERE nome_dependente = 'Alicia';

SELECT datediff ('2022-05-02','1967-05-05')/365 AS 'idade da Elizabeth';
UPDATE dependente set idade_dependente = 36 WHERE nome_dependente = 'Elizabeth';

SELECT departamento.nome_departamento, CONCAT(funcionario.primeiro_nome, " ", funcionario.nome_meio, ".", funcionario.ultimo_nome) AS nome_funcionario, concat(dependente.nome_dependente, " ",funcionario.nome_meio, ".", funcionario.ultimo_nome) AS nome_dependente, idade_dependente,
CASE dependente.sexo
      WHEN 'M' THEN 'Masculino'
      WHEN 'F' THEN 'Feminino'
END AS sexo
FROM funcionario
INNER JOIN dependente ON dependente.cpf_funcionario = funcionario.cpf
INNER JOIN departamento ON departamento.numero_departamento = funcionario.numero_departamento;

-- QUESTÃO DE NÚMERO 7:

SELECT departamento.nome_departamento, CONCAT(funcionario.primeiro_nome, " ", funcionario.nome_meio, ".", funcionario.ultimo_nome) as nome_funcionario, concat( funcionario.salario) as salario
FROM funcionario 
LEFT JOIN dependente ON dependente.cpf_funcionario = funcionario.cpf
INNER JOIN departamento ON departamento.numero_departamento = funcionario.numero_departamento 
WHERE dependente.parentesco IS NULL;

-- QUESTÃO DE NÚMERO 8:
								
SELECT departamento.nome_departamento, 
CONCAT(trabalha_em.numero_projeto, '-', projeto.nome_projeto) AS sobre_projeto, 
CONCAT(funcionario.primeiro_nome, " ", funcionario.nome_meio, ".", funcionario.ultimo_nome) AS nome_funcionario, trabalha_em.horas
FROM (departamento, projeto, trabalha_em, funcionario)
INNER JOIN projeto AS p ON (projeto.numero_departamento = departamento.numero_departamento)
INNER JOIN trabalha_em AS tb ON (trabalha_em.numero_projeto  = projeto.numero_projeto AND trabalha_em.cpf_funcionario = funcionario.cpf)
WHERE funcionario.numero_departamento = departamento.numero_departamento
GROUP BY nome_departamento, sobre_projeto, nome_funcionario, horas;

-- QUESTÃO DE NÚMERO 9:

SELECT nome_departamento, nome_projeto, SUM(horas) AS somatorio_horas 
FROM departamento
INNER JOIN projeto ON projeto.numero_departamento = departamento.numero_departamento 
INNER JOIN trabalha_em ON trabalha_em.numero_projeto = projeto.numero_projeto
GROUP BY nome_projeto, nome_departamento;

-- QUESTÃO DE NÚMERO 10:

SELECT numero_departamento, AVG(salario) AS media_por_departamento
FROM funcionario
WHERE numero_departamento = 5 OR numero_departamento = 4 OR numero_departamento =1
GROUP BY numero_departamento;

-- QUESTÃO DE NÚMERO 11:

SELECT CONCAT(funcionario.primeiro_nome, " ", funcionario.nome_meio, ".",funcionario.ultimo_nome) as nome_funcionario, CONCAT( trabalha_em.numero_projeto, '-', projeto.nome_projeto) AS sobre_projeto , CONCAT( trabalha_em.horas * 50) AS valor_total
FROM (funcionario, departamento, projeto, trabalha_em)
WHERE funcionario.cpf = trabalha_em.cpf_funcionario AND departamento.numero_departamento = projeto.numero_departamento  AND projeto.numero_projeto = trabalha_em.numero_projeto
ORDER BY trabalha_em.numero_projeto;

-- QUESTÃO DE NÚMERO 12:

SELECT CONCAT(funcionario.primeiro_nome, " ", funcionario.nome_meio, ".", funcionario.ultimo_nome) AS nome_completo, departamento.nome_departamento, projeto.nome_projeto 
FROM (funcionario, departamento, projeto)
INNER JOIN funcionario AS f ON (departamento.cpf_gerente = f.cpf)
INNER JOIN projeto AS p ON (departamento.numero_departamento = p.numero_departamento)
INNER JOIN trabalha_em AS tb ON (p.numero_projeto = tb.numero_projeto)
WHERE tb.horas = 0 AND funcionario.cpf = tb.cpf_funcionario
GROUP BY projeto.nome_projeto, departamento.nome_departamento, nome_completo;

-- QUESTÃO DE NÚMERO 13:

SELECT DISTINCT CONCAT(funcionario.primeiro_nome," ",funcionario.nome_meio,".",funcionario.ultimo_nome) AS nome_funcionario, funcionario.sexo, funcionario.idade, dependente.nome_dependente AS nome_dependente, dependente.sexo, dependente.idade_dependente 
FROM (funcionario, dependente)
INNER JOIN dependente AS d ON (funcionario.cpf = dependente.cpf_funcionario)
ORDER BY funcionario.idade DESC, dependente.cpf_funcionario DESC; 

-- QUESTÃO DE NÚMERO 14:

SELECT departamento.nome_departamento, COUNT(funcionario.cpf) AS numero_funcionario
FROM (funcionario,departamento) 
WHERE funcionario.numero_departamento = departamento.numero_departamento
GROUP BY departamento.nome_departamento;

-- QUESTÃO DE NÚMERO 15:

SELECT departamento.nome_departamento, 
CONCAT(trabalha_em.numero_projeto, '-', projeto.nome_projeto) AS sobre_projeto, 
CONCAT(funcionario.primeiro_nome, " ", funcionario.nome_meio, ".", funcionario.ultimo_nome) AS nome_funcionario
FROM (departamento, projeto, trabalha_em, funcionario)
INNER JOIN projeto AS p ON (projeto.numero_departamento = departamento.numero_departamento)
INNER JOIN trabalha_em AS tb ON (trabalha_em.numero_projeto  = projeto.numero_projeto AND trabalha_em.cpf_funcionario = funcionario.cpf)
INNER JOIN funcionario AS f ON (funcionario.numero_departamento = departamento.numero_departamento)
INNER JOIN funcionario AS fun ON (funcionario.cpf = tb.cpf_funcionario)
WHERE funcionario.numero_departamento = departamento.numero_departamento
GROUP BY nome_departamento, nome_funcionario, sobre_projeto;











