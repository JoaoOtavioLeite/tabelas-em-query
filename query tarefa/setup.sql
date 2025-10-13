PRAGMA foreign_keys=ON;

-- Limpa tabelas antigas (idempotência local)
DROP TABLE IF EXISTS provas;
DROP TABLE IF EXISTS aluno;
DROP TABLE IF EXISTS materia;
DROP TABLE IF EXISTS professor;

-- Criar tabelas
CREATE TABLE professor (
  id INTEGER PRIMARY KEY,
  nome TEXT NOT NULL,
  data_nascimento DATE
);

CREATE TABLE materia (
  id INTEGER PRIMARY KEY,
  nome TEXT NOT NULL,
  id_professor INTEGER,
  FOREIGN KEY (id_professor) REFERENCES professor(id)
);

CREATE TABLE aluno (
  id INTEGER PRIMARY KEY,
  nome TEXT NOT NULL,
  data_nascimento DATE
);

CREATE TABLE provas (
  id_aluno INTEGER,
  id_materia INTEGER,
  nota REAL,
  data_da_prova DATE,
  FOREIGN KEY (id_aluno) REFERENCES aluno(id),
  FOREIGN KEY (id_materia) REFERENCES materia(id),
  PRIMARY KEY (id_aluno, id_materia, data_da_prova)
);

-- Inserções conforme pedido
INSERT INTO professor (id, nome, data_nascimento) VALUES (1, 'Mariana Costa', '1982-03-18');
INSERT INTO materia (id, nome, id_professor) VALUES (1, 'Matemática', 1);

INSERT INTO aluno (id, nome, data_nascimento) VALUES (1, 'João Pereira', '2005-06-10');
INSERT INTO aluno (id, nome, data_nascimento) VALUES (2, 'Ana Souza', '2006-02-20');
INSERT INTO aluno (id, nome, data_nascimento) VALUES (3, 'Carlos Lima', '2005-11-30');

INSERT INTO provas (id_aluno, id_materia, nota, data_da_prova) VALUES (1,1,8.5,'2025-09-15');
INSERT INTO provas (id_aluno, id_materia, nota, data_da_prova) VALUES (2,1,9.2,'2025-09-15');
INSERT INTO provas (id_aluno, id_materia, nota, data_da_prova) VALUES (3,1,7.0,'2025-09-15');

-- Query final solicitada: listar aluno, matéria, professor, nota e data_da_prova
SELECT a.id AS id_aluno,
       a.nome AS aluno,
       m.id AS id_materia,
       m.nome AS materia,
       p.nome AS professor,
       pr.nota,
       pr.data_da_prova
FROM provas pr
JOIN aluno a   ON pr.id_aluno = a.id
JOIN materia m ON pr.id_materia = m.id
JOIN professor p ON m.id_professor = p.id
ORDER BY a.id;
