# 🚀 Tu Primera App con Claude Code en 15 Minutos

Tutorial paso a paso para principiantes. Al final tendrás una app funcionando.

**⏱️ Tiempo**: 15 minutos
**📊 Nivel**: Principiante absoluto
**💻 Requisitos**: VS Code instalado

---

## ✅ Antes de Empezar

### Lo que necesitas

- [ ] VS Code instalado (v1.85+)
- [ ] Node.js instalado (v18+)
- [ ] API key de Anthropic
- [ ] 15 minutos sin interrupciones

### Verificar que todo está listo

```bash
# Verificar Node.js
node --version
# Debe mostrar: v18.0.0 o superior

# Verificar VS Code
code --version
# Debe mostrar: 1.85.0 o superior
```

**Si algo falla**: Ve a [Instalación](./docs/01-installation.md)

---

## 🎯 Qué Vamos a Construir

**Proyecto**: Una app web de "Generador de Nombres de Bandas"

**Funcionalidad**:
- Usuario ingresa sus palabras favoritas
- La app genera nombres creativos para bandas
- Frontend simple con HTML/CSS/JavaScript

**Por qué este proyecto**:
- ✅ Simple pero divertido
- ✅ Muestra las capacidades de Claude
- ✅ Funciona en el navegador
- ✅ No requiere base de datos ni backend complejo

---

## 📋 Paso 1: Instalar Claude Code (3 minutos)

### 1.1 - Abrir VS Code

Abre Visual Studio Code.

### 1.2 - Instalar la Extensión

1. Haz clic en el ícono de **Extensions** (cuadrado con piezas de puzzle)
2. Busca: `Claude Code`
3. Haz clic en **Install** en la extensión de Anthropic

**Espera 30-60 segundos** mientras se instala.

### 1.3 - Verificar Instalación

Deberías ver:
- ✅ Un ícono de Claude en la barra lateral izquierda
- ✅ Un panel nuevo llamado "Claude Code"

**Si NO lo ves**: Reinicia VS Code y vuelve a revisar.

---

## 🔑 Paso 2: Configurar API Key (2 minutos)

### 2.1 - Conseguir tu API Key

1. Ve a: https://console.anthropic.com/
2. Inicia sesión o crea una cuenta
3. Ve a **"API Keys"**
4. Haz clic en **"Create Key"**
5. **Copia** tu API key (empieza con `sk-ant-`)

⚠️ **IMPORTANTE**: Guarda esta key en lugar seguro. La necesitarás.

### 2.2 - Configurar la Key en tu Terminal

**Mac/Linux**:
```bash
# Abre tu terminal
# Pega este comando (reemplaza xxx con tu key):
export ANTHROPIC_API_KEY="sk-ant-xxxxx"

# Verifica que funcionó:
echo $ANTHROPIC_API_KEY
# Debe mostrar tu key
```

**Windows (PowerShell)**:
```powershell
# Abre PowerShell
# Pega este comando (reemplaza xxx con tu key):
$env:ANTHROPIC_API_KEY="sk-ant-xxxxx"

# Verifica que funcionó:
echo $env:ANTHROPIC_API_KEY
# Debe mostrar tu key
```

### 2.3 - Reiniciar VS Code

**MUY IMPORTANTE**: Cierra VS Code COMPLETAMENTE y vuélvelo a abrir.

Esto asegura que VS Code vea la nueva variable de entorno.

---

## 💬 Paso 3: Primera Interacción con Claude (2 minutos)

### 3.1 - Abrir Claude Code

1. Haz clic en el ícono de **Claude** en la barra lateral izquierda
2. Deberías ver un panel con un chat

### 3.2 - Test Rápido

Escribe en el chat:

```
Hello! Can you see this?
```

**Respuesta esperada**: Claude debería responder algo como "Yes, I can see your message!"

**Si ves un error**: Revisa que la API key esté configurada correctamente (Paso 2).

---

## 🏗️ Paso 4: Crear el Proyecto (5 minutos)

### 4.1 - Crear Carpeta de Proyecto

```bash
# En tu terminal
mkdir band-name-generator
cd band-name-generator

# Abrir VS Code en esta carpeta
code .
```

### 4.2 - Pedir a Claude que Cree la App

**Abre Claude Code** (ícono en la barra lateral) y pega este prompt:

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

### 4.3 - Esperar a que Claude Cree el Archivo

Claude debería:
1. Crear un archivo `index.html`
2. Escribir todo el código HTML, CSS y JavaScript
3. Mostrarte el código

**Tiempo**: 30-60 segundos

### 4.4 - Verificar que el Archivo Existe

En VS Code, deberías ver:
```
band-name-generator/
└── index.html
```

---

## 🎨 Paso 5: Probar la App (2 minutos)

### 5.1 - Abrir en el Navegador

**Opción 1 - Doble clic**:
- Ve a tu carpeta `band-name-generator`
- Doble clic en `index.html`
- Se abre en tu navegador

**Opción 2 - VS Code Extension** (recomendado):
1. Instala la extensión "Live Server" en VS Code
2. Click derecho en `index.html`
3. Click en "Open with Live Server"

### 5.2 - Probar la App

1. Ingresa 2-3 palabras (ej: "Fire", "Dragon", "Night")
2. Haz clic en "Generate Band Names"
3. Deberías ver 5 nombres de bandas generados

**Ejemplos de nombres generados**:
- "Firedrake Nights"
- "Dragon's Inferno"
- "Nightfire Chronicles"
- etc.

**Si funciona**: ¡Felicidades! 🎉 Acabas de crear tu primera app con Claude Code.

---

## 🔧 Paso 6: Personalizar la App (3 minutos)

Ahora vamos a hacer cambios para que veas cómo Claude te ayuda a iterar.

### 6.1 - Cambiar el Color

Pídele a Claude:

```
Change the color scheme to dark mode with purple and blue gradients
```

Claude debería:
1. Actualizar el archivo `index.html`
2. Cambiar los colores CSS
3. Mostrarte qué cambió

### 6.2 - Añadir Más Features

Pídele a Claude:

```
Add a "Copy to Clipboard" button next to each generated band name
```

Claude debería:
1. Añadir botones de copiar
2. Implementar la funcionalidad de JavaScript
3. Actualizar el HTML

### 6.3 - Probar los Cambios

Recarga la página en tu navegador (F5) y prueba:
- ¿Cambió el color scheme?
- ¿Aparecen los botones de "Copy"?
- ¿Funcionan al hacer clic?

---

## 🎓 Paso 7: Entender Qué Pasó (2 minutos)

### Lo que Acabas de Hacer

1. ✅ Instalaste Claude Code
2. ✅ Configuraste tu API key
3. ✅ Le pediste a Claude que creara una app
4. ✅ Claude escribió TODO el código por ti
5. ✅ Probaste la app
6. ✅ Le pediste cambios y Claude los hizo

### Lo Poderoso de Esto

**Antes** (sin Claude Code):
```
1. Buscar tutorial en Google
2. Copiar/pegar código de StackOverflow
3. Depurar errores
4. Buscar más tutoriales
5. Más errores
6. 2-3 horas después: funciona
```

**Ahora** (con Claude Code):
```
1. Describir lo que quieres
2. Claude lo crea
3. Funciona
4. 5-10 minutos
```

**Reducción de tiempo**: ~90-95% ⚡

---

## 🎯 Próximos Pasos

### ¿Qué Hacer Ahora?

**Opción 1 - Experimenta con esta app**:
```
> Add a "Favorites" section where users can save their favorite names

> Add a "Random" mode that generates names without user input

> Add animations when names appear

> Make it responsive for mobile devices
```

**Opción 2 - Construye otra app**:
- Calculadora
- Conversor de unidades
- Lista de tareas (Todo app)
- Generador de contraseñas

**Opción 3 - Aprende más**:
- Lee el [Cheat Sheet](./CHEATSHEET.md) para prompts comunes
- Revisa [ejemplos más complejos](./examples/README.md)
- Lee [Best Practices](./docs/06-best-practices.md)

---

## 💡 Tips y Trucos

### Cómo Hacer Buenos Prompts

❌ **Malo**:
```
Create an app
```

✅ **Bueno**:
```
Create a weather app that:
- Shows current temperature
- Uses OpenWeather API
- Has a search bar for cities
- Shows 5-day forecast
- Responsive design
```

### Si Algo No Funciona

1. **Lee el error**: Claude a veces explica qué falló
2. **Sé específico**: "Fix the error in line 45"
3. **Itera**: Pide pequeños cambios, no reescribir todo
4. **Pide explicaciones**: "Explain what this code does"

### Comandos Útiles de Claude

```bash
/help    # Ver ayuda
/plan    # Claude planifica antes de codificar
/clear   # Limpiar el chat
```

---

## ❓ Problemas Comunes

### "API key not found"

**Solución**:
1. Verifica que la configuraste: `echo $ANTHROPIC_API_KEY`
2. Reinicia VS Code COMPLETAMENTE
3. Vuelve a configurarla si es necesario

### Claude es muy lento

**Solución**:
1. Cambia a un modelo más rápido (haiku):
   - Settings → Claude Code → Model → `claude-haiku-3.5`

### El código no funciona

**Solución**:
1. Pídele a Claude que lo arregle:
   ```
   This gives an error: [paste error]
   Fix it
   ```

### No sé qué construir

**Ideas simples para practicar**:
- Calculadora de propinas
- Conversor de temperatura
- Generador de colores aleatorios
- Cronómetro/Temporizador
- Lista de compras

---

## 🎉 ¡Lo Lograste!

**Has completado el tutorial**. Ahora sabes:

- ✅ Cómo instalar y configurar Claude Code
- ✅ Cómo pedirle a Claude que cree apps
- ✅ Cómo hacer cambios iterativos
- ✅ Cómo probar tus creaciones

**Tiempo total**: ~15 minutos
**Apps creadas**: 1
**Conocimiento adquirido**: Invaluable

---

## 📚 Recursos Adicionales

**Siguientes pasos**:
- **[FAQ](./FAQ-BEGINNERS.md)** - Preguntas frecuentes
- **[Glosario](./GLOSSARY.md)** - Términos explicados
- **[Cheat Sheet](./CHEATSHEET.md)** - Comandos rápidos
- **[Ejemplos](./examples/README.md)** - Proyectos más complejos

**¿Necesitas ayuda?**
- [Abre un Issue](https://github.com/rmn1978/claude-code-advanced-guide/issues)
- [GitHub Discussions](https://github.com/rmn1978/claude-code-advanced-guide/discussions)

---

## 🚀 Desafío

**Ahora que sabes lo básico, desafíate**:

Crea una de estas apps (30-60 minutos cada una):
1. **Calculadora de IMC** (Índice de Masa Corporal)
2. **Generador de Memes** (texto sobre imagen)
3. **Quiz interactivo** (5 preguntas con puntuación)
4. **Reloj mundial** (muestra hora en diferentes ciudades)

**Comparte tu creación**: Tweet con #ClaudeCode y tag a @learntouseai

---

**¡Feliz Coding!** 💻✨

[← Volver al README](./README.md)
