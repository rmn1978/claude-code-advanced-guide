# 📖 Glossary of Terms - Claude Code

Simple definitions of all the terms you'll find in this guide.

---

## A

### Agent
**What it is**: A "specialized worker" that knows how to do specific tasks very well.

**Example**: The `nextjs-architect` agent knows how to create Next.js applications. The `fastapi-architect` agent knows how to create APIs with FastAPI.

**Analogy**: Like having a team of experts. Instead of a general developer, you have an expert in React, another in Python, another in databases, etc.

**How to use it**:
```
> Use nextjs-architect to create a blog with SSG
```

### API (Application Programming Interface)
**What it is**: An "intermediary" that allows two programs to communicate.

**Simple example**: When you use a weather app, the app uses an API to request data from the weather server.

**In this repo**: Many examples create APIs (FastAPI, Express, Django).

### API Key
**What it is**: Your "password" to use Claude Code. It's like a key that identifies you.

**Where to get it**: https://console.anthropic.com/

**Format**: Starts with `sk-ant-` followed by letters and numbers.

**⚠️ Important**: NEVER share your API key. It's like your bank password.

---

## B

### Backend
**What it is**: The part of the software you DON'T see. It's the "brain" that processes data.

**Example**: When you log in to Facebook:
- Frontend: The form you see
- Backend: The server that verifies your password

**Backend technologies in this repo**: FastAPI, Django, Express

### Bash
**What it is**: The language of the terminal (command line).

**Command example**:
```bash
npm install  # Install dependencies
```

**In Claude Code**: Claude can execute bash commands for you.

---

## C

### CLI (Command Line Interface)
**What it is**: Programs you use by writing commands in the terminal.

**Example**: Instead of clicking buttons, you write:
```bash
git status
npm run dev
```

### CRUD
**What it is**: The 4 basic operations with data:
- **C**reate
- **R**ead
- **U**pdate
- **D**elete

**Example**: In a notes app:
- Create: Create a new note
- Read: View your notes
- Update: Edit a note
- Delete: Delete a note

---

## D

### Database
**What it is**: Where data is stored in an organized way.

**Analogy**: Like a giant, super-organized Excel spreadsheet.

**Types**:
- **PostgreSQL**: Relational database (tables with relationships)
- **Redis**: In-memory database (super fast)
- **MongoDB**: Document database

### Docker
**What it is**: Software that "packages" your application with everything it needs.

**Analogy**: Like a moving box that has EVERYTHING (furniture, clothes, decoration). You can open it in any house and everything works.

**Use**: Ensures your app works the same on your laptop, on the server, anywhere.

---

## E

### Endpoint
**What it is**: An "address" in your API where you can make requests.

**Example**:
```
GET  /api/users      ← Get all users
POST /api/users      ← Create a new user
GET  /api/users/123  ← Get user with ID 123
```

### Environment Variable
**What it is**: A configuration stored outside your code.

**Why**: To NOT put passwords in the code.

**Example**:
```bash
# .env file
DATABASE_URL=postgresql://localhost/mydb
API_KEY=sk-ant-xxxxx
```

---

## F

### FastAPI
**What it is**: Python framework for creating very fast APIs.

**Features**:
- Super fast
- Easy to learn
- Automatic documentation
- Async (can do multiple things at once)

**Example**:
```python
from fastapi import FastAPI
app = FastAPI()

@app.get("/")
def read_root():
    return {"Hello": "World"}
```

### Frontend
**What it is**: The part of the software you DO see. The interface you interact with.

**Example**: The buttons, forms, text you see on a website or app.

**Frontend technologies in this repo**: Next.js, React, Vue, Nuxt

---

## G

### Git
**What it is**: System for saving the history of changes to your code.

**Analogy**: Like ultra-powerful "Control + Z". You can go back to any previous version of your code.

**Basic commands**:
```bash
git status   # See what changed
git add .    # Stage changes
git commit   # Save changes
git push     # Upload to GitHub
```

### GitHub
**What it is**: Website where you can save your code in the cloud (with Git).

**Use**: Share code, collaborate, make backups.

---

## H

### HTTP/HTTPS
**What it is**: The protocol (language) the web uses to communicate.

**Common methods**:
- **GET**: Get data
- **POST**: Send new data
- **PUT**: Update data
- **DELETE**: Delete data

---

## J

### JSON
**What it is**: Format for exchanging data between programs.

**Example**:
```json
{
  "name": "John",
  "age": 30,
  "city": "Madrid"
}
```

**Why it's useful**: It's easy to read for both humans and machines.

### JWT (JSON Web Token)
**What it is**: A "ticket" that proves who you are without having to log in every time.

**Analogy**: Like a VIP pass. You show it and they already know who you are.

**Use**: Authentication in APIs.

---

## M

### MCP (Model Context Protocol)
**What it is**: System that allows Claude Code to connect with external services.

**Example**: With MCP you can connect Claude Code to:
- Your PostgreSQL database
- Your GitHub account
- Stripe (payments)
- Slack

**Benefit**: Claude can do things like "read data from the DB" directly.

### Middleware
**What it is**: Code that runs "in the middle" of a request.

**Example**: Verify you're logged in BEFORE showing you your private messages.

```
Request → Middleware (logged in?) → If YES → Show data
                                  → If NO → Error 401
```

---

## N

### Next.js
**What it is**: React framework for creating modern web applications.

**Features**:
- SSR (Server Side Rendering)
- SSG (Static Site Generation)
- File-based routing
- Super fast

**Use in this repo**: Several examples use Next.js (blog, e-commerce, chat, etc.)

### npm (Node Package Manager)
**What it is**: Tool for installing JavaScript libraries.

**Common commands**:
```bash
npm install          # Install dependencies
npm run dev          # Start development
npm test             # Run tests
```

### Nuxt
**What it is**: Vue framework (similar to Next.js but for Vue).

---

## O

### ORM (Object-Relational Mapping)
**What it is**: Tool that lets you use the database with normal code instead of SQL.

**Without ORM** (direct SQL):
```sql
SELECT * FROM users WHERE id = 1
```

**With ORM** (Prisma):
```javascript
await prisma.user.findUnique({ where: { id: 1 } })
```

**Benefit**: Easier, safer, fewer errors.

---

## P

### Plan Mode
**What it is**: Claude Code mode where it PLANS first before coding.

**How to activate**:
```
> /plan
```

**Benefit**: For complex projects, Claude thinks through the entire architecture before writing code.

**Flow**:
1. You ask for something complex
2. Claude creates a detailed plan
3. You approve the plan
4. Claude executes the plan step by step

### Prisma
**What it is**: Modern ORM for Node.js.

**Use**: Work with databases easily.

**Features**:
- Type-safe (prevents errors)
- Automatic migrations
- Prisma Studio (visual UI)

---

## R

### REST API
**What it is**: Architecture style for creating APIs.

**Principles**:
- Use HTTP methods (GET, POST, PUT, DELETE)
- Clear endpoints (`/users`, `/posts`)
- Stateless (each request is independent)

**Example**:
```
GET    /api/posts     ← Get all posts
POST   /api/posts     ← Create a post
GET    /api/posts/5   ← Get post 5
PUT    /api/posts/5   ← Update post 5
DELETE /api/posts/5   ← Delete post 5
```

### Redis
**What it is**: Super fast database that stores data in RAM memory.

**Use**: Cache, sessions, job queues, pub/sub.

**Why it's fast**: Everything is in RAM (not on disk).

---

## S

### SSG (Static Site Generation)
**What it is**: Generate HTML pages at BUILD time (not on each request).

**Benefit**: Super fast because the pages are already ready.

**Use**: Blogs, documentation, sites that don't change much.

### SSR (Server Side Rendering)
**What it is**: Generate the HTML on the SERVER on each request.

**Benefit**: Dynamic content, better SEO.

**Difference with SSG**:
- SSG: Generates once at build time
- SSR: Generates on each request

### Stack
**What it is**: Set of technologies you use in a project.

**Stack example**:
- Frontend: Next.js + React + Tailwind
- Backend: FastAPI + Python
- Database: PostgreSQL
- Deploy: Vercel + Railway

---

## T

### TypeScript
**What it is**: JavaScript with "types". Helps you prevent errors.

**Without types** (JavaScript):
```javascript
function sum(a, b) {
  return a + b
}
sum("5", 3)  // "53" ← WTF? 🤔
```

**With types** (TypeScript):
```typescript
function sum(a: number, b: number): number {
  return a + b
}
sum("5", 3)  // ❌ ERROR! TypeScript warns you
```

---

## V

### VS Code (Visual Studio Code)
**What it is**: Code editor (where you write code).

**Why this one**: It's where Claude Code integrates.

### Vue
**What it is**: JavaScript framework for creating user interfaces.

**Alternatives**: React, Angular, Svelte

---

## W

### WebSocket
**What it is**: Technology for real-time communication between browser and server.

**Difference with HTTP**:
- HTTP: Request data → Server responds → Connection closes
- WebSocket: Connection always open → Data flows in both directions

**Use**: Real-time chat, notifications, multiplayer games

---

## Claude Code Shortcuts

### Slash Commands

```bash
/help     # Show help
/plan     # Activate plan mode
/clear    # Clear conversation
/model    # Change model
```

### Common Prompts

```
✅ "Create a [type] app with [features]"
✅ "Fix this error: [paste error]"
✅ "Add tests to this code"
✅ "Explain what this code does"
✅ "Refactor this function"
```

---

## 📚 Resources for Continued Learning

### If you're COMPLETELY new to programming:
1. [freeCodeCamp](https://www.freecodecamp.org/) - Free, very good
2. [The Odin Project](https://www.theodinproject.com/) - Free, full-stack
3. [CS50](https://cs50.harvard.edu/) - Harvard course, free

### If you already know programming but are new to web dev:
1. [MDN Web Docs](https://developer.mozilla.org/) - Complete reference
2. [JavaScript.info](https://javascript.info/) - Modern JavaScript
3. [Next.js Learn](https://nextjs.org/learn) - Official Next.js tutorial

### To learn Claude Code:
1. **[15-Minute Tutorial](./TUTORIAL-15MIN.md)** ← Start here
2. **[Installation](./docs/01-installation.md)** - Complete setup
3. **[Examples](./examples/README.md)** - Real projects

---

## 🤔 Still Confused?

**Don't worry**, it's normal. Programming has LOTS of terms.

**Tip**: You don't need to learn them all at once. Go step by step:

1. Start with the [15-Minute Tutorial](./TUTORIAL-15MIN.md)
2. Build your first simple project
3. The terms will become clearer with practice

**Is there a term missing?** [Open an issue](https://github.com/rmn1978/claude-code-advanced-guide/issues) and we'll add it.

---

[← Back to README](./README.md)
