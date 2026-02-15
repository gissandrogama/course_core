# Skill: LiveView CRUD

Checklist para implementar um CRUD com LiveView no CourseCore (listagem + formulário de criação/edição).

## 1. Backend (pré-requisito)

- Context com schema, list, get, create, update, delete (ver `cursos/skills/criar-contexto-ecto.md`).

## 2. Rotas

- Em `lib/course_core_web/router.ex`, dentro do scope e pipeline adequados:
  - `live "/recursos", RecursoLive.Index, :index`
  - `live "/recursos/new", RecursoLive.Index, :new`
  - `live "/recursos/:id/edit", RecursoLive.Index, :edit`
- Ou rotas separadas para Index/New/Edit conforme convenção do projeto.

## 3. LiveView Index

- Módulo em `lib/course_core_web/live/recurso_live/index.ex` (nome com sufixo `Live`).
- `mount/3`: carregar lista (ex.: `list_recursos()`), assigns iniciais.
- `handle_params/3`: atualizar assigns para `:new` ou `:edit` conforme params; carregar recurso quando `:id` existir.
- Assigns típicos: `@recursos`, `@recurso` (para form), `@form` (via `to_form(changeset)`), `@page_title`.
- Links: `<.link navigate={...}>` para new/edit; `<.link patch={...}>` para trocar entre new/edit sem recarregar.

## 4. Formulário

- `<.form for={@form} id="recurso-form" phx-submit="save" phx-change="validate">`.
- `<.input field={@form[:campo]} ... />` para cada campo.
- Botão submit e link cancelar (patch de volta para index).

## 5. Eventos

- `handle_event("validate", %{"recurso" => params}, socket)`: validar com changeset e `assign(socket, form: to_form(changeset))`.
- `handle_event("save", %{"recurso" => params}, socket)`: criar ou atualizar via context; em caso de sucesso, `push_navigate` ou `push_patch` e flash; em erro, assign form com erros.

## 6. Listagem

- Preferir **streams** para listas que crescem ou têm muitas atualizações: `stream(socket, :recursos, recursos, reset: true)` e `stream_delete(socket, :recursos, recurso)`.
- Template: container com `id="recursos" phx-update="stream"` e `:for={{id, item} <- @streams.recursos} id={id}`.
- Para listas simples e pequenas, assign normal também é aceitável.

## 7. Layout e convenções

- Iniciar template com `<Layouts.app flash={@flash} ...>` e passar `current_scope` se o projeto usar escopos autenticados.
- IDs únicos em forms e elementos chave para testes.
- Sem `<script>` inline; JS em `assets/js` se necessário.

## Referência

Ver `.cursor/AGENTS.md` (LiveView e formulários).

- Form sempre com `to_form/2` e `<.form for={@form}>`; nunca changeset direto no template.
- Navegação com `navigate`/`patch` e `push_navigate`/`push_patch`.
