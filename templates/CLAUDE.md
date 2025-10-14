# [Project Name]

> Quick reference for Claude Code on this project's standards, architecture, and conventions.

## 🎯 Project Overview

**Purpose**: [Brief description of what this project does]

**Target Users**: [Who uses this application]

**Key Features**:
- [Feature 1]
- [Feature 2]
- [Feature 3]

## 🏗️ Technology Stack

### Frontend
- **Framework**: [React/Vue/Angular/Svelte]
- **Version**: [18.x]
- **Language**: TypeScript [5.x]
- **Build Tool**: [Vite/Webpack/Next.js]
- **Styling**: [Tailwind/Styled Components/CSS Modules]
- **State Management**: [Redux/Zustand/Jotai/Context]
- **Forms**: [React Hook Form/Formik]
- **Testing**: [Vitest/Jest] + [Testing Library]

### Backend
- **Runtime**: Node.js [20.x LTS]
- **Framework**: [Express/Fastify/NestJS/Hono]
- **Language**: TypeScript [5.x] (strict mode)
- **Database**: [PostgreSQL/MySQL/MongoDB] [version]
- **ORM/ODM**: [Prisma/TypeORM/Mongoose]
- **Authentication**: [JWT/OAuth/Passport]
- **Validation**: [Zod/Joi/Yup]
- **Testing**: [Jest/Vitest]

### Infrastructure
- **Hosting**: [AWS/Vercel/Railway/Render]
- **CI/CD**: [GitHub Actions/CircleCI/Jenkins]
- **Containerization**: [Docker/Podman]
- **Monitoring**: [Sentry/DataDog/New Relic]

### Development Tools
- **Package Manager**: [npm/pnpm/yarn/bun]
- **Linter**: ESLint
- **Formatter**: Prettier
- **Git Hooks**: Husky + lint-staged

## 📁 Project Structure

```
project-root/
├── src/
│   ├── api/                  # API routes/controllers
│   ├── services/             # Business logic
│   ├── models/               # Data models
│   ├── utils/                # Utility functions
│   ├── middleware/           # Express middleware
│   ├── config/               # Configuration
│   └── types/                # TypeScript types
├── tests/
│   ├── unit/                 # Unit tests
│   ├── integration/          # Integration tests
│   └── e2e/                  # End-to-end tests
├── docs/                     # Documentation
├── scripts/                  # Build/deployment scripts
└── prisma/                   # Database schema & migrations
    ├── schema.prisma
    └── migrations/
```

## 🎨 Coding Conventions

### TypeScript

#### Strict Mode
```json
{
  "compilerOptions": {
    "strict": true,
    "noUncheckedIndexedAccess": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true
  }
}
```

#### Type Annotations
```typescript
// ✅ ALWAYS: Explicit function parameter and return types
function calculateTotal(items: Item[]): number {
  return items.reduce((sum, item) => sum + item.price, 0);
}

// ❌ NEVER: Implicit types
function calculateTotal(items) {
  return items.reduce((sum, item) => sum + item.price, 0);
}

// ✅ ALWAYS: Explicit variable types when not obvious
const user: User = await fetchUser(id);

// ✅ OK: Type inference when obvious
const count = 42;  // clearly number
const name = "John";  // clearly string
```

#### Interfaces vs Types

```typescript
// ✅ Use `interface` for object shapes (extensible)
interface User {
  id: string;
  email: string;
  name: string;
}

interface AdminUser extends User {
  permissions: string[];
}

// ✅ Use `type` for unions, intersections, utility types
type Status = 'pending' | 'active' | 'inactive';
type Result<T> = { success: true; data: T } | { success: false; error: string };
type Nullable<T> = T | null;
```

### Naming Conventions

| Item | Convention | Example |
|------|------------|---------|
| Variables | camelCase | `const userId = '123'` |
| Functions | camelCase | `function getUserById() {}` |
| Classes | PascalCase | `class UserService {}` |
| Interfaces | PascalCase | `interface UserData {}` |
| Types | PascalCase | `type UserId = string` |
| Constants | UPPER_SNAKE_CASE | `const MAX_RETRIES = 3` |
| Files | kebab-case | `user-service.ts` |
| Components (React) | PascalCase | `UserProfile.tsx` |
| Enums | PascalCase (members too) | `enum Status { Active, Inactive }` |

### File Organization

```typescript
// ✅ Group imports by category
// 1. External dependencies
import { useState, useEffect } from 'react';
import axios from 'axios';

// 2. Internal dependencies
import { UserService } from '@/services/user-service';
import { formatDate } from '@/utils/date';

// 3. Types
import type { User, UserRole } from '@/types/user';

// 4. Styles (if applicable)
import styles from './component.module.css';
```

### Code Style

```typescript
// ✅ Use const by default, let only when reassignment needed
const user = await getUser();
let count = 0;

// ✅ Prefer early returns over nested if statements
function processUser(user: User | null) {
  if (!user) return null;
  if (!user.isActive) return null;

  // Main logic here
  return user.data;
}

// ❌ Avoid deeply nested code
function processUser(user: User | null) {
  if (user) {
    if (user.isActive) {
      // Main logic here
      return user.data;
    }
  }
  return null;
}

// ✅ Use optional chaining and nullish coalescing
const userName = user?.profile?.name ?? 'Anonymous';

// ✅ Use template literals for string interpolation
const greeting = `Hello, ${user.name}!`;

// ❌ Avoid string concatenation
const greeting = 'Hello, ' + user.name + '!';
```

## 🗄️ Database Schema

### Naming Conventions

```sql
-- Tables: plural, snake_case
users
blog_posts
order_items

-- Columns: snake_case
first_name
created_at
is_active

-- Foreign Keys: {referenced_table}_id
user_id
post_id

-- Indexes: idx_{table}_{columns}
idx_users_email
idx_posts_user_id_created_at

-- Constraints: {table}_{column}_{type}
users_email_unique
posts_title_check
```

### Standard Columns

Every table should include:

```sql
id UUID PRIMARY KEY DEFAULT gen_random_uuid()
created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
deleted_at TIMESTAMP WITH TIME ZONE  -- For soft deletes
```

Or in Prisma:

```prisma
model Example {
  id        String    @id @default(uuid())
  createdAt DateTime  @default(now()) @map("created_at")
  updatedAt DateTime  @updatedAt @map("updated_at")
  deletedAt DateTime? @map("deleted_at")

  @@map("examples")
}
```

## 🌐 API Design

### Endpoint Structure

```
# RESTful conventions
GET    /api/v1/resources           # List (with pagination)
GET    /api/v1/resources/:id       # Get single resource
POST   /api/v1/resources           # Create new resource
PUT    /api/v1/resources/:id       # Full update
PATCH  /api/v1/resources/:id       # Partial update
DELETE /api/v1/resources/:id       # Delete resource

# Nested resources
GET    /api/v1/users/:id/posts     # Get user's posts
POST   /api/v1/users/:id/posts     # Create post for user

# Actions (when RESTful doesn't fit)
POST   /api/v1/users/:id/verify    # Perform action
POST   /api/v1/orders/:id/cancel   # Perform action
```

### Request/Response Format

**Success Response** (200, 201):
```json
{
  "data": {
    "id": "uuid",
    "name": "Resource Name",
    "...": "..."
  },
  "meta": {
    "timestamp": "2024-01-15T10:30:00Z"
  }
}
```

**List Response** (200):
```json
{
  "data": [
    { "id": "1", "name": "Item 1" },
    { "id": "2", "name": "Item 2" }
  ],
  "meta": {
    "page": 1,
    "perPage": 20,
    "total": 100,
    "totalPages": 5
  },
  "links": {
    "self": "/api/v1/resources?page=1",
    "next": "/api/v1/resources?page=2",
    "prev": null,
    "first": "/api/v1/resources?page=1",
    "last": "/api/v1/resources?page=5"
  }
}
```

**Error Response** (4xx, 5xx):
```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Validation failed",
    "details": [
      {
        "field": "email",
        "message": "Invalid email format"
      }
    ]
  },
  "meta": {
    "timestamp": "2024-01-15T10:30:00Z"
  }
}
```

### Standard Error Codes

| Code | HTTP Status | Meaning |
|------|-------------|---------|
| `VALIDATION_ERROR` | 400 | Request validation failed |
| `UNAUTHORIZED` | 401 | Not authenticated |
| `FORBIDDEN` | 403 | Authenticated but not authorized |
| `NOT_FOUND` | 404 | Resource doesn't exist |
| `CONFLICT` | 409 | Resource already exists |
| `RATE_LIMITED` | 429 | Too many requests |
| `INTERNAL_ERROR` | 500 | Server error |
| `SERVICE_UNAVAILABLE` | 503 | Temporary outage |

## 🧪 Testing Standards

### Coverage Requirements

- **Unit Tests**: 80% minimum
- **Integration Tests**: 70% minimum
- **E2E Tests**: Critical user paths

### Test Structure

```typescript
describe('ServiceName', () => {
  // Setup
  let service: ServiceName;

  beforeEach(() => {
    service = new ServiceName();
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  // Group related tests
  describe('methodName()', () => {
    it('should return expected result for valid input', () => {
      // Arrange
      const input = { ... };

      // Act
      const result = service.methodName(input);

      // Assert
      expect(result).toEqual({ ... });
    });

    it('should throw error for invalid input', () => {
      // Arrange
      const invalidInput = null;

      // Act & Assert
      expect(() => service.methodName(invalidInput))
        .toThrow('Expected error message');
    });
  });

  describe('edge cases', () => {
    it('should handle empty array', () => {
      // ...
    });

    it('should handle null values', () => {
      // ...
    });
  });
});
```

### Test Naming

```typescript
// ✅ Format: "should [expected behavior] when/for [condition]"
it('should return user when valid ID provided')
it('should throw NotFoundError when user does not exist')
it('should cache result for subsequent calls')

// ❌ Avoid vague names
it('works')
it('test user')
it('returns correct value')
```

## 🔒 Security

### Environment Variables

```bash
# ✅ Use .env files (never commit!)
DATABASE_URL=postgresql://...
JWT_SECRET=...
API_KEY=...

# ✅ Provide .env.example template
# .env.example
DATABASE_URL=postgresql://user:password@localhost:5432/dbname
JWT_SECRET=your-secret-key-here
API_KEY=your-api-key-here
```

### Authentication

```typescript
// ✅ Hash passwords
const hashedPassword = await bcrypt.hash(password, 10);

// ✅ Use JWT with expiration
const token = jwt.sign(
  { userId: user.id },
  process.env.JWT_SECRET!,
  { expiresIn: '15m' }
);

// ✅ Validate input
const schema = z.object({
  email: z.string().email(),
  password: z.string().min(8)
});
const validated = schema.parse(input);
```

### Common Vulnerabilities to Avoid

```typescript
// ❌ SQL Injection
const query = `SELECT * FROM users WHERE id = '${userId}'`;

// ✅ Parameterized queries (Prisma does this automatically)
const user = await prisma.user.findUnique({ where: { id: userId } });

// ❌ Hardcoded secrets
const API_KEY = "sk_live_123456";

// ✅ Environment variables
const API_KEY = process.env.API_KEY;

// ❌ No input validation
app.post('/user', (req, res) => {
  db.user.create(req.body);
});

// ✅ Always validate
app.post('/user', validate(userSchema), (req, res) => {
  db.user.create(req.body);
});
```

## 🚀 Development Workflow

### Branch Strategy

```
main          # Production
  ↓
develop       # Integration
  ↓
feature/*     # New features
fix/*         # Bug fixes
hotfix/*      # Urgent production fixes
```

### Commit Messages

Use Conventional Commits:

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types**:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Formatting, missing semicolons
- `refactor`: Code restructuring
- `test`: Adding tests
- `chore`: Maintenance, dependencies

**Examples**:
```
feat(auth): add OAuth login support
fix(api): resolve user creation race condition
docs(readme): update installation instructions
test(users): add unit tests for UserService
```

### Pull Request Process

1. Create feature branch from `develop`
2. Implement changes with tests
3. Run test suite: `npm test`
4. Run linter: `npm run lint`
5. Create PR with clear description
6. Request review (minimum 1 reviewer)
7. Address feedback
8. Squash merge to `develop`

## 🛠️ Common Commands

```bash
# Development
npm run dev              # Start dev server
npm run dev:watch        # Watch mode

# Testing
npm test                 # Run all tests
npm run test:watch       # Watch mode
npm run test:coverage    # Coverage report
npm run test:unit        # Unit tests only
npm run test:integration # Integration tests
npm run test:e2e         # E2E tests

# Code Quality
npm run lint             # Run linter
npm run lint:fix         # Auto-fix issues
npm run format           # Prettier formatting
npm run type-check       # TypeScript check

# Database
npm run db:migrate       # Run migrations
npm run db:seed          # Seed database
npm run db:reset         # Reset database (DEV ONLY)
npx prisma studio        # Open Prisma Studio

# Build
npm run build            # Production build
npm run build:check      # Build with type checking
npm run preview          # Preview production build

# Docker
docker-compose up        # Start services
docker-compose down      # Stop services
docker-compose logs -f   # View logs
```

## 📦 Deployment

### Environments

| Environment | Branch | Auto-Deploy | URL |
|-------------|--------|-------------|-----|
| Development | develop | Yes | dev.example.com |
| Staging | main | Yes | staging.example.com |
| Production | main | Manual | example.com |

### Deployment Checklist

- [ ] All tests passing
- [ ] No TypeScript errors
- [ ] Environment variables configured
- [ ] Database migrations ready
- [ ] Backup created (production)
- [ ] Monitoring enabled
- [ ] Rollback plan documented

## 🎯 Performance Targets

- **API Response Time**: < 200ms (p95)
- **Page Load Time**: < 2s (p95)
- **Database Queries**: < 50ms average
- **Test Suite**: < 30s total
- **Build Time**: < 2min

## 🐛 Known Issues

### Issue: [Brief description]
**Impact**: [Who it affects]
**Workaround**: [Temporary solution]
**Tracking**: [Issue #123 or JIRA ticket]

## 📚 Documentation

- **API Docs**: `docs/api/`
- **Architecture**: `docs/architecture.md`
- **Setup Guide**: `README.md`
- **Deployment**: `docs/deployment.md`

## 👥 Team

- **Tech Lead**: @username
- **Backend**: @username1, @username2
- **Frontend**: @username3, @username4
- **DevOps**: @username5

## 🎯 Current Sprint Goals

- [ ] [Goal 1]
- [ ] [Goal 2]
- [ ] [Goal 3]

## 💡 Important Notes for Claude Code

### When to Use Agents

- **code-reviewer**: After significant changes, before PR
- **test-generator**: When creating new features
- **security-auditor**: Before deploying to production
- [Your custom agents here]

### Project-Specific Patterns

[Add any unique patterns or conventions specific to this project]

### Common Gotchas

1. **[Gotcha 1]**: [Explanation and solution]
2. **[Gotcha 2]**: [Explanation and solution]

---

**Last Updated**: [Date]
**Claude Code Version**: [Version if relevant]
