# 📦 Ejemplos Completos - Claude Code

Colección de proyectos completos que demuestran cómo usar Claude Code con diferentes stacks tecnológicos y casos de uso reales.

## 🎯 Índice de Ejemplos

### Por Nivel de Complejidad

#### 🟢 Básico (1-2 horas para completar)
1. [Todo API - FastAPI](#1-todo-api-fastapi) - API REST simple con CRUD
2. [Blog Static - Next.js](#2-blog-static-nextjs) - Blog estático con SSG
3. [Landing Page - Nuxt](#3-landing-page-nuxt) - Landing page con formularios

#### 🟡 Intermedio (3-5 horas para completar)
4. [E-commerce Product Catalog](#4-e-commerce-product-catalog) - Next.js + FastAPI
5. [SaaS Dashboard](#5-saas-dashboard) - Nuxt + Django
6. [API Gateway](#6-api-gateway) - Express + Microservices
7. [Real-Time Chat](#7-real-time-chat) - Next.js + Socket.io + Redis 💬

#### 🔴 Avanzado (6-8 horas para completar)
8. [Landing Page Builder](#8-landing-page-builder) - No-Code Visual Editor 🎨
9. [AI Code Reviewer](#9-ai-code-reviewer) - GitHub PR Analysis with Claude AI 🤖
10. [Video Streaming Platform](#10-video-streaming-platform) - Netflix-scale Video Platform 🎬
11. [Web3 NFT Marketplace](#11-web3-nft-marketplace) - Blockchain NFT Trading Platform ⛓️
12. [Social Media Platform](#12-social-media-platform) - Twitter/X Clone with ML Feed 🐦

#### 🟣 Enterprise (1-2+ días)
13. [Healthcare AI Platform](#13-healthcare-ai-platform) - Multi-stack con especialización médica
14. [Multi-tenant SaaS](#14-multi-tenant-saas) - Full-stack enterprise

---

## 📋 Ejemplos Detallados

### 1. Todo API - FastAPI

**Stack**: Python + FastAPI + SQLAlchemy + PostgreSQL

**Descripción**: API REST completa para gestión de tareas con autenticación JWT.

**Features**:
- ✅ CRUD completo de tareas
- ✅ Autenticación JWT
- ✅ Paginación y filtros
- ✅ Tests con pytest
- ✅ OpenAPI docs automático

**Agente recomendado**: `fastapi-architect`

**Tiempo estimado**: 1-2 horas

**Directorio**: [`todo-api-fastapi/`](./todo-api-fastapi/)

**Comandos rápidos**:
```bash
# Crear proyecto
> Use fastapi-architect to create a Todo API with JWT authentication

# Estructura generada
todo-api/
├── app/
│   ├── api/v1/endpoints/todos.py
│   ├── models/todo.py
│   ├── schemas/todo.py
│   └── core/security.py
├── tests/
├── alembic/
└── main.py
```

---

### 2. Blog Static - Next.js

**Stack**: Next.js 15 + MDX + Tailwind CSS

**Descripción**: Blog estático con SSG, optimizado para SEO y performance.

**Features**:
- ✅ SSG con ISR para posts
- ✅ MDX para contenido rico
- ✅ SEO optimization
- ✅ Core Web Vitals optimizado
- ✅ Dark mode

**Agente recomendado**: `nextjs-architect`

**Tiempo estimado**: 1-2 horas

**Directorio**: [`blog-nextjs/`](./blog-nextjs/)

**Comandos rápidos**:
```bash
# Crear proyecto
> Use nextjs-architect to create a static blog with MDX

# Estructura generada
blog-nextjs/
├── app/
│   ├── blog/[slug]/page.tsx
│   └── blog/page.tsx
├── components/
├── content/
└── lib/mdx.ts
```

---

### 3. Landing Page - Nuxt

**Stack**: Nuxt 3 + Vue 3 + Tailwind + Netlify Forms

**Descripción**: Landing page moderna con formularios y animaciones.

**Features**:
- ✅ SSR con hydration optimizada
- ✅ Formularios con validación
- ✅ Animaciones con GSAP
- ✅ SEO completo
- ✅ Contact form funcional

**Agente recomendado**: `nuxt-architect`

**Tiempo estimado**: 1-2 horas

**Directorio**: [`landing-nuxt/`](./landing-nuxt/)

---

### 4. E-commerce Product Catalog

**Stack**: Next.js 15 + FastAPI + PostgreSQL + Stripe

**Descripción**: Catálogo de productos con carrito, checkout y pagos.

**Features**:
- ✅ Catálogo con filtros y búsqueda
- ✅ Carrito de compras (Zustand)
- ✅ Checkout con Stripe
- ✅ Admin panel para productos
- ✅ Optimistic UI updates
- ✅ Image optimization

**Agentes recomendados**:
- Frontend: `nextjs-architect`
- Backend: `fastapi-architect`

**Tiempo estimado**: 4-5 horas

**Directorio**: [`ecommerce-nextjs-fastapi/`](./ecommerce-nextjs-fastapi/)

**Arquitectura**:
```
Frontend (Next.js)           Backend (FastAPI)
├── Product Listing    ←→    ├── Products API
├── Shopping Cart             ├── Orders API
├── Checkout                  ├── Payments (Stripe)
└── User Dashboard           └── Auth (JWT)
```

**Comandos rápidos**:
```bash
# Fase 1: Backend API
> Use fastapi-architect to create an e-commerce API with products, orders, and Stripe integration

# Fase 2: Frontend
> Use nextjs-architect to create an e-commerce frontend that consumes the FastAPI backend

# Fase 3: Integración
> Connect the Next.js app to the FastAPI backend with proper error handling and loading states
```

---

### 5. SaaS Dashboard

**Stack**: Nuxt 3 + Django + PostgreSQL + Redis

**Descripción**: Dashboard SaaS con autenticación, analytics y configuración.

**Features**:
- ✅ Multi-tenant architecture
- ✅ Dashboard con charts (Chart.js)
- ✅ User management
- ✅ Settings & preferences
- ✅ Real-time notifications
- ✅ API rate limiting

**Agentes recomendados**:
- Frontend: `nuxt-architect`
- Backend: `django-architect`

**Tiempo estimado**: 5-6 horas

**Directorio**: [`saas-dashboard/`](./saas-dashboard/)

**Arquitectura**:
```
Frontend (Nuxt 3)            Backend (Django)
├── Dashboard         ←→     ├── Analytics API
├── User Settings            ├── User Management
├── Team Management          ├── Tenant API
└── Billing                  └── Stripe Webhooks
```

---

### 6. API Gateway

**Stack**: Express.js + TypeScript + Redis + JWT

**Descripción**: API Gateway que coordina microservicios con rate limiting.

**Features**:
- ✅ Request routing
- ✅ Rate limiting con Redis
- ✅ JWT validation
- ✅ Request/response logging
- ✅ Circuit breaker pattern
- ✅ Health checks

**Agente recomendado**: `express-architect`

**Tiempo estimado**: 3-4 horas

**Directorio**: [`api-gateway-express/`](./api-gateway-express/)

**Microservices**:
```
API Gateway (Express)
├── /api/users      → User Service
├── /api/products   → Product Service
├── /api/orders     → Order Service
└── /api/payments   → Payment Service
```

---

### 9. AI Code Reviewer 🤖

**Stack**: FastAPI + Celery + PostgreSQL + Redis + Claude API + GitHub Webhooks

**Descripción**: Sistema de revisión automática de código que usa Claude AI para analizar pull requests en GitHub, detectar bugs, vulnerabilidades de seguridad, y sugerir mejoras.

**Features**:
- ✅ GitHub webhook integration
- ✅ Claude AI code analysis
- ✅ Automated PR comments
- ✅ Security vulnerability detection
- ✅ Performance issue identification
- ✅ Code quality metrics
- ✅ Background job processing con Celery
- ✅ Multi-repository support
- ✅ Custom review rules
- ✅ Severity scoring

**Agente recomendado**: `fastapi-architect`

**Tiempo estimado**: 6-8 horas

**Directorio**: [`ai-code-reviewer/`](./ai-code-reviewer/)

**Arquitectura**:
```
GitHub PR → Webhook → FastAPI → Celery Worker → Claude API → PR Comments
                          ↓
                     PostgreSQL (analysis history)
                          ↓
                       Redis (job queue)
```

**Comandos rápidos**:
```bash
# Crear proyecto
> Use fastapi-architect to create an AI code reviewer that:
  - Receives GitHub webhook events
  - Analyzes code with Claude API
  - Posts automated PR comments
  - Detects security vulnerabilities
  - Tracks analysis history

# Estructura generada
ai-code-reviewer/
├── app/
│   ├── api/v1/endpoints/webhooks.py
│   ├── services/
│   │   ├── claude_analyzer.py
│   │   ├── github_service.py
│   │   └── review_engine.py
│   ├── workers/celery_app.py
│   └── models/
├── tests/
└── docker-compose.yml
```

**Casos de uso**:
- Equipos de desarrollo (code review automation)
- Open source projects
- Empresas con multiple repos
- Consultorías y agencias

**Valor comercial**: $10k-$50k MRR como SaaS

---

### 10. Video Streaming Platform 🎬

**Stack**: Next.js 15 + FastAPI + FFmpeg + AWS S3 + CloudFront + PostgreSQL + Redis

**Descripción**: Plataforma completa de video streaming estilo Netflix con transcoding, HLS adaptive streaming, CDN, y player personalizado.

**Features**:
- ✅ Video upload y processing
- ✅ FFmpeg transcoding pipeline
- ✅ HLS adaptive bitrate streaming
- ✅ CDN configuration (CloudFront)
- ✅ Custom video player con HLS.js
- ✅ Watch progress tracking
- ✅ Subtitle support (WebVTT)
- ✅ Quality selector (1080p, 720p, 480p, 360p)
- ✅ Thumbnail generation
- ✅ Video analytics
- ✅ Content management system
- ✅ User playlists

**Agentes recomendados**:
- Frontend: `nextjs-architect`
- Backend: `fastapi-architect`

**Tiempo estimado**: 8-12 horas

**Directorio**: [`video-streaming-platform/`](./video-streaming-platform/)

**Arquitectura**:
```
Upload → S3 → Lambda (FFmpeg) → Transcoded Videos → CloudFront CDN
                                           ↓
                                    HLS Player ← Analytics
```

**Comandos rápidos**:
```bash
# Crear proyecto
> Use nextjs-architect and fastapi-architect to create a video streaming platform with:
  - Video upload to S3
  - FFmpeg transcoding (multiple qualities)
  - HLS adaptive streaming
  - CloudFront CDN
  - Custom video player
  - Progress tracking
  - Analytics

# Estructura generada
video-streaming-platform/
├── frontend/
│   ├── src/
│   │   ├── app/watch/[videoId]/page.tsx
│   │   ├── components/
│   │   │   ├── VideoPlayer.tsx
│   │   │   └── QualitySelector.tsx
│   │   └── lib/
├── backend/
│   ├── app/
│   │   ├── services/transcoding_service.py
│   │   ├── services/cdn_service.py
│   │   └── api/v1/endpoints/videos.py
│   └── workers/
└── infrastructure/
    └── terraform/
```

**Características técnicas**:
- FFmpeg multi-quality transcoding
- HLS.js player con adaptive bitrate
- S3 + CloudFront para CDN
- Lambda para serverless transcoding
- PostgreSQL para metadata
- Redis para caching

**Casos de uso**:
- Plataformas educativas (cursos online)
- Corporate training
- Entertainment platforms
- Content creator platforms

**Valor comercial**: $100k-$15M MRR como SaaS

---

### 11. Web3 NFT Marketplace ⛓️

**Stack**: Next.js 15 + Solidity + Hardhat + Ethers.js + IPFS + The Graph + PostgreSQL

**Descripción**: Marketplace completo de NFTs con smart contracts en Solidity, integración Web3, minting, trading, subastas, y wallet connection.

**Features**:
- ✅ ERC-721 NFT smart contract
- ✅ Marketplace smart contract
- ✅ Auction smart contract
- ✅ Wallet connection (MetaMask, WalletConnect)
- ✅ NFT minting con IPFS storage
- ✅ Buy/Sell/Trade NFTs
- ✅ Auction system (English auction)
- ✅ Royalty system para creators
- ✅ The Graph indexing
- ✅ Transaction history
- ✅ Collection management
- ✅ Rarity traits

**Agentes recomendados**:
- Frontend: `nextjs-architect`
- Smart Contracts: General-purpose agent

**Tiempo estimado**: 8-12 horas

**Directorio**: [`web3-nft-marketplace/`](./web3-nft-marketplace/)

**Arquitectura**:
```
Frontend (Next.js) ← Ethers.js → Smart Contracts (Solidity)
        ↓                                  ↓
    PostgreSQL                        Ethereum Network
        ↓                                  ↓
  The Graph Indexer ←─────────────────────┘
        ↓
    IPFS (metadata + images)
```

**Smart Contracts**:
```solidity
contracts/
├── NFT.sol                  # ERC-721 implementation
├── NFTMarketplace.sol       # Buy/Sell logic
├── NFTAuction.sol          # Auction system
└── interfaces/
```

**Comandos rápidos**:
```bash
# Crear proyecto
> Create a Web3 NFT marketplace with:
  - Solidity smart contracts (ERC-721, Marketplace, Auction)
  - Next.js frontend with Ethers.js
  - IPFS storage for NFT metadata
  - The Graph for blockchain indexing
  - Wallet connection support
  - Royalty system

# Estructura generada
web3-nft-marketplace/
├── frontend/
│   ├── src/
│   │   ├── app/
│   │   ├── components/web3/
│   │   ├── hooks/useWeb3.ts
│   │   └── lib/contracts/
├── contracts/
│   ├── NFT.sol
│   ├── NFTMarketplace.sol
│   └── NFTAuction.sol
├── hardhat.config.ts
├── scripts/deploy.ts
└── test/
```

**Características técnicas**:
- Hardhat development environment
- Ethers.js para Web3 integration
- IPFS (Pinata) para metadata storage
- The Graph para indexing eficiente
- ERC-721 con royalties
- Gas optimization
- Reentrancy protection

**Casos de uso**:
- NFT art marketplace
- Gaming asset marketplace
- Digital collectibles
- Tokenized real estate

**Valor comercial**: $50k-$500k MRR (2.5% platform fee)

---

### 12. Social Media Platform 🐦

**Stack**: Next.js 15 + FastAPI + PostgreSQL + Redis + ElasticSearch + S3 + ML (Python)

**Descripción**: Plataforma de redes sociales completa estilo Twitter/X con feed algorítmico, real-time updates, trending topics, y content moderation con IA.

**Features**:
- ✅ User profiles y bio
- ✅ Post creation (text, images, videos)
- ✅ Follow/Unfollow system
- ✅ Algorithmic feed con ML ranking
- ✅ Trending topics
- ✅ Hashtags y mentions
- ✅ Likes, retweets, comments
- ✅ Real-time notifications (WebSocket)
- ✅ Direct messages
- ✅ Content moderation (Claude AI)
- ✅ Full-text search (ElasticSearch)
- ✅ Image/video upload
- ✅ Analytics dashboard

**Agentes recomendados**:
- Frontend: `nextjs-architect`
- Backend: `fastapi-architect`

**Tiempo estimado**: 12-16 horas

**Directorio**: [`social-media-platform/`](./social-media-platform/)

**Arquitectura**:
```
Next.js App ← REST API → FastAPI Backend
     ↓                          ↓
WebSocket ← Redis Pub/Sub → PostgreSQL
     ↓                          ↓
Notifications          ElasticSearch (search)
                              ↓
                    ML Feed Ranking Service
                              ↓
                    Claude AI (moderation)
```

**Comandos rápidos**:
```bash
# Crear proyecto
> Create a social media platform with:
  - Next.js 15 frontend
  - FastAPI backend with async
  - PostgreSQL for data
  - Redis for caching and real-time
  - ElasticSearch for search
  - ML feed ranking algorithm
  - Claude AI content moderation
  - WebSocket notifications
  - Image/video uploads to S3

# Estructura generada
social-media-platform/
├── frontend/
│   ├── src/
│   │   ├── app/
│   │   │   ├── home/page.tsx
│   │   │   ├── profile/[username]/page.tsx
│   │   │   └── explore/page.tsx
│   │   ├── components/
│   │   │   ├── Feed/
│   │   │   ├── Post/
│   │   │   └── TrendingSidebar/
│   │   └── lib/
├── backend/
│   ├── app/
│   │   ├── api/v1/
│   │   │   ├── endpoints/posts.py
│   │   │   ├── endpoints/users.py
│   │   │   └── endpoints/feed.py
│   │   ├── services/
│   │   │   ├── feed_service.py
│   │   │   ├── ml_ranker.py
│   │   │   └── moderation_service.py
│   │   └── websocket/
│   └── ml/
│       └── models/
└── infrastructure/
```

**Database Schema (Highlights)**:
```prisma
model Post {
  id            String   @id @default(cuid())
  content       String   @db.Text
  authorId      String
  likes         Like[]
  retweets      Retweet[]
  comments      Comment[]
  hashtags      Hashtag[]
  viewCount     Int      @default(0)
  createdAt     DateTime @default(now())

  @@index([authorId, createdAt])
  @@index([createdAt])
}

model Follow {
  followerId    String
  followingId   String
  @@id([followerId, followingId])
}
```

**ML Feed Algorithm**:
- Feature extraction (recency, engagement, user affinity)
- Ranking model (sklearn/LightGBM)
- Diversity injection
- Real-time updates

**Casos de uso**:
- Nicho communities (vertical social networks)
- Corporate internal social networks
- Event-based platforms
- Content creator platforms

**Valor comercial**: $20k-$200k MRR (ads, premium features)

---

### 13. Healthcare AI Platform

**Stack**: Multi-stack con especialización médica

**Descripción**: Plataforma completa de healthcare con IA, HIPAA compliance.

**Features**:
- ✅ Patient management
- ✅ AI diagnostic assistance
- ✅ FHIR integration
- ✅ HIPAA compliance
- ✅ EHR integration
- ✅ Appointment scheduling

**Agentes recomendados**:
- Medical: `medical-diagnostic`
- Frontend: `nextjs-architect`
- Backend: `django-architect`

**Tiempo estimado**: 1-2 días

**Directorio**: [`healthcare-ai/`](./healthcare-ai/)

**Estado**: ⚠️ En desarrollo (parcialmente completado)

---

### 8. Real-time Chat

**Stack**: React + Express + Socket.io + Redis + PostgreSQL

**Descripción**: Chat en tiempo real con rooms, typing indicators, file upload.

**Features**:
- ✅ Real-time messaging (Socket.io)
- ✅ Chat rooms
- ✅ Typing indicators
- ✅ Online status
- ✅ Message history
- ✅ File uploads (S3)

**Agentes recomendados**:
- Backend: `express-architect`
- Frontend: General-purpose agent

**Tiempo estimado**: 6-8 horas

**Directorio**: [`chat-realtime/`](./chat-realtime/)

---

### 14. Multi-tenant SaaS

**Stack**: Next.js + Django + PostgreSQL + Redis + S3

**Descripción**: SaaS completo con multi-tenancy, billing, team management.

**Features**:
- ✅ Multi-tenant database design
- ✅ Stripe subscription billing
- ✅ Team & role management
- ✅ Usage analytics
- ✅ Custom domains
- ✅ White-label support

**Agentes recomendados**:
- Frontend: `nextjs-architect`
- Backend: `django-architect`
- Orchestration: Multi-agent workflow

**Tiempo estimado**: 2-3 días

**Directorio**: [`multitenant-saas/`](./multitenant-saas/)

---

## 🚀 Cómo Usar los Ejemplos

### Opción 1: Empezar desde Cero

```bash
# 1. Elige un ejemplo
cd examples/

# 2. Usa el agente recomendado
> Use [agente-nombre] to create [project description]

# 3. Sigue el README del ejemplo
cat ecommerce-nextjs-fastapi/README.md
```

### Opción 2: Clonar y Personalizar

```bash
# 1. Copia el directorio
cp -r examples/todo-api-fastapi my-custom-api

# 2. Personaliza con Claude Code
> Modify this Todo API to add [your custom features]
```

### Opción 3: Usar como Referencia

```bash
# Lee el código como referencia
cat examples/ecommerce-nextjs-fastapi/backend/app/api/v1/endpoints/products.py

# Pregunta a Claude
> Explain how this e-commerce example handles pagination
```

---

## 📊 Comparación de Ejemplos

| Ejemplo | Complejidad | Stack | Features | Tiempo | Tipo |
|---------|-------------|-------|----------|--------|------|
| Todo API | 🟢 Básico | FastAPI | CRUD, Auth | 1-2h | API |
| Blog Static | 🟢 Básico | Next.js | SSG, SEO | 1-2h | Frontend |
| Landing Page | 🟢 Básico | Nuxt | Forms, SEO | 1-2h | Frontend |
| E-commerce | 🟡 Intermedio | Next.js + FastAPI | Payments, Cart | 4-5h | Full-stack |
| SaaS Dashboard | 🟡 Intermedio | Nuxt + Django | Multi-tenant | 5-6h | Full-stack |
| API Gateway | 🟡 Intermedio | Express | Microservices | 3-4h | Backend |
| Real-Time Chat 💬 | 🟡 Intermedio | Next.js + Socket.io | WebSockets, Redis | 4-5h | Real-time |
| Landing Page Builder 🎨 | 🔴 Avanzado | Next.js + DnD | No-Code Editor | 6-8h | Frontend |
| AI Code Reviewer 🤖 | 🔴 Avanzado | FastAPI + Claude AI | PR Analysis, Security | 6-8h | AI/DevOps |
| Video Platform 🎬 | 🔴 Avanzado | Next.js + FFmpeg | HLS, CDN, Transcoding | 8-12h | Media |
| Web3 NFT Marketplace ⛓️ | 🔴 Avanzado | Next.js + Solidity | Smart Contracts, IPFS | 8-12h | Blockchain |
| Social Media 🐦 | 🔴 Avanzado | Next.js + FastAPI + ML | Feed Algo, Real-time | 12-16h | Full-stack |
| Healthcare AI | 🟣 Enterprise | Multi-stack | HIPAA, FHIR | 1-2d | Healthcare |
| Multi-tenant SaaS | 🟣 Enterprise | Next.js + Django | Billing, Teams | 2-3d | Enterprise |

---

## 🎯 Rutas de Aprendizaje por Objetivo

### Objetivo: Frontend Moderno

1. **Nivel 1**: Blog Static (Next.js) - Aprende SSG
2. **Nivel 2**: Landing Page (Nuxt) - Aprende SSR
3. **Nivel 3**: E-commerce Frontend - Aprende state management

**Agentes a dominar**: `nextjs-architect`, `nuxt-architect`

---

### Objetivo: Backend APIs

1. **Nivel 1**: Todo API (FastAPI) - Aprende REST basics
2. **Nivel 2**: API Gateway (Express) - Aprende arquitectura
3. **Nivel 3**: Django API - Aprende ORM avanzado

**Agentes a dominar**: `fastapi-architect`, `express-architect`, `django-architect`

---

### Objetivo: Full-Stack Developer

1. **Nivel 1**: Todo API + Blog = Full-stack simple
2. **Nivel 2**: E-commerce - Integración frontend-backend
3. **Nivel 3**: SaaS Dashboard - Multi-tenant

**Agentes a dominar**: Todos los stack architects + multi-agent orchestration

---

### Objetivo: Enterprise/Startup

1. **Nivel 1**: API Gateway - Aprende microservices
2. **Nivel 2**: Real-time Chat - Aprende WebSockets
3. **Nivel 3**: Multi-tenant SaaS - Aprende escalabilidad

**Agentes a dominar**: Todos + domain specialists

---

## 💡 Tips para Maximizar el Aprendizaje

### 1. Progresión Incremental
```bash
# ❌ NO: Empezar con el más complejo
> Create a multi-tenant SaaS with everything

# ✅ SÍ: Progresar paso a paso
> Create a simple Todo API (día 1)
> Add authentication (día 2)
> Add pagination (día 3)
```

### 2. Usar Agentes Específicos
```bash
# ❌ NO: Prompt genérico
> Create an API

# ✅ SÍ: Usar agente especializado
> Use fastapi-architect to create a REST API with Pydantic validation
```

### 3. Pedir Explicaciones
```bash
# Durante el desarrollo
> Explain why you chose async here instead of sync

# Después de completar
> Review the security best practices in this code
```

### 4. Iterar y Mejorar
```bash
# Primera versión funcional
> Create basic e-commerce

# Mejorar performance
> Optimize this code for better performance

# Mejorar seguridad
> Use security-auditor to check for vulnerabilities
```

---

## 🔗 Recursos Relacionados

- **Agentes**: [`../agents/README.md`](../agents/README.md) - Todos los agentes disponibles
- **Guías**: [`../docs/`](../docs/) - Documentación completa
- **Templates**: [`../templates/`](../templates/) - Templates base
- **Scripts**: [`../scripts/`](../scripts/) - Herramientas útiles

---

## 🤝 Contribuir Ejemplos

¿Creaste un proyecto útil? ¡Compártelo!

### Estructura de un Ejemplo

```
examples/
└── my-example/
    ├── README.md              # Descripción completa
    ├── ARCHITECTURE.md        # Decisiones de arquitectura
    ├── .claude/
    │   ├── CLAUDE.md         # Contexto del proyecto
    │   └── agents/           # Agentes personalizados
    ├── frontend/             # (si aplica)
    ├── backend/              # (si aplica)
    ├── docs/                 # Documentación adicional
    └── scripts/              # Scripts útiles
```

### Checklist para Contribuir

- [ ] README completo con descripción
- [ ] Código comentado y limpio
- [ ] Agentes recomendados listados
- [ ] Tiempo estimado incluido
- [ ] ARCHITECTURE.md explicando decisiones
- [ ] .gitignore apropiado
- [ ] Instrucciones de setup claras

---

## 📅 Roadmap de Ejemplos

### v0.2 (Actual)
- ✅ Healthcare AI (parcial)
- ✅ Structure y documentación

### v0.3 (Próximo)
- 🔲 Todo API - FastAPI (completo)
- 🔲 E-commerce - Next.js + FastAPI (completo)
- 🔲 SaaS Dashboard - Nuxt + Django (completo)

### v0.4 (Futuro)
- 🔲 Real-time Chat
- 🔲 API Gateway
- 🔲 Multi-tenant SaaS

---

### 7. Real-Time Chat 💬

**Stack**: Next.js 15 + Socket.io + Redis + PostgreSQL

**Descripción**: Aplicación de chat en tiempo real con salas, mensajes directos, typing indicators, y presencia de usuarios.

**Features**:
- ✅ Real-time messaging con Socket.io
- ✅ Salas públicas y privadas
- ✅ Mensajes directos (DMs)
- ✅ Typing indicators
- ✅ Online/offline presence
- ✅ Message history con paginación
- ✅ File uploads (imágenes)
- ✅ Emoji reactions
- ✅ Read receipts
- ✅ Redis pub/sub para múltiples servidores

**Agente recomendado**: `nextjs-architect`

**Tiempo estimado**: 4-5 horas

**Directorio**: [`realtime-chat-socketio/`](./realtime-chat-socketio/)

**Comandos rápidos**:
```bash
# Crear proyecto
> Use nextjs-architect to create a real-time chat application with:
  - Next.js 15 with App Router
  - Socket.io for real-time messaging
  - PostgreSQL for message persistence
  - Redis for pub/sub
  - User authentication with NextAuth
  - File uploads to S3
  - Typing indicators and presence

# Estructura generada
realtime-chat-socketio/
├── src/
│   ├── app/
│   │   ├── chat/[roomId]/page.tsx
│   │   └── api/
│   ├── components/chat/
│   ├── hooks/useSocket.ts
│   └── lib/socket/
├── server.ts                    # Socket.io server
├── prisma/schema.prisma
└── docker-compose.yml
```

**Características técnicas**:
- Socket.io con Redis adapter para horizontal scaling
- Prisma ORM para PostgreSQL
- JWT authentication
- Typing indicators con debounce
- Message reactions y read receipts
- File upload to S3
- Room management y DMs

**Casos de uso**:
- Chat interno de empresas
- Soporte técnico en vivo
- Comunidades online
- Plataformas de colaboración

---

### 8. Landing Page Builder 🎨

**Stack**: Next.js 15 + React DnD + TipTap + Tailwind CSS + PostgreSQL

**Descripción**: Editor visual drag-and-drop para crear landing pages sin código. Incluye componentes preconstruidos, editor de contenido, personalización de estilos, y exportación de páginas.

**Features**:
- ✅ Drag & Drop visual editor
- ✅ 20+ componentes preconstruidos
- ✅ Editor de texto rico (TipTap)
- ✅ Responsive design preview (mobile, tablet, desktop)
- ✅ Style customization (colores, tipografía, spacing)
- ✅ Image uploads y media library
- ✅ Template gallery
- ✅ Undo/Redo history
- ✅ Export to HTML/React
- ✅ SEO meta tags editor
- ✅ Version history

**Agente recomendado**: `nextjs-architect`

**Tiempo estimado**: 6-8 horas

**Directorio**: [`landing-page-builder/`](./landing-page-builder/)

**Comandos rápidos**:
```bash
# Crear proyecto
> Use nextjs-architect to create a landing page builder with:
  - Next.js 15 with App Router
  - React DnD for drag and drop
  - TipTap for rich text editing
  - Tailwind CSS for styling
  - PostgreSQL for data persistence
  - Image upload to S3
  - Template system
  - Export to HTML

# Estructura generada
landing-page-builder/
├── src/
│   ├── app/
│   │   ├── editor/[pageId]/page.tsx
│   │   └── api/
│   ├── components/
│   │   ├── editor/
│   │   ├── blocks/
│   │   └── dnd/
│   ├── lib/
│   │   ├── editor/store.ts
│   │   └── blocks/registry.ts
│   └── hooks/
├── prisma/schema.prisma
└── package.json
```

**Categorías de Bloques**:
- **Marketing**: Hero, Features, CTA, Pricing, FAQ
- **Social Proof**: Testimonials, Logo Cloud, Stats, Reviews
- **Content**: Text, Image, Gallery, Video, Divider
- **Layout**: Container, Columns, Spacer, Header, Footer
- **Forms**: Contact, Newsletter, Survey, Lead Capture

**Características técnicas**:
- @dnd-kit para drag & drop
- Zustand para state management
- TipTap rich text editor
- Block registry system extensible
- Undo/Redo con history management
- Property panel dinámico
- Responsive breakpoints
- Export to HTML/React components

**Casos de uso**:
- Agencias de marketing
- Freelancers y consultores
- Startups validando ideas
- Equipos de producto (landing pages rápidas)
- No-code builders

---

## 🎓 Testimonios (Proyectados)

> "Los ejemplos me ahorraron semanas de setup. En 2 horas tenía un e-commerce funcional."
> — Developer, Startup

> "El ejemplo de SaaS Dashboard me enseñó más sobre multi-tenancy que 10 tutoriales."
> — Senior Dev, Agency

> "Usé el API Gateway example como base para nuestros microservices. Production-ready."
> — Tech Lead, Enterprise

---

**¿Necesitas ayuda?** Consulta la [documentación principal](../README.md) o los [agentes disponibles](../agents/README.md).

**Próximos ejemplos**: Vota en [GitHub Discussions](https://github.com/tu-usuario/claude-code-advanced-guide/discussions) qué ejemplos quieres ver primero.
