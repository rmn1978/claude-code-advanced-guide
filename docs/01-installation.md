# Instalación y Configuración Inicial

Guía completa para instalar y configurar Claude Code en tu entorno de desarrollo.

## Tabla de Contenidos

- [Requisitos Previos](#requisitos-previos)
- [Instalación](#instalación)
- [Configuración de Autenticación](#configuración-de-autenticación)
- [Integración con VS Code](#integración-con-vs-code)
- [Verificación del Entorno](#verificación-del-entorno)
- [Solución de Problemas Comunes](#solución-de-problemas-comunes)

---

## Requisitos Previos

Antes de instalar Claude Code, asegúrate de tener:

### Software Requerido

- **Visual Studio Code** v1.85.0 o superior
- **Node.js** v18.0.0 o superior
- **npm** v9.0.0 o superior
- **Git** (opcional, pero recomendado)

### Verificar Versiones

```bash
# Verificar Node.js
node --version
# Debe mostrar: v18.0.0 o superior

# Verificar npm
npm --version
# Debe mostrar: v9.0.0 o superior

# Verificar VS Code
code --version
# Debe mostrar: 1.85.0 o superior

# Verificar Git (opcional)
git --version
```

### API Key de Anthropic

Necesitarás una API key de Anthropic. Si no la tienes:

1. Ve a: https://console.anthropic.com/
2. Crea una cuenta o inicia sesión
3. Ve a **"API Keys"** en el menú
4. Haz clic en **"Create Key"**
5. Copia tu API key (empieza con `sk-ant-`)

⚠️ **Importante**: Guarda tu API key en un lugar seguro. No la compartas ni la subas a GitHub.

---

## Instalación

### Opción 1: Extensión de VS Code (Recomendado)

#### Paso 1: Instalar desde VS Code

1. Abre Visual Studio Code
2. Haz clic en el icono de **Extensions** (o presiona `Cmd/Ctrl + Shift + X`)
3. Busca: **"Claude Code"**
4. Haz clic en **"Install"** en la extensión de Anthropic
5. Espera a que se complete la instalación

#### Paso 2: Verificar Instalación

Después de instalar, deberías ver:
- Un ícono de Claude en la barra lateral izquierda
- Un nuevo panel llamado "Claude Code"

### Opción 2: CLI (Línea de Comandos)

```bash
# Instalar la extensión desde la terminal
code --install-extension anthropic.claude-code

# Verificar que se instaló
code --list-extensions | grep claude
```

### Opción 3: Descarga Manual

1. Ve a: https://marketplace.visualstudio.com/items?itemName=anthropic.claude-code
2. Haz clic en **"Download Extension"**
3. En VS Code, ve a Extensions → **"..."** (menú) → **"Install from VSIX..."**
4. Selecciona el archivo `.vsix` descargado

---

## Configuración de Autenticación

### Método 1: Variable de Entorno (Recomendado)

#### En macOS/Linux:

```bash
# Añadir a ~/.zshrc o ~/.bashrc
export ANTHROPIC_API_KEY="sk-ant-xxxxx"

# Recargar el archivo
source ~/.zshrc  # o source ~/.bashrc
```

#### En Windows (PowerShell):

```powershell
# Temporal (solo para la sesión actual)
$env:ANTHROPIC_API_KEY="sk-ant-xxxxx"

# Permanente (requiere admin)
[System.Environment]::SetEnvironmentVariable('ANTHROPIC_API_KEY', 'sk-ant-xxxxx', 'User')
```

#### En Windows (CMD):

```cmd
setx ANTHROPIC_API_KEY "sk-ant-xxxxx"
```

### Método 2: Archivo de Configuración

Crea un archivo `.env` en la raíz de tu proyecto:

```bash
# .env
ANTHROPIC_API_KEY=sk-ant-xxxxx
```

⚠️ **Importante**: Añade `.env` a tu `.gitignore`:

```bash
echo ".env" >> .gitignore
```

### Método 3: VS Code Settings

1. Abre VS Code Settings (`Cmd/Ctrl + ,`)
2. Busca: **"Claude Code"**
3. Encuentra: **"Anthropic: API Key"**
4. Pega tu API key

⚠️ **Nota**: Este método guarda la key en settings de VS Code (menos seguro).

### Verificar Autenticación

```bash
# En la terminal de VS Code
echo $ANTHROPIC_API_KEY  # macOS/Linux
echo %ANTHROPIC_API_KEY%  # Windows
```

Debería mostrar tu API key (empezando con `sk-ant-`).

---

## Integración con VS Code

### Configuración Inicial

1. **Abrir Claude Code**
   - Haz clic en el ícono de Claude en la barra lateral
   - O presiona `Cmd/Ctrl + Shift + P` → busca "Claude Code: Open"

2. **Primera Conexión**
   - Claude Code detectará automáticamente tu API key
   - Verás un mensaje: "✅ Conectado correctamente"

3. **Seleccionar Modelo**
   - Por defecto usa: `claude-sonnet-4.5`
   - Para cambiarlo: Settings → Claude Code → Model

### Configuración Básica (settings.json)

Abre VS Code settings (`Cmd/Ctrl + ,`) y añade:

```json
{
  "claude-code.model": "claude-sonnet-4.5",
  "claude-code.temperature": 0.7,
  "claude-code.maxTokens": 8192,
  "claude-code.allowedTools": [
    "Read",
    "Write",
    "Edit",
    "Bash",
    "Glob",
    "Grep"
  ]
}
```

### Atajos de Teclado Útiles

- **Abrir Claude Code**: `Cmd/Ctrl + Shift + C`
- **Nueva conversación**: `Cmd/Ctrl + N` (dentro de Claude Code)
- **Buscar comandos**: `Cmd/Ctrl + Shift + P`

---

## Verificación del Entorno

### Test Rápido

1. Abre Claude Code en VS Code
2. Escribe en el chat:

```
> Test my setup. Can you read files in this directory?
```

3. Claude debería responder listando los archivos del directorio actual.

### Test de Herramientas

Prueba cada herramienta:

```
> Run this command: echo "Claude Code works!"
```

```
> Create a file called test.txt with content "Hello from Claude Code"
```

```
> Read the test.txt file you just created
```

```
> Delete the test.txt file
```

Si todas estas operaciones funcionan, ¡tu instalación está completa! ✅

### Checklist de Verificación

- [ ] VS Code instalado (v1.85+)
- [ ] Node.js instalado (v18+)
- [ ] Extensión Claude Code instalada
- [ ] API key configurada
- [ ] Claude Code se abre correctamente
- [ ] Puede leer archivos del proyecto
- [ ] Puede crear/editar archivos
- [ ] Puede ejecutar comandos bash
- [ ] No muestra errores de autenticación

---

## Configuración de Proyecto

### Crear `.claude/` en tu Proyecto

```bash
# Crear estructura básica
mkdir -p .claude/agents
touch .claude/CLAUDE.md
```

### Archivo `.claude/CLAUDE.md` Básico

```markdown
# [Nombre del Proyecto]

## Descripción
Breve descripción del proyecto.

## Stack Tecnológico
- Frontend: [e.g., Next.js, React]
- Backend: [e.g., FastAPI, Django]
- Base de datos: [e.g., PostgreSQL]

## Estructura
\`\`\`
proyecto/
├── src/
├── tests/
└── docs/
\`\`\`

## Comandos Importantes
\`\`\`bash
npm run dev
npm test
\`\`\`
```

### Configurar `.gitignore`

```bash
# Añadir a .gitignore
echo ".env" >> .gitignore
echo ".claude/cache/" >> .gitignore
```

---

## Configuración Avanzada

### Múltiples API Keys (Proyectos Diferentes)

Crea un archivo `.claude/config.json` en cada proyecto:

```json
{
  "apiKey": "sk-ant-project-specific-key",
  "model": "claude-sonnet-4.5",
  "temperature": 0.7
}
```

### Workspace Settings (Equipo)

Crea `.vscode/settings.json` en tu proyecto:

```json
{
  "claude-code.model": "claude-sonnet-4.5",
  "claude-code.allowedTools": ["Read", "Write", "Edit", "Bash"],
  "claude-code.maxTokens": 8192
}
```

Esto asegura que todo el equipo use la misma configuración.

---

## Solución de Problemas Comunes

### Error: "API key not found"

**Causa**: La API key no está configurada correctamente.

**Solución**:
```bash
# Verificar variable de entorno
echo $ANTHROPIC_API_KEY

# Si no aparece, configurarla:
export ANTHROPIC_API_KEY="sk-ant-xxxxx"
```

### Error: "Extension not loading"

**Causa**: VS Code no reconoce la extensión.

**Solución**:
1. Reinicia VS Code completamente
2. Desinstala y reinstala la extensión
3. Verifica que VS Code esté actualizado

### Error: "Permission denied" en comandos Bash

**Causa**: Permisos insuficientes.

**Solución**:
```bash
# En macOS/Linux, dar permisos de ejecución
chmod +x nombre-del-script.sh
```

### Claude Code es muy lento

**Causa**: Modelo muy grande o proyecto con muchos archivos.

**Solución**:
1. Usa un modelo más rápido: `claude-haiku-3.5`
2. Reduce `maxTokens` en settings
3. Añade carpetas grandes a `.claudeignore`

### No puede leer archivos

**Causa**: Herramienta "Read" no está permitida.

**Solución**:
Verifica en settings que `"Read"` esté en `allowedTools`:

```json
{
  "claude-code.allowedTools": ["Read", "Write", "Edit", "Bash", "Glob", "Grep"]
}
```

---

## Próximos Pasos

Ahora que tienes Claude Code instalado:

1. **[Configuración Avanzada](./02-configuration.md)** - Personaliza Claude Code
2. **[Agentes Especializados](./03-agents.md)** - Usa agentes por stack
3. **[Ejemplos Prácticos](../examples/README.md)** - Construye proyectos reales

---

## Recursos Adicionales

- **Documentación Oficial**: https://docs.claude.com/claude-code
- **API Reference**: https://docs.anthropic.com/
- **GitHub Repo**: https://github.com/rmn1978/claude-code-advanced-guide
- **Issues/Support**: https://github.com/rmn1978/claude-code-advanced-guide/issues

---

**¿Problemas con la instalación?** Abre un issue: https://github.com/rmn1978/claude-code-advanced-guide/issues/new/choose
