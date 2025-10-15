# 📦 Complete Examples - Claude Code

Collection of complete projects demonstrating how to use Claude Code with different technology stacks and real-world use cases.

## 🎯 Example Index

### By Complexity Level

#### 🟢 Basic (1-2 hours to complete)
1. [Todo API - FastAPI](#1-todo-api---fastapi) - Simple REST API with CRUD
2. [Static Blog - Next.js](#2-static-blog---nextjs) - Static blog with SSG
3. [Landing Page - Nuxt](#3-landing-page---nuxt) - Landing page with forms

#### 🟡 Intermediate (3-5 hours to complete)
4. [E-commerce Product Catalog](#4-e-commerce-product-catalog) - Next.js + FastAPI
5. [SaaS Dashboard](#5-saas-dashboard) - Nuxt + Django
6. [API Gateway](#6-api-gateway) - Express + Microservices
7. [Real-Time Chat](#7-real-time-chat-) - Next.js + Socket.io + Redis 💬

#### 🔴 Advanced (6-8 hours to complete)
8. [Landing Page Builder](#8-landing-page-builder-) - No-Code Visual Editor 🎨
9. [AI Code Reviewer](#9-ai-code-reviewer-) - GitHub PR Analysis with Claude AI 🤖
10. [Video Streaming Platform](#10-video-streaming-platform-) - Netflix-scale Video Platform 🎬
11. [Web3 NFT Marketplace](#11-web3-nft-marketplace-️) - Blockchain NFT Trading Platform ⛓️
12. [Social Media Platform](#12-social-media-platform-) - Twitter/X Clone with ML Feed 🐦

#### 🟣 Enterprise (1-2+ days)
13. [ML Training Pipeline](#13-ml-training-pipeline-) - Production MLOps with MLflow + Optuna 🤖
14. [Healthcare AI Platform](#14-healthcare-ai-platform) - Multi-stack with medical specialization
15. [Multi-tenant SaaS](#15-multi-tenant-saas) - Full-stack enterprise

---

## 📋 Detailed Examples

### 1. Todo API - FastAPI

**Stack**: Python + FastAPI + SQLAlchemy + PostgreSQL

**Description**: Complete REST API for task management with JWT authentication.

**Features**:
- ✅ Complete CRUD for tasks
- ✅ JWT authentication
- ✅ Pagination and filters
- ✅ Tests with pytest
- ✅ Automatic OpenAPI docs

**Recommended agent**: `fastapi-architect`

**Estimated time**: 1-2 hours

**Directory**: [`todo-api-fastapi/`](./todo-api-fastapi/)

**Quick commands**:
```bash
# Create project
> Use fastapi-architect to create a Todo API with JWT authentication

# Generated structure
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

### 2. Static Blog - Next.js

**Stack**: Next.js 15 + MDX + Tailwind CSS

**Description**: Static blog with SSG, optimized for SEO and performance.

**Features**:
- ✅ SSG with ISR for posts
- ✅ MDX for rich content
- ✅ SEO optimization
- ✅ Core Web Vitals optimized
- ✅ Dark mode

**Recommended agent**: `nextjs-architect`

**Estimated time**: 1-2 hours

**Directory**: [`blog-nextjs/`](./blog-nextjs/)

**Quick commands**:
```bash
# Create project
> Use nextjs-architect to create a static blog with MDX

# Generated structure
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

**Description**: Modern landing page with forms and animations.

**Features**:
- ✅ SSR with optimized hydration
- ✅ Forms with validation
- ✅ Animations with GSAP
- ✅ Complete SEO
- ✅ Functional contact form

**Recommended agent**: `nuxt-architect`

**Estimated time**: 1-2 hours

**Directory**: [`landing-nuxt/`](./landing-nuxt/)

---

### 4. E-commerce Product Catalog

**Stack**: Next.js 15 + FastAPI + PostgreSQL + Stripe

**Description**: Product catalog with cart, checkout, and payments.

**Features**:
- ✅ Catalog with filters and search
- ✅ Shopping cart (Zustand)
- ✅ Checkout with Stripe
- ✅ Admin panel for products
- ✅ Optimistic UI updates
- ✅ Image optimization

**Recommended agents**:
- Frontend: `nextjs-architect`
- Backend: `fastapi-architect`

**Estimated time**: 4-5 hours

**Directory**: [`ecommerce-nextjs-fastapi/`](./ecommerce-nextjs-fastapi/)

**Architecture**:
```
Frontend (Next.js)           Backend (FastAPI)
├── Product Listing    ←→    ├── Products API
├── Shopping Cart             ├── Orders API
├── Checkout                  ├── Payments (Stripe)
└── User Dashboard           └── Auth (JWT)
```

**Quick commands**:
```bash
# Phase 1: Backend API
> Use fastapi-architect to create an e-commerce API with products, orders, and Stripe integration

# Phase 2: Frontend
> Use nextjs-architect to create an e-commerce frontend that consumes the FastAPI backend

# Phase 3: Integration
> Connect the Next.js app to the FastAPI backend with proper error handling and loading states
```

---

### 5. SaaS Dashboard

**Stack**: Nuxt 3 + Django + PostgreSQL + Redis

**Description**: SaaS dashboard with authentication, analytics, and configuration.

**Features**:
- ✅ Multi-tenant architecture
- ✅ Dashboard with charts (Chart.js)
- ✅ User management
- ✅ Settings & preferences
- ✅ Real-time notifications
- ✅ API rate limiting

**Recommended agents**:
- Frontend: `nuxt-architect`
- Backend: `django-architect`

**Estimated time**: 5-6 hours

**Directory**: [`saas-dashboard/`](./saas-dashboard/)

**Architecture**:
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

**Description**: API Gateway that coordinates microservices with rate limiting.

**Features**:
- ✅ Request routing
- ✅ Rate limiting with Redis
- ✅ JWT validation
- ✅ Request/response logging
- ✅ Circuit breaker pattern
- ✅ Health checks

**Recommended agent**: `express-architect`

**Estimated time**: 3-4 hours

**Directory**: [`api-gateway-express/`](./api-gateway-express/)

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

**Description**: Automated code review system that uses Claude AI to analyze pull requests on GitHub, detect bugs, security vulnerabilities, and suggest improvements.

**Features**:
- ✅ GitHub webhook integration
- ✅ Claude AI code analysis
- ✅ Automated PR comments
- ✅ Security vulnerability detection
- ✅ Performance issue identification
- ✅ Code quality metrics
- ✅ Background job processing with Celery
- ✅ Multi-repository support
- ✅ Custom review rules
- ✅ Severity scoring

**Recommended agent**: `fastapi-architect`

**Estimated time**: 6-8 hours

**Directory**: [`ai-code-reviewer/`](./ai-code-reviewer/)

**Architecture**:
```
GitHub PR → Webhook → FastAPI → Celery Worker → Claude API → PR Comments
                          ↓
                     PostgreSQL (analysis history)
                          ↓
                       Redis (job queue)
```

**Quick commands**:
```bash
# Create project
> Use fastapi-architect to create an AI code reviewer that:
  - Receives GitHub webhook events
  - Analyzes code with Claude API
  - Posts automated PR comments
  - Detects security vulnerabilities
  - Tracks analysis history

# Generated structure
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

**Use cases**:
- Development teams (code review automation)
- Open source projects
- Companies with multiple repos
- Consultancies and agencies

**Commercial value**: $10k-$50k MRR as SaaS

---

### 10. Video Streaming Platform 🎬

**Stack**: Next.js 15 + FastAPI + FFmpeg + AWS S3 + CloudFront + PostgreSQL + Redis

**Description**: Complete Netflix-style video streaming platform with transcoding, HLS adaptive streaming, CDN, and custom player.

**Features**:
- ✅ Video upload and processing
- ✅ FFmpeg transcoding pipeline
- ✅ HLS adaptive bitrate streaming
- ✅ CDN configuration (CloudFront)
- ✅ Custom video player with HLS.js
- ✅ Watch progress tracking
- ✅ Subtitle support (WebVTT)
- ✅ Quality selector (1080p, 720p, 480p, 360p)
- ✅ Thumbnail generation
- ✅ Video analytics
- ✅ Content management system
- ✅ User playlists

**Recommended agents**:
- Frontend: `nextjs-architect`
- Backend: `fastapi-architect`

**Estimated time**: 8-12 hours

**Directory**: [`video-streaming-platform/`](./video-streaming-platform/)

**Architecture**:
```
Upload → S3 → Lambda (FFmpeg) → Transcoded Videos → CloudFront CDN
                                           ↓
                                    HLS Player ← Analytics
```

**Quick commands**:
```bash
# Create project
> Use nextjs-architect and fastapi-architect to create a video streaming platform with:
  - Video upload to S3
  - FFmpeg transcoding (multiple qualities)
  - HLS adaptive streaming
  - CloudFront CDN
  - Custom video player
  - Progress tracking
  - Analytics

# Generated structure
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

**Technical features**:
- FFmpeg multi-quality transcoding
- HLS.js player with adaptive bitrate
- S3 + CloudFront for CDN
- Lambda for serverless transcoding
- PostgreSQL for metadata
- Redis for caching

**Use cases**:
- Educational platforms (online courses)
- Corporate training
- Entertainment platforms
- Content creator platforms

**Commercial value**: $100k-$15M MRR as SaaS

---

### 11. Web3 NFT Marketplace ⛓️

**Stack**: Next.js 15 + Solidity + Hardhat + Ethers.js + IPFS + The Graph + PostgreSQL

**Description**: Complete NFT marketplace with smart contracts in Solidity, Web3 integration, minting, trading, auctions, and wallet connection.

**Features**:
- ✅ ERC-721 NFT smart contract
- ✅ Marketplace smart contract
- ✅ Auction smart contract
- ✅ Wallet connection (MetaMask, WalletConnect)
- ✅ NFT minting with IPFS storage
- ✅ Buy/Sell/Trade NFTs
- ✅ Auction system (English auction)
- ✅ Royalty system for creators
- ✅ The Graph indexing
- ✅ Transaction history
- ✅ Collection management
- ✅ Rarity traits

**Recommended agents**:
- Frontend: `nextjs-architect`
- Smart Contracts: General-purpose agent

**Estimated time**: 8-12 hours

**Directory**: [`web3-nft-marketplace/`](./web3-nft-marketplace/)

**Architecture**:
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

**Quick commands**:
```bash
# Create project
> Create a Web3 NFT marketplace with:
  - Solidity smart contracts (ERC-721, Marketplace, Auction)
  - Next.js frontend with Ethers.js
  - IPFS storage for NFT metadata
  - The Graph for blockchain indexing
  - Wallet connection support
  - Royalty system

# Generated structure
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

**Technical features**:
- Hardhat development environment
- Ethers.js for Web3 integration
- IPFS (Pinata) for metadata storage
- The Graph for efficient indexing
- ERC-721 with royalties
- Gas optimization
- Reentrancy protection

**Use cases**:
- NFT art marketplace
- Gaming asset marketplace
- Digital collectibles
- Tokenized real estate

**Commercial value**: $50k-$500k MRR (2.5% platform fee)

---

### 12. Social Media Platform 🐦

**Stack**: Next.js 15 + FastAPI + PostgreSQL + Redis + ElasticSearch + S3 + ML (Python)

**Description**: Complete Twitter/X-style social media platform with algorithmic feed, real-time updates, trending topics, and AI content moderation.

**Features**:
- ✅ User profiles and bio
- ✅ Post creation (text, images, videos)
- ✅ Follow/Unfollow system
- ✅ Algorithmic feed with ML ranking
- ✅ Trending topics
- ✅ Hashtags and mentions
- ✅ Likes, retweets, comments
- ✅ Real-time notifications (WebSocket)
- ✅ Direct messages
- ✅ Content moderation (Claude AI)
- ✅ Full-text search (ElasticSearch)
- ✅ Image/video upload
- ✅ Analytics dashboard

**Recommended agents**:
- Frontend: `nextjs-architect`
- Backend: `fastapi-architect`

**Estimated time**: 12-16 hours

**Directory**: [`social-media-platform/`](./social-media-platform/)

**Architecture**:
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

**Quick commands**:
```bash
# Create project
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

# Generated structure
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

**Use cases**:
- Niche communities (vertical social networks)
- Corporate internal social networks
- Event-based platforms
- Content creator platforms

**Commercial value**: $20k-$200k MRR (ads, premium features)

---

### 13. ML Training Pipeline 🤖

**Stack**: Python 3.11 + scikit-learn + MLflow + Optuna + FastAPI + PostgreSQL

**Description**: Complete Machine Learning pipeline for customer churn prediction, including experiment tracking, hyperparameter tuning, model registry, deployment, and monitoring.

**Features**:
- ✅ Data preprocessing and feature engineering
- ✅ Experiment tracking with MLflow
- ✅ Hyperparameter optimization with Optuna
- ✅ Model versioning and registry
- ✅ FastAPI inference endpoint
- ✅ Data drift detection with Evidently
- ✅ Automated retraining pipeline
- ✅ A/B testing framework
- ✅ Prometheus metrics export
- ✅ Docker + Kubernetes deployment

**Included algorithms**:
- Logistic Regression (baseline)
- Random Forest (production)
- Gradient Boosting (high performance)

**Recommended agent**: `ml-engineer` (🚧 coming soon)

**Estimated time**: 8-10 hours

**Directory**: [`ml-training-pipeline/`](./ml-training-pipeline/)

**Architecture**:
```
Raw Data → Preprocessing → Feature Engineering
    ↓
Train/Val/Test Split
    ↓
Training Loop (MLflow logging)
    ↓
Optuna HPO → Best Model → Model Registry
    ↓
FastAPI Deployment
    ↓
Monitoring & Drift Detection
    ↓
Automated Retraining
```

**Quick commands**:
```bash
# Setup
docker-compose up -d  # PostgreSQL + MLflow

# Train model
python src/models/train.py

# Hyperparameter tuning
python src/models/tune.py --n-trials 50

# Start API
uvicorn src.api.main:app --reload

# Predict
curl -X POST http://localhost:8000/predict \
  -H "Content-Type: application/json" \
  -d '{"customer_id": "C123", "total_purchases": 15, ...}'
```

**MLflow UI**:
```bash
# Open MLflow
open http://localhost:5000

# Features:
- Compare experiments
- Visualize metrics
- Model registry
- Artifact viewer
```

**Commercial value**: $15k-$80k MRR (as MLOps platform)

**Use cases**:
- Customer churn prediction
- Credit risk scoring
- Fraud detection
- Demand forecasting
- Product recommendations

---

### 14. Healthcare AI Platform

**Stack**: Multi-stack with medical specialization

**Description**: Complete healthcare platform with AI, HIPAA compliance.

**Features**:
- ✅ Patient management
- ✅ AI diagnostic assistance
- ✅ FHIR integration
- ✅ HIPAA compliance
- ✅ EHR integration
- ✅ Appointment scheduling

**Recommended agents**:
- Medical: `medical-diagnostic`
- Frontend: `nextjs-architect`
- Backend: `django-architect`

**Estimated time**: 1-2 days

**Directory**: [`healthcare-ai/`](./healthcare-ai/)

**Status**: ⚠️ In development (partially completed)

---

### 8. Real-time Chat

**Stack**: React + Express + Socket.io + Redis + PostgreSQL

**Description**: Real-time chat with rooms, typing indicators, file upload.

**Features**:
- ✅ Real-time messaging (Socket.io)
- ✅ Chat rooms
- ✅ Typing indicators
- ✅ Online status
- ✅ Message history
- ✅ File uploads (S3)

**Recommended agents**:
- Backend: `express-architect`
- Frontend: General-purpose agent

**Estimated time**: 6-8 hours

**Directory**: [`chat-realtime/`](./chat-realtime/)

---

### 15. Multi-tenant SaaS

**Stack**: Next.js + Django + PostgreSQL + Redis + S3

**Description**: Complete SaaS with multi-tenancy, billing, team management.

**Features**:
- ✅ Multi-tenant database design
- ✅ Stripe subscription billing
- ✅ Team & role management
- ✅ Usage analytics
- ✅ Custom domains
- ✅ White-label support

**Recommended agents**:
- Frontend: `nextjs-architect`
- Backend: `django-architect`
- Orchestration: Multi-agent workflow

**Estimated time**: 2-3 days

**Directory**: [`multitenant-saas/`](./multitenant-saas/)

---

## 🚀 How to Use the Examples

### Option 1: Start from Scratch

```bash
# 1. Choose an example
cd examples/

# 2. Use the recommended agent
> Use [agent-name] to create [project description]

# 3. Follow the example's README
cat ecommerce-nextjs-fastapi/README.md
```

### Option 2: Clone and Customize

```bash
# 1. Copy the directory
cp -r examples/todo-api-fastapi my-custom-api

# 2. Customize with Claude Code
> Modify this Todo API to add [your custom features]
```

### Option 3: Use as Reference

```bash
# Read the code as reference
cat examples/ecommerce-nextjs-fastapi/backend/app/api/v1/endpoints/products.py

# Ask Claude
> Explain how this e-commerce example handles pagination
```

---

## 📊 Example Comparison

| Example | Complexity | Stack | Features | Time | Type |
|---------|-------------|-------|----------|------|------|
| Todo API | 🟢 Basic | FastAPI | CRUD, Auth | 1-2h | API |
| Static Blog | 🟢 Basic | Next.js | SSG, SEO | 1-2h | Frontend |
| Landing Page | 🟢 Basic | Nuxt | Forms, SEO | 1-2h | Frontend |
| E-commerce | 🟡 Intermediate | Next.js + FastAPI | Payments, Cart | 4-5h | Full-stack |
| SaaS Dashboard | 🟡 Intermediate | Nuxt + Django | Multi-tenant | 5-6h | Full-stack |
| API Gateway | 🟡 Intermediate | Express | Microservices | 3-4h | Backend |
| Real-Time Chat 💬 | 🟡 Intermediate | Next.js + Socket.io | WebSockets, Redis | 4-5h | Real-time |
| Landing Page Builder 🎨 | 🔴 Advanced | Next.js + DnD | No-Code Editor | 6-8h | Frontend |
| AI Code Reviewer 🤖 | 🔴 Advanced | FastAPI + Claude AI | PR Analysis, Security | 6-8h | AI/DevOps |
| Video Platform 🎬 | 🔴 Advanced | Next.js + FFmpeg | HLS, CDN, Transcoding | 8-12h | Media |
| Web3 NFT Marketplace ⛓️ | 🔴 Advanced | Next.js + Solidity | Smart Contracts, IPFS | 8-12h | Blockchain |
| Social Media 🐦 | 🔴 Advanced | Next.js + FastAPI + ML | Feed Algo, Real-time | 12-16h | Full-stack |
| Healthcare AI | 🟣 Enterprise | Multi-stack | HIPAA, FHIR | 1-2d | Healthcare |
| Multi-tenant SaaS | 🟣 Enterprise | Next.js + Django | Billing, Teams | 2-3d | Enterprise |

---

## 🎯 Learning Paths by Objective

### Goal: Modern Frontend

1. **Level 1**: Static Blog (Next.js) - Learn SSG
2. **Level 2**: Landing Page (Nuxt) - Learn SSR
3. **Level 3**: E-commerce Frontend - Learn state management

**Agents to master**: `nextjs-architect`, `nuxt-architect`

---

### Goal: Backend APIs

1. **Level 1**: Todo API (FastAPI) - Learn REST basics
2. **Level 2**: API Gateway (Express) - Learn architecture
3. **Level 3**: Django API - Learn advanced ORM

**Agents to master**: `fastapi-architect`, `express-architect`, `django-architect`

---

### Goal: Full-Stack Developer

1. **Level 1**: Todo API + Blog = Simple full-stack
2. **Level 2**: E-commerce - Frontend-backend integration
3. **Level 3**: SaaS Dashboard - Multi-tenant

**Agents to master**: All stack architects + multi-agent orchestration

---

### Goal: Enterprise/Startup

1. **Level 1**: API Gateway - Learn microservices
2. **Level 2**: Real-time Chat - Learn WebSockets
3. **Level 3**: Multi-tenant SaaS - Learn scalability

**Agents to master**: All + domain specialists

---

## 💡 Tips to Maximize Learning

### 1. Incremental Progression
```bash
# ❌ NO: Start with the most complex
> Create a multi-tenant SaaS with everything

# ✅ YES: Progress step by step
> Create a simple Todo API (day 1)
> Add authentication (day 2)
> Add pagination (day 3)
```

### 2. Use Specific Agents
```bash
# ❌ NO: Generic prompt
> Create an API

# ✅ YES: Use specialized agent
> Use fastapi-architect to create a REST API with Pydantic validation
```

### 3. Ask for Explanations
```bash
# During development
> Explain why you chose async here instead of sync

# After completing
> Review the security best practices in this code
```

### 4. Iterate and Improve
```bash
# First functional version
> Create basic e-commerce

# Improve performance
> Optimize this code for better performance

# Improve security
> Use security-auditor to check for vulnerabilities
```

---

## 🔗 Related Resources

- **Agents**: [`../agents/README.md`](../agents/README.md) - All available agents
- **Guides**: [`../docs/`](../docs/) - Complete documentation
- **Templates**: [`../templates/`](../templates/) - Base templates
- **Scripts**: [`../scripts/`](../scripts/) - Useful tools

---

## 🤝 Contributing Examples

Created a useful project? Share it!

### Example Structure

```
examples/
└── my-example/
    ├── README.md              # Complete description
    ├── ARCHITECTURE.md        # Architecture decisions
    ├── .claude/
    │   ├── CLAUDE.md         # Project context
    │   └── agents/           # Custom agents
    ├── frontend/             # (if applicable)
    ├── backend/              # (if applicable)
    ├── docs/                 # Additional documentation
    └── scripts/              # Useful scripts
```

### Contribution Checklist

- [ ] Complete README with description
- [ ] Commented and clean code
- [ ] Listed recommended agents
- [ ] Estimated time included
- [ ] ARCHITECTURE.md explaining decisions
- [ ] Appropriate .gitignore
- [ ] Clear setup instructions

---

## 📅 Examples Roadmap

### v0.2 (Current)
- ✅ Healthcare AI (partial)
- ✅ Structure and documentation

### v0.3 (Next)
- 🔲 Todo API - FastAPI (complete)
- 🔲 E-commerce - Next.js + FastAPI (complete)
- 🔲 SaaS Dashboard - Nuxt + Django (complete)

### v0.4 (Future)
- 🔲 Real-time Chat
- 🔲 API Gateway
- 🔲 Multi-tenant SaaS

---

### 7. Real-Time Chat 💬

**Stack**: Next.js 15 + Socket.io + Redis + PostgreSQL

**Description**: Real-time chat application with rooms, direct messages, typing indicators, and user presence.

**Features**:
- ✅ Real-time messaging with Socket.io
- ✅ Public and private rooms
- ✅ Direct messages (DMs)
- ✅ Typing indicators
- ✅ Online/offline presence
- ✅ Message history with pagination
- ✅ File uploads (images)
- ✅ Emoji reactions
- ✅ Read receipts
- ✅ Redis pub/sub for multiple servers

**Recommended agent**: `nextjs-architect`

**Estimated time**: 4-5 hours

**Directory**: [`realtime-chat-socketio/`](./realtime-chat-socketio/)

**Quick commands**:
```bash
# Create project
> Use nextjs-architect to create a real-time chat application with:
  - Next.js 15 with App Router
  - Socket.io for real-time messaging
  - PostgreSQL for message persistence
  - Redis for pub/sub
  - User authentication with NextAuth
  - File uploads to S3
  - Typing indicators and presence

# Generated structure
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

**Technical features**:
- Socket.io with Redis adapter for horizontal scaling
- Prisma ORM for PostgreSQL
- JWT authentication
- Typing indicators with debounce
- Message reactions and read receipts
- File upload to S3
- Room management and DMs

**Use cases**:
- Internal company chat
- Live technical support
- Online communities
- Collaboration platforms

---

### 8. Landing Page Builder 🎨

**Stack**: Next.js 15 + React DnD + TipTap + Tailwind CSS + PostgreSQL

**Description**: Visual drag-and-drop editor for creating landing pages without code. Includes pre-built components, content editor, style customization, and page export.

**Features**:
- ✅ Drag & Drop visual editor
- ✅ 20+ pre-built components
- ✅ Rich text editor (TipTap)
- ✅ Responsive design preview (mobile, tablet, desktop)
- ✅ Style customization (colors, typography, spacing)
- ✅ Image uploads and media library
- ✅ Template gallery
- ✅ Undo/Redo history
- ✅ Export to HTML/React
- ✅ SEO meta tags editor
- ✅ Version history

**Recommended agent**: `nextjs-architect`

**Estimated time**: 6-8 hours

**Directory**: [`landing-page-builder/`](./landing-page-builder/)

**Quick commands**:
```bash
# Create project
> Use nextjs-architect to create a landing page builder with:
  - Next.js 15 with App Router
  - React DnD for drag and drop
  - TipTap for rich text editing
  - Tailwind CSS for styling
  - PostgreSQL for data persistence
  - Image upload to S3
  - Template system
  - Export to HTML

# Generated structure
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

**Block Categories**:
- **Marketing**: Hero, Features, CTA, Pricing, FAQ
- **Social Proof**: Testimonials, Logo Cloud, Stats, Reviews
- **Content**: Text, Image, Gallery, Video, Divider
- **Layout**: Container, Columns, Spacer, Header, Footer
- **Forms**: Contact, Newsletter, Survey, Lead Capture

**Technical features**:
- @dnd-kit for drag & drop
- Zustand for state management
- TipTap rich text editor
- Extensible block registry system
- Undo/Redo with history management
- Dynamic property panel
- Responsive breakpoints
- Export to HTML/React components

**Use cases**:
- Marketing agencies
- Freelancers and consultants
- Startups validating ideas
- Product teams (rapid landing pages)
- No-code builders

---

## 🎓 Testimonials (Projected)

> "The examples saved me weeks of setup. In 2 hours I had a functional e-commerce."
> — Developer, Startup

> "The SaaS Dashboard example taught me more about multi-tenancy than 10 tutorials."
> — Senior Dev, Agency

> "I used the API Gateway example as a base for our microservices. Production-ready."
> — Tech Lead, Enterprise

---

**Need help?** Check the [main documentation](../README.md) or the [available agents](../agents/README.md).

**Next examples**: Vote in [GitHub Discussions](https://github.com/tu-usuario/claude-code-advanced-guide/discussions) for which examples you want to see first.
