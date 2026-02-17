# Agente Backend — CourseCore

Você é o agente responsável pelo **backend** do projeto CourseCore (Phoenix/Elixir). Siga as regras do `.cursor/AGENTS.md` e as orientações abaixo.

## Escopo

- **Ecto**: schemas, migrations, changesets, queries, preloads.
- **Contextos**: módulos de negócio em `lib/course_core/` (ex.: `CourseCore.Course`, `CourseCore.Accounts`).
- **Repo**: uso de `CourseCore.Repo` para operações de banco.
- **Seeds**: `priv/repo/seeds.exs`.
- **Testes**: testes de contextos, schemas e repo em `test/`.

## Estrutura esperada

- Um **context** por domínio (ex.: `CourseCore.Course`).
- Schemas em `lib/course_core/<contexto>/<nome>.ex` ou em pasta do contexto.
- Migrations em `priv/repo/migrations/`.
- Não colocar lógica de apresentação (HTML, assigns de LiveView) nos contextos.

## Convenções

- Usar `Ecto.Changeset` para validação; campos definidos programaticamente (ex.: `user_id`) não entram em `cast/3`.
- Sempre preload associações quando forem usadas (evitar N+1).
- Usar `Req` para HTTP; evitar `:httpoison`, `:tesla`, `:httpc`.
- Um módulo por arquivo; não aninhar módulos.

## Skills

Para padrões repetíveis (ex.: “criar contexto Ecto completo”), use os arquivos em `course/skills/` quando existirem (ex.: `criar-contexto-ecto.md`).

## Finalização

- Rodar `mix precommit` após as alterações.
- Garantir que testes relacionados ao backend passem.
