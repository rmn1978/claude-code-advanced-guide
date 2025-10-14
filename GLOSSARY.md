# 📖 Glosario de Términos - Claude Code

Definiciones simples de todos los términos que encontrarás en esta guía.

---

## A

### Agent (Agente)
**Qué es**: Un "trabajador especializado" que sabe hacer tareas específicas muy bien.

**Ejemplo**: El agente `nextjs-architect` sabe crear aplicaciones Next.js. El agente `fastapi-architect` sabe crear APIs con FastAPI.

**Analogía**: Como tener un equipo de expertos. En lugar de un desarrollador general, tienes un experto en React, otro en Python, otro en bases de datos, etc.

**Cómo usarlo**:
```
> Use nextjs-architect to create a blog with SSG
```

### API (Application Programming Interface)
**Qué es**: Un "intermediario" que permite que dos programas se comuniquen.

**Ejemplo simple**: Cuando usas una app del clima, la app usa una API para pedirle los datos al servidor del clima.

**En este repo**: Muchos ejemplos crean APIs (FastAPI, Express, Django).

### API Key
**Qué es**: Tu "contraseña" para usar Claude Code. Es como una llave que te identifica.

**Dónde conseguirla**: https://console.anthropic.com/

**Formato**: Empieza con `sk-ant-` seguido de letras y números.

**⚠️ Importante**: NUNCA compartas tu API key. Es como tu contraseña de banco.

---

## B

### Backend
**Qué es**: La parte del software que NO ves. Es el "cerebro" que procesa datos.

**Ejemplo**: Cuando te logueas en Facebook:
- Frontend: El formulario que ves
- Backend: El servidor que verifica tu contraseña

**Tecnologías backend en este repo**: FastAPI, Django, Express

### Bash
**Qué es**: El lenguaje de la terminal (línea de comandos).

**Ejemplo de comando**:
```bash
npm install  # Instalar dependencias
```

**En Claude Code**: Claude puede ejecutar comandos bash por ti.

---

## C

### CLI (Command Line Interface)
**Qué es**: Programas que usas escribiendo comandos en la terminal.

**Ejemplo**: En lugar de hacer clic en botones, escribes:
```bash
git status
npm run dev
```

### CRUD
**Qué es**: Las 4 operaciones básicas con datos:
- **C**reate (Crear)
- **R**ead (Leer)
- **U**pdate (Actualizar)
- **D**elete (Eliminar)

**Ejemplo**: En una app de notas:
- Create: Crear una nota nueva
- Read: Ver tus notas
- Update: Editar una nota
- Delete: Borrar una nota

---

## D

### Database (Base de Datos)
**Qué es**: Donde se guardan los datos de forma organizada.

**Analogía**: Como un Excel gigante y super organizado.

**Tipos**:
- **PostgreSQL**: Base de datos relacional (tablas con relaciones)
- **Redis**: Base de datos en memoria (super rápida)
- **MongoDB**: Base de datos de documentos

### Docker
**Qué es**: Software que "empaqueta" tu aplicación con todo lo que necesita.

**Analogía**: Como una caja de mudanza que tiene TODO (muebles, ropa, decoración). La puedes abrir en cualquier casa y todo funciona.

**Uso**: Te aseguras de que tu app funcione igual en tu laptop, en el servidor, en cualquier lado.

---

## E

### Endpoint
**Qué es**: Una "dirección" en tu API donde puedes hacer peticiones.

**Ejemplo**:
```
GET  /api/users      ← Obtener todos los usuarios
POST /api/users      ← Crear un usuario nuevo
GET  /api/users/123  ← Obtener el usuario con ID 123
```

### Environment Variable (Variable de Entorno)
**Qué es**: Una configuración que se guarda fuera de tu código.

**Por qué**: Para NO poner contraseñas en el código.

**Ejemplo**:
```bash
# .env file
DATABASE_URL=postgresql://localhost/mydb
API_KEY=sk-ant-xxxxx
```

---

## F

### FastAPI
**Qué es**: Framework de Python para crear APIs muy rápidas.

**Características**:
- Súper rápido
- Fácil de aprender
- Documentación automática
- Async (puede hacer varias cosas a la vez)

**Ejemplo**:
```python
from fastapi import FastAPI
app = FastAPI()

@app.get("/")
def read_root():
    return {"Hello": "World"}
```

### Frontend
**Qué es**: La parte del software que SÍ ves. La interfaz con la que interactúas.

**Ejemplo**: Los botones, formularios, texto que ves en una web o app.

**Tecnologías frontend en este repo**: Next.js, React, Vue, Nuxt

---

## G

### Git
**Qué es**: Sistema para guardar el historial de cambios de tu código.

**Analogía**: Como "Control + Z" ultra poderoso. Puedes volver a cualquier versión anterior de tu código.

**Comandos básicos**:
```bash
git status   # Ver qué cambió
git add .    # Preparar cambios
git commit   # Guardar cambios
git push     # Subir a GitHub
```

### GitHub
**Qué es**: Sitio web donde puedes guardar tu código en la nube (con Git).

**Uso**: Compartir código, colaborar, hacer backup.

---

## H

### HTTP/HTTPS
**Qué es**: El protocolo (lenguaje) que usa la web para comunicarse.

**Métodos comunes**:
- **GET**: Obtener datos
- **POST**: Enviar datos nuevos
- **PUT**: Actualizar datos
- **DELETE**: Borrar datos

---

## J

### JSON
**Qué es**: Formato para intercambiar datos entre programas.

**Ejemplo**:
```json
{
  "nombre": "Juan",
  "edad": 30,
  "ciudad": "Madrid"
}
```

**Por qué es útil**: Es fácil de leer para humanos y para máquinas.

### JWT (JSON Web Token)
**Qué es**: Un "ticket" que prueba quién eres sin tener que loguearte cada vez.

**Analogía**: Como un pase VIP. Lo muestras y ya saben quién eres.

**Uso**: Autenticación en APIs.

---

## M

### MCP (Model Context Protocol)
**Qué es**: Sistema que permite a Claude Code conectarse con servicios externos.

**Ejemplo**: Con MCP puedes conectar Claude Code a:
- Tu base de datos PostgreSQL
- Tu cuenta de GitHub
- Stripe (pagos)
- Slack

**Beneficio**: Claude puede hacer cosas como "leer datos de la BD" directamente.

### Middleware
**Qué es**: Código que se ejecuta "en el medio" de una petición.

**Ejemplo**: Verificar que estás logueado ANTES de mostrarte tus mensajes privados.

```
Petición → Middleware (¿está logueado?) → Si SÍ → Mostrar datos
                                        → Si NO → Error 401
```

---

## N

### Next.js
**Qué es**: Framework de React para crear aplicaciones web modernas.

**Características**:
- SSR (Server Side Rendering)
- SSG (Static Site Generation)
- File-based routing
- Super rápido

**Uso en este repo**: Varios ejemplos usan Next.js (blog, e-commerce, chat, etc.)

### npm (Node Package Manager)
**Qué es**: Herramienta para instalar librerías de JavaScript.

**Comandos comunes**:
```bash
npm install          # Instalar dependencias
npm run dev          # Iniciar desarrollo
npm test             # Correr tests
```

### Nuxt
**Qué es**: Framework de Vue (similar a Next.js pero para Vue).

---

## O

### ORM (Object-Relational Mapping)
**Qué es**: Herramienta que te permite usar la base de datos con código normal en lugar de SQL.

**Sin ORM** (SQL directo):
```sql
SELECT * FROM users WHERE id = 1
```

**Con ORM** (Prisma):
```javascript
await prisma.user.findUnique({ where: { id: 1 } })
```

**Beneficio**: Más fácil, más seguro, menos errores.

---

## P

### Plan Mode
**Qué es**: Modo de Claude Code donde primero PLANIFICA antes de codificar.

**Cómo activarlo**:
```
> /plan
```

**Beneficio**: Para proyectos complejos, Claude piensa toda la arquitectura antes de escribir código.

**Flujo**:
1. Tú pides algo complejo
2. Claude crea un plan detallado
3. Tú apruebas el plan
4. Claude ejecuta el plan paso a paso

### Prisma
**Qué es**: ORM moderno para Node.js.

**Uso**: Trabajar con bases de datos de forma fácil.

**Características**:
- Type-safe (previene errores)
- Migraciones automáticas
- Prisma Studio (UI visual)

---

## R

### REST API
**Qué es**: Estilo de arquitectura para crear APIs.

**Principios**:
- Usar HTTP methods (GET, POST, PUT, DELETE)
- Endpoints claros (`/users`, `/posts`)
- Stateless (cada petición es independiente)

**Ejemplo**:
```
GET    /api/posts     ← Obtener todos los posts
POST   /api/posts     ← Crear un post
GET    /api/posts/5   ← Obtener el post 5
PUT    /api/posts/5   ← Actualizar el post 5
DELETE /api/posts/5   ← Borrar el post 5
```

### Redis
**Qué es**: Base de datos super rápida que guarda datos en memoria RAM.

**Uso**: Caché, sesiones, colas de trabajos, pub/sub.

**Por qué es rápida**: Todo está en RAM (no en disco).

---

## S

### SSG (Static Site Generation)
**Qué es**: Generar páginas HTML en tiempo de BUILD (no en cada petición).

**Beneficio**: Super rápido porque las páginas ya están listas.

**Uso**: Blogs, documentación, sitios que no cambian mucho.

### SSR (Server Side Rendering)
**Qué es**: Generar el HTML en el SERVIDOR en cada petición.

**Beneficio**: Contenido dinámico, mejor SEO.

**Diferencia con SSG**:
- SSG: Genera 1 vez al hacer build
- SSR: Genera en cada petición

### Stack
**Qué es**: Conjunto de tecnologías que usas en un proyecto.

**Ejemplo de stack**:
- Frontend: Next.js + React + Tailwind
- Backend: FastAPI + Python
- Database: PostgreSQL
- Deploy: Vercel + Railway

---

## T

### TypeScript
**Qué es**: JavaScript con "tipos". Te ayuda a prevenir errores.

**Sin tipos** (JavaScript):
```javascript
function suma(a, b) {
  return a + b
}
suma("5", 3)  // "53" ← WTF? 🤔
```

**Con tipos** (TypeScript):
```typescript
function suma(a: number, b: number): number {
  return a + b
}
suma("5", 3)  // ❌ ERROR! TypeScript te avisa
```

---

## V

### VS Code (Visual Studio Code)
**Qué es**: Editor de código (donde escribes código).

**Por qué este**: Es donde se integra Claude Code.

### Vue
**Qué es**: Framework de JavaScript para crear interfaces de usuario.

**Alternativas**: React, Angular, Svelte

---

## W

### WebSocket
**Qué es**: Tecnología para comunicación en tiempo real entre navegador y servidor.

**Diferencia con HTTP**:
- HTTP: Pides datos → El servidor responde → Se cierra la conexión
- WebSocket: Conexión siempre abierta → Datos fluyen en ambas direcciones

**Uso**: Chat en tiempo real, notificaciones, juegos multiplayer

---

## Atajos de Claude Code

### Comandos Slash

```bash
/help     # Ver ayuda
/plan     # Activar plan mode
/clear    # Limpiar conversación
/model    # Cambiar modelo
```

### Prompts Comunes

```
✅ "Create a [tipo] app with [features]"
✅ "Fix this error: [paste error]"
✅ "Add tests to this code"
✅ "Explain what this code does"
✅ "Refactor this function"
```

---

## 📚 Recursos para Seguir Aprendiendo

### Si eres COMPLETAMENTE nuevo en programación:
1. [freeCodeCamp](https://www.freecodecamp.org/) - Gratis, muy bueno
2. [The Odin Project](https://www.theodinproject.com/) - Gratis, full-stack
3. [CS50](https://cs50.harvard.edu/) - Curso de Harvard, gratis

### Si ya sabes programar pero eres nuevo en web dev:
1. [MDN Web Docs](https://developer.mozilla.org/) - Referencia completa
2. [JavaScript.info](https://javascript.info/) - JavaScript moderno
3. [Next.js Learn](https://nextjs.org/learn) - Tutorial oficial de Next.js

### Para aprender Claude Code:
1. **[Tutorial de 15 minutos](./TUTORIAL-15MIN.md)** ← Empieza aquí
2. **[Instalación](./docs/01-installation.md)** - Setup completo
3. **[Ejemplos](./examples/README.md)** - Proyectos reales

---

## 🤔 ¿Todavía confundido?

**No te preocupes**, es normal. La programación tiene MUCHOS términos.

**Tip**: No necesitas aprenderlos todos de una vez. Ve paso a paso:

1. Empieza con el [Tutorial de 15 minutos](./TUTORIAL-15MIN.md)
2. Construye tu primer proyecto simple
3. Los términos se irán aclarando con la práctica

**¿Algún término que no está aquí?** [Abre un issue](https://github.com/rmn1978/claude-code-advanced-guide/issues) y lo añadimos.

---

[← Volver al README](./README.md)
