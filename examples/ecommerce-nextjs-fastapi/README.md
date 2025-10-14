# 🛒 E-commerce Product Catalog

Full-stack e-commerce application with Next.js 15 (App Router) frontend and FastAPI backend.

## 📋 Overview

**Descripción**: Catálogo de productos completo con carrito de compras, checkout con Stripe, y panel de administración.

**Stack**:
- **Frontend**: Next.js 15, React 18, TypeScript, Tailwind CSS, Zustand
- **Backend**: FastAPI, SQLAlchemy 2.0, PostgreSQL, Redis, Stripe
- **Deployment**: Vercel (frontend) + Railway/Render (backend)

**Tiempo estimado**: 4-5 horas para implementación completa

**Nivel**: 🟡 Intermedio

---

## ✨ Features

### Customer Features
- ✅ Product catalog with search and filters
- ✅ Product detail pages with images
- ✅ Shopping cart with persistence
- ✅ User authentication (email/password)
- ✅ Checkout with Stripe integration
- ✅ Order history
- ✅ Wishlist

### Admin Features
- ✅ Product management (CRUD)
- ✅ Order management
- ✅ Inventory tracking
- ✅ Sales analytics
- ✅ Customer management

### Technical Features
- ✅ Server-side rendering (SSR)
- ✅ Optimistic UI updates
- ✅ Image optimization
- ✅ SEO optimization
- ✅ Error handling
- ✅ Loading states
- ✅ Type-safe API client
- ✅ Redis caching
- ✅ Rate limiting

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    FRONTEND (Next.js 15)                     │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   Products   │  │   Cart       │  │   Checkout   │      │
│  │   (SSR)      │  │   (Client)   │  │   (Client)   │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
│                                                               │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   Admin      │  │   Orders     │  │   Profile    │      │
│  │   (CSR)      │  │   (SSR)      │  │   (Client)   │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
│                                                               │
└───────────────────────────┬─────────────────────────────────┘
                            │ HTTP/REST
                            │
┌───────────────────────────▼─────────────────────────────────┐
│                    BACKEND (FastAPI)                         │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │  Products    │  │  Orders      │  │  Auth        │      │
│  │  API         │  │  API         │  │  API         │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
│                                                               │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │  Cart        │  │  Payments    │  │  Users       │      │
│  │  API         │  │  (Stripe)    │  │  API         │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
│                                                               │
└───────────────────────────┬─────────────────────────────────┘
                            │
        ┌───────────────────┼───────────────────┐
        │                   │                   │
        ▼                   ▼                   ▼
  ┌──────────┐       ┌──────────┐       ┌──────────┐
  │PostgreSQL│       │  Redis   │       │ Stripe   │
  │          │       │ (Cache)  │       │   API    │
  └──────────┘       └──────────┘       └──────────┘
```

---

## 🚀 Quick Start

### Prerequisites

```bash
# Required
- Node.js 18+
- Python 3.11+
- PostgreSQL 14+
- Redis 7+

# Optional (for development)
- Docker & Docker Compose
```

### Setup con Claude Code

#### Paso 1: Backend (FastAPI)

```bash
# En Claude Code, en el directorio backend/
> Use fastapi-architect to create an e-commerce API with the following:
  - Products API (CRUD, search, filters, pagination)
  - Shopping cart API (add, remove, update quantities)
  - Orders API (create order, order history)
  - Users & Authentication (JWT, email/password)
  - Stripe integration for payments
  - Redis caching for products
  - PostgreSQL database with SQLAlchemy 2.0
  - Alembic migrations
  - Tests with pytest

# El agente creará la estructura completa
```

#### Paso 2: Frontend (Next.js)

```bash
# En Claude Code, en el directorio frontend/
> Use nextjs-architect to create an e-commerce frontend with:
  - Product listing page (SSR with pagination)
  - Product detail page (SSR with ISR)
  - Shopping cart (client-side state with Zustand)
  - Checkout flow (multi-step form)
  - User authentication (login/register)
  - Admin panel for product management
  - Stripe checkout integration
  - Optimistic UI updates
  - Image optimization with next/image
  - SEO optimization

# El agente creará la estructura completa
```

#### Paso 3: Conectar Frontend y Backend

```bash
> Create a type-safe API client in the Next.js app that connects to the FastAPI backend with proper error handling, retry logic, and TypeScript types
```

---

## 📁 Project Structure

### Backend Structure

```
backend/
├── app/
│   ├── api/
│   │   └── v1/
│   │       ├── endpoints/
│   │       │   ├── products.py       # Product CRUD
│   │       │   ├── cart.py           # Shopping cart
│   │       │   ├── orders.py         # Orders
│   │       │   ├── auth.py           # Authentication
│   │       │   ├── users.py          # User management
│   │       │   └── payments.py       # Stripe integration
│   │       └── router.py
│   ├── core/
│   │   ├── config.py                 # Settings
│   │   ├── security.py               # JWT, password hashing
│   │   └── cache.py                  # Redis utilities
│   ├── db/
│   │   ├── session.py                # Database session
│   │   └── repositories/
│   │       ├── product.py
│   │       ├── order.py
│   │       └── user.py
│   ├── models/
│   │   ├── product.py                # Product model
│   │   ├── order.py                  # Order, OrderItem models
│   │   ├── user.py                   # User model
│   │   └── cart.py                   # Cart model
│   ├── schemas/
│   │   ├── product.py                # Pydantic schemas
│   │   ├── order.py
│   │   ├── user.py
│   │   └── cart.py
│   ├── services/
│   │   ├── stripe_service.py         # Stripe integration
│   │   ├── email_service.py          # Email notifications
│   │   └── inventory_service.py      # Stock management
│   └── main.py
├── tests/
│   ├── api/
│   └── services/
├── alembic/                          # Database migrations
├── .env.example
├── requirements.txt
└── README.md
```

### Frontend Structure

```
frontend/
├── app/
│   ├── (customer)/
│   │   ├── products/
│   │   │   ├── page.tsx              # Product listing (SSR)
│   │   │   └── [id]/
│   │   │       └── page.tsx          # Product detail (SSR + ISR)
│   │   ├── cart/
│   │   │   └── page.tsx              # Shopping cart
│   │   ├── checkout/
│   │   │   └── page.tsx              # Checkout flow
│   │   └── orders/
│   │       └── page.tsx              # Order history
│   ├── (auth)/
│   │   ├── login/
│   │   │   └── page.tsx
│   │   └── register/
│   │       └── page.tsx
│   ├── admin/
│   │   ├── products/
│   │   │   ├── page.tsx              # Product management
│   │   │   ├── new/page.tsx
│   │   │   └── [id]/edit/page.tsx
│   │   ├── orders/
│   │   │   └── page.tsx
│   │   └── analytics/
│   │       └── page.tsx
│   ├── api/
│   │   └── webhook/
│   │       └── stripe/route.ts       # Stripe webhooks
│   └── layout.tsx
├── components/
│   ├── products/
│   │   ├── ProductCard.tsx
│   │   ├── ProductGrid.tsx
│   │   ├── ProductFilters.tsx
│   │   └── ProductSearch.tsx
│   ├── cart/
│   │   ├── CartItem.tsx
│   │   ├── CartSummary.tsx
│   │   └── CartButton.tsx
│   ├── checkout/
│   │   ├── CheckoutForm.tsx
│   │   ├── PaymentForm.tsx
│   │   └── OrderSummary.tsx
│   └── ui/                           # Shadcn/ui components
├── lib/
│   ├── api-client.ts                 # Type-safe API client
│   ├── stripe.ts                     # Stripe utilities
│   └── utils.ts
├── stores/
│   ├── cart-store.ts                 # Zustand store
│   └── auth-store.ts
├── types/
│   ├── product.ts
│   ├── order.ts
│   └── user.ts
├── .env.local.example
├── next.config.js
├── package.json
└── README.md
```

---

## 🔧 Configuration

### Backend (.env)

```bash
# Database
DATABASE_URL=postgresql+asyncpg://user:pass@localhost/ecommerce

# Redis
REDIS_URL=redis://localhost:6379

# Security
SECRET_KEY=your-secret-key-here
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=10080

# Stripe
STRIPE_SECRET_KEY=sk_test_...
STRIPE_PUBLISHABLE_KEY=pk_test_...
STRIPE_WEBHOOK_SECRET=whsec_...

# Frontend URL (for CORS)
FRONTEND_URL=http://localhost:3000

# Email (optional)
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASSWORD=your-app-password
```

### Frontend (.env.local)

```bash
# API
NEXT_PUBLIC_API_URL=http://localhost:8000
API_URL=http://localhost:8000

# Stripe
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=pk_test_...

# App
NEXT_PUBLIC_APP_URL=http://localhost:3000
```

---

## 🎯 Development Workflow

### 1. Desarrollo Inicial

```bash
# Terminal 1: Backend
cd backend
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
pip install -r requirements.txt
uvicorn app.main:app --reload

# Terminal 2: Frontend
cd frontend
npm install
npm run dev

# Terminal 3: Redis
redis-server

# Terminal 4: PostgreSQL
# Ya debe estar corriendo
```

### 2. Crear Features con Claude Code

```bash
# Ejemplo: Agregar sistema de reviews
> Use fastapi-architect to add a product reviews system to the backend with:
  - Review model (rating, comment, user_id, product_id)
  - Reviews API endpoint
  - Average rating calculation
  - Pagination for reviews

> Use nextjs-architect to add product reviews to the frontend with:
  - Review form component
  - Reviews list with pagination
  - Star rating display
  - Optimistic updates when submitting review
```

### 3. Testing

```bash
# Backend tests
cd backend
pytest

# Frontend (si tienes tests)
cd frontend
npm run test
```

---

## 🚢 Deployment

### Backend (Railway/Render)

```bash
# 1. Crear cuenta en Railway/Render
# 2. Conectar repositorio
# 3. Configurar variables de entorno
# 4. Railway detectará FastAPI automáticamente

# O con Docker:
docker build -t ecommerce-api ./backend
docker run -p 8000:8000 ecommerce-api
```

### Frontend (Vercel)

```bash
# 1. Instalar Vercel CLI
npm i -g vercel

# 2. Deploy
cd frontend
vercel

# O conectar desde el dashboard de Vercel
```

---

## 📚 Learning Path

### Fase 1: Setup Básico (1 hora)
1. Crear backend API básica con productos
2. Crear frontend con listado de productos
3. Conectar frontend y backend

### Fase 2: Features Core (2 horas)
4. Implementar carrito de compras
5. Agregar autenticación
6. Crear flujo de checkout

### Fase 3: Payments (1 hora)
7. Integrar Stripe
8. Manejar webhooks
9. Testing de pagos

### Fase 4: Admin & Polish (1 hora)
10. Panel de administración
11. Optimizaciones de performance
12. SEO y analytics

---

## 🎓 Key Learnings

Al completar este ejemplo, aprenderás:

### Frontend (Next.js)
- ✅ App Router con SSR y ISR
- ✅ Client-side state management con Zustand
- ✅ Optimistic UI updates
- ✅ Form handling y validación
- ✅ Image optimization
- ✅ SEO best practices
- ✅ Error boundaries

### Backend (FastAPI)
- ✅ RESTful API design
- ✅ Async SQLAlchemy 2.0
- ✅ Pydantic validation
- ✅ JWT authentication
- ✅ Repository pattern
- ✅ Redis caching
- ✅ Stripe integration
- ✅ Database migrations con Alembic

### Full-Stack Integration
- ✅ Type-safe API client
- ✅ Error handling patterns
- ✅ Loading states
- ✅ CORS configuration
- ✅ Environment variables
- ✅ Deployment strategies

---

## 🐛 Common Issues & Solutions

### Issue: CORS errors

```typescript
// Backend: app/main.py
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000"],  # Frontend URL
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

### Issue: Stripe webhook no funciona en local

```bash
# Usar Stripe CLI
stripe listen --forward-to localhost:8000/api/v1/webhook/stripe
```

### Issue: Images no se optimizan

```typescript
// next.config.js
module.exports = {
  images: {
    domains: ['your-api-domain.com'],
    formats: ['image/avif', 'image/webp'],
  },
}
```

---

## 🔗 Resources

- **FastAPI Architect Agent**: [`../../agents/stacks/python-fastapi/fastapi-architect.md`](../../agents/stacks/python-fastapi/fastapi-architect.md)
- **Next.js Architect Agent**: [`../../agents/stacks/react-next/nextjs-architect.md`](../../agents/stacks/react-next/nextjs-architect.md)
- **Multi-Agent Orchestration**: [`../../docs/guides/02-intermediate/multi-agent-orchestration.md`](../../docs/guides/02-intermediate/multi-agent-orchestration.md)

---

## 💡 Next Steps

Después de completar este ejemplo, puedes:

1. **Agregar más features**:
   - Product reviews y ratings
   - Wishlist
   - Product recommendations
   - Inventory management
   - Multi-currency support

2. **Optimizar performance**:
   - Implement Redis caching
   - Add CDN for images
   - Server-side pagination
   - Database query optimization

3. **Mejorar UX**:
   - Add animations
   - Better loading states
   - Error recovery
   - Offline support

4. **Escalar a producción**:
   - Add monitoring (Sentry)
   - Set up CI/CD
   - Load testing
   - Security audit

---

**¿Listo para empezar?** Usa los agentes `fastapi-architect` y `nextjs-architect` para crear este proyecto completo en 4-5 horas.

**¿Tienes preguntas?** Consulta la [documentación de agentes](../../agents/README.md) o abre un issue.
