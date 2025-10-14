# Landing Page Builder - Project Memory

## 📋 Project Overview

**Name**: Landing Page Builder (No-Code Visual Editor)
**Stack**: Next.js 15 + React DnD + TipTap + Tailwind CSS + PostgreSQL
**Level**: Advanced (6-8 hours)

A no-code visual editor for creating landing pages with drag-and-drop functionality, pre-built components, style customization, and export capabilities.

## 🎯 Core Features

### Visual Editor
- Drag & drop interface (@dnd-kit)
- Canvas with responsive preview modes
- Real-time editing
- Block library with 20+ components
- Property panel for customization
- Layer panel for structure view
- Toolbar with quick actions

### Block System
- Pre-built blocks (Hero, Features, CTA, etc.)
- Block registry for extensibility
- Custom block properties
- Style customization per block
- Nested blocks support
- Block templates

### Editor Features
- Undo/Redo history
- Copy/paste blocks
- Duplicate blocks
- Keyboard shortcuts
- Auto-save
- Version history
- Collaboration (future)

### Export & Publishing
- Export to HTML
- Export to React component
- Publish to custom domain
- SEO meta tags
- Open Graph tags
- Analytics integration

## 🏗️ Architecture

### State Management (Zustand)
```typescript
EditorStore
├── blocks: BlockProps[]           # All blocks on canvas
├── selectedBlockId: string        # Currently selected block
├── hoveredBlockId: string         # Hovered block
├── history: BlockProps[][]        # Undo/redo history
├── historyIndex: number           # Current position in history
├── mode: 'desktop'|'tablet'|'mobile'
├── showGrid: boolean
├── showLayers: boolean
└── showProperties: boolean
```

### Block System
```typescript
BlockProps
├── id: string                     # Unique identifier
├── type: string                   # Block type (hero, features, etc.)
├── props: Record<string, any>     # Block-specific properties
├── styles: BlockStyles            # Custom styles
└── children?: BlockProps[]        # Nested blocks

BlockDefinition
├── type: string                   # Unique type identifier
├── label: string                  # Display name
├── category: string               # Category for organization
├── icon: React.Component          # Icon component
├── defaultProps: object           # Default property values
├── schema: PropertySchema         # Property definitions
├── component: React.Component     # Render component
└── thumbnail?: string             # Preview image
```

### Component Structure
```
src/
├── app/
│   ├── (dashboard)/
│   │   ├── projects/              # Project management
│   │   └── templates/             # Template gallery
│   ├── editor/[pageId]/           # Main editor
│   ├── preview/[pageId]/          # Live preview
│   └── api/
│       ├── pages/                 # Page CRUD
│       ├── blocks/                # Block management
│       ├── templates/             # Template management
│       ├── upload/                # Media upload
│       └── export/                # Export functionality
├── components/
│   ├── editor/
│   │   ├── Editor.tsx             # Main editor container
│   │   ├── Canvas.tsx             # Droppable canvas
│   │   ├── Sidebar.tsx            # Block library
│   │   ├── Toolbar.tsx            # Top toolbar
│   │   ├── PropertyPanel.tsx     # Right panel
│   │   └── LayersPanel.tsx       # Layer tree view
│   ├── blocks/
│   │   ├── HeroBlock.tsx
│   │   ├── FeaturesBlock.tsx
│   │   ├── CTABlock.tsx
│   │   ├── TestimonialBlock.tsx
│   │   ├── PricingBlock.tsx
│   │   ├── FooterBlock.tsx
│   │   └── ... (20+ blocks)
│   └── dnd/
│       ├── DraggableBlock.tsx     # Draggable wrapper
│       ├── DroppableCanvas.tsx    # Drop zone
│       └── DragOverlay.tsx        # Drag preview
└── lib/
    ├── editor/
    │   ├── store.ts               # Zustand store
    │   ├── history.ts             # Undo/redo logic
    │   └── serializer.ts          # Save/load logic
    └── blocks/
        ├── registry.ts            # Block definitions
        └── types.ts               # TypeScript types
```

## 🎨 Block Categories

### Marketing Blocks
- **Hero Section**: Large header with CTA
- **Features Grid**: 2/3/4 column feature showcase
- **CTA Section**: Call-to-action with buttons
- **Pricing Table**: Pricing plans with features
- **FAQ Accordion**: Frequently asked questions

### Social Proof Blocks
- **Testimonials**: Customer reviews/quotes
- **Logo Cloud**: Customer logos
- **Stats**: Key metrics display
- **Reviews**: Star ratings and reviews

### Content Blocks
- **Text**: Rich text editor (TipTap)
- **Image**: Single image with caption
- **Image Gallery**: Multi-image grid
- **Video**: Embedded video player
- **Divider**: Section separator

### Layout Blocks
- **Container**: Wrapper with max-width
- **Column Layout**: 2/3/4 column grid
- **Spacer**: Vertical spacing
- **Header**: Navigation header
- **Footer**: Site footer

### Form Blocks
- **Contact Form**: Email contact form
- **Newsletter**: Email subscription
- **Survey**: Multi-question form
- **Lead Capture**: Name + email form

## 🔧 Block Registry System

### Registering a Block

```typescript
// lib/blocks/registry.ts
import { BlockDefinition } from '@/types/blocks'
import { HeroBlock } from '@/components/blocks/HeroBlock'
import { Heading1 } from 'lucide-react'

export const blockRegistry: Record<string, BlockDefinition> = {
  hero: {
    type: 'hero',
    label: 'Hero Section',
    category: 'marketing',
    icon: Heading1,
    component: HeroBlock,
    defaultProps: {
      heading: 'Build amazing products',
      subheading: 'The best way to grow your business',
      ctaText: 'Get Started',
      ctaLink: '#',
      image: '/placeholder-hero.jpg',
      alignment: 'center',
    },
    schema: {
      heading: {
        type: 'text',
        label: 'Heading',
        defaultValue: 'Build amazing products',
      },
      subheading: {
        type: 'textarea',
        label: 'Subheading',
        defaultValue: 'The best way to grow your business',
      },
      ctaText: {
        type: 'text',
        label: 'CTA Text',
        defaultValue: 'Get Started',
      },
      ctaLink: {
        type: 'text',
        label: 'CTA Link',
        defaultValue: '#',
      },
      image: {
        type: 'image',
        label: 'Background Image',
        defaultValue: '/placeholder-hero.jpg',
      },
      alignment: {
        type: 'select',
        label: 'Alignment',
        defaultValue: 'center',
        options: [
          { label: 'Left', value: 'left' },
          { label: 'Center', value: 'center' },
          { label: 'Right', value: 'right' },
        ],
      },
    },
  },
  // ... more blocks
}
```

### Property Schema Types

```typescript
type PropertyType =
  | 'text'         // Single-line text input
  | 'textarea'     // Multi-line text input
  | 'number'       // Number input with min/max/step
  | 'color'        // Color picker
  | 'select'       // Dropdown with options
  | 'image'        // Image upload/URL
  | 'toggle'       // Boolean switch
  | 'slider'       // Range slider
  | 'richtext'     // TipTap rich text editor
```

## 🎯 Editor State Management

### Zustand Store Actions

**Block Actions**:
- `addBlock(block, index?)` - Add block to canvas
- `updateBlock(id, updates)` - Update block properties
- `deleteBlock(id)` - Remove block
- `moveBlock(fromIndex, toIndex)` - Reorder blocks
- `duplicateBlock(id)` - Clone block
- `selectBlock(id)` - Select for editing
- `hoverBlock(id)` - Hover effect

**History Actions**:
- `undo()` - Undo last action
- `redo()` - Redo undone action
- `canUndo()` - Check if undo available
- `canRedo()` - Check if redo available

**UI Actions**:
- `setMode(mode)` - Change preview mode
- `toggleGrid()` - Toggle grid overlay
- `toggleLayers()` - Toggle layers panel
- `toggleProperties()` - Toggle property panel

**Persistence Actions**:
- `loadPage(blocks)` - Load page from API
- `savePage()` - Save to API
- `autoSave()` - Auto-save every 30s

### History Implementation

```typescript
// Every mutation creates a history entry
const addBlock = (block: BlockProps) => {
  set((state) => {
    const newBlocks = [...state.blocks, block]

    // Trim history after current index
    const newHistory = state.history.slice(0, state.historyIndex + 1)

    // Add new state to history
    newHistory.push(newBlocks)

    // Limit history to 50 entries
    if (newHistory.length > 50) {
      newHistory.shift()
    }

    return {
      blocks: newBlocks,
      history: newHistory,
      historyIndex: newHistory.length - 1,
    }
  })
}
```

## 🎨 Styling System

### Block Styles

Each block has a `styles` object:
```typescript
interface BlockStyles {
  // Spacing
  padding?: string
  margin?: string

  // Background
  backgroundColor?: string
  backgroundImage?: string
  backgroundSize?: string
  backgroundPosition?: string

  // Border
  border?: string
  borderRadius?: string

  // Effects
  boxShadow?: string
  opacity?: number

  // Layout
  display?: string
  flexDirection?: string
  alignItems?: string
  justifyContent?: string

  // Custom CSS
  [key: string]: any
}
```

### Responsive Styles (Future)

```typescript
interface ResponsiveStyles {
  desktop: BlockStyles
  tablet?: BlockStyles
  mobile?: BlockStyles
}
```

## 🖼️ Media Management

### Image Upload Flow

1. User clicks "Upload Image" in property panel
2. File input opens
3. File selected
4. Upload to S3 via `/api/upload`
5. Get back URL
6. Update block's `imageUrl` property
7. Image displays in canvas

### Media Library

```typescript
interface MediaAsset {
  id: string
  name: string
  url: string
  type: 'image' | 'video' | 'file'
  size: number
  mimeType: string
  thumbnail?: string
  userId: string
  createdAt: Date
}
```

## 🔐 Database Schema

```prisma
model User {
  id        String   @id @default(cuid())
  email     String   @unique
  name      String
  avatar    String?
  projects  Project[]
  pages     Page[]
}

model Project {
  id          String   @id @default(cuid())
  name        String
  description String?
  userId      String
  user        User     @relation(fields: [userId], references: [id])
  pages       Page[]
}

model Page {
  id          String   @id @default(cuid())
  title       String
  slug        String
  projectId   String
  userId      String
  content     Json     @default("{}")      # Editor state (blocks)
  settings    Json     @default("{}")      # SEO, meta tags
  isPublished Boolean  @default(false)
  publishedAt DateTime?
  versions    PageVersion[]

  project     Project  @relation(fields: [projectId], references: [id])
  user        User     @relation(fields: [userId], references: [id])

  @@unique([projectId, slug])
}

model PageVersion {
  id        String   @id @default(cuid())
  pageId    String
  content   Json
  settings  Json
  version   Int
  createdAt DateTime @default(now())
  page      Page     @relation(fields: [pageId], references: [id])
}

model Template {
  id          String   @id @default(cuid())
  name        String
  description String?
  thumbnail   String?
  category    String   @default("general")
  content     Json                         # Pre-built blocks
  isPublic    Boolean  @default(true)
}

model MediaAsset {
  id        String   @id @default(cuid())
  name      String
  url       String
  type      String
  size      Int
  mimeType  String
  userId    String
}
```

## 🚀 Export System

### Export to HTML

```typescript
// lib/export/html.ts
export function exportToHTML(blocks: BlockProps[], settings: PageSettings): string {
  const html = `
<!DOCTYPE html>
<html lang="${settings.language || 'en'}">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${settings.title}</title>
  <meta name="description" content="${settings.description}">

  <!-- Open Graph -->
  <meta property="og:title" content="${settings.title}">
  <meta property="og:description" content="${settings.description}">
  <meta property="og:image" content="${settings.ogImage}">

  <!-- Tailwind CSS CDN -->
  <script src="https://cdn.tailwindcss.com"></script>

  <!-- Custom CSS -->
  <style>${settings.customCSS || ''}</style>
</head>
<body>
  ${blocks.map(block => renderBlockToHTML(block)).join('\n')}

  <!-- Custom JS -->
  <script>${settings.customJS || ''}</script>
</body>
</html>
  `

  return html
}
```

### Export to React

```typescript
// lib/export/react.ts
export function exportToReact(blocks: BlockProps[]): string {
  return `
import React from 'react'

export default function LandingPage() {
  return (
    <>
      ${blocks.map(block => renderBlockToJSX(block)).join('\n')}
    </>
  )
}
`
}
```

## 📦 Key Dependencies

### Core
- `next@^15.0.0` - React framework
- `react@^19.0.0` - UI library
- `typescript@^5` - Type safety
- `tailwindcss@^3.4.0` - Utility CSS

### Drag & Drop
- `@dnd-kit/core@^6.1.0` - DnD foundation
- `@dnd-kit/sortable@^8.0.0` - Sortable lists
- `@dnd-kit/utilities@^3.2.0` - DnD utilities

### State & Data
- `zustand@^4.5.0` - State management
- `@prisma/client@^5.15.0` - Database ORM
- `zod@^3.23.0` - Validation

### Editor
- `@tiptap/react@^2.4.0` - Rich text editor
- `@tiptap/starter-kit@^2.4.0` - TipTap extensions

### UI
- `lucide-react@^0.395.0` - Icons
- `@radix-ui/react-*` - Headless UI components
- `clsx` - Conditional classes

### Authentication
- `next-auth@^4.24.0` - Authentication

## 🎯 Development Workflow

### Initial Setup
```bash
npm install
npx prisma generate
npx prisma db push
npm run seed              # Seed with templates
npm run dev
```

### Development Commands
```bash
npm run dev              # Start dev server
npm run build            # Build for production
npm run start            # Start production server
npm run db:studio        # Open Prisma Studio
npm run lint             # Run ESLint
npm run type-check       # Run TypeScript check
```

### Creating a New Block

1. Create block component in `components/blocks/`
2. Register in `lib/blocks/registry.ts`
3. Define properties and schema
4. Add to appropriate category
5. Create thumbnail (optional)

## 🧪 Testing Strategy

### Unit Tests
- Block component rendering
- Property panel updates
- Store actions (Zustand)
- Serialization logic
- Export functions

### Integration Tests
- Drag and drop flow
- Block addition/deletion
- Undo/redo functionality
- Save/load pages
- Template application

### E2E Tests (Playwright)
- Complete page creation flow
- Block customization
- Responsive preview
- Export to HTML
- Template usage

## 🐛 Common Issues & Solutions

### Issue: Drag and drop not working
**Solution**: Check @dnd-kit setup, ensure DndContext wraps components

### Issue: State updates not reflecting
**Solution**: Verify Zustand store selectors, check React.memo dependencies

### Issue: Undo/redo behaving incorrectly
**Solution**: Ensure history is updated on every mutation, check history index

### Issue: Export missing styles
**Solution**: Include Tailwind CDN or inline styles, check custom CSS

### Issue: Blocks not loading
**Solution**: Verify block registry, check component imports

## 📈 Performance Optimizations

### Editor Performance
- React.memo on block components
- Virtualization for block library
- Debounced auto-save (30s)
- Lazy load heavy components
- Code splitting per route

### Canvas Rendering
- Only re-render changed blocks
- useMemo for expensive calculations
- useCallback for event handlers
- Virtualized message lists

### Export Performance
- Server-side rendering
- Minify exported HTML/CSS/JS
- Image optimization
- CDN for assets

## 🔒 Security Considerations

- XSS prevention in user content
- Sanitize custom CSS/JS
- File upload validation
- Rate limiting on API
- CSRF protection
- Secure authentication

## 🌍 Environment Variables

```bash
DATABASE_URL="postgresql://..."
NEXTAUTH_URL="http://localhost:3000"
NEXTAUTH_SECRET="secret"
AWS_ACCESS_KEY_ID=""
AWS_SECRET_ACCESS_KEY=""
AWS_REGION="us-east-1"
AWS_S3_BUCKET=""
```

## 📚 Future Enhancements

### Phase 1 (MVP) ✅
- Drag & drop editor
- 6 core blocks
- Property panel
- Save/load pages

### Phase 2 🔶
- 20+ blocks
- Rich text editor (TipTap)
- Image uploads
- Template gallery
- Responsive breakpoints

### Phase 3 🔲
- Custom CSS/JS injection
- SEO meta editor
- Export to HTML/React
- Version history
- Collaboration (real-time)

### Phase 4 🔲
- A/B testing
- Analytics integration
- Custom domains
- Advanced animations
- Component marketplace

## 🎓 Learning Resources

- [@dnd-kit Documentation](https://docs.dndkit.com/)
- [Zustand Guide](https://github.com/pmndrs/zustand)
- [TipTap Docs](https://tiptap.dev/)
- [Tailwind CSS](https://tailwindcss.com/docs)

---

**Last Updated**: 2025-10-14
**Status**: Production Ready ✅
**Complexity**: Advanced 🔴
**Time Estimate**: 6-8 hours ⏱️
