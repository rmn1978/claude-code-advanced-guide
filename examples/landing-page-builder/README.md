# 🎨 Landing Page Builder (No-Code Visual Editor)

**Stack**: Next.js 15 + React DnD + TipTap + Tailwind CSS + PostgreSQL

**Nivel**: Avanzado (6-8 horas)

**Descripción**: Editor visual drag-and-drop para crear landing pages sin código. Incluye componentes preconstruidos, editor de contenido, personalización de estilos, y exportación de páginas.

## 🎯 Características

### Core Features
- ✅ Drag & Drop visual editor
- ✅ Componentes preconstruidos (Hero, Features, CTA, etc.)
- ✅ Editor de texto rico (TipTap/Slate)
- ✅ Responsive design preview (mobile, tablet, desktop)
- ✅ Style customization (colores, tipografía, spacing)
- ✅ Image uploads y media library
- ✅ Template gallery
- ✅ Undo/Redo history

### Advanced Features
- ✅ Custom CSS/JS injection
- ✅ SEO meta tags editor
- ✅ Analytics integration
- ✅ A/B testing
- ✅ Custom domains
- ✅ Export to HTML/React
- ✅ Collaboration (multiple users)
- ✅ Version history

## 🏗️ Arquitectura

```
landing-page-builder/
├── src/
│   ├── app/
│   │   ├── (dashboard)/
│   │   │   ├── projects/
│   │   │   │   ├── page.tsx
│   │   │   │   └── [id]/
│   │   │   │       └── page.tsx
│   │   │   └── templates/page.tsx
│   │   ├── editor/
│   │   │   └── [pageId]/
│   │   │       └── page.tsx
│   │   ├── preview/
│   │   │   └── [pageId]/page.tsx
│   │   ├── api/
│   │   │   ├── pages/route.ts
│   │   │   ├── blocks/route.ts
│   │   │   ├── templates/route.ts
│   │   │   ├── upload/route.ts
│   │   │   └── export/route.ts
│   │   └── layout.tsx
│   ├── components/
│   │   ├── editor/
│   │   │   ├── Editor.tsx
│   │   │   ├── Canvas.tsx
│   │   │   ├── Sidebar.tsx
│   │   │   ├── Toolbar.tsx
│   │   │   ├── PropertyPanel.tsx
│   │   │   └── LayersPanel.tsx
│   │   ├── blocks/
│   │   │   ├── HeroBlock.tsx
│   │   │   ├── FeaturesBlock.tsx
│   │   │   ├── CTABlock.tsx
│   │   │   ├── TestimonialBlock.tsx
│   │   │   ├── PricingBlock.tsx
│   │   │   └── FooterBlock.tsx
│   │   ├── dnd/
│   │   │   ├── DraggableBlock.tsx
│   │   │   ├── DroppableCanvas.tsx
│   │   │   └── DragOverlay.tsx
│   │   └── ui/
│   ├── lib/
│   │   ├── editor/
│   │   │   ├── store.ts
│   │   │   ├── history.ts
│   │   │   └── serializer.ts
│   │   ├── blocks/
│   │   │   ├── registry.ts
│   │   │   └── types.ts
│   │   ├── prisma.ts
│   │   └── storage.ts
│   ├── hooks/
│   │   ├── useEditor.ts
│   │   ├── useBlocks.ts
│   │   ├── useHistory.ts
│   │   └── useResponsive.ts
│   └── types/
│       ├── editor.ts
│       └── blocks.ts
├── prisma/
│   └── schema.prisma
├── public/
│   └── templates/
├── package.json
└── docker-compose.yml
```

## 🚀 Quick Start

### 1. Usando Claude Code (Recomendado)

```bash
> Use nextjs-architect to create a landing page builder with:
  - Next.js 15 with App Router
  - React DnD for drag and drop
  - TipTap for rich text editing
  - Tailwind CSS for styling
  - PostgreSQL for data persistence
  - Image upload to S3
  - Template system
  - Export to HTML
```

### 2. Setup Manual

```bash
# Clonar e instalar
git clone <repo>
cd landing-page-builder
npm install

# Setup environment
cp .env.example .env

# Setup database
npx prisma generate
npx prisma db push

# Seed templates
npm run seed

# Run development
npm run dev
```

### 3. Acceder a la app

- Editor: http://localhost:3000
- Preview: http://localhost:3000/preview/[pageId]

## 📁 Archivos Clave

### Database Schema

```prisma
// prisma/schema.prisma
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

model User {
  id        String   @id @default(cuid())
  email     String   @unique
  name      String
  avatar    String?
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt

  projects  Project[]
  pages     Page[]
}

model Project {
  id          String   @id @default(cuid())
  name        String
  description String?
  userId      String
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt

  user        User     @relation(fields: [userId], references: [id], onDelete: Cascade)
  pages       Page[]

  @@index([userId])
}

model Page {
  id          String   @id @default(cuid())
  title       String
  slug        String
  description String?
  projectId   String
  userId      String
  content     Json     @default("{}")  // Editor state
  settings    Json     @default("{}")  // Page settings (meta, SEO, etc.)
  isPublished Boolean  @default(false)
  publishedAt DateTime?
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt

  project     Project  @relation(fields: [projectId], references: [id], onDelete: Cascade)
  user        User     @relation(fields: [userId], references: [id], onDelete: Cascade)
  versions    PageVersion[]

  @@unique([projectId, slug])
  @@index([projectId])
  @@index([userId])
}

model PageVersion {
  id        String   @id @default(cuid())
  pageId    String
  content   Json
  settings  Json
  version   Int
  createdAt DateTime @default(now())

  page      Page     @relation(fields: [pageId], references: [id], onDelete: Cascade)

  @@index([pageId])
}

model Template {
  id          String   @id @default(cuid())
  name        String
  description String?
  thumbnail   String?
  category    String   @default("general")
  content     Json
  isPublic    Boolean  @default(true)
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt

  @@index([category])
}

model MediaAsset {
  id        String   @id @default(cuid())
  name      String
  url       String
  type      String   // image, video, file
  size      Int
  mimeType  String
  userId    String
  createdAt DateTime @default(now())

  @@index([userId])
}
```

---

### Block Type Definitions

```typescript
// src/types/blocks.ts
export interface BlockProps {
  id: string
  type: string
  props: Record<string, any>
  children?: BlockProps[]
  styles?: BlockStyles
}

export interface BlockStyles {
  padding?: string
  margin?: string
  backgroundColor?: string
  backgroundImage?: string
  borderRadius?: string
  boxShadow?: string
  [key: string]: any
}

export interface BlockDefinition {
  type: string
  label: string
  category: string
  icon: React.ComponentType
  defaultProps: Record<string, any>
  schema: Record<string, PropertySchema>
  component: React.ComponentType<any>
  thumbnail?: string
}

export interface PropertySchema {
  type: 'text' | 'textarea' | 'number' | 'color' | 'select' | 'image' | 'toggle'
  label: string
  defaultValue?: any
  options?: Array<{ label: string; value: any }>
  min?: number
  max?: number
  step?: number
}

export type EditorMode = 'desktop' | 'tablet' | 'mobile'
```

---

### Editor Store (Zustand)

```typescript
// src/lib/editor/store.ts
import { create } from 'zustand'
import { BlockProps, EditorMode } from '@/types/blocks'

interface EditorState {
  // Blocks
  blocks: BlockProps[]
  selectedBlockId: string | null
  hoveredBlockId: string | null

  // History
  history: BlockProps[][]
  historyIndex: number

  // UI
  mode: EditorMode
  showGrid: boolean
  showLayers: boolean
  showProperties: boolean

  // Actions
  addBlock: (block: BlockProps, index?: number) => void
  updateBlock: (id: string, updates: Partial<BlockProps>) => void
  deleteBlock: (id: string) => void
  moveBlock: (fromIndex: number, toIndex: number) => void
  selectBlock: (id: string | null) => void
  hoverBlock: (id: string | null) => void

  // History actions
  undo: () => void
  redo: () => void
  canUndo: () => boolean
  canRedo: () => boolean

  // UI actions
  setMode: (mode: EditorMode) => void
  toggleGrid: () => void
  toggleLayers: () => void
  toggleProperties: () => void

  // Persistence
  loadPage: (blocks: BlockProps[]) => void
  savePage: () => Promise<void>
}

export const useEditorStore = create<EditorState>((set, get) => ({
  blocks: [],
  selectedBlockId: null,
  hoveredBlockId: null,
  history: [[]],
  historyIndex: 0,
  mode: 'desktop',
  showGrid: true,
  showLayers: true,
  showProperties: true,

  addBlock: (block, index) => {
    set((state) => {
      const newBlocks = [...state.blocks]
      if (index !== undefined) {
        newBlocks.splice(index, 0, block)
      } else {
        newBlocks.push(block)
      }

      // Add to history
      const newHistory = state.history.slice(0, state.historyIndex + 1)
      newHistory.push(newBlocks)

      return {
        blocks: newBlocks,
        history: newHistory,
        historyIndex: newHistory.length - 1,
        selectedBlockId: block.id,
      }
    })
  },

  updateBlock: (id, updates) => {
    set((state) => {
      const newBlocks = state.blocks.map((block) =>
        block.id === id ? { ...block, ...updates } : block
      )

      // Add to history
      const newHistory = state.history.slice(0, state.historyIndex + 1)
      newHistory.push(newBlocks)

      return {
        blocks: newBlocks,
        history: newHistory,
        historyIndex: newHistory.length - 1,
      }
    })
  },

  deleteBlock: (id) => {
    set((state) => {
      const newBlocks = state.blocks.filter((block) => block.id !== id)

      // Add to history
      const newHistory = state.history.slice(0, state.historyIndex + 1)
      newHistory.push(newBlocks)

      return {
        blocks: newBlocks,
        history: newHistory,
        historyIndex: newHistory.length - 1,
        selectedBlockId: null,
      }
    })
  },

  moveBlock: (fromIndex, toIndex) => {
    set((state) => {
      const newBlocks = [...state.blocks]
      const [movedBlock] = newBlocks.splice(fromIndex, 1)
      newBlocks.splice(toIndex, 0, movedBlock)

      return { blocks: newBlocks }
    })
  },

  selectBlock: (id) => set({ selectedBlockId: id }),
  hoverBlock: (id) => set({ hoveredBlockId: id }),

  undo: () => {
    set((state) => {
      if (state.historyIndex > 0) {
        const newIndex = state.historyIndex - 1
        return {
          blocks: state.history[newIndex],
          historyIndex: newIndex,
        }
      }
      return state
    })
  },

  redo: () => {
    set((state) => {
      if (state.historyIndex < state.history.length - 1) {
        const newIndex = state.historyIndex + 1
        return {
          blocks: state.history[newIndex],
          historyIndex: newIndex,
        }
      }
      return state
    })
  },

  canUndo: () => get().historyIndex > 0,
  canRedo: () => get().historyIndex < get().history.length - 1,

  setMode: (mode) => set({ mode }),
  toggleGrid: () => set((state) => ({ showGrid: !state.showGrid })),
  toggleLayers: () => set((state) => ({ showLayers: !state.showLayers })),
  toggleProperties: () => set((state) => ({ showProperties: !state.showProperties })),

  loadPage: (blocks) => {
    set({
      blocks,
      history: [blocks],
      historyIndex: 0,
      selectedBlockId: null,
    })
  },

  savePage: async () => {
    const { blocks } = get()
    // TODO: Save to API
    await fetch('/api/pages/save', {
      method: 'POST',
      body: JSON.stringify({ blocks }),
    })
  },
}))
```

---

### Block Registry

```typescript
// src/lib/blocks/registry.ts
import { BlockDefinition } from '@/types/blocks'
import { HeroBlock } from '@/components/blocks/HeroBlock'
import { FeaturesBlock } from '@/components/blocks/FeaturesBlock'
import { CTABlock } from '@/components/blocks/CTABlock'
import { TestimonialBlock } from '@/components/blocks/TestimonialBlock'
import { PricingBlock } from '@/components/blocks/PricingBlock'
import { FooterBlock } from '@/components/blocks/FooterBlock'
import {
  Heading1,
  Grid3x3,
  Megaphone,
  MessageSquare,
  DollarSign,
  Layout,
} from 'lucide-react'

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

  features: {
    type: 'features',
    label: 'Features Grid',
    category: 'marketing',
    icon: Grid3x3,
    component: FeaturesBlock,
    defaultProps: {
      heading: 'Features',
      subheading: 'Everything you need',
      features: [
        {
          icon: '⚡',
          title: 'Fast',
          description: 'Lightning fast performance',
        },
        {
          icon: '🔒',
          title: 'Secure',
          description: 'Bank-level security',
        },
        {
          icon: '📱',
          title: 'Mobile',
          description: 'Works on all devices',
        },
      ],
      columns: 3,
    },
    schema: {
      heading: {
        type: 'text',
        label: 'Heading',
        defaultValue: 'Features',
      },
      subheading: {
        type: 'text',
        label: 'Subheading',
        defaultValue: 'Everything you need',
      },
      columns: {
        type: 'select',
        label: 'Columns',
        defaultValue: 3,
        options: [
          { label: '2 Columns', value: 2 },
          { label: '3 Columns', value: 3 },
          { label: '4 Columns', value: 4 },
        ],
      },
    },
  },

  cta: {
    type: 'cta',
    label: 'Call to Action',
    category: 'marketing',
    icon: Megaphone,
    component: CTABlock,
    defaultProps: {
      heading: 'Ready to get started?',
      subheading: 'Join thousands of happy customers',
      primaryButtonText: 'Start Free Trial',
      primaryButtonLink: '#',
      secondaryButtonText: 'Learn More',
      secondaryButtonLink: '#',
      backgroundColor: '#3b82f6',
    },
    schema: {
      heading: {
        type: 'text',
        label: 'Heading',
      },
      subheading: {
        type: 'text',
        label: 'Subheading',
      },
      primaryButtonText: {
        type: 'text',
        label: 'Primary Button Text',
      },
      primaryButtonLink: {
        type: 'text',
        label: 'Primary Button Link',
      },
      backgroundColor: {
        type: 'color',
        label: 'Background Color',
        defaultValue: '#3b82f6',
      },
    },
  },

  testimonial: {
    type: 'testimonial',
    label: 'Testimonials',
    category: 'social-proof',
    icon: MessageSquare,
    component: TestimonialBlock,
    defaultProps: {
      heading: 'What our customers say',
      testimonials: [
        {
          quote: 'This product changed my life!',
          author: 'John Doe',
          role: 'CEO at Company',
          avatar: '/avatar1.jpg',
        },
        {
          quote: 'Amazing support team!',
          author: 'Jane Smith',
          role: 'Designer at Studio',
          avatar: '/avatar2.jpg',
        },
      ],
      layout: 'grid',
    },
    schema: {
      heading: {
        type: 'text',
        label: 'Heading',
      },
      layout: {
        type: 'select',
        label: 'Layout',
        defaultValue: 'grid',
        options: [
          { label: 'Grid', value: 'grid' },
          { label: 'Carousel', value: 'carousel' },
        ],
      },
    },
  },

  pricing: {
    type: 'pricing',
    label: 'Pricing Table',
    category: 'marketing',
    icon: DollarSign,
    component: PricingBlock,
    defaultProps: {
      heading: 'Simple, transparent pricing',
      subheading: 'Choose the plan that fits your needs',
      plans: [
        {
          name: 'Starter',
          price: 9,
          interval: 'month',
          features: ['Feature 1', 'Feature 2', 'Feature 3'],
          highlighted: false,
        },
        {
          name: 'Pro',
          price: 29,
          interval: 'month',
          features: ['Everything in Starter', 'Feature 4', 'Feature 5'],
          highlighted: true,
        },
        {
          name: 'Enterprise',
          price: 99,
          interval: 'month',
          features: ['Everything in Pro', 'Feature 6', 'Feature 7'],
          highlighted: false,
        },
      ],
    },
    schema: {
      heading: {
        type: 'text',
        label: 'Heading',
      },
      subheading: {
        type: 'text',
        label: 'Subheading',
      },
    },
  },

  footer: {
    type: 'footer',
    label: 'Footer',
    category: 'layout',
    icon: Layout,
    component: FooterBlock,
    defaultProps: {
      companyName: 'Your Company',
      tagline: 'Making the world a better place',
      links: [
        { label: 'About', href: '/about' },
        { label: 'Blog', href: '/blog' },
        { label: 'Contact', href: '/contact' },
      ],
      socialLinks: {
        twitter: 'https://twitter.com',
        facebook: 'https://facebook.com',
        instagram: 'https://instagram.com',
      },
    },
    schema: {
      companyName: {
        type: 'text',
        label: 'Company Name',
      },
      tagline: {
        type: 'text',
        label: 'Tagline',
      },
    },
  },
}

export function getBlocksByCategory(category?: string): BlockDefinition[] {
  const blocks = Object.values(blockRegistry)
  return category
    ? blocks.filter((block) => block.category === category)
    : blocks
}

export function getBlockDefinition(type: string): BlockDefinition | undefined {
  return blockRegistry[type]
}
```

---

### Hero Block Component

```typescript
// src/components/blocks/HeroBlock.tsx
import { BlockProps } from '@/types/blocks'
import Image from 'next/image'

export function HeroBlock({ props, styles }: BlockProps) {
  const {
    heading,
    subheading,
    ctaText,
    ctaLink,
    image,
    alignment = 'center',
  } = props

  return (
    <div
      className="relative min-h-[500px] flex items-center"
      style={{
        ...styles,
        backgroundImage: image ? `url(${image})` : undefined,
        backgroundSize: 'cover',
        backgroundPosition: 'center',
      }}
    >
      {/* Overlay */}
      <div className="absolute inset-0 bg-black/50" />

      {/* Content */}
      <div className="relative container mx-auto px-4">
        <div
          className={`max-w-3xl ${
            alignment === 'center'
              ? 'mx-auto text-center'
              : alignment === 'right'
              ? 'ml-auto text-right'
              : 'text-left'
          }`}
        >
          <h1 className="text-5xl md:text-6xl font-bold text-white mb-6">
            {heading}
          </h1>

          <p className="text-xl md:text-2xl text-gray-200 mb-8">
            {subheading}
          </p>

          {ctaText && (
            <a
              href={ctaLink}
              className="inline-block bg-blue-600 hover:bg-blue-700 text-white font-semibold px-8 py-4 rounded-lg transition-colors"
            >
              {ctaText}
            </a>
          )}
        </div>
      </div>
    </div>
  )
}
```

---

### Editor Canvas Component

```typescript
// src/components/editor/Canvas.tsx
'use client'

import { useDroppable } from '@dnd-kit/core'
import { SortableContext, verticalListSortingStrategy } from '@dnd-kit/sortable'
import { useEditorStore } from '@/lib/editor/store'
import { DraggableBlock } from '../dnd/DraggableBlock'
import { getBlockDefinition } from '@/lib/blocks/registry'

export function Canvas() {
  const { blocks, selectedBlockId, mode } = useEditorStore()
  const { setNodeRef } = useDroppable({ id: 'canvas' })

  const canvasWidth = {
    desktop: '100%',
    tablet: '768px',
    mobile: '375px',
  }[mode]

  return (
    <div className="flex-1 overflow-auto bg-gray-50 p-8">
      <div
        ref={setNodeRef}
        className="mx-auto bg-white shadow-lg transition-all duration-300"
        style={{
          width: canvasWidth,
          minHeight: '800px',
        }}
      >
        <SortableContext
          items={blocks.map((b) => b.id)}
          strategy={verticalListSortingStrategy}
        >
          {blocks.length === 0 ? (
            <div className="flex items-center justify-center h-full text-gray-400">
              <div className="text-center">
                <p className="text-lg mb-2">Drop blocks here to start building</p>
                <p className="text-sm">Drag components from the sidebar</p>
              </div>
            </div>
          ) : (
            blocks.map((block) => {
              const definition = getBlockDefinition(block.type)
              if (!definition) return null

              const BlockComponent = definition.component

              return (
                <DraggableBlock
                  key={block.id}
                  id={block.id}
                  isSelected={selectedBlockId === block.id}
                >
                  <BlockComponent {...block} />
                </DraggableBlock>
              )
            })
          )}
        </SortableContext>
      </div>
    </div>
  )
}
```

---

### Sidebar Component

```typescript
// src/components/editor/Sidebar.tsx
'use client'

import { useState } from 'react'
import { useDraggable } from '@dnd-kit/core'
import { getBlocksByCategory } from '@/lib/blocks/registry'
import { BlockDefinition } from '@/types/blocks'

const categories = [
  { id: 'marketing', label: 'Marketing' },
  { id: 'social-proof', label: 'Social Proof' },
  { id: 'layout', label: 'Layout' },
  { id: 'content', label: 'Content' },
]

export function Sidebar() {
  const [activeCategory, setActiveCategory] = useState('marketing')

  const blocks = getBlocksByCategory(activeCategory)

  return (
    <div className="w-80 bg-white border-r border-gray-200 flex flex-col">
      {/* Header */}
      <div className="p-4 border-b border-gray-200">
        <h2 className="font-semibold text-lg">Blocks</h2>
      </div>

      {/* Categories */}
      <div className="flex border-b border-gray-200 overflow-x-auto">
        {categories.map((category) => (
          <button
            key={category.id}
            onClick={() => setActiveCategory(category.id)}
            className={`px-4 py-2 text-sm font-medium whitespace-nowrap ${
              activeCategory === category.id
                ? 'text-blue-600 border-b-2 border-blue-600'
                : 'text-gray-600 hover:text-gray-900'
            }`}
          >
            {category.label}
          </button>
        ))}
      </div>

      {/* Block list */}
      <div className="flex-1 overflow-y-auto p-4 space-y-2">
        {blocks.map((block) => (
          <BlockItem key={block.type} block={block} />
        ))}
      </div>
    </div>
  )
}

function BlockItem({ block }: { block: BlockDefinition }) {
  const { attributes, listeners, setNodeRef, isDragging } = useDraggable({
    id: block.type,
    data: { block },
  })

  const Icon = block.icon

  return (
    <div
      ref={setNodeRef}
      {...listeners}
      {...attributes}
      className={`p-4 border border-gray-200 rounded-lg cursor-move hover:border-blue-500 hover:shadow-md transition-all ${
        isDragging ? 'opacity-50' : ''
      }`}
    >
      <div className="flex items-center gap-3">
        <div className="p-2 bg-gray-100 rounded">
          <Icon className="w-5 h-5 text-gray-600" />
        </div>
        <div>
          <h3 className="font-medium text-sm">{block.label}</h3>
          <p className="text-xs text-gray-500">{block.category}</p>
        </div>
      </div>
    </div>
  )
}
```

---

### Property Panel

```typescript
// src/components/editor/PropertyPanel.tsx
'use client'

import { useEditorStore } from '@/lib/editor/store'
import { getBlockDefinition } from '@/lib/blocks/registry'
import { PropertySchema } from '@/types/blocks'

export function PropertyPanel() {
  const { blocks, selectedBlockId, updateBlock } = useEditorStore()

  const selectedBlock = blocks.find((b) => b.id === selectedBlockId)

  if (!selectedBlock) {
    return (
      <div className="w-80 bg-white border-l border-gray-200 p-4">
        <p className="text-gray-500 text-sm">Select a block to edit properties</p>
      </div>
    )
  }

  const definition = getBlockDefinition(selectedBlock.type)

  if (!definition) return null

  const handleChange = (key: string, value: any) => {
    updateBlock(selectedBlock.id, {
      props: {
        ...selectedBlock.props,
        [key]: value,
      },
    })
  }

  return (
    <div className="w-80 bg-white border-l border-gray-200 flex flex-col">
      {/* Header */}
      <div className="p-4 border-b border-gray-200">
        <h2 className="font-semibold text-lg">Properties</h2>
        <p className="text-sm text-gray-500">{definition.label}</p>
      </div>

      {/* Properties */}
      <div className="flex-1 overflow-y-auto p-4 space-y-4">
        {Object.entries(definition.schema).map(([key, schema]) => (
          <PropertyField
            key={key}
            label={schema.label}
            schema={schema}
            value={selectedBlock.props[key]}
            onChange={(value) => handleChange(key, value)}
          />
        ))}

        {/* Spacing */}
        <div className="pt-4 border-t border-gray-200">
          <h3 className="font-medium text-sm mb-3">Spacing</h3>
          <SpacingControls
            value={selectedBlock.styles || {}}
            onChange={(styles) =>
              updateBlock(selectedBlock.id, { styles })
            }
          />
        </div>

        {/* Background */}
        <div className="pt-4 border-t border-gray-200">
          <h3 className="font-medium text-sm mb-3">Background</h3>
          <PropertyField
            label="Background Color"
            schema={{ type: 'color', label: 'Color' }}
            value={selectedBlock.styles?.backgroundColor || ''}
            onChange={(value) =>
              updateBlock(selectedBlock.id, {
                styles: {
                  ...selectedBlock.styles,
                  backgroundColor: value,
                },
              })
            }
          />
        </div>
      </div>
    </div>
  )
}

function PropertyField({
  label,
  schema,
  value,
  onChange,
}: {
  label: string
  schema: PropertySchema
  value: any
  onChange: (value: any) => void
}) {
  switch (schema.type) {
    case 'text':
      return (
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            {label}
          </label>
          <input
            type="text"
            value={value || ''}
            onChange={(e) => onChange(e.target.value)}
            className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
        </div>
      )

    case 'textarea':
      return (
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            {label}
          </label>
          <textarea
            value={value || ''}
            onChange={(e) => onChange(e.target.value)}
            rows={3}
            className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
        </div>
      )

    case 'color':
      return (
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            {label}
          </label>
          <div className="flex gap-2">
            <input
              type="color"
              value={value || '#000000'}
              onChange={(e) => onChange(e.target.value)}
              className="h-10 w-16"
            />
            <input
              type="text"
              value={value || ''}
              onChange={(e) => onChange(e.target.value)}
              className="flex-1 px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            />
          </div>
        </div>
      )

    case 'select':
      return (
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            {label}
          </label>
          <select
            value={value}
            onChange={(e) => onChange(e.target.value)}
            className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
          >
            {schema.options?.map((option) => (
              <option key={option.value} value={option.value}>
                {option.label}
              </option>
            ))}
          </select>
        </div>
      )

    case 'toggle':
      return (
        <div className="flex items-center justify-between">
          <label className="text-sm font-medium text-gray-700">{label}</label>
          <button
            onClick={() => onChange(!value)}
            className={`relative inline-flex h-6 w-11 items-center rounded-full transition-colors ${
              value ? 'bg-blue-600' : 'bg-gray-200'
            }`}
          >
            <span
              className={`inline-block h-4 w-4 transform rounded-full bg-white transition-transform ${
                value ? 'translate-x-6' : 'translate-x-1'
              }`}
            />
          </button>
        </div>
      )

    default:
      return null
  }
}

function SpacingControls({ value, onChange }: any) {
  return (
    <div className="space-y-2">
      <div className="grid grid-cols-2 gap-2">
        <div>
          <label className="block text-xs text-gray-600 mb-1">Padding</label>
          <input
            type="text"
            value={value.padding || ''}
            onChange={(e) => onChange({ ...value, padding: e.target.value })}
            placeholder="e.g., 20px"
            className="w-full px-2 py-1 text-sm border border-gray-300 rounded"
          />
        </div>
        <div>
          <label className="block text-xs text-gray-600 mb-1">Margin</label>
          <input
            type="text"
            value={value.margin || ''}
            onChange={(e) => onChange({ ...value, margin: e.target.value })}
            placeholder="e.g., 20px"
            className="w-full px-2 py-1 text-sm border border-gray-300 rounded"
          />
        </div>
      </div>
    </div>
  )
}
```

---

## 🔧 Configuration Files

### package.json

```json
{
  "name": "landing-page-builder",
  "version": "1.0.0",
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "db:push": "prisma db push",
    "db:studio": "prisma studio",
    "seed": "tsx prisma/seed.ts"
  },
  "dependencies": {
    "next": "^15.0.0",
    "react": "^19.0.0",
    "react-dom": "^19.0.0",
    "@dnd-kit/core": "^6.1.0",
    "@dnd-kit/sortable": "^8.0.0",
    "@prisma/client": "^5.15.0",
    "zustand": "^4.5.0",
    "@tiptap/react": "^2.4.0",
    "@tiptap/starter-kit": "^2.4.0",
    "lucide-react": "^0.395.0",
    "zod": "^3.23.0",
    "next-auth": "^4.24.0"
  },
  "devDependencies": {
    "@types/node": "^20",
    "@types/react": "^19",
    "typescript": "^5",
    "tsx": "^4.15.0",
    "prisma": "^5.15.0",
    "tailwindcss": "^3.4.0",
    "postcss": "^8",
    "autoprefixer": "^10.4.0"
  }
}
```

---

## 📈 Features Roadmap

### Phase 1 (MVP) ✅
- Basic drag & drop
- 6 core blocks
- Property editing
- Save/Load pages

### Phase 2
- More blocks (20+ total)
- Rich text editor (TipTap)
- Image uploads
- Template gallery

### Phase 3
- Custom CSS/JS
- SEO editor
- Responsive breakpoints
- Export to HTML

### Phase 4
- Collaboration
- Version history
- A/B testing
- Analytics

---

**Estimated Time**: 6-8 hours for MVP

**Difficulty**: Advanced

**Prerequisites**: Next.js, React, TypeScript, Drag & Drop concepts
