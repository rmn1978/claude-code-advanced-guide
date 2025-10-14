# ⚙️ Configuración Avanzada de Claude Code

Esta guía profundiza en todos los aspectos de configuración para maximizar tu productividad con Claude Code.

## 📋 Tabla de Contenidos

- [Niveles de Configuración](#niveles-de-configuración)
- [Settings.json Detallado](#settingsjson-detallado)
- [CLAUDE.md como Memoria Persistente](#claudemd-como-memoria-persistente)
- [Gestión de Herramientas](#gestión-de-herramientas)
- [Configuración de Modelos](#configuración-de-modelos)
- [Optimización de Performance](#optimización-de-performance)
- [Configuración por Tipo de Proyecto](#configuración-por-tipo-de-proyecto)

## 🎯 Niveles de Configuración

Claude Code utiliza un sistema de configuración en cascada:

```
1. Settings de Usuario (~/.claude/)
   ↓ heredan y pueden sobreescribir
2. Settings de Proyecto (.claude/)
   ↓ heredan y pueden sobreescribir
3. Settings de Sesión (flags CLI)
```

### Configuración de Usuario (Global)

**Ubicación**: `~/.claude/`

```bash
~/.claude/
├── agents/           # Agentes disponibles en todos tus proyectos
├── commands/         # Comandos globales
├── hooks/            # Hooks globales
├── settings.json     # Configuración global
└── logs/             # Logs de todas las sesiones
```

**Cuándo usar**:
- Agentes que usas en múltiples proyectos
- Configuraciones personales (modelo preferido, herramientas)
- Comandos reutilizables

### Configuración de Proyecto

**Ubicación**: `tu-proyecto/.claude/`

```bash
tu-proyecto/.claude/
├── agents/           # Agentes específicos del proyecto
├── commands/         # Comandos del proyecto
├── hooks/            # Hooks del proyecto
└── settings.json     # Settings del proyecto
```

**Cuándo usar**:
- Configuraciones específicas del proyecto
- Agentes especializados para este codebase
- Comandos relacionados con la arquitectura del proyecto
- Para compartir configuración con el equipo (commit a git)

### Configuración de Sesión

```bash
# Flags temporales que sobreescriben todo
claude --verbose --model opus --no-auto-approve
```

## 🔧 Settings.json Detallado

### Estructura Completa

```json
{
  // ========== HERRAMIENTAS ==========
  "allowedTools": ["*"],
  "deniedTools": [],
  "autoApproveTools": [],

  // ========== MODELO ==========
  "model": "claude-sonnet-4-5-20250929",
  "temperature": 1.0,

  // ========== MCP ==========
  "mcpServers": {},

  // ========== UI/UX ==========
  "diffTool": "auto",
  "outputStyle": "diff",
  "statusLine": true,

  // ========== DEBUGGING ==========
  "verbose": false,
  "mcpDebug": false,
  "logLevel": "info"
}
```

### Configuración de Herramientas

#### allowedTools

Define qué herramientas puede usar Claude:

```json
{
  // Permitir todas (default)
  "allowedTools": ["*"],

  // Permitir solo lectura y búsqueda
  "allowedTools": ["Read", "Grep", "Glob"],

  // Permitir todo excepto bash
  "allowedTools": ["*"],
  "deniedTools": ["Bash"]
}
```

**Herramientas disponibles**:

| Herramienta | Descripción | Uso recomendado |
|------------|-------------|-----------------|
| `Read` | Leer archivos | Siempre |
| `Write` | Crear archivos | Proyectos nuevos |
| `Edit` | Modificar archivos | Refactoring |
| `Bash` | Ejecutar comandos | Testing, builds |
| `Grep` | Búsqueda en archivos | Análisis de código |
| `Glob` | Búsqueda de archivos | Exploración |
| `Task` | Delegar a sub-agentes | Tareas complejas |
| `WebFetch` | Obtener URLs | Documentación |
| `WebSearch` | Búsqueda web | Research |

#### autoApproveTools

Herramientas que no requieren confirmación:

```json
{
  // Auto-aprobar solo lecturas
  "autoApproveTools": ["Read", "Grep", "Glob"],

  // Aprobar también comandos seguros
  "autoApproveTools": [
    "Read", "Grep", "Glob",
    "Bash(npm test:*)",
    "Bash(npm run build:*)"
  ]
}
```

**Patrón de auto-aprobación**:

```json
{
  "autoApproveTools": [
    // Comandos específicos
    "Bash(npm install:*)",
    "Bash(git status)",
    "Bash(docker ps:*)",

    // Comandos con wildcards
    "Bash(npm run *:*)",
    "Bash(pytest *:*)",

    // Lecturas de directorios específicos
    "Read(/tmp/**)",
    "Read(/Users/username/project/**)"
  ]
}
```

### Configuración de Modelos

```json
{
  // Modelo principal
  "model": "claude-sonnet-4-5-20250929",

  // Para agentes (pueden heredar o especificar su propio)
  // Ver en cada agente: model: sonnet | opus | haiku | inherit
}
```

**Modelos disponibles**:

| Modelo | Nombre | Caso de uso |
|--------|--------|-------------|
| Sonnet 4.5 | `claude-sonnet-4-5-20250929` | Uso general (recomendado) |
| Opus 4.1 | `claude-opus-4-1-20250805` | Tareas complejas |
| Haiku 3.5 | `claude-3-5-haiku-20241022` | Tareas simples/rápidas |

**Estrategia de modelos**:

```json
// ~/.claude/settings.json (usuario)
{
  "model": "claude-sonnet-4-5-20250929"  // Default para todo
}

// .claude/settings.json (proyecto)
{
  "model": "claude-opus-4-1-20250805"  // Este proyecto requiere Opus
}

// .claude/agents/quick-formatter.md
---
model: haiku  # Este agente es simple, usar Haiku para velocidad
---
```

### Configuración de UI/UX

#### diffTool

Cómo mostrar cambios en archivos:

```json
{
  // Auto-detectar mejor herramienta
  "diffTool": "auto",

  // Forzar VS Code diff
  "diffTool": "vscode",

  // Usar diff de terminal
  "diffTool": "terminal",

  // Sin diff, mostrar archivo completo
  "diffTool": "none"
}
```

#### outputStyle

Cómo mostrar output:

```json
{
  // Mostrar solo diffs (recomendado)
  "outputStyle": "diff",

  // Mostrar archivo completo
  "outputStyle": "full",

  // Minimal (solo nombres de archivo)
  "outputStyle": "minimal"
}
```

#### statusLine

Status line en VS Code:

```json
{
  // Mostrar status en VS Code
  "statusLine": true,

  // Ocultar status
  "statusLine": false,

  // Custom format
  "statusLine": {
    "enabled": true,
    "format": "$(robot) Claude: {model} | {status}",
    "position": "left"
  }
}
```

### Configuración de Debugging

```json
{
  // Logs verbosos
  "verbose": true,

  // Debug de MCPs
  "mcpDebug": true,

  // Nivel de logs
  "logLevel": "debug",  // error | warn | info | debug

  // Archivo de logs custom
  "logFile": "/Users/username/claude-debug.log"
}
```

## 📝 CLAUDE.md como Memoria Persistente

`CLAUDE.md` es el "cerebro" de tu proyecto. Claude lo lee automáticamente al inicio de cada sesión.

### Estructura Recomendada

```markdown
# Project: [Nombre del Proyecto]

## 🎯 Descripción
[Descripción breve del proyecto]

## 🏗️ Arquitectura

### Stack Tecnológico
- **Frontend**: [Tecnologías]
- **Backend**: [Tecnologías]
- **Database**: [Base de datos]
- **Infrastructure**: [Infraestructura]

### Estructura de Directorios
\`\`\`
/
├── src/
│   ├── api/
│   ├── components/
│   └── utils/
├── tests/
└── docs/
\`\`\`

## 📐 Convenciones de Código

### Naming Conventions
- Variables: camelCase
- Funciones: camelCase
- Clases: PascalCase
- Archivos: kebab-case
- Constantes: UPPER_SNAKE_CASE

### TypeScript Rules
- Siempre usar tipos explícitos
- Interfaces para objetos
- Types para uniones
- Evitar `any`

### Database Schema
- Tablas: plural, snake_case
- Columnas: snake_case
- Foreign keys: {tabla}_id

## 🧪 Testing

### Test Structure
\`\`\`
tests/
├── unit/          # Jest
├── integration/   # Supertest
└── e2e/           # Playwright
\`\`\`

### Coverage Requirements
- Unit: 80% minimum
- Integration: 70% minimum
- E2E: Critical paths

## 🚀 Workflows

### Development Workflow
1. Crear branch feature/nombre
2. Implementar con TDD
3. Tests passing
4. Code review
5. Merge a develop

### Git Conventions
Usar Conventional Commits:
- feat: Nueva feature
- fix: Bug fix
- docs: Documentación
- refactor: Refactoring
- test: Tests

### Deployment
- **Staging**: Auto-deploy on merge to develop
- **Production**: Manual deploy from main

## 🔐 Security

### Authentication
- JWT con expiración 15min
- Refresh tokens 7 días
- HttpOnly cookies

### Data Validation
- Zod para validación
- Sanitización de inputs
- Prepared statements (Prisma)

## 📦 Dependencies

### Core Dependencies
\`\`\`json
{
  "express": "^4.18.2",
  "react": "^18.2.0",
  "prisma": "^5.7.0"
}
\`\`\`

### Development Commands
\`\`\`bash
npm run dev          # Start dev server
npm test             # Run tests
npm run build        # Production build
npm run db:migrate   # Run migrations
\`\`\`

## 🐛 Known Issues
- [Issue 1]: Descripción y workaround
- [Issue 2]: Descripción y workaround

## 📚 Documentation
- API Docs: /docs/api.md
- Architecture: /docs/architecture.md
- Setup Guide: README.md

## 👥 Team
- Tech Lead: @username1
- Backend: @username2
- Frontend: @username3

## 🎯 Current Sprint Goals
- [ ] Implementar autenticación OAuth
- [ ] Migrar a PostgreSQL
- [ ] Optimizar queries N+1

## 💡 Important Notes
- NUNCA commitear .env
- SIEMPRE ejecutar tests antes de PR
- SIEMPRE usar TypeScript strict mode
```

### Templates por Tipo de Proyecto

#### API RESTful

```markdown
# API RESTful Project

## API Design Principles
- RESTful conventions
- Versioning: /api/v1/
- Consistent error responses
- HATEOAS links

## Endpoints Structure
\`\`\`
GET    /api/v1/resources           # List
GET    /api/v1/resources/:id       # Get one
POST   /api/v1/resources           # Create
PUT    /api/v1/resources/:id       # Update (full)
PATCH  /api/v1/resources/:id       # Update (partial)
DELETE /api/v1/resources/:id       # Delete
\`\`\`

## Response Format
\`\`\`json
{
  "data": { ... },
  "meta": {
    "page": 1,
    "totalPages": 10
  },
  "links": {
    "self": "/api/v1/resources?page=1",
    "next": "/api/v1/resources?page=2"
  }
}
\`\`\`

## Error Handling
\`\`\`json
{
  "error": {
    "code": "RESOURCE_NOT_FOUND",
    "message": "User with ID 123 not found",
    "details": { ... }
  }
}
\`\`\`
```

#### Aplicación React

```markdown
# React Application

## Component Structure
\`\`\`
src/
├── components/
│   ├── common/          # Shared components
│   ├── features/        # Feature-specific
│   └── layouts/         # Layout components
├── hooks/               # Custom hooks
├── contexts/            # React contexts
├── services/            # API calls
├── utils/               # Utility functions
└── types/               # TypeScript types
\`\`\`

## Component Patterns

### File Structure
\`\`\`
ComponentName/
├── index.ts                    # Export
├── ComponentName.tsx           # Component
├── ComponentName.test.tsx      # Tests
├── ComponentName.styles.ts     # Styles (if styled-components)
└── ComponentName.stories.tsx   # Storybook (if applicable)
\`\`\`

### Component Template
\`\`\`tsx
interface ComponentNameProps {
  prop1: string;
  prop2?: number;
}

export const ComponentName: React.FC<ComponentNameProps> = ({
  prop1,
  prop2 = 0
}) => {
  // Hooks
  const [state, setState] = useState<Type>(initialValue);

  // Effects
  useEffect(() => {
    // ...
  }, [dependencies]);

  // Handlers
  const handleClick = () => {
    // ...
  };

  // Render
  return (
    <div>
      {/* JSX */}
    </div>
  );
};
\`\`\`

## State Management
- Local state: useState
- Complex state: useReducer
- Global state: Context API + useReducer
- Server state: React Query

## Styling
- Tailwind CSS utility classes
- CSS Modules for component-specific styles
- Avoid inline styles
```

#### Microservicios

```markdown
# Microservices Architecture

## Services

### User Service
- **Port**: 3001
- **Database**: PostgreSQL (users_db)
- **Responsibilities**: Authentication, user management

### Product Service
- **Port**: 3002
- **Database**: PostgreSQL (products_db)
- **Responsibilities**: Product catalog, inventory

### Order Service
- **Port**: 3003
- **Database**: PostgreSQL (orders_db)
- **Responsibilities**: Order processing, payments

## Communication Patterns

### Synchronous (HTTP)
- REST APIs for direct requests
- gRPC for service-to-service

### Asynchronous (Events)
- RabbitMQ for event bus
- Event-driven architecture
- CQRS pattern

## Service Template

### Directory Structure
\`\`\`
service-name/
├── src/
│   ├── api/           # HTTP handlers
│   ├── domain/        # Business logic
│   ├── infra/         # Database, messaging
│   ├── events/        # Event handlers
│   └── config/        # Configuration
├── tests/
├── Dockerfile
└── docker-compose.yml
\`\`\`

### Port Allocation
- User Service: 3001
- Product Service: 3002
- Order Service: 3003
- API Gateway: 3000
- RabbitMQ: 5672
- PostgreSQL: 5432 (different databases)

## Deployment
- Each service in own container
- Kubernetes for orchestration
- Helm charts for configuration
```

## 🎨 Configuración por Tipo de Proyecto

### Frontend React/Vue

```json
// .claude/settings.json
{
  "allowedTools": [
    "Read", "Write", "Edit", "Grep", "Glob",
    "Bash(npm *:*)",
    "Bash(npx *:*)"
  ],
  "autoApproveTools": [
    "Read", "Grep", "Glob",
    "Bash(npm run dev:*)",
    "Bash(npm test:*)"
  ],
  "model": "claude-sonnet-4-5-20250929"
}
```

```markdown
<!-- CLAUDE.md -->
# Frontend Application

## Component Development Workflow
1. Create component skeleton
2. Add TypeScript interfaces
3. Implement functionality
4. Add Storybook story
5. Write tests
6. Document props

## Quality Gates
- TypeScript: No errors
- ESLint: No warnings
- Tests: 80% coverage
- Storybook: All stories render
```

### Backend API

```json
// .claude/settings.json
{
  "allowedTools": [
    "Read", "Write", "Edit", "Bash", "Grep", "Glob"
  ],
  "autoApproveTools": [
    "Read", "Grep",
    "Bash(npm test:*)",
    "Bash(docker ps:*)",
    "Bash(psql *:*)"
  ],
  "model": "claude-sonnet-4-5-20250929",
  "mcpServers": {}  // Heredar de ~/.claude.json
}
```

```markdown
<!-- CLAUDE.md -->
# Backend API

## API Development Workflow
1. Design endpoint schema
2. Create migration
3. Implement controller
4. Add validation
5. Write unit tests
6. Write integration tests
7. Update API docs

## Testing Strategy
- Unit: Controllers, services, utils
- Integration: API endpoints
- E2E: Critical user flows

## Performance Requirements
- Response time: < 200ms (p95)
- Database queries: < 50ms
- No N+1 queries
```

### Full-Stack Monorepo

```json
// .claude/settings.json
{
  "allowedTools": ["*"],
  "autoApproveTools": [
    "Read", "Grep", "Glob",
    "Bash(npm run dev:*)",
    "Bash(npm test:*)",
    "Bash(npm run build:*)"
  ],
  "model": "claude-sonnet-4-5-20250929"
}
```

```markdown
<!-- CLAUDE.md -->
# Full-Stack Monorepo

## Workspace Structure
\`\`\`
/
├── apps/
│   ├── web/          # Frontend
│   └── api/          # Backend
├── packages/
│   ├── ui/           # Shared components
│   ├── types/        # Shared types
│   └── utils/        # Shared utilities
└── turbo.json        # Turborepo config
\`\`\`

## Development Workflow
\`\`\`bash
# Install all dependencies
npm install

# Run all apps in dev mode
npm run dev

# Run specific app
npm run dev --filter=web

# Run tests across workspace
npm run test
\`\`\`

## Code Sharing
- Import from packages: `@repo/ui`, `@repo/types`
- Version in sync via turbo
- Shared config in root
```

## 🚀 Optimización de Performance

### Reducir Uso de Contexto

```json
{
  // Permitir solo herramientas necesarias
  "allowedTools": [
    "Read",
    "Edit",    // No Write (crear archivos innecesarios)
    "Grep",
    "Glob"
  ],

  // Auto-aprobar lecturas para velocidad
  "autoApproveTools": ["Read", "Grep", "Glob"]
}
```

### Estrategia de Modelos por Tarea

```markdown
<!-- CLAUDE.md -->
## Agent Strategy

### Haiku (Fast)
- Simple refactoring
- Formatting
- Documentation updates
- Quick fixes

### Sonnet (Balanced)
- Feature implementation
- Bug fixing
- Code review
- Test writing

### Opus (Complex)
- Architecture decisions
- Complex refactoring
- Security audits
- Performance optimization
```

### Limitar Scope de Archivos

```bash
# Iniciar Claude con scope limitado
claude --add-dir ./src --add-dir ./tests

# No agregar:
# - node_modules (automáticamente excluido)
# - build/dist
# - .git
# - assets grandes
```

## ✅ Checklist de Configuración

### Nivel Usuario

- [ ] `~/.claude/settings.json` configurado
- [ ] Modelo preferido definido
- [ ] Herramientas auto-aprobadas configuradas
- [ ] MCP servers globales configurados en `~/.claude.json`
- [ ] Agentes personales creados en `~/.claude/agents/`

### Nivel Proyecto

- [ ] `.claude/` directory creado
- [ ] `.claude/settings.json` con settings del proyecto
- [ ] `CLAUDE.md` con convenciones y arquitectura
- [ ] `.mcp.json` con MCPs específicos del proyecto (opcional)
- [ ] Agentes del proyecto en `.claude/agents/`
- [ ] Comandos del proyecto en `.claude/commands/`
- [ ] `.gitignore` incluye `.claude/logs/` si aplica

### Verificación

```bash
# Verificar configuración
claude

# En la sesión de Claude
/context      # Ver archivos en scope
/agents       # Ver agentes disponibles
/mcp          # Ver MCPs conectados
/help         # Ver comandos disponibles
```

## 📚 Próximos Pasos

- [Crear Agentes Especializados →](03-agents.md)
- [Configurar MCP Servers →](04-mcp-servers.md)
- [Workflows Avanzados →](05-workflows.md)
