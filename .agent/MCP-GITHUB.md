# GitHub MCP no Cursor

Guia rápido para configurar e verificar o **GitHub MCP Server** no Cursor (formato oficial).

## Configuração global

Arquivo: **`~/.cursor/mcp.json`**

### Usar variável do `.zshrc` (recomendado se o token já está no shell)

Se você já tem `export GITHUB_TOKEN=seu_token` no **`~/.zshrc`**:

```json
{
  "mcpServers": {
    "github": {
      "url": "https://api.githubcopilot.com/mcp/",
      "headers": {
        "Authorization": "Bearer ${GITHUB_TOKEN}"
      }
    }
  }
}
```

**Importante:** o Cursor só enxerga `GITHUB_TOKEN` se for **aberto a partir do terminal** (assim ele herda o ambiente do zsh):

1. No terminal (onde `echo $GITHUB_TOKEN` mostra o valor), vá até a pasta do projeto:
   ```bash
   cd /caminho/do/seu/projeto
   ```
2. Abra o Cursor por aí:
   ```bash
   cursor .
   ```
3. Feche qualquer janela do Cursor aberta pelo Dock/Spotlight e use só a que abriu do terminal.
4. Reinicie o Cursor **por completo** após alterar o `mcp.json`.

Se abrir o Cursor pelo Dock, a variável não estará definida e o MCP não conecta.

---

### Usar token direto no JSON (alternativa)

Requer Cursor **v0.48.0+** (Streamable HTTP). Use se não quiser depender do terminal.

```json
{
  "mcpServers": {
    "github": {
      "url": "https://api.githubcopilot.com/mcp/",
      "headers": {
        "Authorization": "Bearer YOUR_GITHUB_PAT"
      }
    }
  }
}
```

Passos:

1. **Settings** → **Tools & Integrations** → **MCP** → lápis ao lado de **"github"**.
2. Substitua **`YOUR_GITHUB_PAT`** pelo seu [Personal Access Token](https://github.com/settings/personal-access-tokens/new).
3. Salve e **reinicie o Cursor**.

## Verificar instalação

1. Reinicie o Cursor.
2. Em **Settings** → **Tools & Integrations** → **MCP Tools**, confira se o servidor **github** está com **bolinha verde**.
3. No chat/composer, em **Available Tools**, deve aparecer o GitHub.
4. Teste no chat: *"List my GitHub repositories"*.

## Opção local (Docker)

Se preferir rodar o servidor localmente com Docker:

```json
{
  "mcpServers": {
    "github": {
      "command": "docker",
      "args": [
        "run",
        "-i",
        "--rm",
        "-e",
        "GITHUB_PERSONAL_ACCESS_TOKEN",
        "ghcr.io/github/github-mcp-server"
      ],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "YOUR_GITHUB_PAT"
      }
    }
  }
}
```

Docker Desktop deve estar instalado e em execução.

## Troubleshooting

- **Uso de `${GITHUB_TOKEN}`**: abra o Cursor pelo terminal (`cursor .`) para o processo herdar a variável do `.zshrc`. Se abrir pelo Dock, `GITHUB_TOKEN` não existirá no ambiente.
- **Token não funciona**: se não quiser abrir pelo terminal, use o token **literal** no JSON em vez de `${GITHUB_TOKEN}`.
- **Servidor não conecta**: Cursor v0.48.0+ para Remote; reinício completo após editar `mcp.json`.
- **Ferramentas não aparecem**: confira a bolinha verde em MCP e os logs do Cursor em caso de erro.

## Referência

- Config **global**: `~/.cursor/mcp.json`
- Config **por projeto**: `.cursor/mcp.json` na raiz do projeto
