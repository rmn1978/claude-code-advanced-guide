# 📝 Cheat Sheet - Claude Code

Referencia rápida de comandos, prompts y patrones más usados.

**💾 Descarga PDF**: [Próximamente]

---

## ⌨️ Comandos Slash

```
┌──────────────────────────────────────────────┐
│ COMANDO        │ QUÉ HACE                    │
├──────────────────────────────────────────────┤
│ /help          │ Muestra ayuda               │
│ /plan          │ Activa plan mode            │
│ /clear         │ Limpia la conversación      │
│ /model         │ Cambia el modelo            │
└──────────────────────────────────────────────┘
```

---

## 💬 Prompts Básicos

### Crear Apps

```
✅ Create a [tipo] app with [features]

Ejemplos:
> Create a todo app with React that allows CRUD operations
> Create a blog with Next.js using SSG
> Create a REST API with FastAPI for user management
```

### Arreglar Errores

```
✅ Fix this error: [paste error completo]

Mejor aún:
> I'm getting this error in src/api/users.py line 45:
> [paste error]
> Fix it
```

### Añadir Features

```
✅ Add [feature] to this [file/component]

Ejemplos:
> Add authentication to this API
> Add dark mode to this React component
> Add pagination to this user list
```

### Refactoring

```
✅ Refactor this code to [objetivo]

Ejemplos:
> Refactor this code to use async/await
> Refactor this component to use TypeScript
> Refactor this function to be more readable
```

### Explicaciones

```
✅ Explain what this code does

Mejor aún:
> Explain what this code does line by line
> Explain the algorithm used in this function
> Explain why this pattern is used
```

---

## 🎯 Prompts Avanzados

### Usando Agentes

```
✅ Use [agent-name] to [task]

Ejemplos:
> Use nextjs-architect to create a landing page with hero section
> Use fastapi-architect to create a REST API with JWT auth
> Use testing-specialist to add comprehensive tests
```

### Plan Mode

```
✅ /plan
✅ [Describe proyecto complejo]

Ejemplo:
> /plan
> Create a real-time chat app with:
  - Socket.io for real-time messaging
  - PostgreSQL for message persistence
  - Redis for pub/sub
  - User authentication
  - File uploads
```

### Multi-step Tasks

```
✅ Step 1: [tarea]
✅ Step 2: [tarea]
✅ Step 3: [tarea]

Ejemplo:
> Step 1: Create a User model with Prisma
> Step 2: Create CRUD endpoints for users
> Step 3: Add JWT authentication
> Step 4: Add tests for all endpoints
```

---

## 🛠️ Patrones de Desarrollo

### Crear un Proyecto Nuevo

```bash
# 1. Crear carpeta
mkdir my-project && cd my-project

# 2. Inicializar proyecto
> Create a [stack] project with:
  - [framework]
  - [database]
  - [additional tools]

# 3. Verificar estructura
> Show me the project structure
```

### Añadir una Feature

```bash
# 1. Leer código existente
> Read and understand the current [component/module]

# 2. Planificar
> How would you add [feature] to this code?

# 3. Implementar
> Implement [feature] following the existing patterns

# 4. Tests
> Add tests for the new feature
```

### Debugging

```bash
# 1. Mostrar error completo
> I'm getting this error:
  [paste error con stack trace]

# 2. Contexto
> In file: src/api/users.py
> When running: npm run dev

# 3. Pedir solución
> What's causing this and how do I fix it?
```

---

## 🔧 Settings Comunes

### settings.json

```json
{
  // Modelo (elige uno)
  "claude-code.model": "claude-haiku-3.5",      // Rápido y barato
  "claude-code.model": "claude-sonnet-4.5",     // Balanceado (recomendado)
  "claude-code.model": "claude-opus-4",         // Más potente

  // Tokens máximos
  "claude-code.maxTokens": 8192,                // Por defecto
  "claude-code.maxTokens": 4096,                // Si es lento

  // Herramientas permitidas
  "claude-code.allowedTools": [
    "Read",
    "Write",
    "Edit",
    "Bash",
    "Glob",
    "Grep"
  ],

  // Timeout (ms)
  "claude-code.timeout": 120000,                // 2 minutos

  // Logging
  "claude-code.logLevel": "info"                // info, debug, error
}
```

---

## 📁 Estructura de Proyecto Recomendada

```
my-project/
├── .claude/
│   ├── CLAUDE.md          # ⭐ Project memory (IMPORTANTE)
│   ├── agents/            # Agentes custom
│   └── mcp.json          # MCP servers config
│
├── .gitignore            # Git ignore (incluir .env)
├── .claudeignore         # Claude ignore
├── .env                  # Variables de entorno
├── README.md
│
├── src/                  # Código fuente
├── tests/                # Tests
├── docs/                 # Documentación
└── scripts/              # Scripts útiles
```

---

## 🚫 .claudeignore

Archivos/carpetas que Claude debe ignorar:

```
# Dependencies
node_modules/
venv/
env/

# Build outputs
dist/
build/
.next/
out/

# Logs
*.log
logs/

# Cache
.cache/
.turbo/

# OS
.DS_Store
Thumbs.db

# IDE
.vscode/
.idea/

# Test coverage
coverage/
.nyc_output/
```

---

## 📄 Template de CLAUDE.md

```markdown
# [Nombre del Proyecto]

## Descripción
[Qué hace este proyecto]

## Stack Tecnológico
- Frontend: [e.g., Next.js 15, React 18]
- Backend: [e.g., FastAPI, Python 3.11]
- Database: [e.g., PostgreSQL 15]
- Deployment: [e.g., Vercel + Railway]

## Estructura del Proyecto
\`\`\`
src/
├── components/
├── pages/
└── lib/
\`\`\`

## Comandos Importantes
\`\`\`bash
npm run dev      # Desarrollo
npm test         # Tests
npm run build    # Build production
\`\`\`

## Decisiones de Arquitectura
- Por qué elegimos X en lugar de Y
- Patrones importantes
- Cosas que NO cambiar

## Problemas Conocidos
- [Lista de issues conocidos]

## TODOs
- [ ] Implementar feature X
- [ ] Arreglar bug Y
```

---

## 🎨 Stacks Populares

### Next.js Full-Stack

```
> Use nextjs-architect to create a full-stack app with:
  - Next.js 15 App Router
  - Server Components
  - Server Actions for mutations
  - Prisma + PostgreSQL
  - Tailwind CSS
  - TypeScript
```

### FastAPI Backend

```
> Use fastapi-architect to create a REST API with:
  - FastAPI + Python 3.11
  - PostgreSQL with SQLAlchemy
  - JWT authentication
  - Pydantic validation
  - OpenAPI docs
  - Docker setup
```

### MERN Stack

```
> Create a MERN stack app with:
  - React 18 + Vite
  - Express.js + TypeScript
  - MongoDB + Mongoose
  - JWT auth
  - RESTful API
```

---

## 🧪 Testing Patterns

### Pedir Tests

```
✅ Add tests for this [component/function/API]

Mejor:
> Use testing-specialist to add:
  - Unit tests with Jest
  - Integration tests for the API
  - E2E tests with Playwright
  - Coverage threshold of 80%
```

### Test-Driven Development

```
> Step 1: Write failing tests for [feature]
> Step 2: Implement [feature] to pass tests
> Step 3: Refactor while keeping tests green
```

---

## 🚀 Deployment Quick Commands

### Vercel (Frontend)

```bash
# Instalar Vercel CLI
npm i -g vercel

# Deploy
> Add Vercel deployment config
> Create vercel.json with optimal settings

vercel --prod
```

### Railway (Backend)

```bash
# Instalar Railway CLI
npm i -g @railway/cli

# Deploy
> Add Railway deployment config
> Create Procfile and railway.json

railway up
```

### Docker

```
> Create a Dockerfile for this app
> Create docker-compose.yml with all services
> Add .dockerignore
```

---

## 💾 Git Quick Commands

```bash
# Ver cambios
git status
git diff

# Stage y commit
git add .
git commit -m "feat: add user authentication"

# Push
git push origin main

# Crear branch
git checkout -b feature/new-feature

# Merge
git checkout main
git merge feature/new-feature
```

---

## 🔐 Seguridad Checklist

```
✅ No hardcodear secrets (usar .env)
✅ Añadir .env a .gitignore
✅ Validar inputs (usar Zod/Pydantic)
✅ Sanitizar datos de usuario
✅ Usar HTTPS en producción
✅ Implementar rate limiting
✅ Usar JWT con expiration
✅ Hash passwords (bcrypt, argon2)
✅ Configurar CORS correctamente
✅ Añadir security headers (Helmet)

Pedir a Claude:
> Use security-specialist to audit this code
```

---

## ⚡ Performance Checklist

```
✅ Lazy load componentes
✅ Code splitting
✅ Image optimization
✅ Caching (Redis)
✅ Database indexes
✅ Query optimization
✅ CDN para static assets
✅ Compression (gzip/brotli)
✅ Minimize bundle size

Pedir a Claude:
> Use performance-specialist to optimize this code
```

---

## 🎯 Errores Comunes y Soluciones

| Error | Solución Rápida |
|-------|----------------|
| API key not found | `export ANTHROPIC_API_KEY="sk-ant-xxx"` → Reiniciar VS Code |
| Permission denied | `chmod +x script.sh` |
| Module not found | `npm install` o `pip install -r requirements.txt` |
| Port already in use | `lsof -ti:3000 \| xargs kill -9` |
| CORS error | Configurar CORS en backend |

---

## 📊 Modelos de Claude

| Modelo | Velocidad | Costo | Uso Recomendado |
|--------|-----------|-------|-----------------|
| Haiku 3.5 | ⚡⚡⚡ | $ | Tareas simples, iteración rápida |
| Sonnet 4.5 | ⚡⚡ | $$ | Balanceado (recomendado) |
| Opus 4 | ⚡ | $$$ | Tareas complejas, mejor calidad |

---

## 🎓 Recursos Rápidos

| Necesito | Ir a |
|----------|------|
| Instalar Claude Code | [Installation Guide](./docs/01-installation.md) |
| Tutorial paso a paso | [Tutorial 15 min](./TUTORIAL-15MIN.md) |
| Términos que no entiendo | [Glosario](./GLOSSARY.md) |
| Preguntas frecuentes | [FAQ](./FAQ-BEGINNERS.md) |
| Ejemplos de proyectos | [Examples](./examples/README.md) |
| Solucionar problemas | [Troubleshooting](./docs/07-troubleshooting.md) |

---

## 💡 Pro Tips

### 1. Sé Específico
```
❌ "Create an app"
✅ "Create a todo app with React, TypeScript, and localStorage"
```

### 2. Itera en Pasos Pequeños
```
✅ Paso 1: Create basic structure
✅ Paso 2: Add styling
✅ Paso 3: Add functionality
✅ Paso 4: Add tests
```

### 3. Usa Agentes Especializados
```
✅ Use nextjs-architect for Next.js
✅ Use fastapi-architect for Python APIs
✅ Use testing-specialist for tests
```

### 4. Pide Explicaciones
```
✅ "Explain what this code does"
✅ "Why did you choose this approach?"
✅ "What are the trade-offs here?"
```

### 5. Revisa Siempre el Código
```
⚠️ Claude es bueno pero no perfecto
✅ Lee el código generado
✅ Entiende qué hace
✅ Ejecuta tests
```

---

## 🚀 Workflow Productivo

```
1. 📝 Planifica (5 min)
   > /plan
   > [Describe el proyecto]

2. 🏗️ Construye (30-60 min)
   > Implementa siguiendo el plan
   > Itera en pasos pequeños

3. 🧪 Testea (10-15 min)
   > Add tests
   > Run tests
   > Fix issues

4. 🎨 Refina (10-20 min)
   > Improve styling
   > Optimize performance
   > Add error handling

5. 🚀 Deploy (5-10 min)
   > Add deployment config
   > Deploy to Vercel/Railway
   > Test in production
```

---

## 📞 Obtener Ayuda

```
1. Revisa este cheat sheet
2. Lee FAQ: ./FAQ-BEGINNERS.md
3. Revisa Troubleshooting: ./docs/07-troubleshooting.md
4. Busca en Issues: github.com/rmn1978/claude-code-advanced-guide/issues
5. Abre nuevo issue si no encuentras solución
```

---

**💾 Guarda este cheat sheet como favorito** - Lo usarás seguido.

[← Volver al README](./README.md)
