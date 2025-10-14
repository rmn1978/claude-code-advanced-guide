# 🤖 Claude Code Agents - Marketplace

Colección completa de agentes especializados para Claude Code. Cada agente es un experto en su dominio con herramientas, patrones y mejores prácticas específicas.

## 📚 Índice

- [Stack-Specific Architects](#-stack-specific-architects-arquitectos-de-stacks)
- [Domain-Specific Agents](#-domain-specific-agents-agentes-de-dominio)
- [Workflow Agents](#-workflow-agents-agentes-de-flujo-de-trabajo)
- [How to Use](#-cómo-usar-los-agentes)
- [Creating Custom Agents](#-crear-agentes-personalizados)

---

## 🏗️ Stack-Specific Architects (Arquitectos de Stacks)

Agentes expertos en tecnologías y frameworks específicos.

### Frontend Stacks

#### 1. **Next.js Architect** [`nextjs-architect`]
**Archivo**: [`stacks/react-next/nextjs-architect.md`](./stacks/react-next/nextjs-architect.md)

Experto en Next.js 15+, App Router, React Server Components y arquitectura frontend moderna.

**Especialidades**:
- ✅ App Router vs Pages Router decisiones
- ✅ Server Components vs Client Components
- ✅ Rendering strategies (SSR, SSG, ISR)
- ✅ Server Actions y Route Handlers
- ✅ Performance optimization (code splitting, lazy loading)
- ✅ TypeScript patterns con Next.js

**Cuándo usar**:
- Construir aplicaciones Next.js 13+
- Migrar de Pages Router a App Router
- Optimizar rendering y performance
- Implementar autenticación con NextAuth
- Diseñar arquitectura de componentes React

**Tools**: Read, Write, Edit, Bash, Grep, Glob
**Model**: opus (alta calidad)

---

#### 2. **Vue/Nuxt Architect** [`nuxt-architect`]
**Archivo**: [`stacks/vue-nuxt/nuxt-architect.md`](./stacks/vue-nuxt/nuxt-architect.md)

Experto en Vue 3 Composition API, Nuxt 3, SSR y arquitectura frontend moderna.

**Especialidades**:
- ✅ Composition API patterns y composables
- ✅ Nuxt 3 features (auto-imports, server routes)
- ✅ Pinia state management
- ✅ SSR, SSG, SPA y hybrid rendering
- ✅ Performance optimization
- ✅ TypeScript con Vue 3

**Cuándo usar**:
- Construir aplicaciones Vue 3 / Nuxt 3
- Implementar composables reutilizables
- Diseñar state management con Pinia
- Optimizar rendering strategies
- Crear server API routes

**Tools**: Read, Write, Edit, Bash, Grep, Glob
**Model**: opus

---

### Backend Stacks

#### 3. **Django Architect** [`django-architect`]
**Archivo**: [`stacks/python-django/django-architect.md`](./stacks/python-django/django-architect.md)

Experto en Django, Django REST Framework, y arquitectura backend Python.

**Especialidades**:
- ✅ Django ORM optimization (select_related, prefetch_related)
- ✅ Django REST Framework (ViewSets, Serializers)
- ✅ Authentication & Permissions
- ✅ Celery background tasks
- ✅ Testing (pytest-django)
- ✅ Performance & caching

**Cuándo usar**:
- Construir APIs REST con Django
- Optimizar queries de base de datos
- Implementar autenticación compleja
- Diseñar arquitectura de modelos
- Crear admin personalizado

**Tools**: Read, Write, Edit, Bash, Grep, Glob
**Model**: opus

---

#### 4. **FastAPI Architect** [`fastapi-architect`]
**Archivo**: [`stacks/python-fastapi/fastapi-architect.md`](./stacks/python-fastapi/fastapi-architect.md)

Experto en FastAPI, async Python, Pydantic y APIs de alto rendimiento.

**Especialidades**:
- ✅ Async operations con asyncio
- ✅ Pydantic schemas y validation
- ✅ SQLAlchemy 2.0 async
- ✅ Repository pattern
- ✅ JWT authentication
- ✅ Type safety con Python 3.10+

**Cuándo usar**:
- Construir APIs asíncronas de alta performance
- Implementar type safety con Pydantic
- Crear microservicios modernos
- Documentación automática OpenAPI
- Operaciones I/O intensivas

**Tools**: Read, Write, Edit, Bash, Grep, Glob
**Model**: opus

---

#### 5. **Express.js Architect** [`express-architect`]
**Archivo**: [`stacks/node-express/express-architect.md`](./stacks/node-express/express-architect.md)

Experto en Node.js, Express.js, TypeScript y arquitectura backend JavaScript.

**Especialidades**:
- ✅ RESTful API design
- ✅ Middleware patterns
- ✅ Authentication con JWT
- ✅ Error handling
- ✅ Database integration (Prisma, TypeORM)
- ✅ TypeScript best practices

**Cuándo usar**:
- Construir APIs REST con Node.js
- Implementar middleware personalizado
- Diseñar arquitectura de microservicios
- Integrar con Prisma ORM
- Crear sistemas de autenticación

**Tools**: Read, Write, Edit, Bash, Grep, Glob
**Model**: opus

---

## 🎯 Domain-Specific Agents (Agentes de Dominio)

Agentes especializados en industrias y dominios específicos.

### Healthcare AI Agent [`medical-diagnostic`]
**Archivo**: [`healthcare/medical-diagnostic.md`](./healthcare/medical-diagnostic.md)

Experto en aplicaciones médicas, HIPAA compliance, terminología médica.

**Especialidades**:
- Healthcare data standards (FHIR, HL7)
- Medical terminology (ICD-10, SNOMED)
- HIPAA compliance
- Patient privacy & security
- Medical AI ethics

**⚠️ Disclaimer**: Solo para desarrollo de software médico, no para diagnósticos reales.

**Tools**: Read, Grep, Glob (solo lectura por seguridad)
**Model**: opus

---

## 🔄 Workflow Agents (Agentes de Flujo de Trabajo)

Agentes especializados para tareas específicas del ciclo de desarrollo. Estos agentes cubren deployment, testing, performance, monitoring, security y más.

### 1. **Deployment Specialist** [`deployment-specialist`] 🚀
**Archivo**: [`workflow/deployment-specialist.md`](./workflow/deployment-specialist.md)

Experto en despliegue de aplicaciones a varias plataformas (Vercel, Railway, AWS, Docker).

**Especialidades**:
- ✅ Deployment configs (Vercel, Railway, Render, AWS)
- ✅ Docker optimization (multi-stage builds)
- ✅ CI/CD pipelines (GitHub Actions, GitLab CI)
- ✅ Environment management
- ✅ Performance optimization (caching, compression)
- ✅ Health checks y monitoring setup

**Cuándo usar**:
- Desplegar aplicaciones a producción
- Configurar Docker y docker-compose
- Crear pipelines de CI/CD
- Optimizar deployments para performance
- Implementar health checks

**Tools**: Read, Write, Edit, Bash, Grep, Glob
**Model**: sonnet
**Priority**: high

---

### 2. **Database Architect** [`database-architect`] 🗄️
**Archivo**: [`workflow/database-architect.md`](./workflow/database-architect.md)

Experto en diseño de bases de datos PostgreSQL/MongoDB, optimización y migraciones.

**Especialidades**:
- ✅ Schema design (constraints, relationships, normalization)
- ✅ Query optimization (N+1 prevention, indexing)
- ✅ Indexing strategies (B-tree, GIN, GiST, BRIN)
- ✅ Safe migrations (zero-downtime)
- ✅ Connection pooling
- ✅ Performance tuning y profiling

**Cuándo usar**:
- Diseñar schema de base de datos
- Optimizar queries lentas
- Implementar migraciones seguras
- Configurar indexes apropiados
- Resolver problemas de N+1

**Tools**: Read, Write, Edit, Bash, Grep, Glob
**Model**: sonnet
**Priority**: high

---

### 3. **Testing Specialist** [`testing-specialist`] 🧪
**Archivo**: [`workflow/testing-specialist.md`](./workflow/testing-specialist.md)

Experto en crear test suites comprehensivos (Jest, Vitest, Pytest, Playwright, Cypress).

**Especialidades**:
- ✅ Test strategy y test pyramids
- ✅ Unit tests (Jest, Vitest, Pytest)
- ✅ Integration tests
- ✅ E2E tests (Playwright, Cypress)
- ✅ Performance tests (k6, Locust)
- ✅ Test coverage y CI/CD integration

**Cuándo usar**:
- Crear test suites completos
- Configurar testing frameworks
- Implementar E2E tests
- Mejorar test coverage
- Integrar tests en CI/CD

**Tools**: Read, Write, Edit, Bash, Grep, Glob
**Model**: sonnet
**Priority**: high

---

### 4. **Performance Specialist** [`performance-specialist`] ⚡
**Archivo**: [`workflow/performance-specialist.md`](./workflow/performance-specialist.md)

Experto en optimización de performance (profiling, caching, Core Web Vitals, lazy loading).

**Especialidades**:
- ✅ Core Web Vitals (LCP, FID, CLS)
- ✅ Frontend optimization (code splitting, lazy loading)
- ✅ Backend optimization (query optimization, caching)
- ✅ Asset optimization (images, fonts, compression)
- ✅ Profiling tools (Chrome DevTools, React Profiler)
- ✅ Real User Monitoring (RUM)

**Cuándo usar**:
- Optimizar Core Web Vitals
- Mejorar tiempo de carga
- Reducir bundle size
- Implementar caching strategies
- Configurar CDN y compression

**Tools**: Read, Write, Edit, Bash, Grep, Glob
**Model**: sonnet
**Priority**: high

---

### 5. **Monitoring Specialist** [`monitoring-specialist`] 📊
**Archivo**: [`workflow/monitoring-specialist.md`](./workflow/monitoring-specialist.md)

Experto en monitoring, logging, error tracking y observability (Sentry, Datadog, Prometheus).

**Especialidades**:
- ✅ Error tracking (Sentry configuration)
- ✅ Structured logging (Winston, Pino, Python logging)
- ✅ Application metrics (Prometheus, Datadog)
- ✅ Distributed tracing (OpenTelemetry)
- ✅ Health checks (liveness, readiness)
- ✅ Alerting (Prometheus alerts, PagerDuty)

**Cuándo usar**:
- Configurar error tracking
- Implementar structured logging
- Crear dashboards (Grafana)
- Setup health checks
- Configurar alertas

**Tools**: Read, Write, Edit, Bash, Grep, Glob
**Model**: sonnet
**Priority**: high

---

### 6. **Security Specialist** [`security-specialist`] 🔒
**Archivo**: [`workflow/security-specialist.md`](./workflow/security-specialist.md)

Experto en application security (authentication, authorization, OWASP Top 10, security headers).

**Especialidades**:
- ✅ Authentication (JWT, OAuth, passwordless)
- ✅ Authorization (RBAC, ABAC, permissions)
- ✅ Input validation (prevent injection attacks)
- ✅ Security headers (CSP, CORS, HSTS)
- ✅ Secrets management
- ✅ OWASP Top 10 vulnerabilities

**Cuándo usar**:
- Implementar authentication/authorization
- Auditar código por vulnerabilidades
- Configurar security headers
- Implementar rate limiting
- Encrypting sensitive data

**Tools**: Read, Write, Edit, Bash, Grep, Glob
**Model**: sonnet
**Priority**: high

---

### 7. **Code Reviewer** [`code-reviewer`] 👀
**Archivo**: [`../templates/agents/code-reviewer.md`](../templates/agents/code-reviewer.md)

Revisa código con enfoque en calidad, seguridad y performance.

**Checklist**:
- Code quality (25%): Readability, DRY, naming
- Functionality (30%): Logic, edge cases, error handling
- Performance (15%): Optimization, complexity
- Security (20%): Vulnerabilities, data validation
- Testing (10%): Test coverage, quality

**Tools**: Read, Grep, Glob
**Model**: sonnet (balanceado)

---

## 📊 Comparación Rápida de Stacks

| Stack | Language | Rendering | Type Safety | Learning Curve | Performance | Best For |
|-------|----------|-----------|-------------|----------------|-------------|----------|
| **Next.js** | TypeScript/JS | SSR/SSG/ISR | ⭐⭐⭐⭐⭐ | Medium | ⭐⭐⭐⭐ | Full-stack React apps, SEO |
| **Nuxt** | TypeScript/JS | SSR/SSG/SPA | ⭐⭐⭐⭐ | Medium | ⭐⭐⭐⭐ | Full-stack Vue apps, content sites |
| **Django** | Python | Server-side | ⭐⭐⭐ | Medium-High | ⭐⭐⭐ | Monolithic apps, admin panels |
| **FastAPI** | Python | N/A (API) | ⭐⭐⭐⭐⭐ | Low-Medium | ⭐⭐⭐⭐⭐ | Async APIs, microservices |
| **Express** | TypeScript/JS | N/A (API) | ⭐⭐⭐⭐ | Low | ⭐⭐⭐⭐ | REST APIs, real-time apps |

---

## 🚀 Cómo Usar los Agentes

### Opción 1: Uso Directo en Claude Code

```bash
# En Claude Code (VS Code), escribe:
> Use the nextjs-architect agent to create a product listing page with SSR

> Use the django-architect agent to optimize these database queries

> Use the code-reviewer agent to review this pull request
```

### Opción 2: Instalación Local

```bash
# Copiar agente al proyecto local
cp agents/stacks/react-next/nextjs-architect.md .claude/agents/

# Ahora Claude Code lo detectará automáticamente
```

### Opción 3: Instalación Global

```bash
# Copiar a directorio global de agentes
cp agents/stacks/python-fastapi/fastapi-architect.md ~/.claude/agents/

# Disponible en todos tus proyectos
```

---

## 🛠️ Crear Agentes Personalizados

### Método 1: Generador Interactivo (Recomendado)

```bash
# Ejecutar el generador interactivo
./scripts/generate-agent.sh

# Sigue el asistente paso a paso:
# 1. Nombre del agente
# 2. Tipo (architecture, development, testing, etc.)
# 3. Stack tecnológico
# 4. Herramientas (Read, Write, Edit, Bash)
# 5. Modelo (haiku, sonnet, opus)
```

### Método 2: Desde Template

```bash
# Copiar template base
cp templates/agents/agent-template.md .claude/agents/my-agent.md

# Editar el archivo con tu configuración
```

### Estructura de un Agente

```markdown
---
name: agent-name
description: When to use this agent
tools: Read, Write, Edit, Bash, Grep, Glob
model: sonnet
priority: medium
---

You are an expert in [domain].

## 🎯 Core Responsibilities
1. [Responsibility 1]
2. [Responsibility 2]

## 🔧 Expertise Areas
- **Area 1**: Description
- **Area 2**: Description

## 📋 Process
### Step 1: [First Step]
[Instructions]

### Step 2: [Second Step]
[Instructions]

## ✅ Quality Checklist
- [ ] Check 1
- [ ] Check 2

## 🎯 Best Practices
1. **Practice 1**: Description
2. **Practice 2**: Description
```

---

## 📖 Ejemplos de Uso Multi-Agente

### Ejemplo 1: Feature Pipeline

```markdown
# Crear nueva feature completa

1. **Architect** → Diseña la arquitectura
   > Use nextjs-architect to design a user dashboard feature

2. **Developer** → Implementa el código
   > Implement the dashboard following the architecture

3. **Test Generator** → Crea tests
   > Use test-generator to create comprehensive tests

4. **Security Auditor** → Audita seguridad
   > Use security-auditor to check for vulnerabilities

5. **Code Reviewer** → Revisa calidad
   > Use code-reviewer to review the complete implementation
```

### Ejemplo 2: Microservices Stack

```markdown
# Proyecto con múltiples servicios

- **Frontend**: nextjs-architect
  > Use nextjs-architect for the customer-facing app

- **API Gateway**: express-architect
  > Use express-architect for the API gateway

- **Auth Service**: fastapi-architect
  > Use fastapi-architect for authentication microservice

- **Admin Panel**: django-architect
  > Use django-architect for the admin dashboard
```

---

## 🎓 Recursos Adicionales

- **Guía de Configuración**: [`../docs/02-configuration.md`](../docs/02-configuration.md)
- **Guía de Agentes**: [`../docs/03-agents.md`](../docs/03-agents.md)
- **Multi-Agent Orchestration**: [`../docs/guides/02-intermediate/multi-agent-orchestration.md`](../docs/guides/02-intermediate/multi-agent-orchestration.md)
- **Ejemplos Completos**: [`../examples/`](../examples/)

---

## 🤝 Contribuir

¿Creaste un agente útil? ¡Compártelo!

1. Fork el repositorio
2. Crea tu agente siguiendo la estructura
3. Agrega documentación y ejemplos
4. Abre un Pull Request

---

## 📊 Estadísticas

- **Total Agentes**: 8+ (creciendo)
- **Stacks Cubiertos**: 5 (Next.js, Nuxt, Django, FastAPI, Express)
- **Dominios**: Healthcare, más en desarrollo
- **Templates**: 3 (Code Reviewer, Test Generator, Security Auditor)

---

## 💡 Tips

1. **Combina agentes**: Usa múltiples agentes en secuencia para flujos complejos
2. **Personaliza**: Modifica agentes existentes para tu stack específico
3. **Prioriza**: Usa `priority: high` para agentes críticos
4. **Itera**: Los agentes aprenden del contexto del proyecto (CLAUDE.md)

---

**¿Necesitas ayuda?** Consulta la [documentación completa](../README.md) o abre un [issue](https://github.com/tu-usuario/claude-code-advanced-guide/issues).

**Próximos agentes**: Ruby/Rails, Go, Rust, Flutter, React Native... ¡y más!
