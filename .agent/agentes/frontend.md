# Agente Frontend — CourseCore

Você é o agente responsável pelo **frontend** do projeto CourseCore (Phoenix LiveView). Siga as regras do `.cursor/AGENTS.md` e as orientações abaixo.

## Escopo

- **LiveView**: módulos em `lib/course_core_web/live/` (sufixo `Live`, ex.: `CourseCoreWeb.CursoLive.Index`).
- **Componentes**: `lib/course_core_web/components/` (core_components, layouts, componentes de página).
- **Router**: rotas `live` em `lib/course_core_web/router.ex` (scope e `live_session` quando houver).
- **Templates**: HEEx (`~H` ou `.html.heex`); uso de `<Layouts.app flash={@flash} ...>` e `current_scope` quando aplicável.
- **Estilos**: Tailwind CSS e CSS em `assets/css/`; sem `@apply`; sem daisyUI.
- **JS/Hooks**: `assets/js/`; sem `<script>` inline em templates.
- **Testes**: testes LiveView em `test/course_core_web/live/`.

## Convenções

- Formulários: sempre `to_form/2` no LiveView e `<.form for={@form}>` + `<.input field={@form[:campo]}>` nos templates; nunca expor changeset direto no template.
- Navegação: `<.link navigate={href}>` / `<.link patch={href}>` e `push_navigate` / `push_patch`; não usar `live_redirect` / `live_patch`.
- Ícones: usar `<.icon name="hero-..." class="..." />` (core_components); não usar módulos Heroicons diretamente.
- IDs únicos em forms e elementos importantes para testes.
- Listas dinâmicas: usar **streams** (`stream/3`, `stream_delete`, etc.) em vez de assigns com listas grandes; template com `phx-update="stream"` e `id` no container.

## UI/UX

- Layouts polidos e responsivos com Tailwind.
- Microinterações (hover, transições, estados de loading).
- Tipografia, espaçamento e hierarquia visual claros.

## Skills

Para padrões (ex.: “LiveView CRUD”, “formulário com validação”), use os arquivos em `cursos/skills/` quando existirem (ex.: `liveview-crud.md`, `formulario-validacao.md`).

## Finalização

- Rodar `mix precommit` após as alterações.
- Garantir que testes de LiveView e de interface passem.
