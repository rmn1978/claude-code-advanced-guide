#!/bin/bash

# Interactive Agent Generator for Claude Code
# Creates a custom agent based on user input

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Emojis
ROBOT="🤖"
ROCKET="🚀"
CHECK="✅"
QUESTION="❓"
WRENCH="🔧"

echo -e "${BLUE}${ROBOT} Claude Code Agent Generator${NC}"
echo "=================================="
echo ""

# Step 1: Agent Name
echo -e "${CYAN}${QUESTION} Step 1: Basic Information${NC}"
echo "----------------------------"
read -p "Agent name (kebab-case, e.g., 'api-developer'): " AGENT_NAME

# Validate name
if [[ ! $AGENT_NAME =~ ^[a-z0-9-]+$ ]]; then
    echo -e "${RED}❌ Invalid name. Use only lowercase letters, numbers, and hyphens.${NC}"
    exit 1
fi

read -p "Agent description (when to use it): " AGENT_DESCRIPTION

# Step 2: Agent Type
echo ""
echo -e "${CYAN}${QUESTION} Step 2: Agent Type${NC}"
echo "----------------------------"
echo "What type of agent is this?"
echo ""
echo "1) 🏗️  Architecture & Design"
echo "2) 💻 Code Development"
echo "3) 🧪 Testing & QA"
echo "4) 🔒 Security & Compliance"
echo "5) 📊 Data & Analytics"
echo "6) 🚀 DevOps & Infrastructure"
echo "7) 📝 Documentation"
echo "8) 🎨 UI/UX Development"
echo "9) 🔧 Custom/Other"
echo ""

read -p "Select type (1-9): " AGENT_TYPE

case $AGENT_TYPE in
    1) TYPE_NAME="architecture"
       TYPE_DESC="architecture and design decisions"
       ;;
    2) TYPE_NAME="development"
       TYPE_DESC="code development and implementation"
       ;;
    3) TYPE_NAME="testing"
       TYPE_DESC="testing, QA, and quality assurance"
       ;;
    4) TYPE_NAME="security"
       TYPE_DESC="security audits and compliance"
       ;;
    5) TYPE_NAME="data"
       TYPE_DESC="data analysis and processing"
       ;;
    6) TYPE_NAME="devops"
       TYPE_DESC="DevOps, infrastructure, and deployment"
       ;;
    7) TYPE_NAME="documentation"
       TYPE_DESC="documentation and technical writing"
       ;;
    8) TYPE_NAME="uiux"
       TYPE_DESC="UI/UX design and development"
       ;;
    9) TYPE_NAME="custom"
       TYPE_DESC="custom specialized tasks"
       ;;
    *) echo -e "${RED}Invalid selection${NC}"
       exit 1
       ;;
esac

# Step 3: Technology Stack
echo ""
echo -e "${CYAN}${QUESTION} Step 3: Technology Stack${NC}"
echo "----------------------------"
echo "Primary technology/framework:"
echo ""
echo "1)  React/Next.js"
echo "2)  Vue/Nuxt"
echo "3)  Angular"
echo "4)  Python/Django"
echo "5)  Python/FastAPI"
echo "6)  Node.js/Express"
echo "7)  Ruby/Rails"
echo "8)  Go"
echo "9)  Rust"
echo "10) Java/Spring"
echo "11) .NET/C#"
echo "12) PHP/Laravel"
echo "13) Generic/Multiple"
echo ""

read -p "Select stack (1-13): " STACK_CHOICE

case $STACK_CHOICE in
    1) STACK="React/Next.js" ;;
    2) STACK="Vue/Nuxt" ;;
    3) STACK="Angular" ;;
    4) STACK="Python/Django" ;;
    5) STACK="Python/FastAPI" ;;
    6) STACK="Node.js/Express" ;;
    7) STACK="Ruby/Rails" ;;
    8) STACK="Go" ;;
    9) STACK="Rust" ;;
    10) STACK="Java/Spring" ;;
    11) STACK=".NET/C#" ;;
    12) STACK="PHP/Laravel" ;;
    13) STACK="Generic" ;;
    *) STACK="Generic" ;;
esac

# Step 4: Tools Selection
echo ""
echo -e "${CYAN}${QUESTION} Step 4: Tools & Permissions${NC}"
echo "----------------------------"
echo "What tools should this agent have access to?"
echo ""
echo "1) 📖 Read only (safe, for analysis)"
echo "2) 📖✏️  Read + Edit (modify existing files)"
echo "3) 📖✏️📝 Read + Edit + Write (create new files)"
echo "4) 📖✏️📝⚙️  Read + Edit + Write + Bash (full access)"
echo "5) 🔍 Search only (Grep + Glob)"
echo "6) 🎯 Custom (specify manually)"
echo ""

read -p "Select tools (1-6): " TOOLS_CHOICE

case $TOOLS_CHOICE in
    1) TOOLS="Read, Grep, Glob" ;;
    2) TOOLS="Read, Edit, Grep, Glob" ;;
    3) TOOLS="Read, Write, Edit, Grep, Glob" ;;
    4) TOOLS="Read, Write, Edit, Bash, Grep, Glob" ;;
    5) TOOLS="Grep, Glob" ;;
    6) read -p "Enter tools (comma-separated): " TOOLS ;;
esac

# Step 5: Model Selection
echo ""
echo -e "${CYAN}${QUESTION} Step 5: AI Model${NC}"
echo "----------------------------"
echo "Which Claude model should this agent use?"
echo ""
echo "1) ⚡ Haiku (fast, simple tasks)"
echo "2) 🎯 Sonnet (balanced, recommended)"
echo "3) 🧠 Opus (complex, high-quality)"
echo "4) 🔄 Inherit (use project default)"
echo ""

read -p "Select model (1-4): " MODEL_CHOICE

case $MODEL_CHOICE in
    1) MODEL="haiku" ;;
    2) MODEL="sonnet" ;;
    3) MODEL="opus" ;;
    4) MODEL="inherit" ;;
    *) MODEL="sonnet" ;;
esac

# Step 6: Generate Agent File
echo ""
echo -e "${CYAN}${WRENCH} Generating agent...${NC}"

# Determine output location
if [ -d ".claude/agents" ]; then
    OUTPUT_DIR=".claude/agents"
else
    OUTPUT_DIR="$HOME/.claude/agents"
    mkdir -p "$OUTPUT_DIR"
fi

OUTPUT_FILE="$OUTPUT_DIR/$AGENT_NAME.md"

# Create agent file
cat > "$OUTPUT_FILE" << EOF
---
name: $AGENT_NAME
description: $AGENT_DESCRIPTION
tools: $TOOLS
model: $MODEL
---

You are an expert in $TYPE_DESC specializing in $STACK.

## 🎯 Core Responsibilities

1. [Responsibility 1]
2. [Responsibility 2]
3. [Responsibility 3]

## 🔧 Expertise Areas

- **Area 1**: [Description]
- **Area 2**: [Description]
- **Area 3**: [Description]

## 📋 Process

### Step 1: [First Step]
[Detailed instructions for step 1]

### Step 2: [Second Step]
[Detailed instructions for step 2]

### Step 3: [Third Step]
[Detailed instructions for step 3]

## ✅ Quality Checklist

Before completing a task:
- [ ] [Check 1]
- [ ] [Check 2]
- [ ] [Check 3]
- [ ] [Check 4]

## 🎯 Best Practices

1. **Practice 1**: [Description]
2. **Practice 2**: [Description]
3. **Practice 3**: [Description]

## 📖 Example Usage

\`\`\`
> Use the $AGENT_NAME agent to [example task]

Expected output:
[Description of what the agent will do]
\`\`\`

## 🚫 Limitations

This agent should NOT:
- [Limitation 1]
- [Limitation 2]

## 💡 Tips

- Tip 1
- Tip 2
- Tip 3
EOF

echo ""
echo -e "${GREEN}${CHECK} Agent created successfully!${NC}"
echo ""
echo "📁 Location: $OUTPUT_FILE"
echo ""

# Step 7: Customize?
echo -e "${CYAN}${QUESTION} Next Steps${NC}"
echo "----------------------------"
echo ""
echo "1) Open agent file for customization"
echo "2) Test agent immediately"
echo "3) Done (finish)"
echo ""

read -p "Select option (1-3): " NEXT_STEP

case $NEXT_STEP in
    1)
        if command -v code &> /dev/null; then
            code "$OUTPUT_FILE"
        else
            ${EDITOR:-nano} "$OUTPUT_FILE"
        fi
        ;;
    2)
        echo ""
        echo -e "${CYAN}Testing agent...${NC}"
        echo ""
        echo "To test your agent, run:"
        echo "  claude"
        echo ""
        echo "Then in Claude:"
        echo "  > Use the $AGENT_NAME agent to [describe task]"
        echo ""
        ;;
    3)
        echo -e "${GREEN}Done! Happy coding with Claude! ${ROBOT}${NC}"
        ;;
esac

# Step 8: Show summary
echo ""
echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║       Agent Summary                    ║${NC}"
echo -e "${BLUE}╠════════════════════════════════════════╣${NC}"
echo -e "${BLUE}║${NC} Name: $AGENT_NAME"
echo -e "${BLUE}║${NC} Type: $TYPE_NAME"
echo -e "${BLUE}║${NC} Stack: $STACK"
echo -e "${BLUE}║${NC} Model: $MODEL"
echo -e "${BLUE}║${NC} Tools: $TOOLS"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

# Step 9: Add to agents list
if [ -f ".claude/agents/README.md" ]; then
    echo "- **$AGENT_NAME**: $AGENT_DESCRIPTION" >> .claude/agents/README.md
elif [ -f "$HOME/.claude/agents/README.md" ]; then
    echo "- **$AGENT_NAME**: $AGENT_DESCRIPTION" >> "$HOME/.claude/agents/README.md"
fi

echo -e "${GREEN}${ROCKET} Agent ready to use!${NC}"
echo ""
echo "Usage:"
echo "  claude"
echo "  > Use $AGENT_NAME agent to help with [your task]"
echo ""
