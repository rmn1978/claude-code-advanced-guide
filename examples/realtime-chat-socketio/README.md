# 💬 Real-Time Chat Application

**Stack**: Next.js 15 + Socket.io + Redis + PostgreSQL + TypeScript

**Nivel**: Intermedio (4-5 horas)

**Descripción**: Aplicación de chat en tiempo real con salas, mensajes directos, typing indicators, y presencia de usuarios.

## 🎯 Características

### Core Features
- ✅ Real-time messaging con Socket.io
- ✅ Salas públicas y privadas
- ✅ Mensajes directos (DMs)
- ✅ Typing indicators
- ✅ Online/offline presence
- ✅ Message history con paginación
- ✅ File uploads (imágenes)
- ✅ Read receipts
- ✅ Emoji reactions

### Advanced Features
- ✅ Redis pub/sub para múltiples servidores
- ✅ Message search
- ✅ User mentions (@username)
- ✅ Markdown support
- ✅ Push notifications
- ✅ Unread message counter

## 🏗️ Arquitectura

```
realtime-chat-socketio/
├── src/
│   ├── app/
│   │   ├── (auth)/
│   │   │   ├── login/page.tsx
│   │   │   └── register/page.tsx
│   │   ├── chat/
│   │   │   ├── [roomId]/page.tsx
│   │   │   └── layout.tsx
│   │   ├── api/
│   │   │   ├── auth/[...nextauth]/route.ts
│   │   │   ├── rooms/route.ts
│   │   │   ├── messages/route.ts
│   │   │   └── upload/route.ts
│   │   └── layout.tsx
│   ├── components/
│   │   ├── chat/
│   │   │   ├── ChatRoom.tsx
│   │   │   ├── MessageList.tsx
│   │   │   ├── MessageInput.tsx
│   │   │   ├── UserList.tsx
│   │   │   └── TypingIndicator.tsx
│   │   ├── rooms/
│   │   │   ├── RoomList.tsx
│   │   │   ├── CreateRoomModal.tsx
│   │   │   └── RoomItem.tsx
│   │   └── ui/
│   ├── lib/
│   │   ├── socket/
│   │   │   ├── client.ts
│   │   │   └── server.ts
│   │   ├── redis.ts
│   │   ├── prisma.ts
│   │   └── auth.ts
│   ├── hooks/
│   │   ├── useSocket.ts
│   │   ├── useMessages.ts
│   │   ├── useTyping.ts
│   │   └── usePresence.ts
│   └── types/
│       ├── socket.ts
│       └── message.ts
├── prisma/
│   └── schema.prisma
├── server.ts                 # Custom server for Socket.io
├── package.json
├── tsconfig.json
└── docker-compose.yml
```

## 🚀 Quick Start

### 1. Usando Claude Code (Recomendado)

```bash
> Use nextjs-architect to create a real-time chat application with:
  - Next.js 15 with App Router
  - Socket.io for real-time messaging
  - PostgreSQL for message persistence
  - Redis for pub/sub
  - User authentication with NextAuth
  - File uploads to S3
  - Typing indicators and presence
```

### 2. Setup Manual

```bash
# Clonar e instalar
git clone <repo>
cd realtime-chat-socketio
npm install

# Setup environment
cp .env.example .env
# Editar .env con tus credenciales

# Setup database
npx prisma generate
npx prisma db push

# Run development
npm run dev

# En otra terminal, run Socket.io server
npm run dev:socket
```

### 3. Acceder a la app

- Frontend: http://localhost:3000
- Socket.io: ws://localhost:3001

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
  id            String    @id @default(cuid())
  email         String    @unique
  username      String    @unique
  name          String
  avatar        String?
  password      String
  createdAt     DateTime  @default(now())
  updatedAt     DateTime  @updatedAt

  messages      Message[]
  roomMembers   RoomMember[]
  reactions     Reaction[]
  readReceipts  ReadReceipt[]
}

model Room {
  id          String       @id @default(cuid())
  name        String
  description String?
  isPrivate   Boolean      @default(false)
  createdBy   String
  createdAt   DateTime     @default(now())
  updatedAt   DateTime     @updatedAt

  messages    Message[]
  members     RoomMember[]

  @@index([createdAt])
}

model RoomMember {
  id        String   @id @default(cuid())
  roomId    String
  userId    String
  role      String   @default("member") // admin, moderator, member
  joinedAt  DateTime @default(now())

  room      Room     @relation(fields: [roomId], references: [id], onDelete: Cascade)
  user      User     @relation(fields: [userId], references: [id], onDelete: Cascade)

  @@unique([roomId, userId])
  @@index([roomId])
  @@index([userId])
}

model Message {
  id          String       @id @default(cuid())
  content     String       @db.Text
  roomId      String
  userId      String
  type        String       @default("text") // text, image, file
  fileUrl     String?
  replyToId   String?
  createdAt   DateTime     @default(now())
  updatedAt   DateTime     @updatedAt

  room        Room         @relation(fields: [roomId], references: [id], onDelete: Cascade)
  user        User         @relation(fields: [userId], references: [id], onDelete: Cascade)
  replyTo     Message?     @relation("MessageReplies", fields: [replyToId], references: [id])
  replies     Message[]    @relation("MessageReplies")
  reactions   Reaction[]
  readReceipts ReadReceipt[]

  @@index([roomId, createdAt])
  @@index([userId])
}

model Reaction {
  id        String   @id @default(cuid())
  emoji     String
  messageId String
  userId    String
  createdAt DateTime @default(now())

  message   Message  @relation(fields: [messageId], references: [id], onDelete: Cascade)
  user      User     @relation(fields: [userId], references: [id], onDelete: Cascade)

  @@unique([messageId, userId, emoji])
  @@index([messageId])
}

model ReadReceipt {
  id        String   @id @default(cuid())
  messageId String
  userId    String
  readAt    DateTime @default(now())

  message   Message  @relation(fields: [messageId], references: [id], onDelete: Cascade)
  user      User     @relation(fields: [userId], references: [id], onDelete: Cascade)

  @@unique([messageId, userId])
  @@index([messageId])
  @@index([userId])
}
```

---

### Socket.io Server

```typescript
// server.ts
import { createServer } from 'http'
import { Server } from 'socket.io'
import { createAdapter } from '@socket.io/redis-adapter'
import { createClient } from 'redis'
import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()
const httpServer = createServer()

// Redis clients for pub/sub
const pubClient = createClient({ url: process.env.REDIS_URL })
const subClient = pubClient.duplicate()

Promise.all([pubClient.connect(), subClient.connect()]).then(() => {
  const io = new Server(httpServer, {
    cors: {
      origin: process.env.FRONTEND_URL || 'http://localhost:3000',
      credentials: true,
    },
  })

  // Use Redis adapter for horizontal scaling
  io.adapter(createAdapter(pubClient, subClient))

  // Middleware: Authentication
  io.use(async (socket, next) => {
    const token = socket.handshake.auth.token

    if (!token) {
      return next(new Error('Authentication required'))
    }

    try {
      // Verify JWT token (implement your auth logic)
      const decoded = verifyToken(token)
      socket.data.userId = decoded.userId
      socket.data.username = decoded.username
      next()
    } catch (error) {
      next(new Error('Invalid token'))
    }
  })

  // Connection handler
  io.on('connection', async (socket) => {
    const userId = socket.data.userId
    const username = socket.data.username

    console.log(`User connected: ${username} (${userId})`)

    // Join user's personal room for direct messages
    socket.join(`user:${userId}`)

    // Broadcast online status
    io.emit('user:online', { userId, username })

    // Store user socket mapping in Redis
    await pubClient.set(`socket:${userId}`, socket.id, { EX: 3600 })

    // Get user's rooms and join them
    const roomMembers = await prisma.roomMember.findMany({
      where: { userId },
      include: { room: true },
    })

    roomMembers.forEach((member) => {
      socket.join(`room:${member.roomId}`)
    })

    // Handle joining a room
    socket.on('room:join', async ({ roomId }) => {
      try {
        // Check if user is member
        const member = await prisma.roomMember.findUnique({
          where: {
            roomId_userId: { roomId, userId },
          },
          include: { room: true },
        })

        if (!member) {
          return socket.emit('error', { message: 'Not a member of this room' })
        }

        socket.join(`room:${roomId}`)

        // Notify room members
        io.to(`room:${roomId}`).emit('room:user-joined', {
          roomId,
          user: { userId, username },
        })

        socket.emit('room:joined', { room: member.room })
      } catch (error) {
        socket.emit('error', { message: 'Failed to join room' })
      }
    })

    // Handle leaving a room
    socket.on('room:leave', ({ roomId }) => {
      socket.leave(`room:${roomId}`)

      io.to(`room:${roomId}`).emit('room:user-left', {
        roomId,
        user: { userId, username },
      })
    })

    // Handle sending a message
    socket.on('message:send', async (data) => {
      const { roomId, content, replyToId, type = 'text', fileUrl } = data

      try {
        // Save message to database
        const message = await prisma.message.create({
          data: {
            content,
            roomId,
            userId,
            type,
            fileUrl,
            replyToId,
          },
          include: {
            user: {
              select: {
                id: true,
                username: true,
                name: true,
                avatar: true,
              },
            },
            replyTo: {
              include: {
                user: {
                  select: {
                    username: true,
                  },
                },
              },
            },
          },
        })

        // Broadcast to room
        io.to(`room:${roomId}`).emit('message:new', message)

        // Clear typing indicator
        io.to(`room:${roomId}`).emit('typing:stop', { userId, roomId })
      } catch (error) {
        console.error('Error sending message:', error)
        socket.emit('error', { message: 'Failed to send message' })
      }
    })

    // Handle typing indicator
    socket.on('typing:start', ({ roomId }) => {
      socket.to(`room:${roomId}`).emit('typing:start', {
        userId,
        username,
        roomId,
      })
    })

    socket.on('typing:stop', ({ roomId }) => {
      socket.to(`room:${roomId}`).emit('typing:stop', { userId, roomId })
    })

    // Handle message reactions
    socket.on('message:react', async ({ messageId, emoji }) => {
      try {
        // Toggle reaction in database
        const existing = await prisma.reaction.findUnique({
          where: {
            messageId_userId_emoji: { messageId, userId, emoji },
          },
        })

        if (existing) {
          // Remove reaction
          await prisma.reaction.delete({ where: { id: existing.id } })
        } else {
          // Add reaction
          await prisma.reaction.create({
            data: { messageId, userId, emoji },
          })
        }

        // Get updated reactions
        const reactions = await prisma.reaction.groupBy({
          by: ['emoji'],
          where: { messageId },
          _count: { emoji: true },
        })

        // Get message to find room
        const message = await prisma.message.findUnique({
          where: { id: messageId },
          select: { roomId: true },
        })

        // Broadcast to room
        io.to(`room:${message!.roomId}`).emit('message:reactions', {
          messageId,
          reactions,
        })
      } catch (error) {
        socket.emit('error', { message: 'Failed to react to message' })
      }
    })

    // Handle read receipts
    socket.on('message:read', async ({ messageId }) => {
      try {
        await prisma.readReceipt.upsert({
          where: {
            messageId_userId: { messageId, userId },
          },
          create: { messageId, userId },
          update: { readAt: new Date() },
        })

        // Get message to find room
        const message = await prisma.message.findUnique({
          where: { id: messageId },
          select: { roomId: true },
        })

        // Notify message author
        io.to(`room:${message!.roomId}`).emit('message:read', {
          messageId,
          userId,
        })
      } catch (error) {
        console.error('Error marking message as read:', error)
      }
    })

    // Handle direct messages
    socket.on('dm:send', async ({ recipientId, content }) => {
      try {
        // Find or create DM room
        let room = await prisma.room.findFirst({
          where: {
            isPrivate: true,
            members: {
              every: {
                userId: { in: [userId, recipientId] },
              },
            },
          },
        })

        if (!room) {
          // Create new DM room
          room = await prisma.room.create({
            data: {
              name: 'Direct Message',
              isPrivate: true,
              createdBy: userId,
              members: {
                create: [
                  { userId },
                  { userId: recipientId },
                ],
              },
            },
          })
        }

        // Create message
        const message = await prisma.message.create({
          data: {
            content,
            roomId: room.id,
            userId,
          },
          include: {
            user: {
              select: {
                id: true,
                username: true,
                name: true,
                avatar: true,
              },
            },
          },
        })

        // Send to both users
        io.to(`user:${userId}`).emit('dm:new', message)
        io.to(`user:${recipientId}`).emit('dm:new', message)
      } catch (error) {
        socket.emit('error', { message: 'Failed to send DM' })
      }
    })

    // Handle disconnect
    socket.on('disconnect', async () => {
      console.log(`User disconnected: ${username}`)

      // Remove socket mapping
      await pubClient.del(`socket:${userId}`)

      // Broadcast offline status
      io.emit('user:offline', { userId, username })
    })
  })

  const PORT = process.env.SOCKET_PORT || 3001
  httpServer.listen(PORT, () => {
    console.log(`Socket.io server running on port ${PORT}`)
  })
})

function verifyToken(token: string) {
  // Implement JWT verification
  // Return { userId, username, email }
}
```

---

### Socket.io Client Hook

```typescript
// src/hooks/useSocket.ts
'use client'

import { useEffect, useState } from 'react'
import { io, Socket } from 'socket.io-client'
import { useSession } from 'next-auth/react'

export function useSocket() {
  const [socket, setSocket] = useState<Socket | null>(null)
  const [isConnected, setIsConnected] = useState(false)
  const { data: session } = useSession()

  useEffect(() => {
    if (!session?.user) return

    const socketInstance = io(process.env.NEXT_PUBLIC_SOCKET_URL || 'http://localhost:3001', {
      auth: {
        token: session.accessToken,
      },
      reconnection: true,
      reconnectionAttempts: 5,
      reconnectionDelay: 1000,
    })

    socketInstance.on('connect', () => {
      console.log('Socket connected')
      setIsConnected(true)
    })

    socketInstance.on('disconnect', () => {
      console.log('Socket disconnected')
      setIsConnected(false)
    })

    socketInstance.on('error', (error: any) => {
      console.error('Socket error:', error)
    })

    setSocket(socketInstance)

    return () => {
      socketInstance.disconnect()
    }
  }, [session])

  return { socket, isConnected }
}
```

---

### Chat Room Component

```typescript
// src/components/chat/ChatRoom.tsx
'use client'

import { useState, useEffect, useRef } from 'react'
import { useSocket } from '@/hooks/useSocket'
import { MessageList } from './MessageList'
import { MessageInput } from './MessageInput'
import { UserList } from './UserList'
import { TypingIndicator } from './TypingIndicator'

interface Message {
  id: string
  content: string
  userId: string
  user: {
    id: string
    username: string
    name: string
    avatar?: string
  }
  createdAt: string
  replyTo?: {
    id: string
    content: string
    user: { username: string }
  }
  reactions?: Array<{
    emoji: string
    count: number
  }>
}

interface ChatRoomProps {
  roomId: string
}

export function ChatRoom({ roomId }: ChatRoomProps) {
  const { socket, isConnected } = useSocket()
  const [messages, setMessages] = useState<Message[]>([])
  const [typingUsers, setTypingUsers] = useState<string[]>([])
  const [onlineUsers, setOnlineUsers] = useState<string[]>([])
  const messagesEndRef = useRef<HTMLDivElement>(null)

  // Fetch initial messages
  useEffect(() => {
    async function fetchMessages() {
      const res = await fetch(`/api/messages?roomId=${roomId}`)
      const data = await res.json()
      setMessages(data.messages)
    }

    fetchMessages()
  }, [roomId])

  // Socket event listeners
  useEffect(() => {
    if (!socket) return

    // Join room
    socket.emit('room:join', { roomId })

    // Listen for new messages
    socket.on('message:new', (message: Message) => {
      setMessages((prev) => [...prev, message])
      scrollToBottom()
    })

    // Listen for typing indicators
    socket.on('typing:start', ({ userId, username }) => {
      setTypingUsers((prev) => [...new Set([...prev, username])])
    })

    socket.on('typing:stop', ({ userId }) => {
      setTypingUsers((prev) => prev.filter((u) => u !== userId))
    })

    // Listen for user presence
    socket.on('user:online', ({ userId, username }) => {
      setOnlineUsers((prev) => [...new Set([...prev, username])])
    })

    socket.on('user:offline', ({ userId, username }) => {
      setOnlineUsers((prev) => prev.filter((u) => u !== username))
    })

    // Listen for reactions
    socket.on('message:reactions', ({ messageId, reactions }) => {
      setMessages((prev) =>
        prev.map((msg) =>
          msg.id === messageId ? { ...msg, reactions } : msg
        )
      )
    })

    return () => {
      socket.emit('room:leave', { roomId })
      socket.off('message:new')
      socket.off('typing:start')
      socket.off('typing:stop')
      socket.off('user:online')
      socket.off('user:offline')
      socket.off('message:reactions')
    }
  }, [socket, roomId])

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' })
  }

  const handleSendMessage = (content: string, replyToId?: string) => {
    if (!socket) return

    socket.emit('message:send', {
      roomId,
      content,
      replyToId,
    })
  }

  const handleTyping = () => {
    if (!socket) return
    socket.emit('typing:start', { roomId })

    // Stop typing after 2 seconds of inactivity
    setTimeout(() => {
      socket.emit('typing:stop', { roomId })
    }, 2000)
  }

  const handleReact = (messageId: string, emoji: string) => {
    if (!socket) return
    socket.emit('message:react', { messageId, emoji })
  }

  if (!isConnected) {
    return (
      <div className="flex items-center justify-center h-screen">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-500 mx-auto mb-4" />
          <p className="text-gray-600">Connecting to chat...</p>
        </div>
      </div>
    )
  }

  return (
    <div className="flex h-screen">
      {/* Main chat area */}
      <div className="flex-1 flex flex-col">
        {/* Messages */}
        <div className="flex-1 overflow-y-auto p-4 space-y-4">
          <MessageList
            messages={messages}
            onReact={handleReact}
          />
          <div ref={messagesEndRef} />
        </div>

        {/* Typing indicator */}
        {typingUsers.length > 0 && (
          <TypingIndicator users={typingUsers} />
        )}

        {/* Message input */}
        <MessageInput
          onSend={handleSendMessage}
          onTyping={handleTyping}
        />
      </div>

      {/* User list sidebar */}
      <UserList onlineUsers={onlineUsers} />
    </div>
  )
}
```

---

### Message Input Component

```typescript
// src/components/chat/MessageInput.tsx
'use client'

import { useState, useRef } from 'react'
import { Paperclip, Send, Smile } from 'lucide-react'
import EmojiPicker from 'emoji-picker-react'

interface MessageInputProps {
  onSend: (content: string, replyToId?: string) => void
  onTyping: () => void
  replyTo?: { id: string; username: string; content: string }
  onCancelReply?: () => void
}

export function MessageInput({
  onSend,
  onTyping,
  replyTo,
  onCancelReply,
}: MessageInputProps) {
  const [message, setMessage] = useState('')
  const [showEmojiPicker, setShowEmojiPicker] = useState(false)
  const inputRef = useRef<HTMLTextAreaElement>(null)

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()

    if (!message.trim()) return

    onSend(message, replyTo?.id)
    setMessage('')
    inputRef.current?.focus()
  }

  const handleKeyDown = (e: React.KeyboardEvent) => {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault()
      handleSubmit(e)
    }

    onTyping()
  }

  const handleEmojiClick = (emojiData: any) => {
    setMessage((prev) => prev + emojiData.emoji)
    setShowEmojiPicker(false)
    inputRef.current?.focus()
  }

  return (
    <div className="border-t border-gray-200 p-4">
      {/* Reply indicator */}
      {replyTo && (
        <div className="mb-2 p-2 bg-gray-50 rounded-lg flex items-center justify-between">
          <div className="flex-1">
            <p className="text-xs text-gray-500">
              Replying to <span className="font-medium">{replyTo.username}</span>
            </p>
            <p className="text-sm text-gray-700 truncate">{replyTo.content}</p>
          </div>
          <button
            onClick={onCancelReply}
            className="text-gray-400 hover:text-gray-600"
          >
            ✕
          </button>
        </div>
      )}

      <form onSubmit={handleSubmit} className="flex items-end gap-2">
        {/* File upload */}
        <button
          type="button"
          className="p-2 text-gray-500 hover:text-gray-700 transition-colors"
        >
          <Paperclip className="w-5 h-5" />
        </button>

        {/* Emoji picker */}
        <div className="relative">
          <button
            type="button"
            onClick={() => setShowEmojiPicker(!showEmojiPicker)}
            className="p-2 text-gray-500 hover:text-gray-700 transition-colors"
          >
            <Smile className="w-5 h-5" />
          </button>

          {showEmojiPicker && (
            <div className="absolute bottom-12 left-0 z-50">
              <EmojiPicker onEmojiClick={handleEmojiClick} />
            </div>
          )}
        </div>

        {/* Text input */}
        <textarea
          ref={inputRef}
          value={message}
          onChange={(e) => setMessage(e.target.value)}
          onKeyDown={handleKeyDown}
          placeholder="Type a message..."
          className="flex-1 resize-none border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
          rows={1}
          style={{
            minHeight: '40px',
            maxHeight: '120px',
          }}
        />

        {/* Send button */}
        <button
          type="submit"
          disabled={!message.trim()}
          className="p-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
        >
          <Send className="w-5 h-5" />
        </button>
      </form>
    </div>
  )
}
```

---

## 🔧 Configuration Files

### package.json

```json
{
  "name": "realtime-chat-socketio",
  "version": "1.0.0",
  "scripts": {
    "dev": "next dev",
    "dev:socket": "tsx watch server.ts",
    "build": "next build && tsc server.ts --outDir dist",
    "start": "next start",
    "start:socket": "node dist/server.js",
    "lint": "next lint",
    "db:push": "prisma db push",
    "db:studio": "prisma studio"
  },
  "dependencies": {
    "next": "^15.0.0",
    "react": "^19.0.0",
    "react-dom": "^19.0.0",
    "socket.io": "^4.7.0",
    "socket.io-client": "^4.7.0",
    "@socket.io/redis-adapter": "^8.3.0",
    "redis": "^4.6.0",
    "@prisma/client": "^5.15.0",
    "next-auth": "^4.24.0",
    "bcrypt": "^5.1.1",
    "jsonwebtoken": "^9.0.2",
    "zod": "^3.23.0",
    "emoji-picker-react": "^4.11.0",
    "lucide-react": "^0.395.0",
    "react-markdown": "^9.0.0",
    "date-fns": "^3.6.0"
  },
  "devDependencies": {
    "@types/node": "^20",
    "@types/react": "^19",
    "@types/bcrypt": "^5.0.2",
    "@types/jsonwebtoken": "^9.0.6",
    "typescript": "^5",
    "tsx": "^4.15.0",
    "prisma": "^5.15.0",
    "tailwindcss": "^3.4.0",
    "postcss": "^8",
    "autoprefixer": "^10.4.0"
  }
}
```

### docker-compose.yml

```yaml
version: '3.8'

services:
  postgres:
    image: postgres:16-alpine
    environment:
      POSTGRES_USER: chat
      POSTGRES_PASSWORD: password
      POSTGRES_DB: chatdb
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data

volumes:
  postgres_data:
  redis_data:
```

### .env.example

```bash
# Database
DATABASE_URL="postgresql://chat:password@localhost:5432/chatdb"

# Redis
REDIS_URL="redis://localhost:6379"

# NextAuth
NEXTAUTH_URL="http://localhost:3000"
NEXTAUTH_SECRET="your-super-secret-key-change-this"

# JWT
JWT_SECRET="your-jwt-secret-change-this"

# Socket.io
SOCKET_PORT=3001
NEXT_PUBLIC_SOCKET_URL="http://localhost:3001"

# Frontend
FRONTEND_URL="http://localhost:3000"

# File uploads (optional)
AWS_ACCESS_KEY_ID=""
AWS_SECRET_ACCESS_KEY=""
AWS_REGION="us-east-1"
AWS_S3_BUCKET=""
```

---

## 🧪 Testing

### Unit Tests

```typescript
// __tests__/hooks/useSocket.test.ts
import { renderHook, waitFor } from '@testing-library/react'
import { useSocket } from '@/hooks/useSocket'
import { useSession } from 'next-auth/react'

jest.mock('next-auth/react')

describe('useSocket', () => {
  it('connects when user is authenticated', async () => {
    ;(useSession as jest.Mock).mockReturnValue({
      data: { user: { id: '1' }, accessToken: 'token' },
    })

    const { result } = renderHook(() => useSocket())

    await waitFor(() => {
      expect(result.current.isConnected).toBe(true)
    })
  })

  it('does not connect when user is not authenticated', () => {
    ;(useSession as jest.Mock).mockReturnValue({ data: null })

    const { result } = renderHook(() => useSocket())

    expect(result.current.socket).toBe(null)
    expect(result.current.isConnected).toBe(false)
  })
})
```

### Integration Tests

```typescript
// __tests__/api/messages.test.ts
import { POST } from '@/app/api/messages/route'
import { prisma } from '@/lib/prisma'

describe('POST /api/messages', () => {
  it('creates a new message', async () => {
    const request = new Request('http://localhost:3000/api/messages', {
      method: 'POST',
      body: JSON.stringify({
        roomId: 'room-1',
        content: 'Hello world',
      }),
    })

    const response = await POST(request)
    const data = await response.json()

    expect(response.status).toBe(201)
    expect(data.message.content).toBe('Hello world')
  })
})
```

---

## 🚀 Deployment

### Vercel (Frontend + API Routes)

```bash
# Install Vercel CLI
npm i -g vercel

# Deploy
vercel --prod
```

### Railway (Socket.io Server + Database)

```bash
# Install Railway CLI
npm i -g @railway/cli

# Login
railway login

# Deploy
railway up
```

### Environment Variables

Configure in Vercel:
- `DATABASE_URL`
- `REDIS_URL`
- `NEXTAUTH_SECRET`
- `JWT_SECRET`
- `NEXT_PUBLIC_SOCKET_URL`

---

## 📈 Performance Optimizations

1. **Message Pagination**: Load messages in chunks
2. **Virtual Scrolling**: Use `react-window` for large message lists
3. **Redis Caching**: Cache active rooms and online users
4. **CDN for Assets**: Use Cloudinary for image uploads
5. **Connection Pooling**: Prisma connection pool configuration
6. **Lazy Loading**: Load rooms and users on demand

---

## 🔐 Security Considerations

1. **Authentication**: JWT tokens with expiration
2. **Authorization**: Check room membership before sending messages
3. **Rate Limiting**: Limit message sending rate
4. **Input Validation**: Sanitize message content
5. **XSS Prevention**: Escape HTML in messages
6. **CORS**: Restrict Socket.io origins

---

## 📚 Learning Resources

- [Socket.io Documentation](https://socket.io/docs/v4/)
- [Next.js Documentation](https://nextjs.org/docs)
- [Prisma Documentation](https://www.prisma.io/docs)
- [Redis Pub/Sub](https://redis.io/topics/pubsub)

---

## 🎓 Next Steps

After completing this example:
1. Add video/audio calls (WebRTC)
2. Implement message search with ElasticSearch
3. Add message editing and deletion
4. Implement threads for messages
5. Add slash commands (/giphy, /poll)
6. Create mobile app with React Native

---

**Estimated Time**: 4-5 hours for complete implementation

**Difficulty**: Intermediate

**Prerequisites**: Next.js, Socket.io basics, TypeScript
