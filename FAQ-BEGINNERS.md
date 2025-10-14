# ❓ FAQ para Principiantes - Claude Code

Preguntas frecuentes de personas que están empezando con Claude Code.

---

## 🤔 Preguntas Básicas

### ¿Qué es Claude Code exactamente?

**Respuesta simple**: Es un asistente de IA que vive dentro de VS Code y te ayuda a programar.

**Más detalles**:
- Puedes pedirle que escriba código
- Puedes pedirle que explique código
- Puedes pedirle que arregle errores
- Puedes pedirle que cree apps completas

**Diferencia con ChatGPT/Copilot**:
- ChatGPT: Solo texto, sin acceso a tus archivos
- Copilot: Auto-completado inteligente
- **Claude Code**: Puede VER tus archivos, ESCRIBIR código, EJECUTAR comandos

---

### ¿Necesito saber programar para usar Claude Code?

**Respuesta honesta**: Sí, al menos lo básico.

**Nivel mínimo recomendado**:
- ✅ Sabes qué es una variable
- ✅ Sabes qué es una función
- ✅ Sabes usar la terminal básica (`cd`, `ls`)
- ✅ Sabes qué es Git (aunque sea conceptualmente)

**Si NO sabes nada de programación**:
1. Aprende lo básico primero: [freeCodeCamp](https://www.freecodecamp.org/)
2. Luego vuelve y Claude Code será 10x más útil

**Si ya sabes programar pero en otro lenguaje**:
¡Perfecto! Claude Code te ayudará a aprender nuevos lenguajes rápido.

---

### ¿Cuánto cuesta?

**La extensión de VS Code**: GRATIS

**El uso de la API de Claude**: PAGO por uso

**Precios (Abril 2024)**:
- **Haiku** (rápido): ~$0.25 por cada 1M tokens de entrada
- **Sonnet** (balanceado): ~$3 por cada 1M tokens de entrada
- **Opus** (más potente): ~$15 por cada 1M tokens de entrada

**¿Qué significa en dinero real?**

Para un proyecto pequeño (crear una app simple):
- **Costo típico**: $1-5 USD
- **Proyecto mediano**: $10-30 USD
- **Proyecto grande**: $50-100 USD

**¿Es caro?**

Comparado con contratar a alguien: NO
- Desarrollador freelance: $30-100/hora
- Claude Code: $1-5 para completar el mismo proyecto

**Tip**: Empieza con el modelo `haiku` (más barato) para práctica.

---

### ¿Funciona en Windows / Mac / Linux?

**SÍ**, funciona en los 3 sistemas operativos.

**Requisitos**:
- **Windows**: Windows 10 o superior
- **Mac**: macOS 10.15 o superior
- **Linux**: Cualquier distribución moderna

**Lo único que necesitas**:
- VS Code instalado
- Node.js instalado (v18+)
- Conexión a internet

---

### ¿Puedo usarlo sin la terminal / línea de comandos?

**Respuesta corta**: Técnicamente sí, pero te perderás mucho.

**Respuesta larga**:
Claude Code necesita ejecutar comandos como:
```bash
npm install
git commit
python app.py
```

Si no sabes usar la terminal, te recomiendo:
1. Aprende lo básico de terminal (2-3 horas)
2. Tutorial recomendado: [The Odin Project - Command Line](https://www.theodinproject.com/lessons/foundations-command-line-basics)

**Comandos básicos que SÍ o SÍ necesitas saber**:
```bash
cd carpeta      # Entrar a una carpeta
ls              # Ver archivos
pwd             # Ver dónde estás
```

---

### ¿Reemplaza a un desarrollador?

**NO**, no reemplaza a un desarrollador.

**Lo que SÍ hace**:
- ✅ Acelera el desarrollo 3-10x
- ✅ Te ayuda a aprender más rápido
- ✅ Escribe código repetitivo por ti
- ✅ Te ayuda a debuggear

**Lo que NO hace**:
- ❌ No entiende el contexto de negocio (eso lo decides tú)
- ❌ No toma decisiones de arquitectura complejas
- ❌ No entiende requerimientos vagos
- ❌ A veces comete errores (necesitas revisarlo)

**Analogía**: Es como tener un asistente muy competente, no un reemplazo.

---

### ¿Claude Code aprende de mi código?

**NO**, Claude Code NO aprende de tu código específico.

**Qué significa**:
- Tu código NO se usa para entrenar futuros modelos
- Anthropic NO guarda tu código permanentemente
- Tu código NO se comparte con otros usuarios

**Privacidad**:
- Según la política de Anthropic, tus datos NO se usan para entrenamiento
- Las conversaciones se procesan pero NO se almacenan permanentemente

**Recomendación para empresas**:
- Lee la [Privacy Policy de Anthropic](https://www.anthropic.com/privacy)
- Considera usar una API empresarial si manejas datos super sensibles

---

## 🚀 Empezando

### ¿Por dónde empiezo?

**Ruta recomendada (4-6 horas total)**:

1. **[Instalación](./docs/01-installation.md)** (15 min)
   - Instalar VS Code
   - Instalar Claude Code
   - Configurar API key

2. **[Tutorial de 15 minutos](./TUTORIAL-15MIN.md)** (15 min)
   - Tu primera app "Hello World"
   - Ver a Claude Code en acción

3. **[Glosario](./GLOSSARY.md)** (30 min)
   - Leer términos básicos
   - No necesitas memorizarlos, solo familiarizarte

4. **[Ejemplo: Todo API](./examples/todo-api-fastapi/README.md)** (1-2 horas)
   - Construir tu primera API
   - Paso a paso, muy claro

5. **[Ejemplo: Blog](./examples/blog-nextjs/README.md)** (1-2 horas)
   - Construir tu primer frontend
   - Next.js básico

6. **Practica creando tus propios proyectos**
   - Empieza con ideas simples
   - Itera y mejora

---

### ¿Qué proyecto debería construir primero?

**Para aprender, proyectos simples son mejores:**

**Ideas de primer proyecto (1-2 horas)**:
1. **Lista de Tareas (Todo App)**
   - CRUD básico
   - Sin autenticación
   - Solo localStorage

2. **Conversor de Unidades**
   - Celsius ↔ Fahrenheit
   - Kilómetros ↔ Millas
   - Solo frontend, sin backend

3. **Calculadora**
   - Suma, resta, multiplicación, división
   - Interfaz simple

**Ideas de segundo proyecto (3-5 horas)**:
1. **Blog Personal**
   - SSG con Next.js
   - Posts en Markdown
   - Deploy a Vercel

2. **API de Notas**
   - FastAPI + PostgreSQL
   - CRUD completo
   - Autenticación básica

3. **Pomodoro Timer**
   - React
   - LocalStorage para estadísticas

**NO empieces con**:
- ❌ Red social completa
- ❌ E-commerce con pagos
- ❌ App de trading
- ❌ Clon de Netflix

(Estos son demasiado complejos para empezar)

---

### ¿Cuánto tiempo me toma aprender?

**Depende de tu nivel previo:**

**Si ya sabes programar**:
- Familiarizarte con Claude Code: 1-2 horas
- Construir primer proyecto: 2-4 horas
- Ser productivo: 1 semana
- **Total**: ~1 semana

**Si sabes programar pero en otro stack**:
- Aprender el nuevo stack CON Claude Code: 1-2 semanas
- Ser productivo: 2-3 semanas
- **Total**: ~2-3 semanas

**Si eres COMPLETAMENTE nuevo en programación**:
- Aprender programación básica: 3-6 meses
- Aprender Claude Code: 1-2 semanas
- **Total**: 3-6 meses

**Tip**: No tengas prisa. Aprende bien los fundamentos.

---

## 💻 Problemas Técnicos

### "API key not found" - ¿Qué hago?

**Paso 1**: Verifica que configuraste la API key

```bash
# En la terminal
echo $ANTHROPIC_API_KEY  # Mac/Linux
echo %ANTHROPIC_API_KEY%  # Windows
```

**Si sale vacío**:

**Mac/Linux**:
```bash
# Añadir al archivo ~/.zshrc o ~/.bashrc
export ANTHROPIC_API_KEY="sk-ant-xxxxx"

# Recargar
source ~/.zshrc
```

**Windows (PowerShell)**:
```powershell
$env:ANTHROPIC_API_KEY="sk-ant-xxxxx"
```

**Paso 2**: Reinicia VS Code COMPLETAMENTE

**Más ayuda**: [Troubleshooting](./docs/07-troubleshooting.md#error-api-key-not-found)

---

### Claude Code es muy lento, ¿por qué?

**Causas comunes**:

1. **Modelo muy grande**
   - Solución: Usa `haiku` en lugar de `sonnet` o `opus`
   - Settings → Claude Code → Model → `claude-haiku-3.5`

2. **Proyecto con muchos archivos**
   - Solución: Crea `.claudeignore`
   ```
   node_modules/
   .next/
   dist/
   build/
   ```

3. **Tokens máximos muy altos**
   - Solución: Reduce en settings
   ```json
   {
     "claude-code.maxTokens": 4096  // En lugar de 8192
   }
   ```

4. **Conexión a internet lenta**
   - No hay solución más que mejorar tu internet

---

### ¿Por qué Claude Code no entiende mi prompt?

**Prompts malos vs buenos**:

❌ **Malo**: "Crea una app"
- Demasiado vago

✅ **Bueno**: "Create a todo app with React that allows me to add, edit, and delete tasks"
- Específico y claro

❌ **Malo**: "Arregla esto"
- No dice qué está roto

✅ **Bueno**: "I'm getting this error: [paste error]. Fix it in src/api/users.py"
- Error específico + ubicación

**Tips para buenos prompts**:
1. Se específico
2. Menciona el archivo si es relevante
3. Incluye el stack tecnológico
4. Pega errores completos (con stack trace)

---

### Error: "Permission denied" al ejecutar comandos

**Causa**: Falta permiso de ejecución

**Solución Mac/Linux**:
```bash
chmod +x nombre-del-script.sh
```

**Solución Windows**:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

## 🎓 Aprendizaje

### ¿Debo aprender el stack primero o usar Claude Code de una vez?

**Recomendación**: Aprende lo básico del stack PRIMERO.

**Por qué**:
- Si no entiendes lo básico, no sabrás si el código de Claude es bueno o malo
- No podrás corregir errores
- No entenderás lo que está haciendo

**Aprende primero**:
- Sintaxis básica del lenguaje (JavaScript, Python, etc.)
- Qué hace cada herramienta (React, FastAPI, etc.)
- Conceptos fundamentales (variables, funciones, loops)

**Luego usa Claude Code para**:
- Escribir código repetitivo
- Aprender patrones avanzados
- Acelerar el desarrollo

**Analogía**: No uses un auto de Fórmula 1 si aún no sabes manejar. Aprende a manejar primero.

---

### ¿Puedo confiar en el código que genera Claude?

**Respuesta corta**: Sí, PERO siempre revísalo.

**Claude Code es muy bueno, pero NO es perfecto**:

**Tasa de acierto estimada**:
- Tareas simples: ~95% correcto
- Tareas medias: ~85% correcto
- Tareas complejas: ~70% correcto

**SIEMPRE debes**:
1. ✅ Leer el código que genera
2. ✅ Entender qué hace
3. ✅ Probarlo (ejecutar tests)
4. ✅ Hacer ajustes si es necesario

**Señales de que el código puede estar mal**:
- Tiene TODOs o comentarios "// FIX THIS"
- Usa patrones desactualizados
- No sigue las best practices de seguridad
- Tiene hardcoded credentials

---

### ¿Qué hago si Claude genera código con bugs?

**No te frustres, es normal**:

1. **Descríbele el error**:
   ```
   > This code gives error: [paste error]
   > Fix it
   ```

2. **Si persiste, sé más específico**:
   ```
   > The error is in line 45 of src/api/users.py
   > The function expects a string but receives a number
   > Fix the type mismatch
   ```

3. **Si sigue sin funcionar**:
   - Pídele que explique el código
   - Google el error
   - Pregunta en Stack Overflow
   - Simplifica el problema

---

## 📚 Recursos

### ¿Dónde aprendo más?

**Documentación oficial**:
- [Claude Code Docs](https://docs.claude.com/claude-code)
- [Anthropic API Docs](https://docs.anthropic.com/)

**En este repositorio**:
- **[Tutorial 15 min](./TUTORIAL-15MIN.md)** ← Empieza aquí
- **[Glosario](./GLOSSARY.md)** - Términos explicados
- **[Cheat Sheet](./CHEATSHEET.md)** - Referencia rápida
- **[Ejemplos](./examples/README.md)** - 14 proyectos completos

**Para aprender programación**:
- [freeCodeCamp](https://www.freecodecamp.org/) - Gratis
- [The Odin Project](https://www.theodinproject.com/) - Gratis
- [MDN Web Docs](https://developer.mozilla.org/) - Referencia

---

### ¿Hay comunidad / Discord / Forum?

**Oficial**:
- [Anthropic Discord](https://discord.gg/anthropic)
- [GitHub Discussions](https://github.com/anthropics/claude-code/discussions)

**Este repositorio**:
- [GitHub Issues](https://github.com/rmn1978/claude-code-advanced-guide/issues)
- [GitHub Discussions](https://github.com/rmn1978/claude-code-advanced-guide/discussions)

**Redes sociales**:
- Twitter: [@learntouseai](https://twitter.com/learntouseai)

---

## 🎯 Próximos Pasos

**Si ACABAS de instalar Claude Code**:
1. Ve al **[Tutorial de 15 minutos](./TUTORIAL-15MIN.md)**
2. Construye tu primera app
3. Regresa aquí cuando tengas dudas

**Si ya hiciste el tutorial**:
1. Revisa el **[Cheat Sheet](./CHEATSHEET.md)**
2. Elige un **[ejemplo](./examples/README.md)** de tu nivel
3. Constrúyelo paso a paso

**Si ya construiste varios proyectos**:
1. Lee **[Best Practices](./docs/06-best-practices.md)**
2. Aprende **[Multi-Agent Orchestration](./docs/guides/02-intermediate/multi-agent-orchestration.md)**
3. Construye algo más complejo

---

## ❓ ¿Tu pregunta no está aquí?

**Opciones**:

1. **Revisa el [Troubleshooting](./docs/07-troubleshooting.md)**
2. **Busca en [Issues existentes](https://github.com/rmn1978/claude-code-advanced-guide/issues)**
3. **Abre un [nuevo issue](https://github.com/rmn1978/claude-code-advanced-guide/issues/new/choose)**

**Incluye en tu pregunta**:
- Sistema operativo
- Versión de VS Code
- Qué intentaste hacer
- Qué error obtuviste
- Screenshots si es posible

---

**¡Suerte en tu viaje con Claude Code!** 🚀

[← Volver al README](./README.md)
