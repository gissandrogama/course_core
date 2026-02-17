# Skill: Criar contexto Ecto completo

Checklist para criar um novo contexto com schema, migration e funções básicas no CourseCore.

## 1. Migration

- Arquivo em `priv/repo/migrations/` com timestamp e nome descritivo.
- Criar tabela com `create table(:nome_tabela)` e colunas necessárias.
- Índices e foreign keys quando fizer sentido (ex.: `references(:users)`).
- Rodar `mix ecto.gen.migration nome_da_migration` para gerar o arquivo.

## 2. Schema

- Módulo em `lib/course_core/<contexto>/<entidade>.ex`.
- `use Ecto.Schema` e `schema "nome_tabela"`.
- `field` para cada coluna; `belongs_to` / `has_many` / `has_one` para associações.
- Tipo `:string` para texto (incluindo colunas longas).

## 3. Context

- Módulo em `lib/course_core/<contexto>.ex` (ex.: `CourseCore.Course`).
- Funções: `list_<recursos>/0`, `get_<recurso>!/1`, `get_<recurso>/1`, `create_<recurso>/1`, `update_<recurso>/2`, `delete_<recurso>/1`.
- Usar `Repo` para todas as operações de banco.
- Changesets no context ou no schema; campos definidos programaticamente não entram em `cast/3`.

## 4. Testes

- Arquivo em `test/course_core/<contexto>_test.exs` ou `test/course_core/<contexto>/<entidade>_test.exs`.
- Testar list, get, create, update, delete e validações importantes.

## Referência

Ver `.cursor/AGENTS.md` (Ecto e diretrizes gerais).

- Ecto: preload de associações, `get_field` em changesets, sem `map[:field]` em structs.
- Um módulo por arquivo.
