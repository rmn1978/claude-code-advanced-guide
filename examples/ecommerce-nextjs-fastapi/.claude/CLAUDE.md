# E-commerce Platform - Project Memory

## 🎯 Project Overview

**Type**: Full-stack E-commerce Application
**Stack**: Next.js 15 + FastAPI + PostgreSQL + Redis + Stripe
**Purpose**: Production-ready e-commerce platform with shopping cart and payments

## 🏗️ Architecture Decisions

### Frontend: Next.js 15 App Router

**Why Next.js 15?**
- Server-side rendering for SEO
- React Server Components for performance
- Built-in image optimization
- File-based routing
- Easy Vercel deployment

**Key Patterns**:
```typescript
// Product listing: SSR for SEO
// app/(customer)/products/page.tsx
export default async function ProductsPage() {
  const products = await getProducts() // Server component
  return <ProductGrid products={products} />
}

// Shopping cart: Client component for interactivity
// components/cart/CartButton.tsx
'use client'
export function CartButton() {
  const { items } = useCartStore()
  // Client-side state
}
```

### Backend: FastAPI

**Why FastAPI?**
- Async performance for high concurrency
- Automatic OpenAPI documentation
- Pydantic validation
- Type safety with Python 3.11+
- Easy Stripe integration

**Key Patterns**:
```python
# Repository pattern for data access
# app/db/repositories/product.py
class ProductRepository(BaseRepository):
    async def get_with_stock(self, db: AsyncSession, id: int):
        # Optimized query with stock check
        pass

# Service layer for business logic
# app/services/stripe_service.py
class StripeService:
    async def create_payment_intent(self, amount: int):
        # Stripe integration
        pass
```

### Database: PostgreSQL + Redis

**PostgreSQL** for persistent data:
- Products, Users, Orders
- Relational integrity
- ACID transactions

**Redis** for caching:
- Product catalog cache (5 min TTL)
- User sessions
- Shopping cart temporary storage

---

## 📋 Database Schema

### Core Tables

```sql
-- Users
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    hashed_password VARCHAR(255) NOT NULL,
    full_name VARCHAR(255),
    is_active BOOLEAN DEFAULT true,
    is_admin BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Products
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    slug VARCHAR(250) UNIQUE NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock INTEGER DEFAULT 0,
    category VARCHAR(100),
    image_url VARCHAR(500),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Orders
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    status VARCHAR(50) DEFAULT 'pending',
    total DECIMAL(10, 2) NOT NULL,
    stripe_payment_intent_id VARCHAR(255),
    created_at TIMESTAMP DEFAULT NOW()
);

-- Order Items
CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(id),
    product_id INTEGER REFERENCES products(id),
    quantity INTEGER NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- Cart (temporary storage, also cached in Redis)
CREATE TABLE cart_items (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    product_id INTEGER REFERENCES products(id),
    quantity INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(user_id, product_id)
);
```

### Indexes

```sql
CREATE INDEX idx_products_category ON products(category);
CREATE INDEX idx_products_slug ON products(slug);
CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
```

---

## 🔐 Authentication Flow

```
User Registration:
1. POST /api/v1/auth/register { email, password, full_name }
2. Backend hashes password (bcrypt)
3. Creates user in database
4. Returns JWT token

User Login:
1. POST /api/v1/auth/login { email, password }
2. Backend verifies password
3. Generates JWT token (7-day expiry)
4. Frontend stores in httpOnly cookie

Protected Routes:
1. Frontend sends JWT in Authorization header
2. Backend validates token
3. Extracts user_id from payload
4. Attaches user to request context
```

**JWT Payload**:
```json
{
  "sub": "user_id",
  "email": "user@example.com",
  "exp": 1234567890
}
```

---

## 💳 Stripe Payment Flow

```
Checkout Process:
1. User adds items to cart
2. Clicks "Checkout"
3. Frontend calls POST /api/v1/payments/create-intent
   - Backend creates Stripe PaymentIntent
   - Returns client_secret
4. Frontend shows Stripe Elements form
5. User enters card details
6. Stripe confirms payment
7. Stripe sends webhook to /api/v1/webhook/stripe
8. Backend creates Order in database
9. Backend sends confirmation email
10. Frontend redirects to /orders/[id]
```

**Stripe Webhook Events**:
- `payment_intent.succeeded` → Create order
- `payment_intent.payment_failed` → Send failure email
- `charge.refunded` → Update order status

---

## 🛍️ Shopping Cart State Management

### Frontend: Zustand Store

```typescript
// stores/cart-store.ts
interface CartStore {
  items: CartItem[]
  addItem: (product: Product) => void
  removeItem: (productId: string) => void
  updateQuantity: (productId: string, quantity: number) => void
  clearCart: () => void
}

// Persisted to localStorage
// Synced with backend on login
```

### Backend: Dual Storage

**Redis** (fast, temporary):
```python
# 1-hour TTL
cart_key = f"cart:{user_id}"
redis.setex(cart_key, 3600, json.dumps(cart_items))
```

**PostgreSQL** (persistent):
```python
# Backup storage, synced on checkout
await db.execute(
    insert(CartItem).values(user_id=user_id, items=cart_items)
)
```

---

## 🎨 UI/UX Conventions

### Color Scheme
```css
--primary: #3b82f6       /* Blue for CTAs */
--secondary: #8b5cf6     /* Purple for accents */
--success: #10b981       /* Green for success */
--error: #ef4444         /* Red for errors */
--warning: #f59e0b       /* Orange for warnings */
```

### Components Library
- **shadcn/ui**: Button, Card, Dialog, Form, Input
- **Tailwind CSS**: Utility-first styling
- **Lucide Icons**: Consistent iconography

### Loading States
```typescript
// Skeleton loaders for SSR
<ProductCardSkeleton />

// Spinners for async actions
<Button loading={isPending}>Add to Cart</Button>

// Optimistic updates
const { mutate } = useMutation({
  onMutate: async (newItem) => {
    // Update UI immediately
    queryClient.setQueryData(['cart'], old => [...old, newItem])
  }
})
```

---

## 🚀 Performance Optimizations

### Frontend

1. **ISR for Product Pages**:
```typescript
// Revalidate every 5 minutes
export const revalidate = 300

export async function generateStaticParams() {
  const products = await getProducts()
  return products.map((p) => ({ id: p.id }))
}
```

2. **Image Optimization**:
```typescript
<Image
  src={product.image_url}
  alt={product.name}
  width={400}
  height={400}
  loading="lazy"
  placeholder="blur"
/>
```

3. **Code Splitting**:
```typescript
// Lazy load admin panel
const AdminPanel = dynamic(() => import('./AdminPanel'), {
  ssr: false,
  loading: () => <Spinner />
})
```

### Backend

1. **Database Query Optimization**:
```python
# Use select_related to avoid N+1
products = await db.execute(
    select(Product)
    .options(selectinload(Product.category))
    .limit(20)
)
```

2. **Redis Caching**:
```python
# Cache product catalog
@cache(ttl=300)  # 5 minutes
async def get_products():
    return await product_repo.get_all()
```

3. **Connection Pooling**:
```python
# SQLAlchemy engine config
engine = create_async_engine(
    DATABASE_URL,
    pool_size=10,
    max_overflow=20,
    pool_pre_ping=True
)
```

---

## 🧪 Testing Strategy

### Backend Tests

```python
# tests/api/test_products.py
@pytest.mark.asyncio
async def test_get_products(client: AsyncClient):
    response = await client.get("/api/v1/products")
    assert response.status_code == 200
    assert len(response.json()["items"]) > 0

@pytest.mark.asyncio
async def test_create_product_requires_auth(client: AsyncClient):
    response = await client.post("/api/v1/products", json={...})
    assert response.status_code == 401
```

### Frontend Tests (if implemented)

```typescript
// __tests__/components/ProductCard.test.tsx
describe('ProductCard', () => {
  it('renders product information', () => {
    render(<ProductCard product={mockProduct} />)
    expect(screen.getByText(mockProduct.name)).toBeInTheDocument()
  })

  it('adds product to cart on click', async () => {
    render(<ProductCard product={mockProduct} />)
    await userEvent.click(screen.getByText('Add to Cart'))
    expect(mockAddToCart).toHaveBeenCalledWith(mockProduct)
  })
})
```

---

## 🔒 Security Considerations

### Backend

1. **Password Hashing**: bcrypt with 10 rounds
2. **JWT Tokens**: HS256, 7-day expiry
3. **CORS**: Whitelist frontend URL only
4. **Rate Limiting**: 100 requests per 15 min per IP
5. **Input Validation**: Pydantic schemas for all inputs
6. **SQL Injection**: SQLAlchemy ORM (parameterized queries)

### Frontend

1. **XSS Protection**: React escapes by default
2. **CSRF**: SameSite cookies
3. **Secure Cookies**: httpOnly, secure (in production)
4. **Environment Variables**: Never expose API keys to client

---

## 📦 Deployment Checklist

### Backend (Railway/Render)

- [ ] Set environment variables
- [ ] Run database migrations
- [ ] Configure Redis instance
- [ ] Set up Stripe webhook endpoint
- [ ] Enable HTTPS
- [ ] Configure CORS for production domain
- [ ] Set up monitoring (Sentry)
- [ ] Configure backup strategy

### Frontend (Vercel)

- [ ] Set environment variables (NEXT_PUBLIC_*)
- [ ] Configure custom domain
- [ ] Enable Edge caching
- [ ] Set up analytics
- [ ] Configure image optimization domains
- [ ] Add robots.txt and sitemap.xml
- [ ] Test SSR in production

---

## 🎯 Agents to Use

### Primary Agents

1. **fastapi-architect**: For all backend development
   - API endpoints
   - Database models
   - Pydantic schemas
   - Stripe integration

2. **nextjs-architect**: For all frontend development
   - Page components
   - Client components
   - API client
   - State management

### Supporting Agents

3. **code-reviewer**: Before deploying
4. **security-auditor**: After major features
5. **test-generator**: For test coverage

---

## 📝 Common Tasks

### Add a New Product Field

```bash
# 1. Backend: Add field to model
> Use fastapi-architect to add a 'brand' field to the Product model

# 2. Create migration
alembic revision --autogenerate -m "add brand to products"
alembic upgrade head

# 3. Update schemas
> Update ProductCreate and Product schemas to include brand

# 4. Frontend: Update types
> Add brand field to Product type and update ProductCard component
```

### Add Product Reviews

```bash
# 1. Backend
> Use fastapi-architect to add a product reviews feature with:
  - Review model (user_id, product_id, rating, comment)
  - Reviews API endpoints
  - Average rating calculation

# 2. Frontend
> Use nextjs-architect to add reviews to product detail page with:
  - Review form
  - Reviews list
  - Star rating display
```

---

## 🐛 Known Issues & Workarounds

### Issue: Stripe webhook fails in development

**Workaround**: Use Stripe CLI
```bash
stripe listen --forward-to localhost:8000/api/v1/webhook/stripe
```

### Issue: Next.js Image optimization fails for external URLs

**Workaround**: Add domains to next.config.js
```javascript
images: {
  domains: ['your-api-domain.com', 's3.amazonaws.com'],
}
```

---

## 📚 Code Style Guide

### Backend (Python)

```python
# Follow PEP 8
# Use type hints
# Async/await for all I/O operations
# Repository pattern for data access
# Service layer for business logic

# Good
async def get_product(db: AsyncSession, product_id: int) -> Product | None:
    return await product_repo.get(db, id=product_id)

# Bad
def get_product(db, id):
    return db.query(Product).filter(Product.id == id).first()
```

### Frontend (TypeScript)

```typescript
// Use TypeScript strict mode
// Prefer Server Components
// Client components only when needed
// Extract reusable components
// Use Tailwind utilities

// Good
export default async function ProductsPage() {
  const products = await getProducts() // Server component
  return <ProductGrid products={products} />
}

// Bad (unnecessary client component)
'use client'
export default function ProductsPage() {
  const [products, setProducts] = useState([])
  useEffect(() => { /* fetch */ }, [])
  return <ProductGrid products={products} />
}
```

---

**Last Updated**: 2025-01-15
**Version**: 1.0
**Maintained By**: Claude Code Agents (fastapi-architect + nextjs-architect)
