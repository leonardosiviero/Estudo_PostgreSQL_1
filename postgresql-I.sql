/* Criando tabelas  */

CREATE TABLE aluno (
	id SERIAL,
	nome VARCHAR(255),
	cpf CHAR(11),
	observacao TEXT,
	idade INTEGER,
	dinheiro NUMERIC(10,2),
	altura REAL,
	ativo BOOLEAN,
	data_nascimento DATE,
	hora_aula TIME,
	matriculado_em TIMESTAMP
);

SELECT * FROM aluno;

/* Inserindo dados na tabela */

INSERT INTO aluno(nome,
				  cpf,
				  observacao,
				  idade,
				  dinheiro,
				  altura,
				  ativo,
				  data_nascimento,
				  hora_aula,
				  matriculado_em) 
	VALUES ('DIOGO',
			'12345678901',
			'Aaisjdiasjd aisjda jaiiajs iajsdia ja asdai.',
			35,
			100.50,
			1.81,
			TRUE,
			'1984-08-25',
			'17:30:00',
			'2020-02-08 12:32:05'
		   )
		   
/* Modificando tabela */

UPDATE aluno 
	SET nome = 'Diogo'
	WHERE id = 2;

SELECT * FROM aluno WHERE id = 1

UPDATE aluno 
	SET nome = 'Leonardo',
	cpf = '36699766810',
	observacao = 'Teste',
	idade = 32,
	dinheiro = 21500.57,
	altura = 1.71,
	ativo = FALSE,
	data_nascimento = '1989-04-03',
	hora_aula = '19:00:00',
	matriculado_em = '2021-11-10 12:35:58'
WHERE id = 1;

/* Deletando tabela */

DROP TABLE aluno;

/* Consulta e utilização de filtros filtros */

SELECT  * FROM aluno WHERE nome = 'Leonardo';

DELETE FROM aluno WHERE nome = 'Leonardo';

SELECT * FROM aluno WHERE id = 2

SELECT nome AS "Nome do Aluno", idade, cpf AS numero_cpf FROM aluno

INSERT INTO aluno (nome) VALUES ('Vinicius Dias');
INSERT INTO aluno (nome) VALUES ('Leonardo Siviero');
INSERT INTO aluno (nome) VALUES ('Valeria Dantas');
INSERT INTO aluno (nome) VALUES ('Ricardo');
INSERT INTO aluno (nome) VALUES ('Diego');

SELECT * FROM aluno;

SELECT * FROM aluno
WHERE nome = 'Ricardo';

SELECT * FROM aluno
WHERE nome <> 'Ricardo';

SELECT * FROM aluno
WHERE nome != 'Ricardo';

SELECT * FROM aluno
WHERE nome LIKE 'Di_go';

SELECT * FROM aluno
WHERE nome NOT LIKE 'Di_go'

SELECT * FROM aluno
WHERE nome LIKE 'D%'

SELECT * FROM aluno
WHERE nome LIKE '%s'

SELECT * FROM aluno
WHERE nome LIKE '% %'

SELECT * FROM aluno
WHERE nome LIKE '%i%i'

SELECT * FROM aluno WHERE cpf IS NULL

SELECT * FROM aluno WHERE cpf IS NOT NULL

SELECT * FROM aluno WHERE idade = 35

SELECT * FROM aluno WHERE idade <> 36

SELECT * FROM aluno WHERE idade >= 35

SELECT * FROM aluno WHERE idade < 36

SELECT * FROM aluno WHERE idade BETWEEN 10 AND 35

SELECT * FROM aluno WHERE ativo = TRUE

SELECT * FROM aluno WHERE ativo IS NULL

SELECT * FROM aluno WHERE nome LIKE 'D%' and cpf IS NOT NULL

SELECT * FROM aluno 
	WHERE nome LIKE 'Antonio' 
	OR nome LIKE 'Ricardo' 
	OR nome LIKE 'Valeria%'

/* chave primária */

CREATE TABLE curso(
	id INTEGER,
	nome VARCHAR(255)
);

SELECT * FROM curso;

INSERT INTO curso (id, nome) VALUES (NULL, NULL);

DROP TABLE curso;

CREATE TABLE curso(
	id INTEGER NOT NULL UNIQUE,
	nome VARCHAR(255) NOT NULL
);

INSERT INTO curso (id, nome) VALUES (1, 'HTML');
INSERT INTO curso (id, nome) VALUES (2, 'JAVASCRIPT');

SELECT * FROM curso;

DROP TABLE curso;

CREATE TABLE curso(
	id INTEGER PRIMARY KEY,
	nome VARCHAR(255) NOT NULL
);

INSERT INTO curso (id, nome) VALUES (1, 'HTML');
INSERT INTO curso (id, nome) VALUES (2, 'JAVASCRIPT');

SELECT * FROM curso;
SELECT * FROM aluno;

/* chave extrangeira */

DROP TABLE aluno;

CREATE TABLE aluno(
	id SERIAL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL);

INSERT INTO aluno (nome) VALUES ('Diogo');
INSERT INTO aluno (nome) VALUES ('Vinicius');

SELECT * FROM curso;
SELECT * FROM aluno;

CREATE TABLE aluno_curso(
	aluno_id INTEGER,
	curso_id INTEGER,
	PRIMARY KEY (aluno_id, curso_id),
	
	FOREIGN KEY (aluno_id)
	REFERENCES aluno (id),
	
	FOREIGN KEY (curso_id)
	REFERENCES curso (id)
);

SELECT * FROM aluno_curso;
DROP TABLE aluno_curso;

INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (1,1);
INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (2,1);
INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (3,1); /* chave extrangeira não permite incluir esse dado inexistente*/

SELECT * FROM aluno WHERE id = 1;
SELECT * FROM curso WHERE id = 1;

SELECT * FROM aluno WHERE id = 2;
SELECT * FROM curso WHERE id = 1;

/* juntanado tabaleas para uma consulta*/

INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (2,2)

SELECT * FROM aluno;
SELECT * FROM curso;

SELECT * FROM aluno 
	JOIN aluno_curso 
	ON aluno_curso.aluno_id  = aluno.id
	JOIN curso 
	ON curso.id = aluno_curso.curso_id
	
SELECT aluno.nome as "Nome do aluno", curso.nome as "Nome do curso"
	FROM aluno 
	JOIN aluno_curso 
	ON aluno_curso.aluno_id  = aluno.id
	JOIN curso 
	ON curso.id = aluno_curso.curso_id
	
/* Exercício de exemplo de consulta com relacionamento*/

CREATE TABLE departamentos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

CREATE TABLE funcionarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    departamento_id INTEGER,
    FOREIGN KEY (departamento_id) REFERENCES departamentos (id)
);

INSERT INTO departamentos (nome) VALUES ('Engenharia');
INSERT INTO departamentos (nome) VALUES ('Administrativo');
INSERT INTO funcionarios (nome, departamento_id) VALUES ('João',1);
INSERT INTO funcionarios (nome, departamento_id) VALUES ('Antônio',2);
INSERT INTO funcionarios (nome, departamento_id) VALUES ('Sérgio',2);

SELECT * FROM departamentos;
SELECT * FROM funcionarios;

SELECT funcionarios.nome AS "Nome do funcionário", departamentos.nome AS "Departamento"
	FROM funcionarios
	JOIN departamentos
	ON funcionarios.departamento_id  = departamentos.id
	
/*Juntar tabelas qnd não tiver dado em uma das tabelas - LEFT, RIGHT, CROSS e FULL JOINS*/

INSERT INTO aluno (nome) VALUES ('Nico');
INSERT INTO curso (id,nome) VALUES (3,'CSS');

SELECT * FROM aluno;

UPDATE aluno 
	SET nome = 'Orlando'
	WHERE id = 4;
	
SELECT 			aluno.nome as "Nome do aluno", 
				curso.nome as "Nome do curso"
	FROM 		aluno 
	LEFT JOIN 	aluno_curso 
	ON 			aluno_curso.aluno_id  = aluno.id
	LEFT JOIN 	curso 
	ON 			curso.id = aluno_curso.curso_id
	
SELECT 			aluno.nome as "Nome do aluno", 
				curso.nome as "Nome do curso"
	FROM 		aluno 
	RIGHT JOIN 	aluno_curso 
	ON 			aluno_curso.aluno_id  = aluno.id
	RIGHT JOIN 	curso 
	ON 			curso.id = aluno_curso.curso_id

SELECT 			aluno.nome as "Nome do aluno", 
				curso.nome as "Nome do curso"
	FROM 		aluno 
	FULL JOIN 	aluno_curso 
	ON 			aluno_curso.aluno_id  = aluno.id
	FULL JOIN 	curso 
	ON 			curso.id = aluno_curso.curso_id

SELECT 			aluno.nome as "Nome do aluno", 
				curso.nome as "Nome do curso"
	FROM 		aluno 
	CROSS JOIN  curso /*cross join faz o link de todos alunos por todos cursos*/
	
/* Restrição de chave extrangeira - DELETE CASCADE*/

SELECT * FROM aluno;
SELECT * FROM curso;
SELECT * FROM aluno_curso;

DROP TABLE aluno_curso;

CREATE TABLE aluno_curso(
	aluno_id INTEGER,
	curso_id INTEGER,
	PRIMARY KEY (aluno_id, curso_id),
	
	FOREIGN KEY (aluno_id)
	REFERENCES aluno (id)
	ON DELETE CASCADE,
	
	FOREIGN KEY (curso_id)
	REFERENCES curso (id)
);

INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (1,1);
INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (2,1);
INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (3,1);
INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (1,3);

SELECT 			aluno.nome as "Nome do aluno", 
				curso.nome as "Nome do curso"
	FROM 		aluno 
	JOIN 	aluno_curso 
	ON 			aluno_curso.aluno_id  = aluno.id
	JOIN 	curso 
	ON 			curso.id = aluno_curso.curso_id
	
DELETE FROM aluno WHERE id = 1;

/* Restrição de chave extrangeira - UPDATE CASCADE*/

SELECT * FROM aluno;
SELECT * FROM curso;
SELECT * FROM aluno_curso;

DROP TABLE aluno_curso;

CREATE TABLE aluno_curso(
	aluno_id INTEGER,
	curso_id INTEGER,
	PRIMARY KEY (aluno_id, curso_id),
	
	FOREIGN KEY (aluno_id)
	REFERENCES aluno (id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	
	FOREIGN KEY (curso_id)
	REFERENCES curso (id)
);

INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (2,1);
INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (3,1);

SELECT 			aluno.nome as "Nome do aluno", 
				aluno.id as aluno_id, 
				curso.nome as "Nome do curso",
				curso.id as curso_id
	FROM 		aluno 
	JOIN 	aluno_curso 
	ON 			aluno_curso.aluno_id  = aluno.id
	JOIN 	curso 
	ON 			curso.id = aluno_curso.curso_id

UPDATE aluno SET id = 10 where id = 2;

/*Exercicio de exemplo CASCADE e RESTRICT*/

CREATE TABLE pessoas (
    id INTEGER PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

CREATE TABLE telefones (
    id INTEGER PRIMARY KEY,
    pessoa_id INTEGER,
    numero VARCHAR(15) NOT NULL,
    FOREIGN KEY (pessoa_id) REFERENCES pessoas (id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

INSERT INTO pessoas (id, nome) VALUES (1,'Diogo');
INSERT INTO telefones (id, pessoa_id, numero) VALUES (1,1,'(21) 98765-4321');

SELECT * FROM pessoas;
SELECT * FROM telefones;

UPDATE pessoas SET id = 2 WHERE nome = 'Diogo';
DELETE FROM pessoas WHERE nome = 'Diogo'; /*gera erro pois delete está com restrict*/

/*Ordenação de consulta*/

DROP TABLE funcionarios;

CREATE TABLE funcionarios (
	id SERIAL PRIMARY KEY,
	matricula VARCHAR(10),
	nome	  VARCHAR(255),
	sobrenome VARCHAR(255)
);

INSERT INTO funcionarios (matricula, nome, sobrenome) VALUES ('M001','Diogo','Mascarenhas');
INSERT INTO funcionarios (matricula, nome, sobrenome) VALUES ('M002','Vinicius','Dias');
INSERT INTO funcionarios (matricula, nome, sobrenome) VALUES ('M003','Nico','Steppat');
INSERT INTO funcionarios (matricula, nome, sobrenome) VALUES ('M004','João','Roberto');
INSERT INTO funcionarios (matricula, nome, sobrenome) VALUES ('M005','Diogo','Mascarenhas');
INSERT INTO funcionarios (matricula, nome, sobrenome) VALUES ('M006','Alberto','Martins');
INSERT INTO funcionarios (matricula, nome, sobrenome) VALUES ('M007','Diogo','Scarlot');

SELECT * FROM funcionarios
SELECT * FROM funcionarios ORDER BY nome 
SELECT * FROM funcionarios ORDER BY nome DESC /* (ordem descrecente de letra)*/
SELECT * FROM funcionarios ORDER BY nome, matricula
SELECT * FROM funcionarios ORDER BY nome, matricula DESC
SELECT * FROM funcionarios ORDER BY 4 /*coluna 4 - sobrenome*/
SELECT * FROM funcionarios ORDER BY 4 DESC, nome DESC, 2

SELECT * FROM aluno;
SELECT * FROM curso;
SELECT * FROM aluno_curso;

DROP TABLE aluno_curso;

CREATE TABLE aluno_curso(
	aluno_id INTEGER,
	curso_id INTEGER,
	PRIMARY KEY (aluno_id, curso_id),
	
	FOREIGN KEY (aluno_id)
	REFERENCES aluno (id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	
	FOREIGN KEY (curso_id)
	REFERENCES curso (id)
);

INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (3,1);
INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (4,2);
INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (10,2);
INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (10,3);

SELECT 			aluno.nome as "Nome do aluno", 
				aluno.id as aluno_id, 
				curso.nome as "Nome do curso",
				curso.id as curso_id
	FROM 		aluno 
	JOIN 	aluno_curso 
	ON 			aluno_curso.aluno_id  = aluno.id
	JOIN 	curso 
	ON 			curso.id = aluno_curso.curso_id
	ORDER BY aluno.nome DESC, curso.nome ASC /* nao precisa por ASC para ser ascendente */
	
SELECT * FROM aluno;
SELECT * FROM curso;
SELECT * FROM aluno_curso;

/*Limitando as consultas*/

DROP TABLE funcionarios;

CREATE TABLE funcionarios (
	id SERIAL PRIMARY KEY,
	matricula VARCHAR(10),
	nome	  VARCHAR(255),
	sobrenome VARCHAR(255)
);

INSERT INTO funcionarios (matricula, nome, sobrenome) VALUES ('M001','Diogo','Mascarenhas');
INSERT INTO funcionarios (matricula, nome, sobrenome) VALUES ('M002','Vinicius','Dias');
INSERT INTO funcionarios (matricula, nome, sobrenome) VALUES ('M003','Nico','Steppat');
INSERT INTO funcionarios (matricula, nome, sobrenome) VALUES ('M004','João','Roberto');
INSERT INTO funcionarios (matricula, nome, sobrenome) VALUES ('M005','Diogo','Mascarenhas');
INSERT INTO funcionarios (matricula, nome, sobrenome) VALUES ('M006','Alberto','Martins');
INSERT INTO funcionarios (matricula, nome, sobrenome) VALUES ('M007','Diogo','Scarlot');

SELECT * FROM funcionarios LIMIT 5;
SELECT * FROM funcionarios ORDER BY nome LIMIT 5;
SELECT * FROM funcionarios ORDER BY id LIMIT 5 OFFSET 3; /*consultando a partir do id 3*/

/*Exercicio - classificação vestibular*/

CREATE TABLE vestibular(
	id SERIAL PRIMARY KEY,
	nome VARCHAR(255),
	sobrenome VARCHAR(255),
	nota INTEGER
	);

SELECT * FROM vestibular;

INSERT INTO vestibular (nome, sobrenome, nota) VALUES ('Mariana', 'Rios', 100);
INSERT INTO vestibular (nome, sobrenome, nota) VALUES ('Marlon', 'Relos', 85);
INSERT INTO vestibular (nome, sobrenome, nota) VALUES ('Nathalia', 'Maraios', 10);
INSERT INTO vestibular (nome, sobrenome, nota) VALUES ('Rosana', 'Silva', 15);
INSERT INTO vestibular (nome, sobrenome, nota) VALUES ('Maria', 'Rosa', 60);
INSERT INTO vestibular (nome, sobrenome, nota) VALUES ('José', 'Veiga', 97);
INSERT INTO vestibular (nome, sobrenome, nota) VALUES ('Renato', 'Contreras', 34);
INSERT INTO vestibular (nome, sobrenome, nota) VALUES ('Pedro', 'Alencar', 100);
INSERT INTO vestibular (nome, sobrenome, nota) VALUES ('Caio', 'Stegart', 100);
INSERT INTO vestibular (nome, sobrenome, nota) VALUES ('Alberto', 'Ross', 83);
INSERT INTO vestibular (nome, sobrenome, nota) VALUES ('Alexandre', 'Matos', 30);
INSERT INTO vestibular (nome, sobrenome, nota) VALUES ('Rosalina', 'Silva', 75);
INSERT INTO vestibular (nome, sobrenome, nota) VALUES ('Rodrigo', 'Queiroz', 91);
INSERT INTO vestibular (nome, sobrenome, nota) VALUES ('Alessandro', 'Veiga', 92);
INSERT INTO vestibular (nome, sobrenome, nota) VALUES ('Alessandra', 'Contras', 79);
INSERT INTO vestibular (nome, sobrenome, nota) VALUES ('Pablo', 'Silva', 17);
INSERT INTO vestibular (nome, sobrenome, nota) VALUES ('Caio', 'Rosa', 100);

SELECT *FROM vestibular ORDER BY nota DESC, nome LIMIT 5

/* Funções de agregação:*/

-- COUNT - Retorna a quantidade de registros
-- SUM	 - Retorna a soma dos registros
-- MAX	 - Retorna o maior valor dos registros
-- MIN	 - Retorna o menor valor dos registros
-- AVG	 - Retorna a média dos registros

SELECT * FROM funcionarios;
SELECT COUNT(id) FROM funcionarios;
SELECT SUM(id) FROM funcionarios;
SELECT MAX(id) FROM funcionarios;
SELECT MIN(id) FROM funcionarios;
SELECT ROUND(AVG(id),0) FROM funcionarios;

/* Agrupando consultas */

SELECT * FROM funcionarios;

SELECT DISTINCT nome, sobrenome FROM funcionarios ORDER BY nome;
SELECT nome, sobrenome, COUNT(id) FROM funcionarios GROUP BY nome, sobrenome ORDER BY nome; /*conta homonimos*/

SELECT * FROM aluno
SELECT curso.nome, COUNT(aluno.id) FROM aluno
	JOIN aluno_curso ON aluno.id = aluno_curso.aluno_id 
	JOIN curso ON curso.id = aluno_curso.curso_id 
	GROUP BY 1
	ORDER BY 1

/* Filtrando consultas agrupadas. */

SELECT * FROM aluno;
SELECT * FROM aluno_curso;
SELECT * FROM curso;

SELECT * FROM curso 
	LEFT JOIN aluno_curso ON aluno_curso.curso_id = curso.id
	LEFT JOIN aluno ON aluno.id = aluno_curso.aluno_id
	
SELECT curso.nome,
	COUNT(aluno.id)
	FROM curso 
	LEFT JOIN aluno_curso ON aluno_curso.curso_id = curso.id
	LEFT JOIN aluno ON aluno.id = aluno_curso.aluno_id
	GROUP BY 1
	
SELECT curso.nome,
	COUNT(aluno.id)
	FROM curso 
	LEFT JOIN aluno_curso ON aluno_curso.curso_id = curso.id
	LEFT JOIN aluno ON aluno.id = aluno_curso.aluno_id
	WHERE curso.nome = 'JAVASCRIPT'
	GROUP BY 1
	
SELECT curso.nome,
	COUNT(aluno.id)
	FROM curso 
	LEFT JOIN aluno_curso ON aluno_curso.curso_id = curso.id
	LEFT JOIN aluno ON aluno.id = aluno_curso.aluno_id
	GROUP BY 1
	HAVING COUNT(aluno.id) = 2 -- ou > 0 por exemplo
	
SELECT nome
	FROM funcionarios
	GROUP BY nome
	HAVING COUNT(id) > 1;

SELECT nome, COUNT(id) 
	FROM funcionarios
	GROUP BY nome
	HAVING COUNT(id) > 1;
	
SELECT nome, COUNT(id) 
	FROM funcionarios
	GROUP BY nome
	HAVING COUNT(id) = 1;










	

