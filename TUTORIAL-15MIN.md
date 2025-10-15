# 🚀 Your First App with Claude Code in 15 Minutes

Step-by-step tutorial for absolute beginners. By the end you'll have a working app.

**⏱️ Time**: 15 minutes
**📊 Level**: Absolute beginner
**💻 Requirements**: VS Code installed

---

## ✅ Before Starting

### What you need

- [ ] VS Code installed (v1.85+)
- [ ] Node.js installed (v18+)
- [ ] Anthropic API key
- [ ] 15 minutes without interruptions

### Verify everything is ready

```bash
# Verify Node.js
node --version
# Should show: v18.0.0 or higher

# Verify VS Code
code --version
# Should show: 1.85.0 or higher
```

**If something fails**: Go to [Installation](./docs/01-installation.md)

---

## 🎯 What We're Going to Build

**Project**: A "Band Name Generator" web app

**Functionality**:
- User enters their favorite words
- The app generates creative band names
- Simple frontend with HTML/CSS/JavaScript

**Why this project**:
- ✅ Simple but fun
- ✅ Shows Claude's capabilities
- ✅ Works in the browser
- ✅ Doesn't require database or complex backend

---

## 📋 Step 1: Install Claude Code (3 minutes)

### 1.1 - Open VS Code

Open Visual Studio Code.

### 1.2 - Install the Extension

1. Click on the **Extensions** icon (square with puzzle pieces)
2. Search: `Claude Code`
3. Click **Install** on Anthropic's extension

**Wait 30-60 seconds** while it installs.

### 1.3 - Verify Installation

You should see:
- ✅ A Claude icon in the left sidebar
- ✅ A new panel called "Claude Code"

**If you DON'T see it**: Restart VS Code and check again.

---

## 🔑 Step 2: Configure API Key (2 minutes)

### 2.1 - Get your API Key

1. Go to: https://console.anthropic.com/
2. Log in or create an account
3. Go to **"API Keys"**
4. Click **"Create Key"**
5. **Copy** your API key (starts with `sk-ant-`)

⚠️ **IMPORTANT**: Save this key in a safe place. You'll need it.

### 2.2 - Configure the Key in your Terminal

**Mac/Linux**:
```bash
# Open your terminal
# Paste this command (replace xxx with your key):
export ANTHROPIC_API_KEY="sk-ant-xxxxx"

# Verify it worked:
echo $ANTHROPIC_API_KEY
# Should show your key
```

**Windows (PowerShell)**:
```powershell
# Open PowerShell
# Paste this command (replace xxx with your key):
$env:ANTHROPIC_API_KEY="sk-ant-xxxxx"

# Verify it worked:
echo $env:ANTHROPIC_API_KEY
# Should show your key
```

### 2.3 - Restart VS Code

**VERY IMPORTANT**: Close VS Code COMPLETELY and reopen it.

This ensures VS Code sees the new environment variable.

---

## 💬 Step 3: First Interaction with Claude (2 minutes)

### 3.1 - Open Claude Code

1. Click on the **Claude** icon in the left sidebar
2. You should see a panel with a chat

### 3.2 - Quick Test

Type in the chat:

```
Hello! Can you see this?
```

**Expected response**: Claude should respond something like "Yes, I can see your message!"

**If you see an error**: Check that the API key is configured correctly (Step 2).

---

## 🏗️ Step 4: Create the Project (5 minutes)

### 4.1 - Create Project Folder

```bash
# In your terminal
mkdir band-name-generator
cd band-name-generator

# Open VS Code in this folder
code .
```

### 4.2 - Ask Claude to Create the App

**Open Claude Code** (icon in the sidebar) and paste this prompt:

```
Create a Band Name Generator web app with the following requirements:

1. A single HTML file with embedded CSS and JavaScript
2. User can input 2-3 words they like
3. Click a button to generate creative band names
4. Show 5 different band name suggestions
5. Modern, fun design with gradients
6. No external dependencies - pure HTML/CSS/JS

The file should be called index.html and be ready to open in a browser.
```

### 4.3 - Wait for Claude to Create the File

Claude should:
1. Create an `index.html` file
2. Write all the HTML, CSS and JavaScript code
3. Show you the code

**Time**: 30-60 seconds

### 4.4 - Verify the File Exists

In VS Code, you should see:
```
band-name-generator/
└── index.html
```

---

## 🎨 Step 5: Test the App (2 minutes)

### 5.1 - Open in Browser

**Option 1 - Double click**:
- Go to your `band-name-generator` folder
- Double click on `index.html`
- Opens in your browser

**Option 2 - VS Code Extension** (recommended):
1. Install the "Live Server" extension in VS Code
2. Right click on `index.html`
3. Click on "Open with Live Server"

### 5.2 - Test the App

1. Enter 2-3 words (e.g., "Fire", "Dragon", "Night")
2. Click on "Generate Band Names"
3. You should see 5 generated band names

**Examples of generated names**:
- "Firedrake Nights"
- "Dragon's Inferno"
- "Nightfire Chronicles"
- etc.

**If it works**: Congratulations! 🎉 You just created your first app with Claude Code.

---

## 🔧 Step 6: Customize the App (3 minutes)

Now let's make changes so you can see how Claude helps you iterate.

### 6.1 - Change the Color

Ask Claude:

```
Change the color scheme to dark mode with purple and blue gradients
```

Claude should:
1. Update the `index.html` file
2. Change the CSS colors
3. Show you what changed

### 6.2 - Add More Features

Ask Claude:

```
Add a "Copy to Clipboard" button next to each generated band name
```

Claude should:
1. Add copy buttons
2. Implement the JavaScript functionality
3. Update the HTML

### 6.3 - Test the Changes

Reload the page in your browser (F5) and test:
- Did the color scheme change?
- Do the "Copy" buttons appear?
- Do they work when clicked?

---

## 🎓 Step 7: Understand What Happened (2 minutes)

### What You Just Did

1. ✅ Installed Claude Code
2. ✅ Configured your API key
3. ✅ Asked Claude to create an app
4. ✅ Claude wrote ALL the code for you
5. ✅ Tested the app
6. ✅ Asked for changes and Claude made them

### The Power of This

**Before** (without Claude Code):
```
1. Search for tutorial on Google
2. Copy/paste code from StackOverflow
3. Debug errors
4. Search for more tutorials
5. More errors
6. 2-3 hours later: it works
```

**Now** (with Claude Code):
```
1. Describe what you want
2. Claude creates it
3. It works
4. 5-10 minutes
```

**Time reduction**: ~90-95% ⚡

---

## 🎯 Next Steps

### What to Do Now?

**Option 1 - Experiment with this app**:
```
> Add a "Favorites" section where users can save their favorite names

> Add a "Random" mode that generates names without user input

> Add animations when names appear

> Make it responsive for mobile devices
```

**Option 2 - Build another app**:
- Calculator
- Unit converter
- Todo list (Todo app)
- Password generator

**Option 3 - Learn more**:
- Read the [Cheat Sheet](./CHEATSHEET.md) for common prompts
- Review [more complex examples](./examples/README.md)
- Read [Best Practices](./docs/06-best-practices.md)

---

## 💡 Tips and Tricks

### How to Write Good Prompts

❌ **Bad**:
```
Create an app
```

✅ **Good**:
```
Create a weather app that:
- Shows current temperature
- Uses OpenWeather API
- Has a search bar for cities
- Shows 5-day forecast
- Responsive design
```

### If Something Doesn't Work

1. **Read the error**: Claude sometimes explains what failed
2. **Be specific**: "Fix the error in line 45"
3. **Iterate**: Ask for small changes, not rewriting everything
4. **Ask for explanations**: "Explain what this code does"

### Useful Claude Commands

```bash
/help    # Show help
/plan    # Claude plans before coding
/clear   # Clear chat
```

---

## ❓ Common Problems

### "API key not found"

**Solution**:
1. Verify you configured it: `echo $ANTHROPIC_API_KEY`
2. Restart VS Code COMPLETELY
3. Reconfigure if necessary

### Claude is very slow

**Solution**:
1. Switch to a faster model (haiku):
   - Settings → Claude Code → Model → `claude-haiku-3.5`

### The code doesn't work

**Solution**:
1. Ask Claude to fix it:
   ```
   This gives an error: [paste error]
   Fix it
   ```

### I don't know what to build

**Simple ideas for practice**:
- Tip calculator
- Temperature converter
- Random color generator
- Stopwatch/Timer
- Shopping list

---

## 🎉 You Did It!

**You've completed the tutorial**. Now you know:

- ✅ How to install and configure Claude Code
- ✅ How to ask Claude to create apps
- ✅ How to make iterative changes
- ✅ How to test your creations

**Total time**: ~15 minutes
**Apps created**: 1
**Knowledge gained**: Invaluable

---

## 📚 Additional Resources

**Next steps**:
- **[FAQ](./FAQ-BEGINNERS.md)** - Frequently asked questions
- **[Glossary](./GLOSSARY.md)** - Terms explained
- **[Cheat Sheet](./CHEATSHEET.md)** - Quick commands
- **[Examples](./examples/README.md)** - More complex projects

**Need help?**
- [Open an Issue](https://github.com/rmn1978/claude-code-advanced-guide/issues)
- [GitHub Discussions](https://github.com/rmn1978/claude-code-advanced-guide/discussions)

---

## 🚀 Challenge

**Now that you know the basics, challenge yourself**:

Create one of these apps (30-60 minutes each):
1. **BMI Calculator** (Body Mass Index)
2. **Meme Generator** (text on image)
3. **Interactive Quiz** (5 questions with scoring)
4. **World Clock** (shows time in different cities)

**Share your creation**: Tweet with #ClaudeCode and tag @learntouseai

---

**Happy Coding!** 💻✨

[← Back to README](./README.md)
