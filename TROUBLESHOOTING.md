# 🔧 Troubleshooting Guide

Soluciones rápidas a problemas comunes con Claude Code.

## 📋 Índice

- [Problemas de Instalación](#problemas-de-instalación)
- [Problemas de Configuración](#problemas-de-configuración)
- [Problemas con Agentes](#problemas-con-agentes)
- [Problemas de Rendimiento](#problemas-de-rendimiento)
- [Problemas con Ejemplos](#problemas-con-ejemplos)

---

## 🚨 Problemas de Instalación

### Error: "Cannot find module '@anthropic-ai/claude-code'"

**Síntomas**: Claude Code no se instala correctamente

**Solución**:
```bash
# Limpiar cache de npm
npm cache clean --force

# Reinstalar globalmente
npm uninstall -g @anthropic-ai/claude-code
npm install -g @anthropic-ai/claude-code

# Verificar instalación
claude --version
```

---

### Error: "ANTHROPIC_API_KEY not set"

**Síntomas**: Claude Code no encuentra tu API key

**Solución**:
```bash
# Opción 1: Export temporal
export ANTHROPIC_API_KEY="sk-ant-xxxxx"

# Opción 2: Agregar a .bashrc/.zshrc (permanente)
echo 'export ANTHROPIC_API_KEY="sk-ant-xxxxx"' >> ~/.zshrc
source ~/.zshrc

# Verificar
echo $ANTHROPIC_API_KEY
```

---

### VS Code Extension no se conecta

**Síntomas**: La extensión está instalada pero no funciona

**Solución**:
1. Verificar extensión instalada: `Cmd+Shift+X` → buscar "Claude Code"
2. Reload VS Code: `Cmd+Shift+P` → "Developer: Reload Window"
3. Verificar configuración: `Cmd+,` → buscar "Claude"
4. Reiniciar VS Code completamente

---

## ⚙️ Problemas de Configuración

### Agente no encuentra herramientas

**Síntomas**: Agent says "I don't have access to [tool]"

**Solución**:
```json
// .claude/settings.json
{
  "allowedTools": [
    "Read",
    "Write",
    "Edit",
    "Bash",
    "Grep",
    "Glob"
  ]
}
```

Restart Claude Code después de cambiar settings.

---

### Comandos Bash bloqueados

**Síntomas**: "Bash command not allowed"

**Solución**:
```json
// .claude/settings.json
{
  "bashAllowList": [
    "git*",
    "npm*",
    "node*",
    "python*",
    "docker*"
  ]
}
```

O permitir específicamente:
```json
{
  "bashAllowList": ["git status", "npm install", "npm run dev"]
}
```

---

### CLAUDE.md no se detecta

**Síntomas**: Claude no recuerda contexto del proyecto

**Solución**:
1. Verificar ubicación: Debe estar en `.claude/CLAUDE.md`
2. Verificar formato: Debe ser Markdown válido
3. Recargar proyecto: Cerrar y reabrir carpeta en VS Code
4. Verificar size: Max 10KB (comprimir si es muy grande)

---

## 🤖 Problemas con Agentes

### Agente no se activa

**Síntomas**: Agente en `.claude/agents/` pero no disponible

**Solución**:
1. Verificar frontmatter:
```markdown
---
name: my-agent
description: My agent description
tools: Read, Write, Edit
model: sonnet
---
```

2. Verificar ubicación: `.claude/agents/agent-name.md`
3. Reload: `Cmd+Shift+P` → "Developer: Reload Window"

---

### Agente da respuestas genéricas

**Síntomas**: Agente no sigue sus instrucciones específicas

**Solución**:
1. Hacer las instrucciones más específicas
2. Agregar ejemplos concretos
3. Usar frases imperativas: "Always...", "Never..."
4. Aumentar prioridad: `priority: high`

**Antes**:
```markdown
You help with code.
```

**Después**:
```markdown
You are a TypeScript expert. Always:
1. Use strict type checking
2. Prefer interfaces over types
3. Include JSDoc comments
4. Never use `any` type
```

---

### Multiple agentes en conflicto

**Síntomas**: Agentes dan consejos contradictorios

**Solución**:
1. Usar agentes específicos con `> Use [agent-name] to...`
2. Set different priorities
3. Separar responsabilidades claramente

```markdown
# nextjs-architect
priority: high
description: Use for Next.js architecture decisions

# code-reviewer
priority: medium
description: Use for reviewing existing code only
```

---

## ⚡ Problemas de Rendimiento

### Claude Code muy lento

**Síntomas**: Respuestas toman >30 segundos

**Solución**:
1. Usar modelo más rápido:
```json
{
  "defaultModel": "haiku"  // Más rápido que sonnet/opus
}
```

2. Reducir contexto:
```json
{
  "maxContextFiles": 10  // Limitar archivos en contexto
}
```

3. Cerrar archivos no necesarios en VS Code

---

### Timeout en operaciones largas

**Síntomas**: "Operation timed out"

**Solución**:
```json
{
  "timeout": 120000  // 2 minutos (en ms)
}
```

O dividir en tareas más pequeñas:
```bash
# ❌ No: Una tarea gigante
> Create entire e-commerce platform

# ✅ Sí: Tareas incrementales
> Create product model
> Create product API endpoints
> Create product list component
```

---

### Rate limit exceeded

**Síntomas**: "Rate limit exceeded. Try again later"

**Solución**:
1. Esperar 1 minuto
2. Usar modelo más económico (haiku vs opus)
3. Reducir frecuencia de requests
4. Verificar tu plan en Anthropic console

---

## 💻 Problemas con Ejemplos

### Ejemplo no funciona después de seguir README

**Síntomas**: Error al ejecutar ejemplo

**Pasos de diagnóstico**:
1. Verificar versiones:
```bash
node --version  # Debe ser 18+
python --version  # Debe ser 3.11+
```

2. Verificar dependencias instaladas:
```bash
npm install  # o pip install -r requirements.txt
```

3. Verificar variables de entorno:
```bash
# Copiar .env.example
cp .env.example .env

# Editar con tus valores
nano .env
```

4. Verificar base de datos corriendo:
```bash
# PostgreSQL
psql -U postgres -c "SELECT version();"

# Redis
redis-cli ping
```

---

### Database migration fails

**Síntomas**: Error al correr migraciones

**Django**:
```bash
# Reset migraciones
python manage.py migrate --fake-initial

# O reset completo
python manage.py flush
python manage.py migrate
```

**Alembic**:
```bash
# Downgrade y upgrade
alembic downgrade base
alembic upgrade head

# O generar nueva migración
alembic revision --autogenerate -m "reset"
```

**Prisma**:
```bash
# Reset database
npx prisma migrate reset

# Push schema sin migración
npx prisma db push
```

---

### Build fails con TypeScript errors

**Síntomas**: `npm run build` falla con type errors

**Solución**:
```bash
# Regenerar types
npm run generate  # Si usas Prisma/tRPC

# Limpiar cache
rm -rf .next
rm -rf node_modules/.cache

# Reinstalar
npm install

# Build de nuevo
npm run build
```

Si persiste, verificar `tsconfig.json`:
```json
{
  "compilerOptions": {
    "strict": true,
    "skipLibCheck": true  // Temporal para debug
  }
}
```

---

### Port already in use

**Síntomas**: "Port 3000 is already in use"

**Solución**:
```bash
# Encontrar proceso
lsof -i :3000

# Matar proceso
kill -9 [PID]

# O usar puerto diferente
PORT=3001 npm run dev
```

---

## 🔍 Debugging Tips

### Verificar qué herramientas tiene Claude

```bash
> List all tools you have access to
```

### Ver configuración actual

```bash
> Show me the current settings.json configuration
```

### Test de agente

```bash
> Use [agent-name] to explain your core responsibilities
```

### Verificar memoria del proyecto

```bash
> Summarize what you know about this project from CLAUDE.md
```

---

## 🆘 Aún necesitas ayuda?

### 1. Revisar documentación oficial
- [Claude Code Docs](https://docs.claude.com/claude-code)
- [Anthropic Support](https://support.anthropic.com)

### 2. Buscar en Issues
- [GitHub Issues](https://github.com/anthropics/claude-code/issues)
- Busca tu error específico

### 3. Preguntar en comunidad
- Reddit: [r/ClaudeAI](https://reddit.com/r/ClaudeAI)
- Discord: Claude AI Community

### 4. Abrir Issue en este repo
- Describe el problema
- Incluye logs/screenshots
- Menciona tu entorno (OS, versions)

---

## 📊 Checklist de Diagnóstico

Antes de reportar un bug, verifica:

- [ ] Versión más reciente de Claude Code
- [ ] API key válida y configurada
- [ ] VS Code actualizado
- [ ] Node.js 18+
- [ ] Settings.json correcto
- [ ] CLAUDE.md en ubicación correcta
- [ ] Extensión de VS Code habilitada
- [ ] Internet connection estable
- [ ] Sin errores en VS Code console (`Cmd+Shift+U`)

---

**La mayoría de problemas se resuelven con**:
1. Restart VS Code
2. Verificar settings.json
3. Reinstalar dependencias

**¡No te desesperes! La comunidad está aquí para ayudar.** 🤝

---

**Última actualización**: 2025-01-15
**Versión**: 1.0
