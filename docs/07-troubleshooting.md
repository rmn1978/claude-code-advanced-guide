# Troubleshooting - Solución de Problemas

Guía de solución de problemas comunes con Claude Code.

## Problemas de Autenticación

### Error: "API key not found"

**Síntomas**: Claude Code no inicia, error de API key.

**Soluciones**:

```bash
# 1. Verificar variable de entorno
echo $ANTHROPIC_API_KEY  # macOS/Linux
echo %ANTHROPIC_API_KEY%  # Windows

# 2. Configurar si no existe
export ANTHROPIC_API_KEY="sk-ant-xxxxx"  # macOS/Linux

# 3. Reiniciar VS Code
# Cmd/Ctrl + Q → Reabrir VS Code
```

### Error: "Invalid API key"

**Causa**: API key incorrecta o expirada.

**Solución**:
1. Ve a: https://console.anthropic.com/
2. Verifica que tu API key sea válida
3. Genera una nueva key si es necesario
4. Actualiza la variable de entorno

## Problemas de Rendimiento

### Claude Code es muy lento

**Causas y Soluciones**:

```json
// 1. Usar modelo más rápido
{
  "claude-code.model": "claude-haiku-3.5"  // Más rápido
}

// 2. Reducir tokens máximos
{
  "claude-code.maxTokens": 4096  // Reducir de 8192
}

// 3. Crear .claudeignore
// Excluir carpetas grandes
```

```bash
# .claudeignore
node_modules/
.next/
dist/
build/
coverage/
*.log
```

### Timeout en respuestas largas

**Solución**:

```json
{
  "claude-code.timeout": 120000  // 2 minutos (en ms)
}
```

## Problemas con Herramientas

### Error: "Permission denied" en Bash

**Causa**: Permisos insuficientes.

**Solución**:

```bash
# macOS/Linux: Dar permisos de ejecución
chmod +x script.sh

# Si persiste, verificar allowedTools
```

```json
{
  "claude-code.allowedTools": ["Read", "Write", "Edit", "Bash", "Glob", "Grep"]
}
```

### No puede leer/escribir archivos

**Solución**:

```json
{
  "claude-code.allowedTools": [
    "Read",    // ← Asegurar que estén habilitados
    "Write",
    "Edit"
  ]
}
```

### Error: "Tool not allowed"

**Causa**: Herramienta no está en `allowedTools`.

**Solución**: Añadir a settings.json:

```json
{
  "claude-code.allowedTools": [
    "Read",
    "Write",
    "Edit",
    "Bash",
    "Glob",
    "Grep",
    "WebSearch",  // Si usas búsqueda web
    "WebFetch"    // Si usas fetch de URLs
  ]
}
```

## Problemas de Conexión

### Error: "Failed to connect to Claude API"

**Soluciones**:

```bash
# 1. Verificar conexión a internet
ping anthropic.com

# 2. Verificar firewall/proxy
# Asegurar que VS Code puede acceder a:
# - api.anthropic.com
# - console.anthropic.com

# 3. Verificar configuración de proxy
```

```json
// Si usas proxy corporativo
{
  "http.proxy": "http://proxy.company.com:8080",
  "http.proxyStrictSSL": false
}
```

## Problemas con Extensión

### Extensión no aparece en VS Code

**Soluciones**:

```bash
# 1. Verificar instalación
code --list-extensions | grep claude

# 2. Reinstalar
code --uninstall-extension anthropic.claude-code
code --install-extension anthropic.claude-code

# 3. Reiniciar VS Code completamente
# Cerrar TODAS las ventanas y reabrir
```

### Extensión instalada pero no funciona

**Soluciones**:

1. **Verificar versión de VS Code**:
   - Requiere v1.85.0 o superior
   - Help → About → Versión

2. **Limpiar caché**:
   ```bash
   # macOS/Linux
   rm -rf ~/.vscode/extensions/anthropic.claude-code-*

   # Windows
   # Eliminar: %USERPROFILE%\.vscode\extensions\anthropic.claude-code-*
   ```

3. **Reinstalar desde cero**

## Problemas con Agentes

### Agente no encuentra archivos del proyecto

**Causa**: Ruta incorrecta en el agente.

**Solución**: En `.claude/agents/my-agent.md`:

```markdown
# Verificar que la ruta sea correcta
> Read src/api/users.py

# Si no funciona, usar ruta absoluta
> Read /ruta/completa/al/proyecto/src/api/users.py
```

### Error: "Agent not found"

**Causa**: Nombre de agente incorrecto.

**Solución**:

```bash
# Listar agentes disponibles
ls -la .claude/agents/

# Usar nombre exacto del archivo (sin .md)
> Use nextjs-architect to...
```

## Problemas con MCP Servers

### MCP Server no conecta

**Soluciones**:

```bash
# 1. Verificar que el MCP esté instalado
npm list -g | grep mcp

# 2. Verificar mcp.json
cat .claude/mcp.json

# 3. Verificar logs
# Ver Output panel → Claude Code MCP
```

### Error: "MCP command not found"

**Solución**:

```bash
# Instalar el MCP globalmente
npm install -g @modelcontextprotocol/server-filesystem

# O usar npx en mcp.json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "${workspaceFolder}"]
    }
  }
}
```

## Problemas Comunes de Código

### "Module not found" después de que Claude creó código

**Causa**: Dependencias no instaladas.

**Solución**:

```bash
# Node.js
npm install

# Python
pip install -r requirements.txt

# Siempre pedir a Claude que genere package.json/requirements.txt
```

### Código generado no funciona

**Mejores prácticas**:

```
✅ BUENO:
> After creating the code, run it and fix any errors

✅ BUENO:
> Add error handling and validation to this code

✅ BUENO:
> Test this code with example inputs
```

## Logs y Debugging

### Ver logs de Claude Code

1. **VS Code Output Panel**:
   - View → Output
   - Seleccionar: "Claude Code" en el dropdown

2. **Developer Tools**:
   - Help → Toggle Developer Tools
   - Ver Console tab

### Nivel de logging

```json
{
  "claude-code.logLevel": "debug"  // info, debug, error
}
```

## Obtener Ayuda

### Antes de Reportar un Issue

1. ✅ Verificar que tienes la última versión de VS Code
2. ✅ Verificar que tienes la última versión de Claude Code
3. ✅ Intentar las soluciones de esta guía
4. ✅ Revisar [Issues existentes](https://github.com/rmn1978/claude-code-advanced-guide/issues)

### Reportar un Issue

Incluye:
- Sistema operativo y versión
- Versión de VS Code
- Versión de Claude Code
- Pasos para reproducir el error
- Logs/screenshots del error
- Archivo de configuración (sin API keys!)

**[Reportar Issue →](https://github.com/rmn1978/claude-code-advanced-guide/issues/new/choose)**

## FAQ - Preguntas Frecuentes

### ¿Claude Code funciona offline?

No, requiere conexión a internet para comunicarse con la API de Anthropic.

### ¿Cuánto cuesta usar Claude Code?

Claude Code es gratuito. Pagas solo por el uso de la API de Anthropic según tu plan.

### ¿Puedo usar Claude Code en proyectos privados?

Sí, Claude Code funciona con cualquier proyecto. Tus archivos no se comparten sin tu permiso.

### ¿Funciona con otros editores además de VS Code?

Actualmente solo VS Code está soportado oficialmente.

## Recursos Adicionales

- **[Instalación](./01-installation.md)** - Guía de instalación
- **[Best Practices](./06-best-practices.md)** - Mejores prácticas
- **GitHub Issues**: https://github.com/rmn1978/claude-code-advanced-guide/issues

---

**¿No encuentras la solución?** [Abre un issue](https://github.com/rmn1978/claude-code-advanced-guide/issues/new/choose) y te ayudaremos.

---

[← Volver a Documentación](./README.md)
