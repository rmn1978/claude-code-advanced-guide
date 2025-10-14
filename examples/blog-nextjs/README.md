# 📝 Blog Static - Next.js 15

Modern static blog with MDX, optimized for SEO and performance using Next.js 15 App Router.

## 📋 Overview

**Descripción**: Blog estático con contenido MDX, optimizado para SEO, Core Web Vitals, y máximo performance.

**Stack**:
- **Frontend**: Next.js 15, React 18, TypeScript, Tailwind CSS
- **Content**: MDX (Markdown + React Components)
- **SEO**: Next.js metadata API, structured data
- **Deployment**: Vercel (with automatic ISR)

**Tiempo estimado**: 1-2 horas

**Nivel**: 🟢 Básico (perfecto para aprender Next.js)

---

## ✨ Features

### Content Features
- ✅ MDX blog posts with React components
- ✅ Syntax highlighting for code blocks
- ✅ Reading time estimation
- ✅ Table of contents generation
- ✅ Categories and tags
- ✅ Search functionality
- ✅ Related posts
- ✅ Author information
- ✅ RSS feed

### Design Features
- ✅ Responsive design (mobile-first)
- ✅ Dark mode support
- ✅ Custom fonts (next/font)
- ✅ Optimized images (next/image)
- ✅ Smooth animations
- ✅ Reading progress bar

### Technical Features
- ✅ Static Site Generation (SSG)
- ✅ Incremental Static Regeneration (ISR)
- ✅ SEO optimized (metadata, Open Graph, Twitter Cards)
- ✅ Sitemap generation
- ✅ robots.txt
- ✅ Analytics ready (Vercel Analytics)
- ✅ Core Web Vitals optimized
- ✅ Lighthouse score 100

---

## 🏗️ Architecture

```
┌────────────────────────────────────────────┐
│         User (Browser)                      │
└──────────────────┬─────────────────────────┘
                   │
                   │ Request: /blog/my-post
                   │
┌──────────────────▼─────────────────────────┐
│      Next.js 15 (App Router)               │
├────────────────────────────────────────────┤
│                                             │
│  ┌──────────────────────────────────────┐ │
│  │  Server Components (Default)         │ │
│  │  • Blog listing (SSG)                │ │
│  │  • Post page (SSG + ISR)             │ │
│  │  • Category pages (SSG)              │ │
│  └──────────────────────────────────────┘ │
│                                             │
│  ┌──────────────────────────────────────┐ │
│  │  MDX Processing                      │ │
│  │  • Parse frontmatter                 │ │
│  │  • Generate reading time             │ │
│  │  • Render React components           │ │
│  │  • Apply syntax highlighting         │ │
│  └──────────────────────────────────────┘ │
│                                             │
└──────────────────┬─────────────────────────┘
                   │
                   │ Static HTML + JSON
                   │
            ┌──────▼──────┐
            │   Vercel    │
            │   CDN       │
            │  (Cached)   │
            └─────────────┘

Content Workflow:
┌──────────────┐
│   Author     │
│  Writes MDX  │
└──────┬───────┘
       │
       │ content/posts/my-post.mdx
       │
┌──────▼───────┐
│  Build Time  │
│  • Parse MDX │
│  • Generate  │
│  • Optimize  │
└──────┬───────┘
       │
       │ Static HTML
       │
┌──────▼───────┐
│   Deploy     │
│  (Instant)   │
└──────────────┘
```

---

## 🚀 Quick Start

### Prerequisites

```bash
# Required
- Node.js 18+

# Optional
- VSCode with MDX extension
```

### Setup con Claude Code

**Opción 1: Usar el agente Next.js (Recomendado)**

```bash
# En Claude Code
> Use nextjs-architect to create a static blog with:
  - Next.js 15 App Router
  - MDX for blog posts
  - Blog listing page with pagination
  - Individual post pages with reading time
  - Categories and tags pages
  - Search functionality
  - Dark mode toggle
  - SEO optimization (metadata, Open Graph)
  - RSS feed generation
  - Sitemap
  - Syntax highlighting for code
  - Table of contents
  - Related posts
  - Responsive design with Tailwind CSS
  - Analytics integration

# El agente creará toda la estructura automáticamente
```

**Opción 2: Manual Setup**

```bash
# 1. Create Next.js app
npx create-next-app@latest blog-nextjs --typescript --tailwind --app

# 2. Install dependencies
npm install @next/mdx next-mdx-remote gray-matter reading-time rehype-highlight rehype-slug rehype-autolink-headings

# 3. Start development server
npm run dev
```

### Access the Blog

```bash
# Development
http://localhost:3000

# Blog listing
http://localhost:3000/blog

# Individual post
http://localhost:3000/blog/my-first-post
```

---

## 📁 Project Structure

```
blog-nextjs/
├── app/
│   ├── layout.tsx                 # Root layout
│   ├── page.tsx                   # Homepage
│   ├── blog/
│   │   ├── page.tsx               # Blog listing (SSG)
│   │   ├── [slug]/
│   │   │   └── page.tsx           # Blog post page (SSG + ISR)
│   │   └── category/
│   │       └── [category]/
│   │           └── page.tsx       # Category page (SSG)
│   ├── about/
│   │   └── page.tsx
│   └── api/
│       └── rss/
│           └── route.ts           # RSS feed generation
├── components/
│   ├── blog/
│   │   ├── PostCard.tsx           # Blog post preview
│   │   ├── PostContent.tsx        # MDX renderer
│   │   ├── TableOfContents.tsx
│   │   ├── RelatedPosts.tsx
│   │   ├── SearchBar.tsx
│   │   └── CategoryBadge.tsx
│   ├── layout/
│   │   ├── Header.tsx
│   │   ├── Footer.tsx
│   │   └── Navigation.tsx
│   └── ui/
│       ├── DarkModeToggle.tsx
│       └── ReadingProgress.tsx
├── content/
│   └── posts/
│       ├── my-first-post.mdx      # Blog posts in MDX
│       ├── nextjs-tutorial.mdx
│       └── typescript-tips.mdx
├── lib/
│   ├── mdx.ts                     # MDX processing utilities
│   ├── posts.ts                   # Get/filter posts
│   ├── search.ts                  # Search functionality
│   └── seo.ts                     # SEO utilities
├── types/
│   └── post.ts                    # TypeScript types
├── public/
│   ├── images/                    # Blog post images
│   └── og/                        # Open Graph images
├── styles/
│   └── mdx.css                    # MDX content styling
├── next.config.js                 # Next.js configuration
├── tailwind.config.ts
└── README.md
```

---

## 📝 Creating Blog Posts

### MDX File Format

```mdx
---
title: 'Getting Started with Next.js 15'
date: '2025-01-15'
author: 'John Doe'
category: 'Tutorial'
tags: ['nextjs', 'react', 'typescript']
excerpt: 'Learn how to build modern web applications with Next.js 15 App Router'
coverImage: '/images/nextjs-tutorial.jpg'
---

# Getting Started with Next.js 15

Next.js 15 introduces powerful new features for building modern web applications.

## Why Next.js?

Next.js provides an excellent developer experience with features like:

- **Server Components** for better performance
- **App Router** for intuitive routing
- **Built-in optimization** for images, fonts, and scripts

## Installation

```bash
npx create-next-app@latest my-app
```

## Your First Component

You can embed React components directly in MDX:

<CustomComponent />

## Conclusion

Next.js 15 is amazing for building modern web apps!
```

### Frontmatter Fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `title` | string | ✅ | Post title |
| `date` | string | ✅ | Publication date (YYYY-MM-DD) |
| `author` | string | ✅ | Author name |
| `category` | string | ✅ | Primary category |
| `tags` | array | ✅ | Tags for filtering |
| `excerpt` | string | ✅ | Short description (for listing) |
| `coverImage` | string | ❌ | Cover image path |
| `draft` | boolean | ❌ | Hide from production |

---

## 🎨 MDX Features

### Custom Components

```tsx
// components/mdx/Callout.tsx
export function Callout({ type = 'info', children }) {
  return (
    <div className={`callout callout-${type}`}>
      {children}
    </div>
  )
}

// Use in MDX:
<Callout type="warning">
  This is important information!
</Callout>
```

### Code Blocks with Syntax Highlighting

```mdx
```typescript
// Automatically highlighted
const hello = (name: string) => {
  console.log(`Hello, ${name}!`)
}
```
```

### Table of Contents

```tsx
// Automatically generated from headings
<TableOfContents headings={headings} />
```

---

## 🔍 SEO Optimization

### Metadata Generation

```typescript
// app/blog/[slug]/page.tsx
export async function generateMetadata({ params }): Promise<Metadata> {
  const post = await getPost(params.slug)

  return {
    title: post.title,
    description: post.excerpt,
    authors: [{ name: post.author }],
    openGraph: {
      title: post.title,
      description: post.excerpt,
      type: 'article',
      publishedTime: post.date,
      images: [post.coverImage],
    },
    twitter: {
      card: 'summary_large_image',
      title: post.title,
      description: post.excerpt,
      images: [post.coverImage],
    },
  }
}
```

### Structured Data

```typescript
// JSON-LD for blog posts
const structuredData = {
  '@context': 'https://schema.org',
  '@type': 'BlogPosting',
  headline: post.title,
  image: post.coverImage,
  datePublished: post.date,
  author: {
    '@type': 'Person',
    name: post.author,
  },
}
```

### Sitemap

```typescript
// app/sitemap.ts
export default function sitemap(): MetadataRoute.Sitemap {
  const posts = getAllPosts()

  return [
    {
      url: 'https://yourblog.com',
      lastModified: new Date(),
    },
    ...posts.map((post) => ({
      url: `https://yourblog.com/blog/${post.slug}`,
      lastModified: new Date(post.date),
    })),
  ]
}
```

---

## 🚀 Performance Optimization

### Image Optimization

```tsx
// Automatic optimization with next/image
import Image from 'next/image'

<Image
  src={post.coverImage}
  alt={post.title}
  width={1200}
  height={630}
  priority={isFirstPost}
  placeholder="blur"
  blurDataURL={post.blurDataURL}
/>
```

### Font Optimization

```tsx
// app/layout.tsx
import { Inter, JetBrains_Mono } from 'next/font/google'

const inter = Inter({
  subsets: ['latin'],
  display: 'swap',
  variable: '--font-inter',
})

const jetbrainsMono = JetBrains_Mono({
  subsets: ['latin'],
  display: 'swap',
  variable: '--font-mono',
})
```

### Static Generation

```typescript
// Generate pages at build time
export async function generateStaticParams() {
  const posts = getAllPosts()

  return posts.map((post) => ({
    slug: post.slug,
  }))
}

// ISR: Revalidate every hour
export const revalidate = 3600
```

---

## 🎯 Features Implementation

### Search

```tsx
'use client'

import { useState } from 'react'
import { searchPosts } from '@/lib/search'

export function SearchBar() {
  const [query, setQuery] = useState('')
  const [results, setResults] = useState([])

  const handleSearch = (e) => {
    const q = e.target.value
    setQuery(q)

    if (q.length > 2) {
      const filtered = searchPosts(q)
      setResults(filtered)
    } else {
      setResults([])
    }
  }

  return (
    <div>
      <input
        type="search"
        value={query}
        onChange={handleSearch}
        placeholder="Search posts..."
      />

      {results.length > 0 && (
        <ul>
          {results.map((post) => (
            <li key={post.slug}>
              <Link href={`/blog/${post.slug}`}>
                {post.title}
              </Link>
            </li>
          ))}
        </ul>
      )}
    </div>
  )
}
```

### Reading Progress

```tsx
'use client'

import { useEffect, useState } from 'react'

export function ReadingProgress() {
  const [progress, setProgress] = useState(0)

  useEffect(() => {
    const updateProgress = () => {
      const scrolled = window.scrollY
      const height = document.documentElement.scrollHeight - window.innerHeight
      const progress = (scrolled / height) * 100
      setProgress(progress)
    }

    window.addEventListener('scroll', updateProgress)
    return () => window.removeEventListener('scroll', updateProgress)
  }, [])

  return (
    <div className="fixed top-0 left-0 right-0 h-1 bg-gray-200">
      <div
        className="h-full bg-blue-600 transition-all"
        style={{ width: `${progress}%` }}
      />
    </div>
  )
}
```

### Dark Mode

```tsx
// app/providers.tsx
'use client'

import { ThemeProvider } from 'next-themes'

export function Providers({ children }) {
  return (
    <ThemeProvider attribute="class" defaultTheme="system">
      {children}
    </ThemeProvider>
  )
}

// components/DarkModeToggle.tsx
'use client'

import { useTheme } from 'next-themes'

export function DarkModeToggle() {
  const { theme, setTheme } = useTheme()

  return (
    <button
      onClick={() => setTheme(theme === 'dark' ? 'light' : 'dark')}
    >
      {theme === 'dark' ? '🌞' : '🌙'}
    </button>
  )
}
```

---

## 🎓 Learning Objectives

Al completar este ejemplo, aprenderás:

### Next.js 15
- ✅ App Router architecture
- ✅ Server Components by default
- ✅ Static Site Generation (SSG)
- ✅ Incremental Static Regeneration (ISR)
- ✅ Metadata API for SEO
- ✅ Image and font optimization

### MDX
- ✅ Writing content in MDX
- ✅ Frontmatter parsing
- ✅ Custom React components in markdown
- ✅ Syntax highlighting
- ✅ Table of contents generation

### SEO
- ✅ Metadata and Open Graph
- ✅ Structured data (JSON-LD)
- ✅ Sitemap generation
- ✅ RSS feed
- ✅ Performance optimization

### Performance
- ✅ Core Web Vitals
- ✅ Lighthouse optimization
- ✅ Image optimization
- ✅ Code splitting
- ✅ Static generation

---

## 🚢 Deployment

### Deploy to Vercel (Recommended)

```bash
# 1. Install Vercel CLI
npm i -g vercel

# 2. Deploy
vercel

# Or connect from GitHub
# - Push to GitHub
# - Import project in Vercel dashboard
# - Automatic deployments on git push
```

### Build Locally

```bash
# Production build
npm run build

# Test production build
npm start

# Static export (if needed)
npm run build && npx next export
```

### Environment Variables

```bash
# .env.local
NEXT_PUBLIC_SITE_URL=https://yourblog.com
NEXT_PUBLIC_GA_ID=G-XXXXXXXXXX

# For Vercel, add in dashboard:
# Settings → Environment Variables
```

---

## 📊 Performance Metrics

### Target Scores

- **Lighthouse Performance**: 100
- **SEO**: 100
- **Accessibility**: 100
- **Best Practices**: 100

### Core Web Vitals

- **LCP** (Largest Contentful Paint): < 2.5s
- **FID** (First Input Delay): < 100ms
- **CLS** (Cumulative Layout Shift): < 0.1

### Optimization Techniques Used

- ✅ Static generation (no server runtime)
- ✅ Image optimization (WebP, AVIF)
- ✅ Font optimization (next/font)
- ✅ Code splitting (dynamic imports)
- ✅ Minimal JavaScript (Server Components)
- ✅ CDN caching (Vercel Edge)

---

## 💡 Next Steps

Después de completar este blog básico:

### Add More Features
1. **Comments**: Add Giscus (GitHub Discussions)
2. **Newsletter**: Integrate ConvertKit or Mailchimp
3. **Views Counter**: Track post views
4. **Reactions**: Add emoji reactions
5. **Series**: Group related posts
6. **Authors**: Multiple author support

### Enhance Content
1. **Code Playground**: Embed runnable code (CodeSandbox)
2. **Diagrams**: Add Mermaid diagrams
3. **Math**: Add KaTeX for equations
4. **Videos**: Embed YouTube videos
5. **Interactive Components**: Charts, quizzes

### Improve Functionality
1. **RSS Feed**: Full content RSS
2. **JSON Feed**: Alternative feed format
3. **AMP Pages**: Accelerated Mobile Pages
4. **PWA**: Progressive Web App
5. **i18n**: Multi-language support

---

## 🔗 Resources

- **Next.js Architect Agent**: [`../../agents/stacks/react-next/nextjs-architect.md`](../../agents/stacks/react-next/nextjs-architect.md)
- **Next.js Documentation**: https://nextjs.org/docs
- **MDX Documentation**: https://mdxjs.com
- **Tailwind CSS**: https://tailwindcss.com

---

## 🆚 Comparison

| Feature | This Blog | WordPress | Gatsby | Hugo |
|---------|-----------|-----------|--------|------|
| **Setup Time** | 1-2 hours | 30 min | 2-3 hours | 1-2 hours |
| **Performance** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **Developer Experience** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ |
| **React Components** | ✅ | ❌ | ✅ | ❌ |
| **TypeScript** | ✅ | ❌ | ✅ | ❌ |
| **Hosting** | Vercel (free) | Requires hosting | Vercel/Netlify | Vercel/Netlify |
| **Database** | None | MySQL | None | None |

---

**¿Listo para empezar?** Usa el agente `nextjs-architect` para crear este blog en 1-2 horas.

**Próximo paso**: Después de dominar este blog estático, intenta agregar un CMS como [Sanity](https://www.sanity.io) o [Contentful](https://www.contentful.com), o explora el [E-commerce example](../ecommerce-nextjs-fastapi/) para full-stack development.
