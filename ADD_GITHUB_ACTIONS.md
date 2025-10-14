# Cómo Añadir GitHub Actions Workflow

## Opción 1: Crear el archivo directamente en GitHub (Recomendado)

1. Ve a tu repositorio: https://github.com/rmn1978/claude-code-advanced-guide

2. Haz clic en **"Add file"** → **"Create new file"**

3. En el campo de nombre, escribe: `.github/workflows/validate.yml`

4. Copia y pega el siguiente contenido:

```yaml
name: Validate Repository

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  validate:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Check for broken links in README
        run: |
          echo "✅ Checking README.md for broken internal links..."

          # Extract all internal links from README.md
          grep -oP '\]\([^)]+\)' README.md | sed 's/](\(.*\))/\1/' | grep -v '^http' | while read link; do
            # Remove anchor links
            file_path=$(echo "$link" | sed 's/#.*//')

            if [ ! -z "$file_path" ] && [ ! -e "$file_path" ]; then
              echo "❌ Broken link found: $link"
              exit 1
            fi
          done

          echo "✅ All internal links are valid!"

      - name: Validate agent files
        run: |
          echo "✅ Validating agent markdown files..."

          agent_count=$(find agents -name "*.md" -type f | wc -l)
          echo "Found $agent_count agent files"

          if [ $agent_count -lt 5 ]; then
            echo "❌ Expected at least 5 agent files"
            exit 1
          fi

          echo "✅ Agent files validated!"

      - name: Check examples structure
        run: |
          echo "✅ Checking examples directory..."

          if [ ! -f "examples/README.md" ]; then
            echo "❌ examples/README.md not found"
            exit 1
          fi

          example_count=$(find examples -mindepth 1 -maxdepth 1 -type d | wc -l)
          echo "Found $example_count example directories"

          if [ $example_count -lt 10 ]; then
            echo "❌ Expected at least 10 examples"
            exit 1
          fi

          echo "✅ Examples structure validated!"

      - name: Validate documentation
        run: |
          echo "✅ Checking documentation files..."

          required_docs=(
            "README.md"
            "LICENSE"
            "CONTRIBUTING.md"
            "examples/README.md"
            "agents/README.md"
          )

          for doc in "${required_docs[@]}"; do
            if [ ! -f "$doc" ]; then
              echo "❌ Missing required file: $doc"
              exit 1
            fi
          done

          echo "✅ All required documentation exists!"

      - name: Summary
        run: |
          echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
          echo "✅ All validation checks passed!"
          echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
          echo ""
          echo "📊 Repository Statistics:"
          echo "  - Agent files: $(find agents -name '*.md' -type f | wc -l)"
          echo "  - Examples: $(find examples -mindepth 1 -maxdepth 1 -type d | wc -l)"
          echo "  - Documentation files: $(find . -name '*.md' -type f | wc -l)"
          echo "  - Total files: $(find . -type f | wc -l)"
```

5. En el mensaje de commit, escribe: `Add GitHub Actions validation workflow`

6. Haz clic en **"Commit new file"**

¡Listo! GitHub Actions comenzará a validar tu repositorio automáticamente.

---

## Opción 2: Crear un nuevo Personal Access Token con scope 'workflow'

Si prefieres subir desde la línea de comandos:

1. Ve a: https://github.com/settings/tokens

2. Haz clic en **"Generate new token (classic)"**

3. Selecciona los scopes:
   - ✅ `repo` (full control)
   - ✅ `workflow` (update workflows)

4. Copia el token

5. Ejecuta en tu terminal:
```bash
cd /Users/a_/claude-code-advanced-guide
git add .github/workflows/
git commit -m "Add GitHub Actions validation workflow"
git push origin main
# Cuando te pida la contraseña, pega el nuevo token
```

---

## ¿Qué hace este workflow?

El workflow de GitHub Actions valida automáticamente:

- ✅ **Links rotos** - Verifica que todos los enlaces internos en el README funcionen
- ✅ **Estructura de agentes** - Valida que existan al menos 5 archivos de agentes
- ✅ **Estructura de ejemplos** - Verifica que existan al menos 10 ejemplos
- ✅ **Documentación requerida** - Asegura que existan README, LICENSE, CONTRIBUTING, etc.
- ✅ **Estadísticas** - Muestra conteo de archivos del repositorio

Se ejecuta:
- ⚡ En cada push a `main`
- ⚡ En cada pull request

Verás un badge verde ✅ o rojo ❌ en tu repositorio indicando si las validaciones pasaron.
