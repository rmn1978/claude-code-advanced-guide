# 📝 Cheat Sheet - Claude Code

Quick reference for most commonly used commands, prompts, and patterns.

**💾 Download PDF**: [Coming soon]

---

## ⌨️ Slash Commands

```
┌──────────────────────────────────────────────┐
│ COMMAND        │ WHAT IT DOES                │
├──────────────────────────────────────────────┤
│ /help          │ Shows help                  │
│ /plan          │ Activates plan mode         │
│ /clear         │ Clears conversation         │
│ /model         │ Changes model               │
└──────────────────────────────────────────────┘
```

---

## 💬 Basic Prompts

### Create Apps

```
✅ Create a [type] app with [features]

Examples:
> Create a todo app with React that allows CRUD operations
> Create a blog with Next.js using SSG
> Create a REST API with FastAPI for user management
```

### Fix Errors

```
✅ Fix this error: [paste complete error]

Better yet:
> I'm getting this error in src/api/users.py line 45:
> [paste error]
> Fix it
```

### Add Features

```
✅ Add [feature] to this [file/component]

Examples:
> Add authentication to this API
> Add dark mode to this React component
> Add pagination to this user list
```

### Refactoring

```
✅ Refactor this code to [goal]

Examples:
> Refactor this code to use async/await
> Refactor this component to use TypeScript
> Refactor this function to be more readable
```

### Explanations

```
✅ Explain what this code does

Better yet:
> Explain what this code does line by line
> Explain the algorithm used in this function
> Explain why this pattern is used
```

---

## 🎯 Advanced Prompts

### Using Agents

```
✅ Use [agent-name] to [task]

Examples:
> Use nextjs-architect to create a landing page with hero section
> Use fastapi-architect to create a REST API with JWT auth
> Use testing-specialist to add comprehensive tests
```

### Plan Mode

```
✅ /plan
✅ [Describe complex project]

Example:
> /plan
> Create a real-time chat app with:
  - Socket.io for real-time messaging
  - PostgreSQL for message persistence
  - Redis for pub/sub
  - User authentication
  - File uploads
```

### Multi-step Tasks

```
✅ Step 1: [task]
✅ Step 2: [task]
✅ Step 3: [task]

Example:
> Step 1: Create a User model with Prisma
> Step 2: Create CRUD endpoints for users
> Step 3: Add JWT authentication
> Step 4: Add tests for all endpoints
```

---

## 🛠️ Development Patterns

### Create a New Project

```bash
# 1. Create folder
mkdir my-project && cd my-project

# 2. Initialize project
> Create a [stack] project with:
  - [framework]
  - [database]
  - [additional tools]

# 3. Verify structure
> Show me the project structure
```

### Add a Feature

```bash
# 1. Read existing code
> Read and understand the current [component/module]

# 2. Plan
> How would you add [feature] to this code?

# 3. Implement
> Implement [feature] following the existing patterns

# 4. Tests
> Add tests for the new feature
```

### Debugging

```bash
# 1. Show complete error
> I'm getting this error:
  [paste error with stack trace]

# 2. Context
> In file: src/api/users.py
> When running: npm run dev

# 3. Ask for solution
> What's causing this and how do I fix it?
```

---

## 🔧 Common Settings

### settings.json

```json
{
  // Model (choose one)
  "claude-code.model": "claude-haiku-3.5",      // Fast and cheap
  "claude-code.model": "claude-sonnet-4.5",     // Balanced (recommended)
  "claude-code.model": "claude-opus-4",         // Most powerful

  // Max tokens
  "claude-code.maxTokens": 8192,                // Default
  "claude-code.maxTokens": 4096,                // If slow

  // Allowed tools
  "claude-code.allowedTools": [
    "Read",
    "Write",
    "Edit",
    "Bash",
    "Glob",
    "Grep"
  ],

  // Timeout (ms)
  "claude-code.timeout": 120000,                // 2 minutes

  // Logging
  "claude-code.logLevel": "info"                // info, debug, error
}
```

---

## 📁 Recommended Project Structure

```
my-project/
├── .claude/
│   ├── CLAUDE.md          # ⭐ Project memory (IMPORTANT)
│   ├── agents/            # Custom agents
│   └── mcp.json          # MCP servers config
│
├── .gitignore            # Git ignore (include .env)
├── .claudeignore         # Claude ignore
├── .env                  # Environment variables
├── README.md
│
├── src/                  # Source code
├── tests/                # Tests
├── docs/                 # Documentation
└── scripts/              # Useful scripts
```

---

## 🚫 .claudeignore

Files/folders Claude should ignore:

```
# Dependencies
node_modules/
venv/
env/

# Build outputs
dist/
build/
.next/
out/

# Logs
*.log
logs/

# Cache
.cache/
.turbo/

# OS
.DS_Store
Thumbs.db

# IDE
.vscode/
.idea/

# Test coverage
coverage/
.nyc_output/
```

---

## 📄 CLAUDE.md Template

```markdown
# [Project Name]

## Description
[What this project does]

## Technology Stack
- Frontend: [e.g., Next.js 15, React 18]
- Backend: [e.g., FastAPI, Python 3.11]
- Database: [e.g., PostgreSQL 15]
- Deployment: [e.g., Vercel + Railway]

## Project Structure
\`\`\`
src/
├── components/
├── pages/
└── lib/
\`\`\`

## Important Commands
\`\`\`bash
npm run dev      # Development
npm test         # Tests
npm run build    # Production build
\`\`\`

## Architecture Decisions
- Why we chose X over Y
- Important patterns
- Things NOT to change

## Known Issues
- [List of known issues]

## TODOs
- [ ] Implement feature X
- [ ] Fix bug Y
```

---

## 🎨 Popular Stacks

### Next.js Full-Stack

```
> Use nextjs-architect to create a full-stack app with:
  - Next.js 15 App Router
  - Server Components
  - Server Actions for mutations
  - Prisma + PostgreSQL
  - Tailwind CSS
  - TypeScript
```

### FastAPI Backend

```
> Use fastapi-architect to create a REST API with:
  - FastAPI + Python 3.11
  - PostgreSQL with SQLAlchemy
  - JWT authentication
  - Pydantic validation
  - OpenAPI docs
  - Docker setup
```

### MERN Stack

```
> Create a MERN stack app with:
  - React 18 + Vite
  - Express.js + TypeScript
  - MongoDB + Mongoose
  - JWT auth
  - RESTful API
```

---

## 🧪 Testing Patterns

### Request Tests

```
✅ Add tests for this [component/function/API]

Better:
> Use testing-specialist to add:
  - Unit tests with Jest
  - Integration tests for the API
  - E2E tests with Playwright
  - Coverage threshold of 80%
```

### Test-Driven Development

```
> Step 1: Write failing tests for [feature]
> Step 2: Implement [feature] to pass tests
> Step 3: Refactor while keeping tests green
```

---

## 🚀 Deployment Quick Commands

### Vercel (Frontend)

```bash
# Install Vercel CLI
npm i -g vercel

# Deploy
> Add Vercel deployment config
> Create vercel.json with optimal settings

vercel --prod
```

### Railway (Backend)

```bash
# Install Railway CLI
npm i -g @railway/cli

# Deploy
> Add Railway deployment config
> Create Procfile and railway.json

railway up
```

### Docker

```
> Create a Dockerfile for this app
> Create docker-compose.yml with all services
> Add .dockerignore
```

---

## 💾 Git Quick Commands

```bash
# View changes
git status
git diff

# Stage and commit
git add .
git commit -m "feat: add user authentication"

# Push
git push origin main

# Create branch
git checkout -b feature/new-feature

# Merge
git checkout main
git merge feature/new-feature
```

---

## 🔐 Security Checklist

```
✅ Don't hardcode secrets (use .env)
✅ Add .env to .gitignore
✅ Validate inputs (use Zod/Pydantic)
✅ Sanitize user data
✅ Use HTTPS in production
✅ Implement rate limiting
✅ Use JWT with expiration
✅ Hash passwords (bcrypt, argon2)
✅ Configure CORS correctly
✅ Add security headers (Helmet)

Ask Claude:
> Use security-specialist to audit this code
```

---

## ⚡ Performance Checklist

```
✅ Lazy load components
✅ Code splitting
✅ Image optimization
✅ Caching (Redis)
✅ Database indexes
✅ Query optimization
✅ CDN for static assets
✅ Compression (gzip/brotli)
✅ Minimize bundle size

Ask Claude:
> Use performance-specialist to optimize this code
```

---

## 🎯 Common Errors and Solutions

| Error | Quick Solution |
|-------|----------------|
| API key not found | `export ANTHROPIC_API_KEY="sk-ant-xxx"` → Restart VS Code |
| Permission denied | `chmod +x script.sh` |
| Module not found | `npm install` or `pip install -r requirements.txt` |
| Port already in use | `lsof -ti:3000 \| xargs kill -9` |
| CORS error | Configure CORS in backend |

---

## 📊 Claude Models

| Model | Speed | Cost | Recommended Use |
|--------|-----------|-------|-----------------|
| Haiku 3.5 | ⚡⚡⚡ | $ | Simple tasks, rapid iteration |
| Sonnet 4.5 | ⚡⚡ | $$ | Balanced (recommended) |
| Opus 4 | ⚡ | $$$ | Complex tasks, best quality |

---

## 🎓 Quick Resources

| I Need | Go to |
|----------|------|
| Install Claude Code | [Installation Guide](./docs/01-installation.md) |
| Step-by-step tutorial | [15-min Tutorial](./TUTORIAL-15MIN.md) |
| Terms I don't understand | [Glossary](./GLOSSARY.md) |
| Frequently asked questions | [FAQ](./FAQ-BEGINNERS.md) |
| Project examples | [Examples](./examples/README.md) |
| Troubleshoot problems | [Troubleshooting](./docs/07-troubleshooting.md) |

---

## 💡 Pro Tips

### 1. Be Specific
```
❌ "Create an app"
✅ "Create a todo app with React, TypeScript, and localStorage"
```

### 2. Iterate in Small Steps
```
✅ Step 1: Create basic structure
✅ Step 2: Add styling
✅ Step 3: Add functionality
✅ Step 4: Add tests
```

### 3. Use Specialized Agents
```
✅ Use nextjs-architect for Next.js
✅ Use fastapi-architect for Python APIs
✅ Use testing-specialist for tests
```

### 4. Ask for Explanations
```
✅ "Explain what this code does"
✅ "Why did you choose this approach?"
✅ "What are the trade-offs here?"
```

### 5. Always Review the Code
```
⚠️ Claude is good but not perfect
✅ Read the generated code
✅ Understand what it does
✅ Run tests
```

---

## 🚀 Productive Workflow

```
1. 📝 Plan (5 min)
   > /plan
   > [Describe the project]

2. 🏗️ Build (30-60 min)
   > Implement following the plan
   > Iterate in small steps

3. 🧪 Test (10-15 min)
   > Add tests
   > Run tests
   > Fix issues

4. 🎨 Refine (10-20 min)
   > Improve styling
   > Optimize performance
   > Add error handling

5. 🚀 Deploy (5-10 min)
   > Add deployment config
   > Deploy to Vercel/Railway
   > Test in production
```

---

## 📞 Get Help

```
1. Review this cheat sheet
2. Read FAQ: ./FAQ-BEGINNERS.md
3. Review Troubleshooting: ./docs/07-troubleshooting.md
4. Search Issues: github.com/rmn1978/claude-code-advanced-guide/issues
5. Open new issue if you don't find a solution
```

---

**💾 Save this cheat sheet as a bookmark** - You'll use it often.

[← Back to README](./README.md)
