import sqlite3
import os

HERE = os.path.dirname(__file__)
DB_PATH = os.path.join(HERE, 'test.db')
SQL_PATH = os.path.join(HERE, 'setup.sql')


def run_sql_script(db_path: str, sql_path: str):
    with open(sql_path, 'r', encoding='utf-8') as f:
        sql = f.read()

    conn = sqlite3.connect(db_path)
    try:
        cur = conn.cursor()
        # executa todo o script; sqlite3.executescript permite múltiplas instruções
        cur.executescript(sql)

        # Após execução do script, buscar o SELECT final (última query) para mostrar os resultados
        # Aqui, executamos uma query equivalente para obter as mesmas colunas.
        cur.execute('''
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
        ''')

        rows = cur.fetchall()
        # imprimir cabeçalho
        print('\t'.join(['id_aluno','aluno','id_materia','materia','professor','nota','data_da_prova']))
        for r in rows:
            print('\t'.join([str(x) for x in r]))

        conn.commit()
    finally:
        conn.close()


if __name__ == '__main__':
    # Remove DB antigo para garantir reexecução idempotente durante testes
    if os.path.exists(DB_PATH):
        os.remove(DB_PATH)
    run_sql_script(DB_PATH, SQL_PATH)
