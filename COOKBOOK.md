# 📖 Claude Code Cookbook

Recetas rápidas para tareas comunes con Claude Code. Cada receta incluye el comando exacto y el resultado esperado.

## 📋 Índice

- [Setup & Configuration](#setup--configuration)
- [Creating Agents](#creating-agents)
- [Building Applications](#building-applications)
- [Database & Backend](#database--backend)
- [Frontend & UI](#frontend--ui)
- [Testing & Quality](#testing--quality)
- [Deployment](#deployment)
- [Optimization](#optimization)

---

## 🔧 Setup & Configuration

### Receta 1: Setup Inicial de Proyecto

```bash
# En Claude Code
> Initialize a new Next.js 15 project with TypeScript, Tailwind CSS, and App Router. Set up the basic folder structure with components/, lib/, and types/ directories.

# Resultado:
- next.config.js configurado
- tailwind.config.ts con preset
- tsconfig.json strict mode
- Estructura de carpetas creada
- .gitignore apropiado
```

**Tiempo**: 2 minutos

---

### Receta 2: Configurar CLAUDE.md para Proyecto

```bash
> Create a comprehensive CLAUDE.md file for this [tipo de proyecto] project that includes:
  - Project overview and tech stack
  - Architecture decisions
  - Database schema
  - API conventions
  - Code style guide
  - Common tasks

# Ejemplo para E-commerce:
> Create a CLAUDE.md for an e-commerce platform using Next.js and Django. Include product catalog structure, order flow, and payment integration patterns.
```

**Tiempo**: 3 minutos

---

### Receta 3: Configurar settings.json con Permisos

```bash
> Create a .claude/settings.json file with the following configuration:
  - Allow all file operations (Read, Write, Edit)
  - Allow Bash for git, npm, and docker
  - Enable Grep and Glob for search
  - Set model to sonnet for general tasks
  - Add tools priority list

# Resultado:
{
  "allowedTools": ["Read", "Write", "Edit", "Bash", "Grep", "Glob"],
  "bashAllowList": ["git*", "npm*", "docker*"],
  "defaultModel": "sonnet"
}
```

**Tiempo**: 1 minuto

---

## 🤖 Creating Agents

### Receta 4: Crear Agente de Code Review

```bash
# Opción 1: Usar el generador
./scripts/generate-agent.sh

# Seleccionar:
# Tipo: code-review
# Tools: Read, Grep, Glob
# Model: sonnet

# Opción 2: Con prompt directo
> Create a code review agent that checks for:
  - Code quality (naming, readability, DRY)
  - Security issues (SQL injection, XSS)
  - Performance problems (N+1 queries, unnecessary re-renders)
  - Test coverage
  Save it to .claude/agents/code-reviewer.md
```

**Tiempo**: 2 minutos

---

### Receta 5: Crear Agente de Testing

```bash
> Use test-generator agent template to create an agent that:
  - Generates unit tests with Jest/Vitest
  - Creates integration tests
  - Includes test fixtures and mocks
  - Achieves 80%+ coverage
  - Follows AAA pattern (Arrange, Act, Assert)
```

**Tiempo**: 2 minutos

---

### Receta 6: Agente Específico de Stack

```bash
# Para Next.js
> Copy the nextjs-architect agent to my project and customize it for:
  - Our specific design system (shadcn/ui)
  - Our state management (Zustand)
  - Our API client (tRPC)

# Para Django
> Copy the django-architect agent and customize for:
  - Our authentication system (JWT + OAuth2)
  - Our ORM patterns (select_related rules)
  - Our serializer conventions
```

**Tiempo**: 5 minutos

---

## 🏗️ Building Applications

### Receta 7: API REST Completa en 5 Minutos

```bash
> Use fastapi-architect to create a complete REST API for [recurso] with:
  - CRUD endpoints (GET, POST, PUT, DELETE)
  - Pydantic schemas for validation
  - SQLAlchemy models
  - JWT authentication
  - Pagination and filtering
  - OpenAPI documentation
  - Error handling
  - Tests with pytest

# Ejemplo:
> Use fastapi-architect to create a complete REST API for a task management system with tasks, projects, and users.
```

**Tiempo**: 5 minutos
**Resultado**: API funcional con ~500 líneas de código

---

### Receta 8: Página de Listado con SSR

```bash
> Use nextjs-architect to create a product listing page with:
  - Server-side rendering for SEO
  - Pagination (server-side)
  - Filters (category, price range, search)
  - Sorting options
  - Optimistic UI for interactions
  - Loading states with Suspense
  - Error boundaries

# Incluir:
- app/products/page.tsx (Server Component)
- components/ProductCard.tsx
- components/ProductFilters.tsx (Client Component)
- lib/api/products.ts
```

**Tiempo**: 8 minutos

---

### Receta 9: Formulario con Validación

```bash
> Create a multi-step form for user registration with:
  - Step 1: Email and password
  - Step 2: Personal information
  - Step 3: Preferences
  - Zod validation on each step
  - React Hook Form integration
  - Progress indicator
  - Error messages
  - Success confirmation

# Stack: Next.js + TypeScript + Tailwind
```

**Tiempo**: 10 minutos

---

## 💾 Database & Backend

### Receta 10: Configurar Prisma con PostgreSQL

```bash
> Set up Prisma ORM for PostgreSQL with:
  - Initial schema (User, Post models)
  - Migrations configured
  - Seed script with sample data
  - Database utilities (connect, disconnect)
  - TypeScript types generated
  - CRUD repository pattern

# Incluir:
- prisma/schema.prisma
- prisma/seed.ts
- lib/db.ts
```

**Tiempo**: 5 minutos

---

### Receta 11: Optimizar Query N+1

```bash
> I have this code with N+1 query problem:
[pegar código]

Optimize it using:
- select_related for ForeignKey (Django)
- prefetch_related for Many-to-Many (Django)
- joinedload/selectinload for SQLAlchemy
- Include benchmark comparison

# Resultado: Código optimizado + explicación
```

**Tiempo**: 3 minutos

---

### Receta 12: Crear Migración de Base de Datos

```bash
# Django
> Create a Django migration to add a 'status' field to the Order model with choices (pending, processing, completed, cancelled). Include data migration to set existing orders to 'completed'.

# Alembic (FastAPI/Flask)
> Create an Alembic migration to add a 'subscription_tier' enum column to users table with values (free, pro, enterprise). Set default to 'free'.
```

**Tiempo**: 2 minutos

---

## 🎨 Frontend & UI

### Receta 13: Implementar Dark Mode

```bash
> Implement dark mode toggle using next-themes with:
  - Persistent preference (localStorage)
  - System preference detection
  - Smooth transition animations
  - Dark mode styles for all components
  - Toggle button in header

# Stack: Next.js + Tailwind CSS
```

**Tiempo**: 5 minutos

---

### Receta 14: Crear Sistema de Diseño

```bash
> Create a design system with:
  - Color palette (primary, secondary, neutral, semantic)
  - Typography scale (headings, body, code)
  - Spacing scale (4px base)
  - Component library (Button, Input, Card, Modal)
  - Storybook setup for documentation

# Using shadcn/ui as base
```

**Tiempo**: 15 minutos

---

### Receta 15: Optimizar Imágenes

```bash
> Optimize all images in the public/images/ directory:
  - Convert to WebP format
  - Generate multiple sizes (thumbnail, medium, large)
  - Create blur placeholders
  - Update Image components to use optimized versions
  - Add loading="lazy" where appropriate

# Framework: Next.js
```

**Tiempo**: 5 minutos

---

## 🧪 Testing & Quality

### Receta 16: Generar Tests Unitarios

```bash
> Generate comprehensive unit tests for [archivo]:
  - Test all functions/methods
  - Include edge cases and error scenarios
  - Mock external dependencies
  - Achieve 90%+ coverage
  - Use descriptive test names

# Ejemplo:
> Generate comprehensive unit tests for lib/utils/date-formatter.ts using Vitest
```

**Tiempo**: 5 minutos por archivo

---

### Receta 17: E2E Test con Playwright

```bash
> Create E2E tests for the user registration flow with Playwright:
  1. Navigate to /register
  2. Fill form with valid data
  3. Submit form
  4. Verify redirect to /dashboard
  5. Check welcome message displayed
  Include error scenarios (invalid email, password too short)
```

**Tiempo**: 8 minutos

---

### Receta 18: Security Audit

```bash
> Use security-auditor agent to audit this codebase for:
  - SQL injection vulnerabilities
  - XSS vulnerabilities
  - CSRF protection
  - Authentication issues
  - Sensitive data exposure
  - Dependency vulnerabilities

Generate a report with findings and fixes.
```

**Tiempo**: 10 minutos

---

## 🚀 Deployment

### Receta 19: Configurar Docker

```bash
> Create Docker setup for this Next.js + FastAPI application:
  - Dockerfile for frontend (multi-stage build)
  - Dockerfile for backend (Python 3.11)
  - docker-compose.yml (frontend, backend, postgres, redis)
  - .dockerignore files
  - Environment variable handling
  - Health checks

# Incluir comandos de build y run
```

**Tiempo**: 10 minutos

---

### Receta 20: Deploy a Vercel

```bash
> Prepare this Next.js app for Vercel deployment:
  - Create vercel.json configuration
  - Set up environment variables documentation
  - Add build optimization settings
  - Configure redirects and rewrites
  - Add deployment preview comments script
  - Create deploy documentation in DEPLOY.md
```

**Tiempo**: 5 minutos

---

### Receta 21: CI/CD con GitHub Actions

```bash
> Create GitHub Actions workflow for:
  - Run tests on every PR
  - Lint code (ESLint, Prettier)
  - Type check (TypeScript)
  - Build application
  - Deploy to staging on merge to develop
  - Deploy to production on merge to main

# Incluir caching para dependencies
```

**Tiempo**: 10 minutos

---

## ⚡ Optimization

### Receta 22: Optimizar Bundle Size

```bash
> Analyze and optimize the bundle size of this Next.js app:
  - Run bundle analyzer
  - Identify large dependencies
  - Implement code splitting
  - Add dynamic imports for heavy components
  - Remove unused dependencies
  - Configure tree shaking

Generate before/after comparison report.
```

**Tiempo**: 15 minutos

---

### Receta 23: Implementar Caching

```bash
> Implement Redis caching for this Django API:
  - Cache product catalog (5 min TTL)
  - Cache user sessions
  - Cache computed analytics (1 hour TTL)
  - Add cache invalidation on updates
  - Include cache hit/miss metrics

# Configurar redis-py con async support
```

**Tiempo**: 10 minutos

---

### Receta 24: Mejorar Core Web Vitals

```bash
> Optimize this Next.js page for Core Web Vitals:
  - Reduce LCP (Largest Contentful Paint) to < 2.5s
  - Minimize CLS (Cumulative Layout Shift) to < 0.1
  - Improve FID (First Input Delay) to < 100ms

Apply these techniques:
- Image optimization
- Font preloading
- Minimize JavaScript
- Use Suspense boundaries
- Add loading skeletons

Generate Lighthouse report before and after.
```

**Tiempo**: 20 minutos

---

## 🔐 Security & Auth

### Receta 25: Implementar JWT Authentication

```bash
> Implement JWT authentication for this FastAPI backend:
  - Register endpoint (email, password)
  - Login endpoint (returns access token)
  - Protected route decorator
  - Token refresh mechanism
  - Password hashing with bcrypt
  - Token expiration (7 days)

Include example protected endpoint.
```

**Tiempo**: 10 minutos

---

### Receta 26: OAuth2 con Google

```bash
> Add Google OAuth2 authentication to this Next.js app:
  - Use NextAuth.js
  - Configure Google provider
  - Handle sign in/sign out
  - Session management
  - Protect routes with middleware
  - Store user in database after first login

# Incluir .env.example con required variables
```

**Tiempo**: 15 minutos

---

### Receta 27: Rate Limiting

```bash
> Implement rate limiting for this Express API:
  - 100 requests per 15 minutes per IP
  - Different limits for authenticated users (200/15min)
  - Custom limits for specific endpoints (login: 5/min)
  - Return rate limit headers
  - Store in Redis for distributed systems
```

**Tiempo**: 8 minutos

---

## 📊 Analytics & Monitoring

### Receta 28: Integrar Analytics

```bash
> Add analytics to this Next.js app:
  - Vercel Analytics for Web Vitals
  - Google Analytics 4 for user behavior
  - Custom events (button clicks, form submissions)
  - Page views tracking
  - GDPR-compliant cookie consent
  - Privacy-focused (no PII tracking)
```

**Tiempo**: 10 minutos

---

### Receta 29: Error Tracking con Sentry

```bash
> Set up Sentry for error tracking:
  - Configure Sentry for frontend (Next.js)
  - Configure Sentry for backend (Django/FastAPI)
  - Capture exceptions automatically
  - Add custom error context
  - Set up alerts for critical errors
  - Include source maps for debugging

# Generar sentry.client.config.ts y sentry.server.config.ts
```

**Tiempo**: 12 minutos

---

### Receta 30: Dashboard de Métricas

```bash
> Create an admin analytics dashboard showing:
  - Total users (with growth trend)
  - Active users (daily, weekly, monthly)
  - Revenue metrics
  - Top features used
  - Error rate over time
  - API response times

# Stack: Next.js + Chart.js + Django backend
# Include real-time updates every 30s
```

**Tiempo**: 25 minutos

---

## 🎯 Multi-Agent Workflows

### Receta 31: Feature Pipeline Completa

```bash
> Implement a new "Product Reviews" feature using the Feature Pipeline pattern:

Phase 1 (Architect): Design the feature
Phase 2 (Backend): Create review model and API
Phase 3 (Frontend): Build review UI components
Phase 4 (Testing): Generate tests
Phase 5 (Security): Security audit
Phase 6 (Review): Code review
Phase 7 (Deploy): Deployment prep

Use multi-agent orchestration with these agents:
- nextjs-architect
- django-architect
- test-generator
- security-auditor
- code-reviewer
```

**Tiempo**: 1-2 horas (automático con orquestación)

---

## 💡 Quick Fixes

### Receta 32: Arreglar Errores de TypeScript

```bash
> Fix all TypeScript errors in this file:
[pegar archivo con errores]

Make minimal changes to preserve functionality.
Include explanation for each fix.
```

**Tiempo**: 2-5 minutos por archivo

---

### Receta 33: Refactorizar Componente Grande

```bash
> This component is 500+ lines. Refactor it by:
  - Extracting custom hooks for logic
  - Creating sub-components for UI sections
  - Moving constants to separate file
  - Improving readability
  - Maintaining exact same functionality

[pegar componente]
```

**Tiempo**: 10 minutos

---

### Receta 34: Agregar Manejo de Errores

```bash
> Add comprehensive error handling to this code:
[pegar código]

Include:
- Try/catch blocks
- User-friendly error messages
- Error logging
- Fallback UI
- Retry logic where appropriate
```

**Tiempo**: 5 minutos

---

## 🎨 UI/UX Improvements

### Receta 35: Agregar Skeleton Loaders

```bash
> Add skeleton loaders to all data-fetching components:
  - ProductCard skeleton
  - Dashboard stats skeleton
  - Table skeleton
  - Match component dimensions
  - Smooth shimmer animation

# Framework: Tailwind CSS
```

**Tiempo**: 8 minutos

---

### Receta 36: Implementar Toast Notifications

```bash
> Create a toast notification system:
  - Success, error, warning, info variants
  - Auto-dismiss after 5 seconds
  - Manual dismiss option
  - Stack multiple toasts
  - Accessible (ARIA labels)
  - Smooth enter/exit animations

# Use react-hot-toast or custom implementation
```

**Tiempo**: 10 minutos

---

### Receta 37: Responsive Navigation

```bash
> Convert this desktop navigation to responsive:
  - Mobile: Hamburger menu
  - Tablet: Collapsed menu
  - Desktop: Full horizontal menu
  - Smooth animations
  - Close on route change (mobile)
  - Keyboard accessible

[pegar código de navegación]
```

**Tiempo**: 12 minutos

---

## 📱 Mobile & PWA

### Receta 38: Convertir a PWA

```bash
> Convert this Next.js app to PWA:
  - Add manifest.json
  - Create service worker
  - Implement offline support
  - Add install prompt
  - Cache static assets
  - Cache API responses (stale-while-revalidate)
  - Add app icons (multiple sizes)
```

**Tiempo**: 15 minutos

---

### Receta 39: Optimizar para Mobile

```bash
> Optimize this page for mobile devices:
  - Touch-friendly buttons (min 44px)
  - Optimize images for mobile
  - Reduce animations on low-end devices
  - Improve form inputs for mobile
  - Test on viewport sizes (375px, 768px)
  - Fix horizontal scroll issues
```

**Tiempo**: 15 minutos

---

## 🔄 Data Management

### Receta 40: Implementar Optimistic Updates

```bash
> Add optimistic updates to this todo list:
  - Instantly show new todo on create
  - Update UI before server confirms
  - Revert if server returns error
  - Show subtle loading indicator
  - Handle race conditions

# Stack: React Query + Next.js
```

**Tiempo**: 10 minutos

---

## 🎓 Tips para Usar el Cookbook

### Mejores Prácticas

1. **Sea específico**: Modifica las recetas con tus requisitos exactos
2. **Combine recetas**: Use múltiples recetas en secuencia
3. **Verifique el resultado**: Siempre revise el código generado
4. **Personalice**: Adapte las recetas a su stack

### Template de Receta Personalizada

```bash
> [ACCIÓN] para [CONTEXTO] con:
  - [Requisito 1]
  - [Requisito 2]
  - [Requisito 3]

# Stack: [Tu stack]
# Incluir: [Archivos específicos]
```

---

## 📚 Recursos Relacionados

- **Agentes Especializados**: [`agents/README.md`](./agents/README.md)
- **Ejemplos Completos**: [`examples/README.md`](./examples/README.md)
- **Multi-Agent Orchestration**: [`docs/guides/02-intermediate/multi-agent-orchestration.md`](./docs/guides/02-intermediate/multi-agent-orchestration.md)

---

**¿Tienes una receta útil?** [Contribuye al cookbook](./CONTRIBUTING.md) y ayuda a la comunidad.

**¿No encuentras lo que buscas?** Crea un [issue](https://github.com/tu-usuario/claude-code-advanced-guide/issues) con tu receta sugerida.

---

**Última actualización**: 2025-01-15 (v0.2)
**Total de recetas**: 40
**Tiempo total ahorrado**: ~200 horas de desarrollo manual
