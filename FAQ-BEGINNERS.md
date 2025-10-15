# ❓ FAQ for Beginners - Claude Code

Frequently asked questions from people who are getting started with Claude Code.

---

## 🤔 Basic Questions

### What exactly is Claude Code?

**Simple answer**: It's an AI assistant that lives inside VS Code and helps you program.

**More details**:
- You can ask it to write code
- You can ask it to explain code
- You can ask it to fix errors
- You can ask it to create complete apps

**Difference with ChatGPT/Copilot**:
- ChatGPT: Text only, no access to your files
- Copilot: Intelligent auto-completion
- **Claude Code**: Can SEE your files, WRITE code, EXECUTE commands

---

### Do I need to know how to program to use Claude Code?

**Honest answer**: Yes, at least the basics.

**Minimum recommended level**:
- ✅ You know what a variable is
- ✅ You know what a function is
- ✅ You know how to use the basic terminal (`cd`, `ls`)
- ✅ You know what Git is (even conceptually)

**If you DON'T know anything about programming**:
1. Learn the basics first: [freeCodeCamp](https://www.freecodecamp.org/)
2. Then come back and Claude Code will be 10x more useful

**If you already know programming but in another language**:
Perfect! Claude Code will help you learn new languages quickly.

---

### How much does it cost?

**The VS Code extension**: FREE

**Using the Claude API**: PAY per use

**Pricing (April 2024)**:
- **Haiku** (fast): ~$0.25 per 1M input tokens
- **Sonnet** (balanced): ~$3 per 1M input tokens
- **Opus** (most powerful): ~$15 per 1M input tokens

**What does this mean in real money?**

For a small project (creating a simple app):
- **Typical cost**: $1-5 USD
- **Medium project**: $10-30 USD
- **Large project**: $50-100 USD

**Is it expensive?**

Compared to hiring someone: NO
- Freelance developer: $30-100/hour
- Claude Code: $1-5 to complete the same project

**Tip**: Start with the `haiku` model (cheaper) for practice.

---

### Does it work on Windows / Mac / Linux?

**YES**, it works on all 3 operating systems.

**Requirements**:
- **Windows**: Windows 10 or higher
- **Mac**: macOS 10.15 or higher
- **Linux**: Any modern distribution

**All you need**:
- VS Code installed
- Node.js installed (v18+)
- Internet connection

---

### Can I use it without the terminal / command line?

**Short answer**: Technically yes, but you'll miss a lot.

**Long answer**:
Claude Code needs to execute commands like:
```bash
npm install
git commit
python app.py
```

If you don't know how to use the terminal, I recommend:
1. Learn the terminal basics (2-3 hours)
2. Recommended tutorial: [The Odin Project - Command Line](https://www.theodinproject.com/lessons/foundations-command-line-basics)

**Basic commands you MUST know**:
```bash
cd folder      # Enter a folder
ls             # View files
pwd            # See where you are
```

---

### Does it replace a developer?

**NO**, it doesn't replace a developer.

**What it DOES do**:
- ✅ Accelerates development 3-10x
- ✅ Helps you learn faster
- ✅ Writes repetitive code for you
- ✅ Helps you debug

**What it DOESN'T do**:
- ❌ Doesn't understand business context (you decide that)
- ❌ Doesn't make complex architecture decisions
- ❌ Doesn't understand vague requirements
- ❌ Sometimes makes mistakes (you need to review it)

**Analogy**: It's like having a very competent assistant, not a replacement.

---

### Does Claude Code learn from my code?

**NO**, Claude Code does NOT learn from your specific code.

**What this means**:
- Your code is NOT used to train future models
- Anthropic does NOT store your code permanently
- Your code is NOT shared with other users

**Privacy**:
- According to Anthropic's policy, your data is NOT used for training
- Conversations are processed but NOT stored permanently

**Recommendation for companies**:
- Read [Anthropic's Privacy Policy](https://www.anthropic.com/privacy)
- Consider using an enterprise API if handling super sensitive data

---

## 🚀 Getting Started

### Where do I start?

**Recommended path (4-6 hours total)**:

1. **[Installation](./docs/01-installation.md)** (15 min)
   - Install VS Code
   - Install Claude Code
   - Configure API key

2. **[15-Minute Tutorial](./TUTORIAL-15MIN.md)** (15 min)
   - Your first "Hello World" app
   - See Claude Code in action

3. **[Glossary](./GLOSSARY.md)** (30 min)
   - Read basic terms
   - No need to memorize, just familiarize

4. **[Example: Todo API](./examples/todo-api-fastapi/README.md)** (1-2 hours)
   - Build your first API
   - Step by step, very clear

5. **[Example: Blog](./examples/blog-nextjs/README.md)** (1-2 hours)
   - Build your first frontend
   - Basic Next.js

6. **Practice creating your own projects**
   - Start with simple ideas
   - Iterate and improve

---

### What project should I build first?

**For learning, simple projects are better:**

**First project ideas (1-2 hours)**:
1. **Todo List (Todo App)**
   - Basic CRUD
   - No authentication
   - Just localStorage

2. **Unit Converter**
   - Celsius ↔ Fahrenheit
   - Kilometers ↔ Miles
   - Frontend only, no backend

3. **Calculator**
   - Addition, subtraction, multiplication, division
   - Simple interface

**Second project ideas (3-5 hours)**:
1. **Personal Blog**
   - SSG with Next.js
   - Posts in Markdown
   - Deploy to Vercel

2. **Notes API**
   - FastAPI + PostgreSQL
   - Complete CRUD
   - Basic authentication

3. **Pomodoro Timer**
   - React
   - LocalStorage for statistics

**DON'T start with**:
- ❌ Complete social network
- ❌ E-commerce with payments
- ❌ Trading app
- ❌ Netflix clone

(These are too complex to start with)

---

### How long does it take to learn?

**Depends on your previous level:**

**If you already know programming**:
- Familiarize yourself with Claude Code: 1-2 hours
- Build first project: 2-4 hours
- Be productive: 1 week
- **Total**: ~1 week

**If you know programming but in another stack**:
- Learn the new stack WITH Claude Code: 1-2 weeks
- Be productive: 2-3 weeks
- **Total**: ~2-3 weeks

**If you're COMPLETELY new to programming**:
- Learn basic programming: 3-6 months
- Learn Claude Code: 1-2 weeks
- **Total**: 3-6 months

**Tip**: Don't rush. Learn the fundamentals well.

---

## 💻 Technical Problems

### "API key not found" - What do I do?

**Step 1**: Verify you configured the API key

```bash
# In the terminal
echo $ANTHROPIC_API_KEY  # Mac/Linux
echo %ANTHROPIC_API_KEY%  # Windows
```

**If it's empty**:

**Mac/Linux**:
```bash
# Add to ~/.zshrc or ~/.bashrc file
export ANTHROPIC_API_KEY="sk-ant-xxxxx"

# Reload
source ~/.zshrc
```

**Windows (PowerShell)**:
```powershell
$env:ANTHROPIC_API_KEY="sk-ant-xxxxx"
```

**Step 2**: Restart VS Code COMPLETELY

**More help**: [Troubleshooting](./docs/07-troubleshooting.md#error-api-key-not-found)

---

### Claude Code is very slow, why?

**Common causes**:

1. **Model too large**
   - Solution: Use `haiku` instead of `sonnet` or `opus`
   - Settings → Claude Code → Model → `claude-haiku-3.5`

2. **Project with many files**
   - Solution: Create `.claudeignore`
   ```
   node_modules/
   .next/
   dist/
   build/
   ```

3. **Max tokens too high**
   - Solution: Reduce in settings
   ```json
   {
     "claude-code.maxTokens": 4096  // Instead of 8192
   }
   ```

4. **Slow internet connection**
   - No solution except improving your internet

---

### Why doesn't Claude Code understand my prompt?

**Bad vs good prompts**:

❌ **Bad**: "Create an app"
- Too vague

✅ **Good**: "Create a todo app with React that allows me to add, edit, and delete tasks"
- Specific and clear

❌ **Bad**: "Fix this"
- Doesn't say what's broken

✅ **Good**: "I'm getting this error: [paste error]. Fix it in src/api/users.py"
- Specific error + location

**Tips for good prompts**:
1. Be specific
2. Mention the file if relevant
3. Include the technology stack
4. Paste complete errors (with stack trace)

---

### Error: "Permission denied" when executing commands

**Cause**: Missing execution permission

**Solution Mac/Linux**:
```bash
chmod +x script-name.sh
```

**Solution Windows**:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

## 🎓 Learning

### Should I learn the stack first or use Claude Code right away?

**Recommendation**: Learn the stack basics FIRST.

**Why**:
- If you don't understand the basics, you won't know if Claude's code is good or bad
- You won't be able to fix errors
- You won't understand what it's doing

**Learn first**:
- Basic language syntax (JavaScript, Python, etc.)
- What each tool does (React, FastAPI, etc.)
- Fundamental concepts (variables, functions, loops)

**Then use Claude Code to**:
- Write repetitive code
- Learn advanced patterns
- Accelerate development

**Analogy**: Don't use a Formula 1 car if you still don't know how to drive. Learn to drive first.

---

### Can I trust the code Claude generates?

**Short answer**: Yes, BUT always review it.

**Claude Code is very good, but NOT perfect**:

**Estimated success rate**:
- Simple tasks: ~95% correct
- Medium tasks: ~85% correct
- Complex tasks: ~70% correct

**You should ALWAYS**:
1. ✅ Read the code it generates
2. ✅ Understand what it does
3. ✅ Test it (run tests)
4. ✅ Make adjustments if necessary

**Signs the code might be wrong**:
- Has TODOs or comments "// FIX THIS"
- Uses outdated patterns
- Doesn't follow security best practices
- Has hardcoded credentials

---

### What do I do if Claude generates code with bugs?

**Don't get frustrated, it's normal**:

1. **Describe the error**:
   ```
   > This code gives error: [paste error]
   > Fix it
   ```

2. **If it persists, be more specific**:
   ```
   > The error is in line 45 of src/api/users.py
   > The function expects a string but receives a number
   > Fix the type mismatch
   ```

3. **If it still doesn't work**:
   - Ask it to explain the code
   - Google the error
   - Ask on Stack Overflow
   - Simplify the problem

---

## 📚 Resources

### Where can I learn more?

**Official documentation**:
- [Claude Code Docs](https://docs.claude.com/claude-code)
- [Anthropic API Docs](https://docs.anthropic.com/)

**In this repository**:
- **[15-min Tutorial](./TUTORIAL-15MIN.md)** ← Start here
- **[Glossary](./GLOSSARY.md)** - Terms explained
- **[Cheat Sheet](./CHEATSHEET.md)** - Quick reference
- **[Examples](./examples/README.md)** - 14 complete projects

**To learn programming**:
- [freeCodeCamp](https://www.freecodecamp.org/) - Free
- [The Odin Project](https://www.theodinproject.com/) - Free
- [MDN Web Docs](https://developer.mozilla.org/) - Reference

---

### Is there a community / Discord / Forum?

**Official**:
- [Anthropic Discord](https://discord.gg/anthropic)
- [GitHub Discussions](https://github.com/anthropics/claude-code/discussions)

**This repository**:
- [GitHub Issues](https://github.com/rmn1978/claude-code-advanced-guide/issues)
- [GitHub Discussions](https://github.com/rmn1978/claude-code-advanced-guide/discussions)

**Social media**:
- Twitter: [@learntouseai](https://twitter.com/learntouseai)

---

## 🎯 Next Steps

**If you JUST installed Claude Code**:
1. Go to the **[15-Minute Tutorial](./TUTORIAL-15MIN.md)**
2. Build your first app
3. Come back here when you have questions

**If you already did the tutorial**:
1. Review the **[Cheat Sheet](./CHEATSHEET.md)**
2. Choose an **[example](./examples/README.md)** at your level
3. Build it step by step

**If you already built several projects**:
1. Read **[Best Practices](./docs/06-best-practices.md)**
2. Learn **[Multi-Agent Orchestration](./docs/guides/02-intermediate/multi-agent-orchestration.md)**
3. Build something more complex

---

## ❓ Your Question Not Here?

**Options**:

1. **Check [Troubleshooting](./docs/07-troubleshooting.md)**
2. **Search in [existing Issues](https://github.com/rmn1978/claude-code-advanced-guide/issues)**
3. **Open a [new issue](https://github.com/rmn1978/claude-code-advanced-guide/issues/new/choose)**

**Include in your question**:
- Operating system
- VS Code version
- What you tried to do
- What error you got
- Screenshots if possible

---

**Good luck on your journey with Claude Code!** 🚀

[← Back to README](./README.md)
