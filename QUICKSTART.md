# 🚀 Quick Start Guide - Claude Code

Guía rápida para empezar con Claude Code en 10 minutos.

## ⚡ Instalación Rápida (5 minutos)

### Paso 1: Verificar Prerequisitos

```bash
# Node.js 16+
node --version

# npm
npm --version
```

Si no tienes Node.js: [Descargar aquí](https://nodejs.org/)

### Paso 2: Instalar Claude Code CLI

```bash
npm install -g @anthropic-ai/claude-code
```

### Paso 3: Instalar Extensión de VS Code

```bash
# Opción 1: CLI
code --install-extension anthropic.claude-code

# Opción 2: VS Code Extensions
# Buscar "Claude Code" en Extensions (Ctrl+Shift+X)
```

### Paso 4: Autenticación

```bash
# Opción A: API Key (recomendado para desarrollo)
export ANTHROPIC_API_KEY="sk-ant-xxxxx"

# Agregar a tu shell profile (~/.zshrc o ~/.bashrc)
echo 'export ANTHROPIC_API_KEY="sk-ant-xxxxx"' >> ~/.zshrc

# Opción B: Claude Pro/Max (login interactivo)
claude  # Te pedirá login en primera ejecución
```

### Paso 5: Verificar

```bash
claude --version
```

✅ Si ves la versión, ¡estás listo!

## 🎯 Primer Uso (5 minutos)

### 1. Navega a tu Proyecto

```bash
cd tu-proyecto
```

### 2. Inicia Claude

```bash
claude
```

Verás algo como:
```
> Welcome to Claude Code
> Type /help for available commands
>
```

### 3. Prueba Comandos Básicos

```bash
# Ver ayuda
/help

# Ver contexto actual
/context

# Conectar con VS Code
/ide

# Listar archivos
/ls
```

### 4. Haz tu Primera Pregunta

```bash
> Explain the structure of this project
```

Claude analizará tu proyecto y te dará un resumen.

### 5. Haz tu Primer Cambio

```bash
> Create a simple README.md with project description
```

Claude creará el archivo y te mostrará el diff.

## 📁 Setup de Proyecto (Opcional pero Recomendado)

### Usar Script de Setup Automático

```bash
# Descargar y ejecutar
curl -sSL https://raw.githubusercontent.com/tu-usuario/claude-code-advanced-guide/main/scripts/setup.sh | bash

# O si clonaste el repo
cd claude-code-advanced-guide
./scripts/setup.sh
```

El script te guiará para:
- ✅ Crear estructura `.claude/`
- ✅ Configurar `settings.json`
- ✅ Crear agentes básicos
- ✅ Generar `CLAUDE.md`

### Setup Manual (3 minutos)

```bash
# 1. Crear estructura
mkdir -p .claude/{agents,commands,hooks}

# 2. Crear settings.json
cat > .claude/settings.json << 'EOF'
{
  "allowedTools": ["Read", "Write", "Edit", "Bash", "Grep", "Glob"],
  "autoApproveTools": ["Read", "Grep", "Glob"],
  "model": "claude-sonnet-4-5-20250929"
}
EOF

# 3. Crear CLAUDE.md básico
cat > CLAUDE.md << 'EOF'
# Mi Proyecto

## Stack Tecnológico
- [Tu stack aquí]

## Estructura
[Estructura de tu proyecto]

## Convenciones
[Tus convenciones de código]
EOF

# 4. Verificar
ls -la .claude/
```

## 🤖 Crear tu Primer Agente (2 minutos)

```bash
cat > .claude/agents/code-reviewer.md << 'EOF'
---
name: code-reviewer
description: Expert code reviewer for quality and security checks
tools: Read, Grep, Glob
model: sonnet
---

You are a senior software engineer specializing in code review.

Review checklist:
1. Code quality and readability
2. Potential bugs
3. Security issues
4. Performance concerns
5. Test coverage

Provide specific, actionable feedback.
EOF
```

Ahora puedes usar:
```bash
> Use the code-reviewer agent to review my latest changes
```

## 💡 Casos de Uso Comunes

### 1. Análisis de Proyecto

```bash
> Analyze the architecture of this project and suggest improvements
```

### 2. Generar Código

```bash
> Create a new API endpoint for user registration with validation
```

### 3. Refactoring

```bash
> Refactor the UserService class to follow SOLID principles
```

### 4. Testing

```bash
> Generate unit tests for the calculateTotal function
```

### 5. Debugging

```bash
> This function is throwing an error. Can you debug it?
[Paste función o indicar archivo]
```

### 6. Documentación

```bash
> Generate API documentation for all endpoints in routes/users.ts
```

## 🎨 Personalizar Claude Code

### Cambiar Modelo

```bash
# En la sesión de Claude
/model claude-opus-4-1-20250805

# O en settings.json
{
  "model": "claude-opus-4-1-20250805"
}
```

### Auto-aprobar Herramientas

```json
// .claude/settings.json
{
  "autoApproveTools": [
    "Read",
    "Grep",
    "Glob",
    "Bash(npm test:*)",
    "Bash(npm run build:*)"
  ]
}
```

Esto permite que Claude ejecute automáticamente comandos de lectura y tests.

### Agregar Contexto Adicional

```bash
# En la sesión
/add-dir /path/to/other/relevant/code
```

## 📚 Comandos Esenciales

| Comando | Descripción |
|---------|-------------|
| `/help` | Mostrar ayuda |
| `/context` | Ver archivos en contexto |
| `/ide` | Conectar con VS Code |
| `/agents` | Listar agentes disponibles |
| `/model [name]` | Cambiar modelo |
| `/clear` | Limpiar conversación |
| `/exit` | Salir |

## 🔑 Atajos de Teclado

| Atajo | Acción |
|-------|--------|
| `Cmd/Ctrl + Esc` | Abrir/cerrar Claude Code |
| `Shift + Tab` (2x) | Plan Mode (analizar sin ejecutar) |
| `Ctrl + C` | Cancelar operación actual |

## 🎯 Plan Mode (Muy Útil!)

Plan Mode te permite revisar lo que Claude hará ANTES de que lo haga.

**Activar**: Presiona `Shift + Tab` dos veces

```bash
> Refactor this entire codebase to use TypeScript

# Claude te mostrará:
# 1. Plan de acción detallado
# 2. Archivos que modificará
# 3. Pasos que seguirá

# Puedes:
# - Aprobar el plan
# - Modificar el plan
# - Rechazar el plan
```

## 🚨 Troubleshooting Rápido

### Claude no se conecta a VS Code

```bash
# Verificar que 'code' está en PATH
which code

# Si no está, agregarlo
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
```

### Error de permisos en macOS

```bash
# Otorgar permisos cuando se solicite
# O reiniciar permisos:
tccutil reset SystemPolicyAllFiles
```

### Claude no encuentra archivos

```bash
# Verificar directorio actual
pwd

# Listar archivos que Claude ve
/context
```

### API Key no funciona

```bash
# Verificar que está seteada
echo $ANTHROPIC_API_KEY

# Debe mostrar tu key
# Si no, volver a exportar:
export ANTHROPIC_API_KEY="sk-ant-xxxxx"
```

## 📖 Siguiente Nivel

Ahora que tienes lo básico:

1. **Lee la [Guía de Configuración Avanzada](docs/02-configuration.md)**
   - Personalizar settings
   - Crear CLAUDE.md detallado
   - Configurar MCP servers

2. **Explora [Agentes Especializados](docs/03-agents.md)**
   - Crear agentes custom
   - Biblioteca de agentes útiles
   - Orquestación de agentes

3. **Ve [Ejemplos Prácticos](examples/)**
   - Healthcare AI
   - Financial Analyzer
   - Code Reviewer Avanzado

## 💡 Tips para Productividad

### 1. Usa Plan Mode para Cambios Grandes

Antes de refactorings grandes, activa Plan Mode para revisar el plan.

### 2. Crea Agentes Especializados

En vez de explicar lo mismo cada vez, crea agentes con ese conocimiento.

### 3. Mantén CLAUDE.md Actualizado

Cada vez que establezcas una convención nueva, agrégala a CLAUDE.md

### 4. Aprovecha Auto-aprobar

Para operaciones seguras (lectura, tests), auto-apruébalas para mayor velocidad.

### 5. Usa Comandos Personalizados

Para tareas repetitivas, crea comandos en `.claude/commands/`

## 🎓 Recursos Adicionales

- **Documentación Completa**: [README.md](README.md)
- **Configuración Avanzada**: [docs/02-configuration.md](docs/02-configuration.md)
- **Agentes**: [docs/03-agents.md](docs/03-agents.md)
- **Ejemplos**: [examples/](examples/)
- **Discord**: [Claude Community](https://discord.gg/claude)

## ❓ FAQ Rápido

**P: ¿Cuánto cuesta Claude Code?**
R: Requiere suscripción Claude Pro/Max O API key (pago por uso).

**P: ¿Funciona offline?**
R: No, requiere conexión a internet.

**P: ¿Qué lenguajes soporta?**
R: Todos los principales (JavaScript, TypeScript, Python, Go, Rust, etc.)

**P: ¿Puede modificar mi código sin permiso?**
R: Solo si lo auto-apruebas en settings. Por defecto, pide confirmación.

**P: ¿Mis datos son privados?**
R: Ver [Privacy Policy de Anthropic](https://www.anthropic.com/privacy)

**P: ¿Puedo usar en proyectos comerciales?**
R: Sí, sujeto a términos de servicio de Anthropic.

## 🆘 Obtener Ayuda

- 📝 [GitHub Issues](https://github.com/anthropics/claude-code/issues)
- 💬 [GitHub Discussions](https://github.com/anthropics/claude-code/discussions)
- 🎮 [Discord Community](https://discord.gg/claude)
- 📧 [Anthropic Support](https://support.anthropic.com/)

---

¡Feliz coding con Claude! 🚀

**Próximo paso recomendado**: Lee [Configuración Avanzada](docs/02-configuration.md) para personalizar Claude Code a tu workflow.
