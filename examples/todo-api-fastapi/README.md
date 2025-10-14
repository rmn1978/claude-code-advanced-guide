# ✅ Todo API - FastAPI

Simple yet complete REST API for task management with authentication, built with FastAPI.

## 📋 Overview

**Descripción**: API REST completa para gestión de tareas (Todo list) con autenticación JWT, perfect for learning FastAPI basics.

**Stack**:
- **Backend**: FastAPI, SQLAlchemy 2.0, PostgreSQL, Pydantic
- **Auth**: JWT tokens with bcrypt password hashing
- **Testing**: Pytest with async support
- **Docs**: Automatic OpenAPI (Swagger)

**Tiempo estimado**: 1-2 horas

**Nivel**: 🟢 Básico (perfecto para principiantes)

---

## ✨ Features

### API Endpoints

**Authentication**:
- `POST /api/v1/auth/register` - Register new user
- `POST /api/v1/auth/login` - Login and get JWT token

**Todos (Protected)**:
- `GET /api/v1/todos` - List all todos (with pagination)
- `GET /api/v1/todos/{id}` - Get single todo
- `POST /api/v1/todos` - Create new todo
- `PUT /api/v1/todos/{id}` - Update todo
- `DELETE /api/v1/todos/{id}` - Delete todo
- `PATCH /api/v1/todos/{id}/complete` - Mark as complete
- `GET /api/v1/todos/stats` - Get user statistics

### Technical Features
- ✅ JWT authentication
- ✅ Password hashing with bcrypt
- ✅ Pydantic validation
- ✅ SQLAlchemy 2.0 async
- ✅ Pagination support
- ✅ Filtering (completed/pending)
- ✅ Automatic API documentation
- ✅ CORS enabled
- ✅ Error handling
- ✅ Database migrations (Alembic)
- ✅ Unit tests with pytest

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────┐
│         Client (Postman/Frontend)        │
└───────────────────┬─────────────────────┘
                    │ HTTP/REST + JWT
                    │
┌───────────────────▼─────────────────────┐
│           FastAPI Application            │
├─────────────────────────────────────────┤
│                                          │
│  ┌──────────────┐  ┌──────────────┐    │
│  │   Auth API   │  │   Todos API  │    │
│  │              │  │              │    │
│  │ • Register   │  │ • CRUD       │    │
│  │ • Login      │  │ • Filter     │    │
│  │ • JWT        │  │ • Stats      │    │
│  └──────────────┘  └──────────────┘    │
│                                          │
│  ┌──────────────────────────────────┐  │
│  │      Repository Pattern          │  │
│  │  • UserRepository                │  │
│  │  • TodoRepository                │  │
│  └──────────────────────────────────┘  │
│                                          │
└───────────────────┬─────────────────────┘
                    │ SQLAlchemy
                    │
            ┌───────▼────────┐
            │   PostgreSQL   │
            │                │
            │  • users       │
            │  • todos       │
            └────────────────┘
```

---

## 🚀 Quick Start

### Prerequisites

```bash
# Required
- Python 3.11+
- PostgreSQL 14+

# Optional
- Docker (for easy PostgreSQL setup)
```

### Setup con Claude Code

**Opción 1: Usar el agente FastAPI (Recomendado)**

```bash
# En Claude Code, en el directorio todo-api-fastapi/
> Use fastapi-architect to create a Todo API with the following features:
  - User registration and login with JWT authentication
  - Todo CRUD operations (create, read, update, delete)
  - Mark todos as complete/incomplete
  - Filter todos by status (completed/pending)
  - Pagination for todo list
  - User statistics (total, completed, pending todos)
  - PostgreSQL database with SQLAlchemy 2.0
  - Pydantic schemas for validation
  - Tests with pytest
  - Alembic migrations

# El agente creará toda la estructura automáticamente
```

**Opción 2: Manual Setup**

```bash
# 1. Create virtual environment
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# 2. Install dependencies
pip install fastapi uvicorn sqlalchemy asyncpg alembic pydantic-settings python-jose passlib bcrypt pytest pytest-asyncio httpx

# 3. Create .env file
cp .env.example .env
# Edit .env with your database credentials

# 4. Run migrations
alembic upgrade head

# 5. Start server
uvicorn app.main:app --reload
```

### Access the API

```bash
# API runs on
http://localhost:8000

# Interactive API documentation (Swagger)
http://localhost:8000/docs

# Alternative documentation (ReDoc)
http://localhost:8000/redoc
```

---

## 📁 Project Structure

```
todo-api-fastapi/
├── app/
│   ├── __init__.py
│   ├── main.py                    # FastAPI app entry point
│   ├── api/
│   │   └── v1/
│   │       ├── __init__.py
│   │       ├── endpoints/
│   │       │   ├── auth.py        # Authentication endpoints
│   │       │   └── todos.py       # Todo CRUD endpoints
│   │       └── router.py          # API router
│   ├── core/
│   │   ├── __init__.py
│   │   ├── config.py              # Pydantic settings
│   │   └── security.py            # JWT & password utilities
│   ├── db/
│   │   ├── __init__.py
│   │   ├── base.py                # SQLAlchemy Base
│   │   ├── session.py             # Database session
│   │   └── repositories/
│   │       ├── __init__.py
│   │       ├── base.py            # Base repository
│   │       ├── user.py            # User repository
│   │       └── todo.py            # Todo repository
│   ├── models/
│   │   ├── __init__.py
│   │   ├── user.py                # User SQLAlchemy model
│   │   └── todo.py                # Todo SQLAlchemy model
│   └── schemas/
│       ├── __init__.py
│       ├── user.py                # User Pydantic schemas
│       ├── todo.py                # Todo Pydantic schemas
│       └── token.py               # JWT token schemas
├── tests/
│   ├── __init__.py
│   ├── conftest.py                # Pytest fixtures
│   ├── test_auth.py               # Auth endpoint tests
│   └── test_todos.py              # Todo endpoint tests
├── alembic/
│   ├── versions/                  # Migration files
│   ├── env.py                     # Alembic environment
│   └── script.py.mako
├── .env.example                   # Environment template
├── .gitignore
├── alembic.ini                    # Alembic config
├── requirements.txt               # Python dependencies
└── README.md
```

---

## 🔧 Configuration

### Environment Variables (.env)

```bash
# Database
DATABASE_URL=postgresql+asyncpg://postgres:password@localhost/todo_db

# JWT
SECRET_KEY=your-secret-key-min-32-characters-long
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=10080  # 7 days

# App
APP_NAME=Todo API
DEBUG=True
```

### Generate Secret Key

```bash
# Generate a secure secret key
python -c "import secrets; print(secrets.token_urlsafe(32))"
```

---

## 📝 API Usage Examples

### 1. Register User

```bash
curl -X POST "http://localhost:8000/api/v1/auth/register" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "password": "securepassword123",
    "full_name": "John Doe"
  }'

# Response:
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "token_type": "bearer",
  "user": {
    "id": 1,
    "email": "user@example.com",
    "full_name": "John Doe"
  }
}
```

### 2. Login

```bash
curl -X POST "http://localhost:8000/api/v1/auth/login" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=user@example.com&password=securepassword123"

# Response:
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "token_type": "bearer"
}
```

### 3. Create Todo

```bash
curl -X POST "http://localhost:8000/api/v1/todos" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Learn FastAPI",
    "description": "Complete the FastAPI tutorial"
  }'

# Response:
{
  "id": 1,
  "title": "Learn FastAPI",
  "description": "Complete the FastAPI tutorial",
  "completed": false,
  "created_at": "2025-01-15T10:30:00Z",
  "user_id": 1
}
```

### 4. List Todos

```bash
# Get all todos
curl -X GET "http://localhost:8000/api/v1/todos" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"

# Filter completed todos
curl -X GET "http://localhost:8000/api/v1/todos?completed=true" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"

# Pagination
curl -X GET "http://localhost:8000/api/v1/todos?skip=0&limit=10" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"

# Response:
{
  "items": [
    {
      "id": 1,
      "title": "Learn FastAPI",
      "description": "Complete the FastAPI tutorial",
      "completed": false,
      "created_at": "2025-01-15T10:30:00Z"
    }
  ],
  "total": 1,
  "page": 1,
  "size": 10,
  "pages": 1
}
```

### 5. Update Todo

```bash
curl -X PUT "http://localhost:8000/api/v1/todos/1" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Learn FastAPI Advanced",
    "completed": true
  }'
```

### 6. Mark as Complete

```bash
curl -X PATCH "http://localhost:8000/api/v1/todos/1/complete" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

### 7. Get Statistics

```bash
curl -X GET "http://localhost:8000/api/v1/todos/stats" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"

# Response:
{
  "total": 10,
  "completed": 7,
  "pending": 3,
  "completion_rate": 70.0
}
```

### 8. Delete Todo

```bash
curl -X DELETE "http://localhost:8000/api/v1/todos/1" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

---

## 🧪 Testing

### Run Tests

```bash
# Run all tests
pytest

# Run with coverage
pytest --cov=app tests/

# Run specific test file
pytest tests/test_todos.py

# Run with verbose output
pytest -v
```

### Test Example

```python
# tests/test_todos.py
import pytest
from httpx import AsyncClient

@pytest.mark.asyncio
async def test_create_todo(client: AsyncClient, auth_headers):
    """Test creating a new todo"""
    response = await client.post(
        "/api/v1/todos",
        json={
            "title": "Test Todo",
            "description": "Test Description"
        },
        headers=auth_headers
    )

    assert response.status_code == 201
    data = response.json()
    assert data["title"] == "Test Todo"
    assert data["completed"] is False

@pytest.mark.asyncio
async def test_list_todos(client: AsyncClient, auth_headers):
    """Test listing todos"""
    response = await client.get(
        "/api/v1/todos",
        headers=auth_headers
    )

    assert response.status_code == 200
    data = response.json()
    assert "items" in data
    assert "total" in data
```

---

## 🎓 Learning Objectives

Al completar este ejemplo, aprenderás:

### FastAPI Basics
- ✅ Crear una aplicación FastAPI
- ✅ Definir endpoints con decoradores
- ✅ Request/response con Pydantic
- ✅ Dependency injection
- ✅ Automatic API documentation

### Database
- ✅ SQLAlchemy 2.0 async
- ✅ Database models
- ✅ Async sessions
- ✅ Repository pattern
- ✅ Alembic migrations

### Authentication
- ✅ JWT tokens
- ✅ Password hashing
- ✅ Protected endpoints
- ✅ OAuth2 password flow

### Best Practices
- ✅ Project structure
- ✅ Environment variables
- ✅ Error handling
- ✅ Testing async code
- ✅ Type hints

---

## 🔒 Security Features

### Password Security
```python
# Passwords are hashed with bcrypt
from passlib.context import CryptContext

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# Hash on registration
hashed = pwd_context.hash(plain_password)

# Verify on login
is_valid = pwd_context.verify(plain_password, hashed)
```

### JWT Tokens
```python
# Token includes user ID and expiration
from jose import jwt

payload = {
    "sub": str(user.id),
    "exp": datetime.utcnow() + timedelta(minutes=10080)
}

token = jwt.encode(payload, SECRET_KEY, algorithm=ALGORITHM)
```

### Protected Endpoints
```python
# Require authentication
from app.api.deps import get_current_user

@router.get("/todos")
async def get_todos(
    current_user: User = Depends(get_current_user)
):
    # Only accessible with valid JWT
    pass
```

---

## 🚢 Deployment

### Docker Setup

```dockerfile
# Dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
```

```yaml
# docker-compose.yml
version: '3.8'

services:
  db:
    image: postgres:14
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: password
      POSTGRES_DB: todo_db
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"

  api:
    build: .
    ports:
      - "8000:8000"
    environment:
      DATABASE_URL: postgresql+asyncpg://postgres:password@db/todo_db
    depends_on:
      - db

volumes:
  postgres_data:
```

### Deploy to Railway/Render

```bash
# 1. Create account on Railway or Render
# 2. Connect GitHub repository
# 3. Set environment variables
# 4. Deploy (automatic detection)
```

---

## 💡 Next Steps

Después de completar este ejemplo básico, puedes:

### Add More Features
1. **Categories**: Add todo categories/tags
2. **Due Dates**: Add deadlines for todos
3. **Priority**: Add priority levels (high/medium/low)
4. **Sharing**: Share todos with other users
5. **Search**: Full-text search in todos
6. **Attachments**: Upload files to todos

### Improve Architecture
1. **Caching**: Add Redis for caching
2. **Background Jobs**: Use Celery for async tasks
3. **Notifications**: Email/SMS notifications
4. **Webhooks**: Notify external services
5. **Rate Limiting**: Prevent API abuse

### Add Frontend
1. **React Frontend**: Connect with Next.js
2. **Vue Frontend**: Connect with Nuxt
3. **Mobile App**: React Native or Flutter

---

## 🐛 Common Issues

### Issue: Database connection fails

```bash
# Check PostgreSQL is running
docker ps

# Check connection string
echo $DATABASE_URL
```

### Issue: JWT token expired

```bash
# Tokens expire after 7 days by default
# Login again to get new token
```

### Issue: Alembic migration fails

```bash
# Reset database
alembic downgrade base
alembic upgrade head

# Or create new migration
alembic revision --autogenerate -m "description"
```

---

## 🔗 Resources

- **FastAPI Architect Agent**: [`../../agents/stacks/python-fastapi/fastapi-architect.md`](../../agents/stacks/python-fastapi/fastapi-architect.md)
- **FastAPI Documentation**: https://fastapi.tiangolo.com
- **SQLAlchemy 2.0**: https://docs.sqlalchemy.org/en/20/
- **Pydantic**: https://docs.pydantic.dev

---

## 📊 Complexity Comparison

| Feature | This Example | E-commerce | SaaS Dashboard |
|---------|--------------|------------|----------------|
| **Time** | 1-2 hours | 4-5 hours | 5-6 hours |
| **Endpoints** | 8 | 20+ | 30+ |
| **Models** | 2 | 5-7 | 10+ |
| **Auth** | JWT Basic | JWT + OAuth | Multi-tenant |
| **Database** | PostgreSQL | PostgreSQL + Redis | PostgreSQL + Redis |
| **Payments** | No | Stripe | Stripe + Subscriptions |
| **Frontend** | No | Next.js | Nuxt |

---

**¿Listo para empezar?** Usa el agente `fastapi-architect` para crear este proyecto en 1-2 horas.

**¿Tienes preguntas?** Consulta la [documentación del agente](../../agents/stacks/python-fastapi/fastapi-architect.md) o la [guía de FastAPI](https://fastapi.tiangolo.com).

**Próximo paso recomendado**: Después de dominar este ejemplo, intenta el [E-commerce example](../ecommerce-nextjs-fastapi/) para aprender full-stack development.
