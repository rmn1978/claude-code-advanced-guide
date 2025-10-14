# 🌐 API Gateway - Express + TypeScript

Modern API Gateway with routing, rate limiting, authentication, and circuit breaker pattern.

## 📋 Overview

**Descripción**: API Gateway que coordina múltiples microservicios con rate limiting, JWT auth, request/response logging, y circuit breaker.

**Stack**:
- **Gateway**: Express.js, TypeScript, Redis
- **Features**: Rate limiting, Circuit breaker, JWT validation, Request logging
- **Microservices**: User Service, Product Service, Order Service, Payment Service

**Tiempo estimado**: 3-4 horas

**Nivel**: 🟡 Intermedio

---

## ✨ Features

### Gateway Features
- ✅ Intelligent request routing
- ✅ Rate limiting per client (Redis)
- ✅ JWT token validation
- ✅ Request/response logging
- ✅ Circuit breaker pattern
- ✅ Health checks
- ✅ API key management
- ✅ CORS configuration
- ✅ Request/response transformation
- ✅ Caching layer

### Monitoring
- ✅ Request metrics
- ✅ Error tracking
- ✅ Performance monitoring
- ✅ Service health dashboard

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────┐
│                     Clients                              │
│  (Web, Mobile, Third-party APIs)                        │
└──────────────────────┬──────────────────────────────────┘
                       │
                       │ HTTPS/REST
                       │
┌──────────────────────▼──────────────────────────────────┐
│              API GATEWAY (Express)                       │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  ┌────────────────────────────────────────────────┐   │
│  │          Middleware Stack                       │   │
│  ├────────────────────────────────────────────────┤   │
│  │  1. CORS                                       │   │
│  │  2. Rate Limiting (Redis)                      │   │
│  │  3. JWT Validation                             │   │
│  │  4. Request Logging                            │   │
│  │  5. Circuit Breaker                            │   │
│  └────────────────────────────────────────────────┘   │
│                                                          │
│  ┌────────────────────────────────────────────────┐   │
│  │             Route Handlers                      │   │
│  ├────────────────────────────────────────────────┤   │
│  │  /api/users/*      → User Service              │   │
│  │  /api/products/*   → Product Service           │   │
│  │  /api/orders/*     → Order Service             │   │
│  │  /api/payments/*   → Payment Service           │   │
│  └────────────────────────────────────────────────┘   │
│                                                          │
└──────────────┬───────────────────┬──────────────────────┘
               │                   │
       ┌───────┴────┐      ┌──────▼────────┐
       │   Redis    │      │   Metrics     │
       │ (Cache &   │      │  (Prometheus) │
       │  Limits)   │      └───────────────┘
       └────────────┘
               │
        ┌──────┴──────────────────────┐
        │                             │
   ┌────▼─────┐  ┌──────────┐  ┌─────▼────┐  ┌────────────┐
   │  User    │  │ Product  │  │  Order   │  │  Payment   │
   │ Service  │  │ Service  │  │ Service  │  │  Service   │
   │ :3001    │  │ :3002    │  │ :3003    │  │  :3004     │
   └──────────┘  └──────────┘  └──────────┘  └────────────┘
```

---

## 🚀 Quick Start

### Prerequisites

```bash
# Required
- Node.js 18+
- Redis 7+

# Optional
- Docker (for easy setup)
```

### Setup con Claude Code

```bash
> Use express-architect to create an API Gateway with:
  - Request routing to 4 microservices (users, products, orders, payments)
  - Rate limiting with Redis (100 req/15min per IP)
  - JWT token validation middleware
  - Circuit breaker pattern (opossum)
  - Request/response logging with Winston
  - Health check endpoints for each service
  - CORS configuration
  - Error handling middleware
  - Metrics endpoint (Prometheus format)
  - TypeScript with strict mode

# El agente creará toda la estructura
```

### Manual Setup

```bash
# 1. Install dependencies
npm install express cors helmet compression morgan
npm install redis ioredis express-rate-limit
npm install jsonwebtoken opossum winston
npm install axios http-proxy-middleware
npm install -D typescript @types/node @types/express

# 2. Start Redis
docker run -d -p 6379:6379 redis:7-alpine

# 3. Configure environment
cp .env.example .env

# 4. Start gateway
npm run dev
```

---

## 📁 Project Structure

```
api-gateway-express/
├── src/
│   ├── index.ts                    # Entry point
│   ├── app.ts                      # Express app setup
│   ├── config/
│   │   ├── index.ts                # Configuration
│   │   ├── services.ts             # Microservices URLs
│   │   └── redis.ts                # Redis client
│   ├── middleware/
│   │   ├── auth.ts                 # JWT validation
│   │   ├── rateLimit.ts            # Rate limiting
│   │   ├── circuitBreaker.ts       # Circuit breaker
│   │   ├── logger.ts               # Request logging
│   │   ├── errorHandler.ts         # Error handling
│   │   └── cors.ts                 # CORS config
│   ├── routes/
│   │   ├── index.ts                # Route aggregator
│   │   ├── users.ts                # User service proxy
│   │   ├── products.ts             # Product service proxy
│   │   ├── orders.ts               # Order service proxy
│   │   ├── payments.ts             # Payment service proxy
│   │   └── health.ts               # Health checks
│   ├── services/
│   │   ├── proxy.ts                # Proxy logic
│   │   └── circuitBreaker.ts       # Circuit breaker service
│   ├── utils/
│   │   ├── logger.ts               # Winston logger
│   │   └── metrics.ts              # Prometheus metrics
│   └── types/
│       └── index.ts                # TypeScript types
├── tests/
│   ├── integration/
│   └── unit/
├── docker-compose.yml              # Gateway + Redis + Services
├── .env.example
├── tsconfig.json
├── package.json
└── README.md
```

---

## ⚙️ Configuration

### Environment Variables

```bash
# .env
NODE_ENV=development
PORT=3000

# Redis
REDIS_URL=redis://localhost:6379

# JWT
JWT_SECRET=your-secret-key-here
JWT_ALGORITHM=HS256

# Microservices
USER_SERVICE_URL=http://localhost:3001
PRODUCT_SERVICE_URL=http://localhost:3002
ORDER_SERVICE_URL=http://localhost:3003
PAYMENT_SERVICE_URL=http://localhost:3004

# Rate Limiting
RATE_LIMIT_WINDOW_MS=900000        # 15 minutes
RATE_LIMIT_MAX_REQUESTS=100

# Circuit Breaker
CIRCUIT_BREAKER_TIMEOUT=3000       # 3 seconds
CIRCUIT_BREAKER_ERROR_THRESHOLD=50  # 50%
CIRCUIT_BREAKER_RESET_TIMEOUT=30000 # 30 seconds

# Logging
LOG_LEVEL=info
```

---

## 🔧 Key Implementation

### 1. Rate Limiting Middleware

```typescript
// src/middleware/rateLimit.ts
import rateLimit from 'express-rate-limit'
import RedisStore from 'rate-limit-redis'
import { redis } from '../config/redis'

export const rateLimiter = rateLimit({
  store: new RedisStore({
    client: redis,
    prefix: 'rate_limit:',
  }),
  windowMs: parseInt(process.env.RATE_LIMIT_WINDOW_MS || '900000'),
  max: parseInt(process.env.RATE_LIMIT_MAX_REQUESTS || '100'),
  standardHeaders: true,
  legacyHeaders: false,
  message: {
    error: 'Too many requests, please try again later.',
  },
  keyGenerator: (req) => {
    // Use API key if present, otherwise IP
    return req.headers['x-api-key'] as string || req.ip
  },
})

// Custom rate limit for auth endpoints
export const authRateLimiter = rateLimit({
  store: new RedisStore({
    client: redis,
    prefix: 'auth_limit:',
  }),
  windowMs: 60000, // 1 minute
  max: 5, // 5 requests per minute
  message: {
    error: 'Too many login attempts, please try again later.',
  },
})
```

---

### 2. JWT Validation Middleware

```typescript
// src/middleware/auth.ts
import { Request, Response, NextFunction } from 'express'
import jwt from 'jsonwebtoken'

interface JWTPayload {
  userId: string
  email: string
  role: string
}

declare global {
  namespace Express {
    interface Request {
      user?: JWTPayload
    }
  }
}

export const authenticate = (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const token = req.headers.authorization?.replace('Bearer ', '')

    if (!token) {
      return res.status(401).json({
        error: 'No token provided',
      })
    }

    const payload = jwt.verify(
      token,
      process.env.JWT_SECRET!
    ) as JWTPayload

    req.user = payload
    next()
  } catch (error) {
    return res.status(401).json({
      error: 'Invalid or expired token',
    })
  }
}

// Optional authentication (doesn't fail if no token)
export const optionalAuth = (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const token = req.headers.authorization?.replace('Bearer ', '')

  if (token) {
    try {
      const payload = jwt.verify(
        token,
        process.env.JWT_SECRET!
      ) as JWTPayload
      req.user = payload
    } catch (error) {
      // Continue without user
    }
  }

  next()
}
```

---

### 3. Circuit Breaker Implementation

```typescript
// src/services/circuitBreaker.ts
import CircuitBreaker from 'opossum'
import axios, { AxiosRequestConfig } from 'axios'
import { logger } from '../utils/logger'

interface CircuitBreakerOptions {
  timeout?: number
  errorThresholdPercentage?: number
  resetTimeout?: number
}

export const createCircuitBreaker = (
  serviceName: string,
  serviceUrl: string,
  options: CircuitBreakerOptions = {}
) => {
  const breaker = new CircuitBreaker(
    async (config: AxiosRequestConfig) => {
      const response = await axios({
        ...config,
        baseURL: serviceUrl,
        timeout: options.timeout || 3000,
      })
      return response.data
    },
    {
      timeout: options.timeout || 3000,
      errorThresholdPercentage: options.errorThresholdPercentage || 50,
      resetTimeout: options.resetTimeout || 30000,
    }
  )

  // Event listeners
  breaker.on('open', () => {
    logger.warn(`Circuit breaker OPEN for ${serviceName}`)
  })

  breaker.on('halfOpen', () => {
    logger.info(`Circuit breaker HALF-OPEN for ${serviceName}`)
  })

  breaker.on('close', () => {
    logger.info(`Circuit breaker CLOSED for ${serviceName}`)
  })

  breaker.fallback(() => {
    return {
      error: `${serviceName} is currently unavailable`,
      service: serviceName,
      status: 'circuit_open',
    }
  })

  return breaker
}
```

---

### 4. Request Proxy

```typescript
// src/services/proxy.ts
import { Request, Response } from 'express'
import { createCircuitBreaker } from './circuitBreaker'

const breakers = {
  users: createCircuitBreaker('UserService', process.env.USER_SERVICE_URL!),
  products: createCircuitBreaker('ProductService', process.env.PRODUCT_SERVICE_URL!),
  orders: createCircuitBreaker('OrderService', process.env.ORDER_SERVICE_URL!),
  payments: createCircuitBreaker('PaymentService', process.env.PAYMENT_SERVICE_URL!),
}

export const proxyRequest = async (
  req: Request,
  res: Response,
  service: keyof typeof breakers
) => {
  try {
    const data = await breakers[service].fire({
      method: req.method,
      url: req.path,
      data: req.body,
      params: req.query,
      headers: {
        ...req.headers,
        'x-gateway': 'true',
        'x-user-id': req.user?.userId,
      },
    })

    res.json(data)
  } catch (error: any) {
    if (error.status === 'circuit_open') {
      return res.status(503).json({
        error: 'Service temporarily unavailable',
        service,
      })
    }

    res.status(error.response?.status || 500).json({
      error: error.message || 'Internal server error',
    })
  }
}
```

---

### 5. Health Checks

```typescript
// src/routes/health.ts
import { Router } from 'express'
import axios from 'axios'
import { redis } from '../config/redis'

const router = Router()

const services = {
  users: process.env.USER_SERVICE_URL!,
  products: process.env.PRODUCT_SERVICE_URL!,
  orders: process.env.ORDER_SERVICE_URL!,
  payments: process.env.PAYMENT_SERVICE_URL!,
}

router.get('/health', async (req, res) => {
  const checks = {
    gateway: 'healthy',
    redis: 'unknown',
    services: {} as Record<string, string>,
  }

  // Check Redis
  try {
    await redis.ping()
    checks.redis = 'healthy'
  } catch (error) {
    checks.redis = 'unhealthy'
  }

  // Check each microservice
  await Promise.all(
    Object.entries(services).map(async ([name, url]) => {
      try {
        await axios.get(`${url}/health`, { timeout: 2000 })
        checks.services[name] = 'healthy'
      } catch (error) {
        checks.services[name] = 'unhealthy'
      }
    })
  )

  const isHealthy =
    checks.redis === 'healthy' &&
    Object.values(checks.services).every(s => s === 'healthy')

  res.status(isHealthy ? 200 : 503).json(checks)
})

router.get('/health/live', (req, res) => {
  res.json({ status: 'ok' })
})

router.get('/health/ready', async (req, res) => {
  try {
    await redis.ping()
    res.json({ status: 'ready' })
  } catch (error) {
    res.status(503).json({ status: 'not ready' })
  }
})

export default router
```

---

## 📊 Metrics & Monitoring

### Prometheus Metrics

```typescript
// src/utils/metrics.ts
import { Request, Response, NextFunction } from 'express'
import promClient from 'prom-client'

const register = new promClient.Register()

// Metrics
const httpRequestDuration = new promClient.Histogram({
  name: 'http_request_duration_seconds',
  help: 'Duration of HTTP requests in seconds',
  labelNames: ['method', 'route', 'status_code'],
  registers: [register],
})

const httpRequestTotal = new promClient.Counter({
  name: 'http_requests_total',
  help: 'Total number of HTTP requests',
  labelNames: ['method', 'route', 'status_code'],
  registers: [register],
})

// Middleware
export const metricsMiddleware = (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const start = Date.now()

  res.on('finish', () => {
    const duration = (Date.now() - start) / 1000
    const route = req.route?.path || req.path

    httpRequestDuration.observe(
      {
        method: req.method,
        route,
        status_code: res.statusCode,
      },
      duration
    )

    httpRequestTotal.inc({
      method: req.method,
      route,
      status_code: res.statusCode,
    })
  })

  next()
}

// Endpoint
export const metricsEndpoint = async (req: Request, res: Response) => {
  res.set('Content-Type', register.contentType)
  res.end(await register.metrics())
}
```

---

## 🧪 Testing

### Integration Test Example

```typescript
// tests/integration/gateway.test.ts
import request from 'supertest'
import app from '../../src/app'

describe('API Gateway', () => {
  describe('Rate Limiting', () => {
    it('should allow requests within limit', async () => {
      for (let i = 0; i < 5; i++) {
        const res = await request(app).get('/api/products')
        expect(res.status).toBe(200)
      }
    })

    it('should block requests exceeding limit', async () => {
      // Assuming limit is 100 per 15 minutes
      for (let i = 0; i < 100; i++) {
        await request(app).get('/api/products')
      }

      const res = await request(app).get('/api/products')
      expect(res.status).toBe(429)
    })
  })

  describe('Authentication', () => {
    it('should require JWT for protected routes', async () => {
      const res = await request(app).get('/api/orders')
      expect(res.status).toBe(401)
    })

    it('should allow access with valid JWT', async () => {
      const token = 'valid-jwt-token'
      const res = await request(app)
        .get('/api/orders')
        .set('Authorization', `Bearer ${token}`)
      expect(res.status).not.toBe(401)
    })
  })

  describe('Circuit Breaker', () => {
    it('should return fallback when service is down', async () => {
      // Simulate service down by making many failed requests
      const res = await request(app).get('/api/unavailable-service')
      expect(res.body).toHaveProperty('status', 'circuit_open')
    })
  })
})
```

---

## 🚢 Deployment

### Docker Setup

```yaml
# docker-compose.yml
version: '3.8'

services:
  gateway:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - REDIS_URL=redis://redis:6379
    depends_on:
      - redis
    networks:
      - microservices

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    networks:
      - microservices

  user-service:
    image: user-service:latest
    ports:
      - "3001:3001"
    networks:
      - microservices

  product-service:
    image: product-service:latest
    ports:
      - "3002:3002"
    networks:
      - microservices

  order-service:
    image: order-service:latest
    ports:
      - "3003:3003"
    networks:
      - microservices

  payment-service:
    image: payment-service:latest
    ports:
      - "3004:3004"
    networks:
      - microservices

networks:
  microservices:
    driver: bridge
```

---

## 🎓 Learning Objectives

- ✅ API Gateway patterns
- ✅ Rate limiting strategies
- ✅ Circuit breaker implementation
- ✅ Microservices communication
- ✅ Request proxying
- ✅ Health checks
- ✅ Metrics collection
- ✅ Error handling in distributed systems

---

## 💡 Next Steps

1. Add API versioning
2. Implement request caching
3. Add GraphQL gateway
4. Implement request transformation
5. Add API documentation (Swagger)
6. Implement WebSocket proxying
7. Add service discovery

---

## 🔗 Resources

- **Express Architect**: [`../../agents/stacks/node-express/express-architect.md`](../../agents/stacks/node-express/express-architect.md)
- **Multi-Agent Orchestration**: [`../../docs/guides/02-intermediate/multi-agent-orchestration.md`](../../docs/guides/02-intermediate/multi-agent-orchestration.md)

---

**Tiempo**: 3-4 horas
**Nivel**: Intermedio
**Stack**: Express + TypeScript + Redis

**¿Listo para construir tu API Gateway?** Usa el agente `express-architect` para empezar.
