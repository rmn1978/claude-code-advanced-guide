# MCP Servers (Model Context Protocol)

Guía para usar MCP servers con Claude Code y extender sus capacidades.

## ¿Qué es MCP?

**Model Context Protocol (MCP)** es un estándar abierto que permite a Claude Code conectarse con sistemas externos como bases de datos, APIs, y servicios en la nube.

## Instalación de MCP Servers

### Configuración Básica

Crea o edita `.claude/mcp.json`:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/ruta/a/tu/proyecto"]
    }
  }
}
```

## MCP Servers Populares

### 1. Filesystem Server

Acceso seguro al sistema de archivos.

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "${workspaceFolder}"]
    }
  }
}
```

### 2. GitHub Server

Integración con GitHub.

```bash
npm install -g @modelcontextprotocol/server-github
```

```json
{
  "mcpServers": {
    "github": {
      "command": "mcp-server-github",
      "env": {
        "GITHUB_TOKEN": "ghp_your_token_here"
      }
    }
  }
}
```

### 3. PostgreSQL Server

Acceso a bases de datos PostgreSQL.

```bash
npm install -g @modelcontextprotocol/server-postgres
```

```json
{
  "mcpServers": {
    "postgres": {
      "command": "mcp-server-postgres",
      "env": {
        "DATABASE_URL": "postgresql://user:pass@localhost:5432/dbname"
      }
    }
  }
}
```

## Recursos

- **Especificación MCP**: https://spec.modelcontextprotocol.io/
- **MCP Servers**: https://github.com/modelcontextprotocol/servers
- **Crear tu MCP**: https://docs.claude.com/mcp

---

[← Volver a Documentación](./README.md)
