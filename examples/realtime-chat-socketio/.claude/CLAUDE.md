# Real-Time Chat Application - Project Memory

## 📋 Project Overview

**Name**: Real-Time Chat Application
**Stack**: Next.js 15 + Socket.io + Redis + PostgreSQL + TypeScript
**Level**: Intermediate (4-5 hours)

A production-ready real-time chat application with Socket.io for instant messaging, Redis pub/sub for horizontal scaling, and PostgreSQL for message persistence.

## 🎯 Core Features

### Real-Time Messaging
- Socket.io WebSocket connections
- Instant message delivery
- Message persistence in PostgreSQL
- Message history with pagination
- Typing indicators
- User presence (online/offline)

### Room Management
- Public and private rooms
- Room creation and joining
- Direct messages (DMs)
- Room member management
- Room notifications

### Message Features
- Text messages
- File uploads (images)
- Emoji reactions
- Read receipts
- Reply to messages
- User mentions (@username)
- Markdown support

### Scalability
- Redis pub/sub for multiple server instances
- Socket.io Redis adapter
- Connection pooling
- Optimized queries

## 🏗️ Architecture

### Frontend (Next.js 15)
```
src/app/
├── (auth)/
│   ├── login/page.tsx          # Login page
│   └── register/page.tsx       # Registration page
├── chat/
│   ├── [roomId]/page.tsx       # Chat room page
│   └── layout.tsx              # Chat layout
├── api/
│   ├── auth/[...nextauth]/     # NextAuth API routes
│   ├── rooms/                  # Room management API
│   ├── messages/               # Message API
│   └── upload/                 # File upload API
└── layout.tsx
```

### Backend (Socket.io Server)
```
server.ts                        # Socket.io server
├── Authentication middleware
├── Connection handler
├── Room management events
├── Message events
├── Typing events
├── Reaction events
└── Presence events
```

### Database Schema
```
User
├── id (cuid)
├── email (unique)
├── username (unique)
├── name
├── avatar
└── password (hashed)

Room
├── id (cuid)
├── name
├── description
├── isPrivate (boolean)
├── createdBy
└── timestamps

RoomMember
├── id (cuid)
├── roomId (FK)
├── userId (FK)
├── role (admin/moderator/member)
└── joinedAt

Message
├── id (cuid)
├── content (text)
├── roomId (FK)
├── userId (FK)
├── type (text/image/file)
├── fileUrl
├── replyToId (FK, self-reference)
└── timestamps

Reaction
├── id (cuid)
├── emoji
├── messageId (FK)
├── userId (FK)
└── createdAt

ReadReceipt
├── id (cuid)
├── messageId (FK)
├── userId (FK)
└── readAt
```

## 🔧 Technical Implementation

### Socket.io Events

**Client → Server**:
- `room:join` - Join a room
- `room:leave` - Leave a room
- `message:send` - Send a message
- `typing:start` - Start typing indicator
- `typing:stop` - Stop typing indicator
- `message:react` - Add/remove reaction
- `message:read` - Mark message as read
- `dm:send` - Send direct message

**Server → Client**:
- `room:joined` - Successfully joined room
- `room:user-joined` - User joined room
- `room:user-left` - User left room
- `message:new` - New message received
- `typing:start` - User started typing
- `typing:stop` - User stopped typing
- `message:reactions` - Updated reactions
- `message:read` - Message read by user
- `dm:new` - New direct message
- `user:online` - User came online
- `user:offline` - User went offline
- `error` - Error occurred

### Authentication Flow

1. User registers/logs in via NextAuth
2. JWT token issued
3. Client connects to Socket.io with token
4. Server verifies JWT token
5. Socket connection authenticated
6. User joins personal room `user:{userId}`
7. User auto-joins all their rooms

### Message Flow

1. User types message
2. Emit `typing:start` (with debounce)
3. User sends message via `message:send`
4. Server validates membership
5. Server saves message to PostgreSQL
6. Server emits `message:new` to room
7. All room members receive message
8. Client displays message
9. Emit `typing:stop`

### Typing Indicator Flow

1. User starts typing
2. Emit `typing:start` with roomId
3. Server broadcasts to other room members
4. After 2 seconds of inactivity, emit `typing:stop`
5. Server broadcasts stop to room

### Presence System

1. User connects → emit `user:online`
2. Store socket mapping in Redis: `socket:{userId}` → socketId
3. User disconnects → emit `user:offline`
4. Remove socket mapping from Redis

### Scaling with Redis

```typescript
// Redis adapter for Socket.io
io.adapter(createAdapter(pubClient, subClient))

// When server A emits to room:
io.to('room:123').emit('message:new', data)

// Redis pub/sub broadcasts to all servers
// All servers emit to their local clients in room:123
```

## 📦 Key Dependencies

### Frontend
- `next@^15.0.0` - React framework
- `socket.io-client@^4.7.0` - Socket.io client
- `next-auth@^4.24.0` - Authentication
- `@prisma/client@^5.15.0` - Database ORM
- `zod@^3.23.0` - Validation
- `emoji-picker-react@^4.11.0` - Emoji picker
- `react-markdown@^9.0.0` - Markdown rendering
- `date-fns@^3.6.0` - Date formatting

### Backend
- `socket.io@^4.7.0` - WebSocket server
- `@socket.io/redis-adapter@^8.3.0` - Redis adapter
- `redis@^4.6.0` - Redis client
- `jsonwebtoken@^9.0.2` - JWT tokens
- `bcrypt@^5.1.1` - Password hashing

## 🎨 UI Components

### ChatRoom Component
Main chat interface with:
- Message list (virtualized for performance)
- Message input with emoji picker
- User list sidebar
- Typing indicator
- Connection status

### MessageList Component
Displays messages with:
- User avatars
- Timestamps
- Reply threads
- Emoji reactions
- File attachments
- Read receipts

### MessageInput Component
Input area with:
- Auto-expanding textarea
- Emoji picker
- File upload button
- Send button
- Reply indicator

### UserList Component
Sidebar showing:
- Online users (green dot)
- Offline users (gray)
- User avatars
- Click to send DM

### TypingIndicator Component
Shows "User is typing..." animation

## 🔐 Security

### Authentication
- JWT tokens with expiration (15min access, 7d refresh)
- Password hashing with bcrypt (12 rounds)
- Secure HTTP-only cookies
- CSRF protection

### Authorization
- Verify room membership before message send
- Check ownership for DMs
- Rate limiting on message sending
- File upload size limits

### Input Validation
- Zod schemas for all inputs
- XSS prevention (sanitize HTML)
- SQL injection prevention (Prisma ORM)
- File type validation

## 🚀 Performance Optimizations

### Frontend
- Virtual scrolling for message lists
- Message pagination (load 50 at a time)
- Image lazy loading
- Debounced typing indicators
- React.memo for message components
- useCallback for event handlers

### Backend
- Redis caching for active users
- Database query optimization:
  - Select only needed fields
  - Eager loading with `include`
  - Indexes on foreign keys
- Connection pooling (Prisma)
- Socket.io binary support for files

### Scaling
- Redis adapter for horizontal scaling
- Sticky sessions (if needed)
- CDN for static assets
- S3 for file uploads
- Database read replicas

## 🧪 Testing Strategy

### Unit Tests
- Component tests (React Testing Library)
- Hook tests (useSocket, useMessages)
- Utility function tests
- Validation schema tests

### Integration Tests
- API route tests
- Database operation tests
- Authentication flow tests
- File upload tests

### E2E Tests (Optional)
- Complete chat flow
- Room creation and joining
- Message sending and receiving
- Typing indicators
- Reactions

## 🐛 Common Issues & Solutions

### Issue: Messages not received
**Solution**: Check Socket.io connection, verify room membership, check network tab

### Issue: Typing indicator stuck
**Solution**: Ensure `typing:stop` is called, add timeout fallback

### Issue: Duplicate messages
**Solution**: Add message deduplication, check for double event listeners

### Issue: High latency
**Solution**: Enable Redis adapter, check database queries, use CDN

### Issue: Socket disconnects frequently
**Solution**: Increase timeout, implement reconnection logic, check CORS

## 📚 API Routes

### Authentication
- `POST /api/auth/login` - Login
- `POST /api/auth/register` - Register
- `POST /api/auth/logout` - Logout

### Rooms
- `GET /api/rooms` - Get user's rooms
- `POST /api/rooms` - Create room
- `GET /api/rooms/:id` - Get room details
- `POST /api/rooms/:id/join` - Join room
- `DELETE /api/rooms/:id/leave` - Leave room

### Messages
- `GET /api/messages?roomId=X&cursor=Y` - Get messages (paginated)
- `POST /api/messages` - Send message (fallback)
- `DELETE /api/messages/:id` - Delete message

### Upload
- `POST /api/upload` - Upload file to S3

## 🌍 Environment Variables

```bash
# Database
DATABASE_URL="postgresql://..."

# Redis
REDIS_URL="redis://localhost:6379"

# NextAuth
NEXTAUTH_URL="http://localhost:3000"
NEXTAUTH_SECRET="random-secret"

# JWT
JWT_SECRET="jwt-secret"

# Socket.io
SOCKET_PORT=3001
NEXT_PUBLIC_SOCKET_URL="http://localhost:3001"

# File uploads
AWS_ACCESS_KEY_ID=""
AWS_SECRET_ACCESS_KEY=""
AWS_REGION="us-east-1"
AWS_S3_BUCKET=""
```

## 🎯 Development Workflow

### Initial Setup
```bash
# Install dependencies
npm install

# Setup database
npx prisma generate
npx prisma db push

# Start PostgreSQL & Redis (Docker)
docker-compose up -d

# Run development
npm run dev          # Next.js (port 3000)
npm run dev:socket   # Socket.io (port 3001)
```

### Development Commands
```bash
npm run dev          # Start Next.js dev server
npm run dev:socket   # Start Socket.io dev server
npm run build        # Build for production
npm run start        # Start production server
npm run db:studio    # Open Prisma Studio
npm run lint         # Run ESLint
```

## 📈 Future Enhancements

### Phase 1 (Completed)
- ✅ Real-time messaging
- ✅ Rooms and DMs
- ✅ Typing indicators
- ✅ Reactions
- ✅ File uploads

### Phase 2 (Next)
- 🔲 Video/audio calls (WebRTC)
- 🔲 Screen sharing
- 🔲 Message search (ElasticSearch)
- 🔲 Message editing/deletion
- 🔲 Threads
- 🔲 Polls
- 🔲 Slash commands (/giphy, /help)

### Phase 3 (Future)
- 🔲 Voice messages
- 🔲 Message translation
- 🔲 Bot integrations
- 🔲 Webhooks
- 🔲 Mobile app (React Native)
- 🔲 Desktop app (Electron)

## 🎓 Learning Resources

- [Socket.io Documentation](https://socket.io/docs/v4/)
- [Next.js App Router](https://nextjs.org/docs/app)
- [Redis Pub/Sub](https://redis.io/topics/pubsub)
- [Prisma Docs](https://www.prisma.io/docs)
- [WebSocket Protocol](https://developer.mozilla.org/en-US/docs/Web/API/WebSockets_API)

## 🔗 Related Examples

- E-commerce (Next.js + FastAPI)
- SaaS Dashboard (Nuxt + Django)
- API Gateway (Express)

---

**Last Updated**: 2025-10-14
**Status**: Production Ready ✅
**Complexity**: Intermediate 🔶
**Time Estimate**: 4-5 hours ⏱️
