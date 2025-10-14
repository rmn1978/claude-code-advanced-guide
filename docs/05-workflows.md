# Workflows y Patrones

Guía de workflows comunes para diferentes tipos de proyectos con Claude Code.

## Workflows por Tipo de Proyecto

### 1. Nuevo Proyecto Full-Stack

```
Step 1: Planificación
> Use nextjs-architect to plan a new e-commerce app with:
  - Product catalog
  - Shopping cart
  - Stripe checkout

Step 2: Backend
> Use fastapi-architect to create the backend API

Step 3: Frontend
> Use nextjs-architect to create the frontend

Step 4: Testing
> Use testing-specialist to add comprehensive tests

Step 5: Deployment
> Use deployment-specialist to deploy to Vercel + Railway
```

### 2. Agregar Feature a Proyecto Existente

```
Step 1: Analizar código existente
> Read and understand the current authentication system

Step 2: Plan Mode
> /plan
> Add OAuth2 authentication with Google and GitHub

Step 3: Implementación
> Implement the planned OAuth2 feature

Step 4: Testing
> Add tests for the new OAuth2 flow
```

### 3. Code Review y Refactoring

```
Step 1: Análisis
> Review this file for potential issues: src/api/users.py

Step 2: Refactor
> Refactor this code to follow best practices

Step 3: Security
> Use security-specialist to check for vulnerabilities

Step 4: Performance
> Use performance-specialist to optimize
```

## Plan Mode Avanzado

Plan Mode permite que Claude Code planifique antes de codificar.

### Activar Plan Mode

```
> /plan
```

### Ejemplo de Uso

```
User: /plan
User: Create a real-time chat app with Socket.io

Claude: [Creates detailed plan with steps]

User: looks good, proceed

Claude: [Executes the plan step by step]
```

## Slash Commands Útiles

```bash
/help        # Ver ayuda
/plan        # Activar plan mode
/clear       # Limpiar conversación
/model       # Cambiar modelo
```

## Recursos

- **[Multi-Agent Orchestration](./guides/02-intermediate/multi-agent-orchestration.md)** - Coordinar múltiples agentes
- **[Ejemplos Prácticos](../examples/README.md)** - Proyectos completos

---

[← Volver a Documentación](./README.md)
