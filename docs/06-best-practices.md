# Mejores Prácticas

Guía de mejores prácticas para trabajar efectivamente con Claude Code.

## Organización de Archivos

### Estructura Recomendada

```
proyecto/
├── .claude/
│   ├── CLAUDE.md           # Project memory (importante!)
│   ├── agents/             # Agentes custom
│   └── mcp.json           # MCP servers config
├── .gitignore             # Incluir .env, .claude/cache/
├── src/
├── tests/
└── docs/
```

### Archivo CLAUDE.md

Siempre crea un `.claude/CLAUDE.md` detallado:

```markdown
# Mi Proyecto

## Descripción
[Qué hace el proyecto]

## Stack
- Frontend: Next.js 15
- Backend: FastAPI
- Database: PostgreSQL

## Comandos Importantes
\`\`\`bash
npm run dev    # Iniciar desarrollo
npm test       # Correr tests
\`\`\`

## Arquitectura
[Explicación de la arquitectura]

## Decisiones Importantes
- Por qué usamos X en lugar de Y
- Patrones específicos del proyecto
```

## Gestión de Contexto

### ✅ DO: Prompts Específicos

```
✅ BUENO:
> Use nextjs-architect to create a product catalog page with:
  - Server components for data fetching
  - Client components for interactive filters
  - Prisma for database queries
  - Tailwind for styling

❌ MALO:
> Create a product page
```

### ✅ DO: Referencias Claras

```
✅ BUENO:
> In src/api/users.py line 45-60, refactor the authentication logic

❌ MALO:
> Fix the auth code
```

### ✅ DO: Iteración

```
✅ BUENO:
> Create basic user model
> Now add email validation
> Now add password hashing
> Now add JWT token generation

❌ MALO:
> Create complete user authentication system with everything
```

## Seguridad

### Proteger Secrets

```bash
# .gitignore
.env
.env.local
.env.*.local
secrets/
*.pem
*.key
id_rsa*
```

### Usar Variables de Entorno

```bash
# ✅ BUENO
DATABASE_URL=postgresql://localhost/db

# ❌ MALO (hardcoded)
const db = 'postgresql://user:pass@localhost/db'
```

## Performance

### Optimizar Lectura de Archivos

```
✅ BUENO:
> Read src/api/users.py lines 1-50

❌ MALO:
> Read all files in src/
```

### Usar .claudeignore

Crea `.claudeignore` para excluir carpetas grandes:

```
node_modules/
.next/
dist/
build/
coverage/
.git/
```

## Testing

### Pedir Tests Siempre

```
> After creating each feature, add tests
```

### Especificar Framework

```
> Use testing-specialist to add Jest tests for this component
```

## Colaboración en Equipo

### Settings Compartidos

Crea `.vscode/settings.json` en el repo:

```json
{
  "claude-code.model": "claude-sonnet-4.5",
  "claude-code.allowedTools": ["Read", "Write", "Edit", "Bash"]
}
```

### Documentar Decisiones

En CLAUDE.md, documenta:
- Por qué se eligió X tecnología
- Patrones específicos del proyecto
- Comandos importantes
- Problemas conocidos

## Debugging

### Reproducir Errores

```
> I'm getting this error:
[pegar error completo con stack trace]

In this file: src/api/users.py
When running: npm run dev
```

### Pedir Explicaciones

```
> Explain why this error is happening and suggest fixes
```

## Recursos

- **[Troubleshooting](./07-troubleshooting.md)** - Solución de problemas
- **[Workflows](./05-workflows.md)** - Patrones de trabajo

---

[← Volver a Documentación](./README.md)
