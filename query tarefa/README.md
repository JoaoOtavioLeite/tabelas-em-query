# Script de exemplo: provas / alunos / matérias

Arquivos criados:

- `setup.sql` - script SQL que cria as tabelas, insere 3 alunos, 1 professor, 1 matéria e 1 prova por aluno; no final contém uma SELECT que mostra os resultados.
- `run_sqlite.py` - pequeno runner em Python que executa `setup.sql` em um banco SQLite (`test.db`) e imprime os linhas resultantes.

Como rodar (Windows PowerShell):

```powershell
python .\run_sqlite.py
```

Notas:
- O runner apaga `test.db` antes de rodar para garantir reexecução limpa.
- O `setup.sql` usa `DROP TABLE IF EXISTS` para evitar erros em reexecuções.
