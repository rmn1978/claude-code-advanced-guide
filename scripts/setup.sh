#!/bin/bash

# Claude Code Advanced Setup Script
# Automatically configures Claude Code for your project

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Emoji support
CHECK="✅"
CROSS="❌"
ROCKET="🚀"
WRENCH="🔧"
BOOK="📚"
ROBOT="🤖"

echo -e "${BLUE}${ROCKET} Claude Code Advanced Setup${NC}"
echo "=================================="
echo ""

# Function to print colored messages
print_success() {
    echo -e "${GREEN}${CHECK} $1${NC}"
}

print_error() {
    echo -e "${RED}${CROSS} $1${NC}"
}

print_info() {
    echo -e "${BLUE}${WRENCH} $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Step 1: Check prerequisites
echo -e "${BLUE}${BOOK} Step 1: Checking Prerequisites${NC}"
echo "-----------------------------------"

# Check Node.js
if command_exists node; then
    NODE_VERSION=$(node --version)
    print_success "Node.js installed: $NODE_VERSION"
else
    print_error "Node.js is not installed"
    echo "Please install Node.js from https://nodejs.org/"
    exit 1
fi

# Check npm
if command_exists npm; then
    NPM_VERSION=$(npm --version)
    print_success "npm installed: $NPM_VERSION"
else
    print_error "npm is not installed"
    exit 1
fi

# Check VS Code
if command_exists code; then
    print_success "VS Code CLI available"
else
    print_warning "VS Code CLI not found (optional)"
fi

echo ""

# Step 2: Check Claude Code CLI
echo -e "${BLUE}${ROBOT} Step 2: Claude Code CLI${NC}"
echo "--------------------------------"

if command_exists claude; then
    CLAUDE_VERSION=$(claude --version 2>/dev/null || echo "unknown")
    print_success "Claude Code CLI installed: $CLAUDE_VERSION"
else
    print_warning "Claude Code CLI not found"
    read -p "Install Claude Code CLI globally? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_info "Installing Claude Code CLI..."
        npm install -g @anthropic-ai/claude-code
        print_success "Claude Code CLI installed"
    else
        print_warning "Skipping Claude Code CLI installation"
    fi
fi

echo ""

# Step 3: VS Code Extension
echo -e "${BLUE}${WRENCH} Step 3: VS Code Extension${NC}"
echo "-----------------------------------"

if command_exists code; then
    if code --list-extensions | grep -q "anthropic.claude-code"; then
        print_success "Claude Code extension installed"
    else
        read -p "Install Claude Code VS Code extension? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            print_info "Installing extension..."
            code --install-extension anthropic.claude-code
            print_success "Extension installed"
        fi
    fi
else
    print_warning "VS Code CLI not available, skipping extension check"
fi

echo ""

# Step 4: Authentication
echo -e "${BLUE}🔑 Step 4: Authentication${NC}"
echo "----------------------------"

if [ -z "$ANTHROPIC_API_KEY" ]; then
    print_warning "ANTHROPIC_API_KEY not set"
    echo ""
    echo "You have two options:"
    echo "1. Use API Key (recommended for development)"
    echo "2. Use Claude Pro/Max subscription"
    echo ""
    read -p "Do you want to set up API Key now? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        read -p "Enter your Anthropic API Key: " api_key
        export ANTHROPIC_API_KEY="$api_key"

        # Add to shell profile
        SHELL_PROFILE=""
        if [ -f "$HOME/.zshrc" ]; then
            SHELL_PROFILE="$HOME/.zshrc"
        elif [ -f "$HOME/.bashrc" ]; then
            SHELL_PROFILE="$HOME/.bashrc"
        fi

        if [ -n "$SHELL_PROFILE" ]; then
            if ! grep -q "ANTHROPIC_API_KEY" "$SHELL_PROFILE"; then
                echo "" >> "$SHELL_PROFILE"
                echo "# Anthropic API Key" >> "$SHELL_PROFILE"
                echo "export ANTHROPIC_API_KEY=\"$api_key\"" >> "$SHELL_PROFILE"
                print_success "Added to $SHELL_PROFILE"
            fi
        fi

        print_success "API Key configured"
    fi
else
    print_success "ANTHROPIC_API_KEY is set"
fi

echo ""

# Step 5: Project Selection
echo -e "${BLUE}📁 Step 5: Project Setup${NC}"
echo "-------------------------"

# Detect current directory
CURRENT_DIR=$(pwd)
PROJECT_NAME=$(basename "$CURRENT_DIR")

echo "Current directory: $CURRENT_DIR"
read -p "Set up Claude Code in current directory? (y/n) " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    PROJECT_DIR="$CURRENT_DIR"
else
    read -p "Enter project directory path: " PROJECT_DIR
    if [ ! -d "$PROJECT_DIR" ]; then
        print_error "Directory does not exist: $PROJECT_DIR"
        exit 1
    fi
fi

cd "$PROJECT_DIR"
print_success "Working in: $PROJECT_DIR"

echo ""

# Step 6: Create .claude directory structure
echo -e "${BLUE}${WRENCH} Step 6: Creating Directory Structure${NC}"
echo "--------------------------------------------"

if [ -d ".claude" ]; then
    print_warning ".claude directory already exists"
    read -p "Overwrite existing configuration? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Keeping existing configuration"
        SKIP_DIRS=true
    fi
fi

if [ "$SKIP_DIRS" != true ]; then
    print_info "Creating .claude directory structure..."
    mkdir -p .claude/{agents,commands,hooks}
    print_success "Directory structure created"
fi

echo ""

# Step 7: Project Type Selection
echo -e "${BLUE}🎯 Step 7: Select Project Type${NC}"
echo "--------------------------------"

echo "What type of project is this?"
echo "1) Full-Stack Web Application"
echo "2) Backend API"
echo "3) Frontend React/Vue"
echo "4) Machine Learning / Data Science"
echo "5) Healthcare / Medical AI"
echo "6) Financial Analysis"
echo "7) Custom (manual setup)"
echo ""

read -p "Enter choice (1-7): " project_type

# Step 8: Create configuration files based on project type
echo ""
echo -e "${BLUE}${WRENCH} Step 8: Creating Configuration Files${NC}"
echo "--------------------------------------------"

case $project_type in
    1)
        print_info "Setting up Full-Stack configuration..."

        # Create settings.json
        cat > .claude/settings.json << 'EOF'
{
  "allowedTools": ["Read", "Write", "Edit", "Bash", "Grep", "Glob"],
  "autoApproveTools": [
    "Read",
    "Grep",
    "Glob",
    "Bash(npm run dev:*)",
    "Bash(npm test:*)",
    "Bash(npm run build:*)"
  ],
  "model": "claude-sonnet-4-5-20250929"
}
EOF

        # Create basic CLAUDE.md
        cat > CLAUDE.md << 'EOF'
# Full-Stack Application

## Technology Stack

### Frontend
- Framework: [React/Vue/Angular]
- TypeScript
- Styling: [Tailwind/CSS Modules]

### Backend
- Framework: [Express/Fastify/NestJS]
- Database: [PostgreSQL/MongoDB]
- ORM: [Prisma/TypeORM]

## Project Structure

```
/
├── frontend/     # Frontend application
├── backend/      # Backend API
├── shared/       # Shared types and utilities
└── docs/         # Documentation
```

## Development Commands

```bash
npm run dev           # Start both frontend and backend
npm run dev:frontend  # Frontend only
npm run dev:backend   # Backend only
npm test              # Run tests
npm run build         # Production build
```

## Coding Conventions

- TypeScript strict mode enabled
- ESLint + Prettier configured
- Conventional commits
- 80%+ test coverage
EOF

        # Create fullstack-developer agent
        cat > .claude/agents/fullstack-developer.md << 'EOF'
---
name: fullstack-developer
description: Full-stack developer for complete feature implementation
tools: Read, Write, Edit, Bash, Grep, Glob
model: sonnet
---

You are an expert full-stack developer.

When implementing features:
1. Design database schema if needed
2. Create backend API endpoints
3. Implement frontend components
4. Write tests for both
5. Update documentation

Follow the project conventions in CLAUDE.md
EOF

        print_success "Full-stack configuration created"
        ;;

    2)
        print_info "Setting up Backend API configuration..."

        cat > .claude/settings.json << 'EOF'
{
  "allowedTools": ["Read", "Write", "Edit", "Bash", "Grep", "Glob"],
  "autoApproveTools": [
    "Read",
    "Grep",
    "Bash(npm test:*)",
    "Bash(docker ps:*)"
  ],
  "model": "claude-sonnet-4-5-20250929"
}
EOF

        cat > CLAUDE.md << 'EOF'
# Backend API

## Stack
- Framework: [Express/Fastify/NestJS]
- Database: [PostgreSQL/MongoDB]
- Authentication: [JWT/OAuth]

## API Design
- RESTful conventions
- Versioning: /api/v1/
- OpenAPI documentation

## Development
```bash
npm run dev     # Start dev server
npm test        # Run tests
npm run migrate # Run migrations
```
EOF

        cat > .claude/agents/api-developer.md << 'EOF'
---
name: api-developer
description: Backend API developer
tools: Read, Write, Edit, Bash, Grep
model: sonnet
---

You are a backend API expert.

When creating endpoints:
1. Design the endpoint schema
2. Implement validation
3. Add proper error handling
4. Write unit and integration tests
5. Update API documentation
EOF

        print_success "Backend API configuration created"
        ;;

    3)
        print_info "Setting up Frontend configuration..."

        cat > .claude/settings.json << 'EOF'
{
  "allowedTools": [
    "Read",
    "Write",
    "Edit",
    "Grep",
    "Glob",
    "Bash(npm *:*)",
    "Bash(npx *:*)"
  ],
  "autoApproveTools": ["Read", "Grep", "Glob"],
  "model": "claude-sonnet-4-5-20250929"
}
EOF

        cat > CLAUDE.md << 'EOF'
# Frontend Application

## Stack
- Framework: [React/Vue/Angular]
- TypeScript
- State Management: [Redux/Zustand/Pinia]
- Styling: [Tailwind/Styled Components]

## Component Structure
```
src/
├── components/
├── hooks/
├── services/
└── utils/
```

## Development
```bash
npm run dev    # Start dev server
npm test       # Run tests
npm run build  # Production build
```
EOF

        print_success "Frontend configuration created"
        ;;

    5)
        print_info "Setting up Healthcare AI configuration..."
        print_info "This will copy the complete healthcare example..."

        # Check if we're in the repo
        if [ -f "../../examples/healthcare-ai/CLAUDE.md" ]; then
            cp -r ../../examples/healthcare-ai/.claude/* .claude/
            cp ../../examples/healthcare-ai/CLAUDE.md ./
            print_success "Healthcare AI configuration copied"
        else
            print_warning "Healthcare example not found, creating basic config..."
            cat > .claude/settings.json << 'EOF'
{
  "allowedTools": ["Read", "Write", "Edit", "Bash", "Grep", "Glob", "WebSearch"],
  "autoApproveTools": ["Read", "Grep", "Glob"],
  "model": "claude-opus-4-1-20250805"
}
EOF
        fi
        ;;

    7)
        print_info "Creating minimal configuration..."

        cat > .claude/settings.json << 'EOF'
{
  "allowedTools": ["*"],
  "autoApproveTools": ["Read", "Grep", "Glob"],
  "model": "claude-sonnet-4-5-20250929"
}
EOF

        touch CLAUDE.md
        print_success "Minimal configuration created"
        ;;

    *)
        print_warning "Invalid selection, creating minimal configuration"
        cat > .claude/settings.json << 'EOF'
{
  "allowedTools": ["*"],
  "autoApproveTools": ["Read", "Grep", "Glob"],
  "model": "claude-sonnet-4-5-20250929"
}
EOF
        ;;
esac

echo ""

# Step 9: Create basic agents
echo -e "${BLUE}${ROBOT} Step 9: Creating Basic Agents${NC}"
echo "-----------------------------------"

if [ ! -f ".claude/agents/code-reviewer.md" ]; then
    cat > .claude/agents/code-reviewer.md << 'EOF'
---
name: code-reviewer
description: Expert code reviewer for quality checks and security audits
tools: Read, Grep, Glob
model: sonnet
---

You are a senior software engineer specializing in code review.

Review checklist:
1. Code quality and readability
2. Potential bugs and edge cases
3. Security vulnerabilities
4. Performance issues
5. Test coverage
6. Documentation

Provide specific, actionable feedback with examples.
EOF
    print_success "Created code-reviewer agent"
fi

if [ ! -f ".claude/agents/test-generator.md" ]; then
    cat > .claude/agents/test-generator.md << 'EOF'
---
name: test-generator
description: Generates comprehensive test suites
tools: Read, Write, Edit
model: sonnet
---

You are a testing expert.

When generating tests:
1. Analyze the code structure
2. Identify test cases (happy path, edge cases, errors)
3. Write unit tests with good coverage
4. Follow Arrange-Act-Assert pattern
5. Use descriptive test names

Aim for 80%+ coverage.
EOF
    print_success "Created test-generator agent"
fi

echo ""

# Step 10: Create .gitignore entry
echo -e "${BLUE}📝 Step 10: Git Configuration${NC}"
echo "--------------------------------"

if [ -f ".gitignore" ]; then
    if ! grep -q ".claude/logs" .gitignore; then
        echo "" >> .gitignore
        echo "# Claude Code" >> .gitignore
        echo ".claude/logs/" >> .gitignore
        print_success "Added .claude/logs/ to .gitignore"
    else
        print_info ".gitignore already configured"
    fi
else
    cat > .gitignore << 'EOF'
# Claude Code
.claude/logs/

# Dependencies
node_modules/

# Environment
.env
.env.local
EOF
    print_success "Created .gitignore"
fi

echo ""

# Step 11: Verification
echo -e "${BLUE}${CHECK} Step 11: Verification${NC}"
echo "----------------------------"

errors=0

# Check .claude directory
if [ -d ".claude" ]; then
    print_success ".claude/ directory exists"
else
    print_error ".claude/ directory not found"
    ((errors++))
fi

# Check settings.json
if [ -f ".claude/settings.json" ]; then
    print_success ".claude/settings.json exists"
else
    print_error ".claude/settings.json not found"
    ((errors++))
fi

# Check agents
agent_count=$(find .claude/agents -name "*.md" 2>/dev/null | wc -l)
if [ "$agent_count" -gt 0 ]; then
    print_success "Found $agent_count agent(s)"
else
    print_warning "No agents found"
fi

# Check CLAUDE.md
if [ -f "CLAUDE.md" ]; then
    print_success "CLAUDE.md exists"
else
    print_warning "CLAUDE.md not found (optional but recommended)"
fi

echo ""

# Final Summary
echo ""
echo -e "${BLUE}======================================${NC}"
echo -e "${GREEN}${ROCKET} Setup Complete!${NC}"
echo -e "${BLUE}======================================${NC}"
echo ""

if [ $errors -eq 0 ]; then
    print_success "All checks passed!"
else
    print_warning "Setup completed with $errors issue(s)"
fi

echo ""
echo "Next steps:"
echo "1. Review and customize .claude/settings.json"
echo "2. Edit CLAUDE.md with your project details"
echo "3. Add more specialized agents in .claude/agents/"
echo "4. Run: claude"
echo ""

read -p "Open Claude Code now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if command_exists claude; then
        print_info "Starting Claude Code..."
        claude
    else
        print_error "Claude Code CLI not found"
        echo "Install with: npm install -g @anthropic-ai/claude-code"
    fi
fi

echo ""
echo -e "${GREEN}Happy coding with Claude! ${ROBOT}${NC}"
