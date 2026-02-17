# Skills do agente do curso

Esta pasta contém **skills** (habilidades/padrões) que o agente do curso pode usar ao trabalhar no projeto.

## O que são skills

Cada arquivo `.md` aqui descreve um padrão, fluxo ou checklist reutilizável, por exemplo:

- Como criar um contexto Ecto completo (schema + migrations + context)
- Como criar uma LiveView com formulário e validação
- Checklist de acessibilidade ou de testes

## Como usar

1. **Criar uma skill**: adicione um novo `.md` em `cursos/skills/` com nome descritivo (ex.: `criar-contexto-ecto.md`, `liveview-crud.md`).
2. **Usar no agente**: ao dar uma tarefa, mencione a skill ou inclua o conteúdo do arquivo no prompt quando for relevante.

## Skills planejadas (sugestão)

- `criar-contexto-ecto.md` — backend: schema, migration, context e funções CRUD
- `liveview-crud.md` — frontend: rota live, LiveView, form e listagem
- `formulario-validacao.md` — frontend: form com `to_form`, `handle_event` e mensagens de erro

Você pode adicionar ou remover skills conforme o andamento do curso.    