# 🎭 Orquestación Avanzada de Agentes

Guía completa para coordinar múltiples agentes especializados en workflows complejos.

## 📋 Tabla de Contenidos

- [Conceptos Fundamentales](#conceptos-fundamentales)
- [Patrones de Orquestación](#patrones-de-orquestación)
- [Implementaciones Prácticas](#implementaciones-prácticas)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)

## 🎯 Conceptos Fundamentales

### ¿Por qué Orquestación?

**Problema**: Tareas complejas requieren múltiples especialidades

**Solución**: Coordinar agentes especializados que trabajan juntos

**Beneficios**:
- ✅ Especialización profunda por agente
- ✅ Reutilización en diferentes workflows
- ✅ Mantenimiento más fácil
- ✅ Testing más simple (por agente)

### Tipos de Coordinación

| Tipo | Cuándo Usar | Ejemplo |
|------|-------------|---------|
| **Secuencial** | Un agente depende del otro | Design → Code → Test |
| **Paralelo** | Tareas independientes | Frontend + Backend simultáneamente |
| **Condicional** | Decisiones basadas en resultados | Si tests fallan → Debug agent |
| **Iterativo** | Refinamiento progresivo | Code → Review → Fix → Repeat |

## 🔄 Patrones de Orquestación

### Patrón 1: Cadena de Responsabilidad (Chain of Responsibility)

**Uso**: Cuando cada agente procesa y pasa al siguiente

**Estructura**:
```
Input → Agent A → Agent B → Agent C → Output
```

**Ejemplo Práctico: Feature Implementation Pipeline**

```markdown
<!-- .claude/workflows/feature-pipeline.md -->

# Feature Development Pipeline

## Phase 1: Planning (Architect Agent)
**Responsabilidad**: Diseñar arquitectura de la feature

Input: Feature requirements
Output: Architecture document

Tasks:
1. Analizar requisitos
2. Diseñar componentes
3. Definir APIs
4. Identificar dependencias
5. Estimar complejidad

Handoff to next agent:
- Architecture document
- Component specifications
- API contracts

## Phase 2: Database Design (Database Architect Agent)
**Responsabilidad**: Diseñar esquema de base de datos

Input: Architecture document
Output: Database schema + migrations

Tasks:
1. Diseñar tablas y relaciones
2. Crear migrations
3. Definir indexes
4. Validar contra requirements
5. Documentar schema

Handoff to next agent:
- Migration files
- Schema documentation
- Query patterns

## Phase 3: Backend Implementation (Backend Developer Agent)
**Responsabilidad**: Implementar lógica de negocio y APIs

Input: Architecture + Database schema
Output: Working API endpoints

Tasks:
1. Crear modelos (ORM)
2. Implementar servicios
3. Crear controllers
4. Añadir validación
5. Implementar error handling

Handoff to next agent:
- API endpoints implemented
- Business logic complete
- Integration points ready

## Phase 4: Frontend Implementation (Frontend Developer Agent)
**Responsabilidad**: Implementar UI y componentes

Input: API contracts + designs
Output: Working UI components

Tasks:
1. Crear componentes React/Vue
2. Implementar state management
3. Conectar con APIs
4. Añadir loading states
5. Implementar error handling

Handoff to next agent:
- UI components complete
- API integration done
- User flows working

## Phase 5: Testing (Test Engineer Agent)
**Responsabilidad**: Verificar calidad y funcionamiento

Input: Código completo
Output: Test suite + coverage report

Tasks:
1. Unit tests para servicios
2. Integration tests para APIs
3. E2E tests para user flows
4. Performance tests
5. Generar coverage report

Handoff to next agent:
- All tests passing
- Coverage > 80%
- Performance benchmarks

## Phase 6: Code Review (Code Reviewer Agent)
**Responsabilidad**: Asegurar calidad y seguridad

Input: Todo el código
Output: Review report + fixes

Tasks:
1. Security audit
2. Performance review
3. Code quality check
4. Documentation review
5. Suggest improvements

Handoff to next agent:
- Review report
- Approved for merge
- Action items (if any)

## Phase 7: Documentation (Documentation Writer Agent)
**Responsabilidad**: Documentar feature

Input: Código + arquitectura
Output: Documentación completa

Tasks:
1. API documentation
2. Usage examples
3. Architecture diagrams
4. Update CHANGELOG
5. Update README

Final Output:
- Feature complete
- Documented
- Tested
- Ready for deployment
```

**Cómo Ejecutar**:
```bash
> Implement the user authentication feature using the feature-pipeline workflow

# Claude invocará automáticamente cada agente en secuencia
```

### Patrón 2: Trabajo Paralelo (Parallel Workers)

**Uso**: Tareas independientes que pueden ejecutarse simultáneamente

**Estructura**:
```
         ┌──→ Agent A ──┐
Input ──→├──→ Agent B ──┤──→ Aggregator ──→ Output
         └──→ Agent C ──┘
```

**Ejemplo: Microservices Development**

```markdown
<!-- .claude/workflows/parallel-microservices.md -->

# Parallel Microservices Development

Deploy multiple agents working on independent services simultaneously.

## Service Assignments

### Agent 1: Auth Service Developer
**Service**: auth-service
**Tasks**:
- Implement JWT authentication
- User registration/login
- Password reset
- Session management

**Stack**: Node.js + PostgreSQL
**Ports**: 3001

### Agent 2: Payment Service Developer
**Service**: payment-service
**Tasks**:
- Stripe integration
- Payment processing
- Webhook handling
- Receipt generation

**Stack**: Node.js + PostgreSQL
**Ports**: 3002

### Agent 3: Notification Service Developer
**Service**: notification-service
**Tasks**:
- Email sending (SendGrid)
- SMS notifications (Twilio)
- Push notifications
- Template management

**Stack**: Node.js + Redis
**Ports**: 3003

### Agent 4: API Gateway Developer
**Service**: api-gateway
**Tasks**:
- Request routing
- Authentication middleware
- Rate limiting
- API documentation

**Stack**: Node.js + Nginx
**Ports**: 3000

## Coordination Points

### 1. Shared Types
All agents use shared TypeScript types:
```typescript
// packages/shared/types/user.ts
export interface User {
  id: string;
  email: string;
  name: string;
}
```

### 2. Event Bus
Services communicate via RabbitMQ:
- `user.created` → Notification service sends welcome email
- `payment.succeeded` → Auth service updates subscription
- `auth.session.expired` → All services invalidate cache

### 3. Service Discovery
All services register with Consul

### 4. Monitoring
All services report to Datadog

## Execution Flow

1. **Start parallel work** (all agents work simultaneously)
   ```bash
   > Develop all microservices in parallel using parallel-microservices workflow
   ```

2. **Each agent works independently**
   - Auth agent implements auth-service
   - Payment agent implements payment-service
   - Notification agent implements notification-service
   - Gateway agent implements api-gateway

3. **Integration testing** (after all complete)
   - Integration test agent verifies services work together
   - E2E test agent tests complete user flows

4. **Deployment**
   - DevOps agent deploys all services
   - Monitoring agent sets up dashboards

## Benefits

- 4x faster than sequential (in theory)
- Each agent focused on one service
- No merge conflicts (different codebases)
- Can scale team easily
```

### Patrón 3: Especialización por Dominio

**Uso**: Proyecto con múltiples dominios técnicos complejos

**Ejemplo: Full-Stack App con AI**

```markdown
<!-- .claude/workflows/domain-specialists.md -->

# Domain Specialist Coordination

## Domain Assignments

### Auth Domain Specialist
**Expertise**: Authentication & Authorization

Handles:
- OAuth 2.0 / OpenID Connect
- JWT token management
- Role-based access control (RBAC)
- Session management
- Password security
- 2FA/MFA implementation

When to invoke:
> Use auth-domain-specialist for implementing user login with Google OAuth

### Payment Domain Specialist
**Expertise**: Payment Processing

Handles:
- Stripe/PayPal integration
- Subscription management
- Invoice generation
- Payment webhooks
- PCI compliance
- Refund handling

When to invoke:
> Use payment-domain-specialist to add subscription billing

### Email Domain Specialist
**Expertise**: Email Infrastructure

Handles:
- SendGrid/Mailgun setup
- Template design
- Deliverability optimization
- Bounce handling
- Email analytics
- Transactional emails

When to invoke:
> Use email-domain-specialist for email verification flow

### ML/AI Domain Specialist
**Expertise**: Machine Learning

Handles:
- Model training
- Feature engineering
- Model serving
- A/B testing
- Performance monitoring
- Data pipelines

When to invoke:
> Use ml-ai-domain-specialist to add recommendation engine

### Database Domain Specialist
**Expertise**: Database Design & Optimization

Handles:
- Schema design
- Query optimization
- Index strategies
- Migration planning
- Backup strategies
- Scaling approaches

When to invoke:
> Use database-domain-specialist to optimize slow queries

### DevOps Domain Specialist
**Expertise**: Infrastructure & Deployment

Handles:
- CI/CD pipelines
- Docker/Kubernetes
- Monitoring setup
- Log aggregation
- Auto-scaling
- Disaster recovery

When to invoke:
> Use devops-domain-specialist for Kubernetes deployment

## Coordination Example

**Scenario**: Implementing "Premium Subscription Feature"

```
User Story: As a user, I want to upgrade to premium and get access to advanced features.

Workflow:
1. Auth-Specialist: Add "premium" role to RBAC
2. Payment-Specialist: Create Stripe subscription
3. Database-Specialist: Add subscription tables
4. Backend-Developer: Implement subscription API
5. Frontend-Developer: Build pricing page
6. Email-Specialist: Send confirmation emails
7. DevOps-Specialist: Deploy with feature flags
```

**Execution**:
```bash
> Implement premium subscription feature

# Claude Code coordinates:
# 1. Auth agent adds premium role
# 2. Payment agent integrates Stripe
# 3. Database agent creates schema
# 4. Backend agent creates API
# 5. Frontend agent builds UI
# 6. Email agent sets up notifications
# 7. DevOps agent deploys
```
```

### Patrón 4: Iterativo con Feedback Loop

**Uso**: Refinamiento progresivo hasta alcanzar calidad deseada

**Estructura**:
```
Input → Agent → Validator → [Pass] → Output
           ↑                 ↓ [Fail]
           └─────────────────┘
```

**Ejemplo: Code Quality Loop**

```markdown
<!-- .claude/workflows/quality-iteration.md -->

# Iterative Quality Improvement

## Loop Structure

### Iteration 1: Initial Implementation
**Agent**: Feature Developer
**Task**: Implement feature based on requirements
**Output**: Initial code

↓

### Iteration 2: Security Review
**Agent**: Security Auditor
**Task**: Scan for vulnerabilities
**Pass Criteria**: No high/critical issues
**If Fail**: Return to Feature Developer with findings

↓

### Iteration 3: Performance Check
**Agent**: Performance Optimizer
**Task**: Analyze performance
**Pass Criteria**:
- Response time < 200ms
- Memory usage < 100MB
- No N+1 queries
**If Fail**: Return to Feature Developer with optimizations

↓

### Iteration 4: Code Quality
**Agent**: Code Reviewer
**Task**: Review code quality
**Pass Criteria**:
- Test coverage > 80%
- No code smells
- Documentation complete
**If Fail**: Return to Feature Developer with suggestions

↓

### Iteration 5: Final Validation
**Agent**: QA Engineer
**Task**: End-to-end testing
**Pass Criteria**: All tests pass
**If Fail**: Return to appropriate specialist

↓

**Success**: Feature ready for deployment

## Example Execution

\`\`\`bash
> Implement user profile feature with quality iteration workflow

# Round 1
Developer: Implements feature
Security: Finds SQL injection → FAIL
Developer: Fixes SQL injection

# Round 2
Developer: Re-submits
Security: ✅ Pass
Performance: Finds N+1 queries → FAIL
Developer: Adds eager loading

# Round 3
Developer: Re-submits
Security: ✅ Pass
Performance: ✅ Pass
Code Reviewer: Missing tests → FAIL
Developer: Adds tests

# Round 4
Developer: Re-submits
Security: ✅ Pass
Performance: ✅ Pass
Code Reviewer: ✅ Pass
QA: ✅ All tests pass

✅ Feature ready for deployment
\`\`\`

## Maximum Iterations

Set limit to avoid infinite loops:
```yaml
# .claude/workflows/config.yml
quality-iteration:
  max_iterations: 5
  fail_on_max: false  # Log warning but continue
```
```

## 💼 Implementaciones Prácticas

### Caso Real 1: E-commerce Product Launch

```markdown
<!-- .claude/workflows/ecommerce-product-launch.md -->

# E-commerce Product Launch Workflow

Complete workflow for launching a new product category.

## Agents Involved
1. Product Manager Agent
2. Database Architect Agent
3. Backend Developer Agent
4. Frontend Developer Agent
5. Image Optimizer Agent
6. SEO Specialist Agent
7. QA Engineer Agent
8. DevOps Agent

## Workflow Steps

### Step 1: Requirements (Product Manager Agent)
**Input**: Product category description
**Output**: Detailed requirements document

```
> Use product-manager agent to analyze requirements for "Electronics" category

Output:
- Required fields (name, price, specs, warranty, etc.)
- Filtering requirements (brand, price range, ratings)
- Search requirements
- Image requirements (min 3 per product)
- SEO requirements
```

### Step 2: Database Design (Database Architect Agent)
**Input**: Requirements document
**Output**: Schema + migrations

```sql
-- products table
CREATE TABLE products (
  id UUID PRIMARY KEY,
  category_id UUID REFERENCES categories(id),
  name VARCHAR(255),
  description TEXT,
  price DECIMAL(10,2),
  specs JSONB,
  created_at TIMESTAMP
);

-- Indexes for filtering/search
CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_products_price ON products(price);
CREATE INDEX idx_products_search ON products USING GIN(to_tsvector('english', name || ' ' || description));
```

### Step 3: Backend API (Backend Developer Agent)
**Input**: Database schema
**Output**: REST API endpoints

```typescript
// GET /api/products?category=electronics&minPrice=100&maxPrice=500
app.get('/api/products', async (req, res) => {
  const { category, minPrice, maxPrice } = req.query;
  // Implementation
});

// POST /api/products
app.post('/api/products', validateProduct, async (req, res) => {
  // Implementation
});
```

### Step 4: Frontend (Frontend Developer Agent)
**Input**: API contracts
**Output**: Product listing page + filters

```tsx
// ProductListing.tsx
export function ProductListing() {
  // Component implementation
}
```

### Step 5: Image Optimization (Image Optimizer Agent)
**Input**: Product images
**Output**: Optimized images + CDN setup

```
- Convert to WebP
- Generate thumbnails (100x100, 300x300, 600x600)
- Upload to CDN
- Generate URLs
```

### Step 6: SEO (SEO Specialist Agent)
**Input**: Product data
**Output**: SEO optimizations

```typescript
// Meta tags, structured data, sitemap
export const productMeta = {
  title: `${product.name} - Best Price | YourStore`,
  description: truncate(product.description, 160),
  openGraph: { ... },
  jsonLd: {
    '@type': 'Product',
    name: product.name,
    offers: {
      price: product.price,
      priceCurrency: 'USD'
    }
  }
};
```

### Step 7: Testing (QA Engineer Agent)
**Input**: Complete implementation
**Output**: Test results

```
- Unit tests: ✅ 152 tests passing
- Integration tests: ✅ 45 tests passing
- E2E tests: ✅ 12 user flows passing
- Performance: ✅ Page load < 2s
- Accessibility: ✅ WCAG AA compliant
```

### Step 8: Deployment (DevOps Agent)
**Input**: Tested code
**Output**: Production deployment

```bash
# Deploy to production
- Build Docker image
- Push to registry
- Update K8s deployment
- Run database migrations
- Verify health checks
- Update CDN cache
- Enable monitoring alerts
```

## Execution
```bash
> Launch Electronics product category using ecommerce-product-launch workflow
```

Claude Code coordina todos los agentes automáticamente.
```

## 🎯 Best Practices

### 1. Definir Handoffs Claros

```markdown
**Malo** ❌:
Agent A: "Make it work"
Agent B: "Do the frontend"

**Bueno** ✅:
Agent A Output:
- API endpoint: POST /api/users
- Request schema: { email, password, name }
- Response schema: { id, email, name, token }
- Error codes: 400 (validation), 409 (duplicate), 500 (server)

Agent B Input:
- Uses API endpoint POST /api/users
- Implements form validation matching backend
- Handles all error codes appropriately
```

### 2. Estado Compartido

```typescript
// shared-state.ts
export interface WorkflowState {
  phase: 'planning' | 'implementation' | 'testing' | 'review';
  artifacts: {
    architecture?: ArchitectureDocument;
    schema?: DatabaseSchema;
    api?: APISpecification;
    tests?: TestResults;
  };
  decisions: Decision[];
  blockers: Blocker[];
}
```

### 3. Checkpoints y Rollback

```yaml
# .claude/workflows/checkpoints.yml
workflow: feature-implementation
checkpoints:
  - after: database-design
    validate: schema is valid
    rollback_on_fail: true

  - after: backend-implementation
    validate: tests pass
    rollback_on_fail: true

  - after: code-review
    validate: no critical issues
    rollback_on_fail: false  # Just warn
```

### 4. Timeouts y Límites

```yaml
# .claude/workflows/limits.yml
agent_timeouts:
  architect: 10min
  developer: 30min
  tester: 20min
  reviewer: 15min

max_iterations: 3
fail_fast: true  # Stop workflow on first error
```

## 🐛 Troubleshooting

### Problema: Agentes trabajando en archivos diferentes modifican el mismo archivo

**Síntoma**: Merge conflicts, trabajo sobrescrito

**Solución**: Coordinación explícita
```yaml
# .claude/workflows/file-ownership.yml
file_assignments:
  frontend_agent:
    - src/components/**
    - src/pages/**
  backend_agent:
    - src/api/**
    - src/services/**
  database_agent:
    - prisma/**
    - migrations/**
```

### Problema: Workflow se queda atascado esperando agente

**Síntoma**: Un agente no termina su tarea

**Solución**: Timeouts + fallbacks
```markdown
Agent: backend-developer
Timeout: 30min
On Timeout:
  1. Save current state
  2. Log issue
  3. Invoke backup agent (general-developer)
  4. Continue workflow
```

### Problema: Información perdida entre agentes

**Síntoma**: Agente B no tiene contexto de Agente A

**Solución**: Handoff Document
```markdown
## Handoff Template

From: Architect Agent
To: Backend Developer Agent
Date: 2025-01-15

### What was done:
- Designed database schema
- Created API specification
- Identified 3 external dependencies

### What's needed:
- Implement 5 API endpoints (spec attached)
- Use PostgreSQL with Prisma
- Add input validation with Zod

### Artifacts:
- [schema.sql](./artifacts/schema.sql)
- [api-spec.yml](./artifacts/api-spec.yml)

### Blockers:
- None

### Decisions made:
1. Using JWT for auth (not sessions)
2. PostgreSQL over MongoDB (relational data)
3. REST API (not GraphQL)

### Questions for next agent:
- Should we add rate limiting now or later?
- Prefer Express or Fastify?
```

## 🚀 Próximos Pasos

- [Ver ejemplos de workflows completos](../../examples/)
- [Crear tu primer agente orquestador](./creating-orchestrator-agents.md)
- [Advanced: Custom workflow DSL](../03-advanced/workflow-dsl.md)

---

**Tip**: Empieza simple. Un workflow de 2-3 agentes es suficiente para la mayoría de casos. Añade complejidad solo cuando la necesites.