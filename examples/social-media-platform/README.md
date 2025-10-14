# 🐦 Social Media Platform (Twitter/X Clone)

**Stack**: Next.js 15 + FastAPI + PostgreSQL + Redis + S3 + ElasticSearch + WebSockets

**Nivel**: Avanzado (15-18 hours)

**Descripción**: Plataforma completa de redes sociales con posts, follows, likes, comments, trending topics, notifications en tiempo real, y feed algorítmico. Un clon completo de Twitter/X.

## 🔥 ¿QUÉ CONSTRUIREMOS?

Una **red social completa** que demuestra:

### 🎯 Características Principales

**Core Social Features**:
- ✅ Posts (texto, imágenes, videos, polls)
- ✅ Comments & replies (threaded conversations)
- ✅ Likes, retweets, bookmarks
- ✅ Follow/unfollow users
- ✅ User profiles (bio, avatar, banner)
- ✅ Direct messages (1-on-1 chat)
- ✅ Notifications en tiempo real
- ✅ Search (users, posts, hashtags)

**Advanced Features**:
- ✅ Algorithmic feed (relevance-based)
- ✅ Trending topics & hashtags
- ✅ Verified accounts (blue checkmarks)
- ✅ Lists (curated user groups)
- ✅ Moments (curated stories)
- ✅ Spaces (live audio rooms)
- ✅ Communities (topic-based groups)
- ✅ Analytics dashboard

**Content Moderation**:
- ✅ AI-powered content moderation (Claude API)
- ✅ User reporting system
- ✅ Shadowban capabilities
- ✅ NSFW detection
- ✅ Spam filtering
- ✅ Abuse prevention

**Engagement Features**:
- ✅ @mentions
- ✅ #hashtags with indexing
- ✅ Quote tweets
- ✅ Thread maker (long-form)
- ✅ Rich previews (link cards)
- ✅ GIF support (Giphy API)
- ✅ Emoji reactions

**AI-Powered**:
- ✅ Recommended follows (ML)
- ✅ Personalized feed ranking
- ✅ Trending prediction
- ✅ Smart replies suggestions
- ✅ Content quality scoring
- ✅ Spam detection

## 🏗️ Arquitectura

```
┌────────────────────────────────────────────────────────┐
│                User Browser/Mobile                      │
│              (Next.js + React Native)                   │
└────────────┬───────────────────────────────────────────┘
             │
             ↓
┌────────────────────────────────────────────────────────┐
│              CDN (CloudFront/Vercel)                    │
│  • Static assets                                        │
│  • Media files                                          │
└────────────┬───────────────────────────────────────────┘
             │
             ↓
┌────────────────────────────────────────────────────────┐
│          Application Layer (Next.js)                    │
│  • Server-side rendering                                │
│  • API routes                                           │
│  • Authentication                                       │
└────────────┬───────────────────────────────────────────┘
             │
       ┌─────┴─────┐
       │           │
       ↓           ↓
┌────────────┐  ┌──────────────────────────────────────┐
│   FastAPI  │  │        WebSocket Server              │
│  Backend   │  │  • Real-time notifications           │
│  • APIs    │  │  • Live updates                      │
│  • ML      │  │  • Typing indicators                 │
│  • Jobs    │  │  • Presence                          │
└────┬───────┘  └──────────────────────────────────────┘
     │
     ↓
┌─────────────────────────────────────────────────────────┐
│              Data Layer                                  │
│  ┌──────────┐  ┌──────────┐  ┌──────────────────────┐ │
│  │PostgreSQL│  │  Redis   │  │   ElasticSearch      │ │
│  │• Users   │  │• Cache   │  │• Full-text search    │ │
│  │• Posts   │  │• Sessions│  │• Posts index         │ │
│  │• Follows │  │• Feed    │  │• Users index         │ │
│  │• Likes   │  │• Jobs    │  │• Hashtags index      │ │
│  └──────────┘  └──────────┘  └──────────────────────┘ │
│                                                          │
│  ┌──────────────────────────────────────────────────┐  │
│  │               AWS S3                              │  │
│  │  • Profile images                                │  │
│  │  • Post media                                    │  │
│  │  • Videos (with encoding)                        │  │
│  └──────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
```

## 📁 Estructura del Proyecto

```
social-media-platform/
├── frontend/                      # Next.js App
│   ├── src/
│   │   ├── app/
│   │   │   ├── page.tsx                    # Home feed
│   │   │   ├── explore/page.tsx            # Trending
│   │   │   ├── notifications/page.tsx
│   │   │   ├── messages/page.tsx           # DMs
│   │   │   ├── [username]/
│   │   │   │   ├── page.tsx               # Profile
│   │   │   │   └── status/[id]/page.tsx   # Post detail
│   │   │   ├── compose/page.tsx           # New post
│   │   │   └── settings/page.tsx
│   │   ├── components/
│   │   │   ├── Feed/
│   │   │   │   ├── Feed.tsx
│   │   │   │   ├── Post.tsx
│   │   │   │   ├── PostComposer.tsx
│   │   │   │   └── InfiniteScroll.tsx
│   │   │   ├── Sidebar/
│   │   │   │   ├── Trends.tsx
│   │   │   │   ├── WhoToFollow.tsx
│   │   │   │   └── SearchBar.tsx
│   │   │   └── Modals/
│   │   │       ├── ComposeModal.tsx
│   │   │       └── ImageViewer.tsx
│   │   ├── hooks/
│   │   │   ├── useFeed.ts
│   │   │   ├── usePost.ts
│   │   │   ├── useNotifications.ts
│   │   │   └── useWebSocket.ts
│   │   └── lib/
│   │       ├── api.ts
│   │       └── websocket.ts
│   └── package.json
│
├── backend/                       # FastAPI Backend
│   ├── app/
│   │   ├── api/
│   │   │   ├── v1/
│   │   │   │   ├── endpoints/
│   │   │   │   │   ├── posts.py
│   │   │   │   │   ├── users.py
│   │   │   │   │   ├── follows.py
│   │   │   │   │   ├── likes.py
│   │   │   │   │   ├── comments.py
│   │   │   │   │   ├── search.py
│   │   │   │   │   ├── trends.py
│   │   │   │   │   └── messages.py
│   │   ├── services/
│   │   │   ├── feed_service.py             # Feed algorithm
│   │   │   ├── recommendation_service.py   # ML recommendations
│   │   │   ├── moderation_service.py       # Content moderation
│   │   │   ├── notification_service.py
│   │   │   └── search_service.py
│   │   ├── ml/
│   │   │   ├── feed_ranker.py             # ML feed ranking
│   │   │   ├── spam_detector.py
│   │   │   └── content_classifier.py
│   │   ├── workers/
│   │   │   ├── feed_worker.py
│   │   │   ├── notification_worker.py
│   │   │   └── trend_worker.py
│   │   ├── models/
│   │   │   ├── user.py
│   │   │   ├── post.py
│   │   │   ├── follow.py
│   │   │   └── notification.py
│   │   └── core/
│   │       ├── config.py
│   │       └── claude.py
│   └── requirements.txt
│
├── websocket/                     # WebSocket Server
│   ├── server.py
│   └── handlers/
│       ├── notifications.py
│       └── messages.py
│
├── ml/                            # Machine Learning
│   ├── models/
│   │   ├── feed_ranker/
│   │   └── spam_detector/
│   └── training/
│       └── train_feed_ranker.py
│
├── docker-compose.yml
└── README.md
```

## 🎨 Core Components

### 1. Post Composer

```typescript
// frontend/src/components/Feed/PostComposer.tsx
'use client'

import { useState, useRef } from 'react'
import { uploadMedia } from '@/lib/api'
import { Image, Gif, Poll, Smile, Calendar } from 'lucide-react'

export function PostComposer({ onPost }: { onPost: () => void }) {
  const [content, setContent] = useState('')
  const [media, setMedia] = useState<File[]>([])
  const [poll, setPoll] = useState<{ options: string[] } | null>(null)
  const [submitting, setSubmitting] = useState(false)
  const fileInputRef = useRef<HTMLInputElement>(null)

  const handleSubmit = async () => {
    if (!content.trim() && media.length === 0) return

    setSubmitting(true)

    try {
      // Upload media if any
      const mediaUrls = await Promise.all(
        media.map((file) => uploadMedia(file))
      )

      // Create post
      await fetch('/api/posts', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          content,
          mediaUrls,
          poll,
        }),
      })

      // Reset
      setContent('')
      setMedia([])
      setPoll(null)
      onPost()
    } catch (error) {
      console.error('Error posting:', error)
      alert('Failed to post')
    } finally {
      setSubmitting(false)
    }
  }

  const remainingChars = 280 - content.length

  return (
    <div className="border-b border-gray-200 p-4">
      <div className="flex gap-3">
        <img
          src="/avatar.jpg"
          alt="Profile"
          className="w-12 h-12 rounded-full"
        />

        <div className="flex-1">
          <textarea
            value={content}
            onChange={(e) => setContent(e.target.value)}
            placeholder="What's happening?"
            className="w-full text-xl resize-none outline-none"
            rows={3}
            maxLength={280}
          />

          {/* Media preview */}
          {media.length > 0 && (
            <div className="grid grid-cols-2 gap-2 mt-3">
              {media.map((file, i) => (
                <div key={i} className="relative">
                  <img
                    src={URL.createObjectURL(file)}
                    alt="Upload"
                    className="rounded-xl"
                  />
                  <button
                    onClick={() => setMedia(media.filter((_, j) => j !== i))}
                    className="absolute top-2 right-2 bg-black/70 text-white rounded-full p-1"
                  >
                    ✕
                  </button>
                </div>
              ))}
            </div>
          )}

          {/* Poll */}
          {poll && (
            <div className="mt-3 space-y-2">
              {poll.options.map((option, i) => (
                <input
                  key={i}
                  value={option}
                  onChange={(e) => {
                    const newOptions = [...poll.options]
                    newOptions[i] = e.target.value
                    setPoll({ ...poll, options: newOptions })
                  }}
                  placeholder={`Option ${i + 1}`}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2"
                />
              ))}
            </div>
          )}

          {/* Actions */}
          <div className="flex items-center justify-between mt-3 pt-3 border-t border-gray-200">
            <div className="flex gap-2">
              <button
                onClick={() => fileInputRef.current?.click()}
                className="p-2 hover:bg-blue-50 rounded-full text-blue-500"
              >
                <Image className="w-5 h-5" />
              </button>

              <button className="p-2 hover:bg-blue-50 rounded-full text-blue-500">
                <Gif className="w-5 h-5" />
              </button>

              <button
                onClick={() => setPoll({ options: ['', ''] })}
                className="p-2 hover:bg-blue-50 rounded-full text-blue-500"
              >
                <Poll className="w-5 h-5" />
              </button>

              <button className="p-2 hover:bg-blue-50 rounded-full text-blue-500">
                <Smile className="w-5 h-5" />
              </button>

              <button className="p-2 hover:bg-blue-50 rounded-full text-blue-500">
                <Calendar className="w-5 h-5" />
              </button>
            </div>

            <div className="flex items-center gap-3">
              <span
                className={`text-sm ${
                  remainingChars < 0
                    ? 'text-red-500'
                    : remainingChars < 20
                    ? 'text-yellow-500'
                    : 'text-gray-500'
                }`}
              >
                {remainingChars}
              </span>

              <button
                onClick={handleSubmit}
                disabled={submitting || (!content.trim() && media.length === 0)}
                className="bg-blue-500 text-white px-6 py-2 rounded-full font-bold hover:bg-blue-600 disabled:opacity-50"
              >
                {submitting ? 'Posting...' : 'Post'}
              </button>
            </div>
          </div>
        </div>
      </div>

      <input
        ref={fileInputRef}
        type="file"
        accept="image/*,video/*"
        multiple
        className="hidden"
        onChange={(e) => {
          const files = Array.from(e.target.files || [])
          setMedia([...media, ...files])
        }}
      />
    </div>
  )
}
```

### 2. Feed Algorithm (Python)

```python
# backend/app/services/feed_service.py
from typing import List
import numpy as np
from app.models import Post, User, Follow, Like
from app.ml.feed_ranker import FeedRanker
from sqlalchemy.orm import Session
from datetime import datetime, timedelta

class FeedService:
    def __init__(self, db: Session):
        self.db = db
        self.ranker = FeedRanker()

    async def get_personalized_feed(
        self,
        user_id: str,
        limit: int = 20,
        cursor: str = None
    ) -> List[Post]:
        """
        Generate personalized feed using ML ranking

        Algorithm:
        1. Get candidate posts (follows + trending)
        2. Score each post using ML model
        3. Apply diversity & freshness filters
        4. Return top N posts
        """

        # Step 1: Get candidate posts
        candidates = await self._get_candidate_posts(user_id, limit * 5)

        # Step 2: Score posts
        scored_posts = []
        for post in candidates:
            score = await self._score_post(user_id, post)
            scored_posts.append((post, score))

        # Step 3: Sort by score
        scored_posts.sort(key=lambda x: x[1], reverse=True)

        # Step 4: Apply diversity (don't show too many posts from same user)
        diverse_posts = self._apply_diversity(scored_posts, max_per_user=3)

        # Step 5: Return top N
        return [post for post, _ in diverse_posts[:limit]]

    async def _get_candidate_posts(
        self,
        user_id: str,
        limit: int
    ) -> List[Post]:
        """
        Get candidate posts from:
        1. Following users (70%)
        2. Trending (20%)
        3. Recommended users (10%)
        """

        # Get users this user follows
        follows = self.db.query(Follow).filter(
            Follow.follower_id == user_id
        ).all()

        following_ids = [f.following_id for f in follows]

        # Get recent posts from following
        following_posts = self.db.query(Post).filter(
            Post.user_id.in_(following_ids),
            Post.created_at > datetime.now() - timedelta(days=7)
        ).order_by(Post.created_at.desc()).limit(int(limit * 0.7)).all()

        # Get trending posts
        trending_posts = self.db.query(Post).filter(
            Post.created_at > datetime.now() - timedelta(days=1)
        ).order_by(
            Post.like_count.desc(),
            Post.retweet_count.desc()
        ).limit(int(limit * 0.2)).all()

        # Combine and deduplicate
        all_posts = list(set(following_posts + trending_posts))

        return all_posts

    async def _score_post(self, user_id: str, post: Post) -> float:
        """
        Score a post for relevance to user

        Features:
        - Recency (decay over time)
        - Engagement (likes, retweets, comments)
        - Author relationship (follow, interactions)
        - Content similarity (topics, hashtags)
        - User behavior (past interactions)
        """

        features = self._extract_features(user_id, post)
        score = self.ranker.predict(features)

        return score

    def _extract_features(self, user_id: str, post: Post) -> np.ndarray:
        """Extract features for ML ranking"""

        # Recency score (exponential decay)
        age_hours = (datetime.now() - post.created_at).total_seconds() / 3600
        recency_score = np.exp(-age_hours / 24)  # Half-life of 24 hours

        # Engagement score
        engagement_score = (
            post.like_count * 1.0 +
            post.retweet_count * 2.0 +
            post.comment_count * 3.0
        ) / 100

        # Author relationship
        is_following = self.db.query(Follow).filter(
            Follow.follower_id == user_id,
            Follow.following_id == post.user_id
        ).first() is not None

        # Past interactions with author
        past_interactions = self.db.query(Like).filter(
            Like.user_id == user_id,
            Like.post.has(user_id=post.user_id)
        ).count()

        # Content features
        has_media = post.media_urls is not None and len(post.media_urls) > 0
        has_hashtags = '#' in post.content
        content_length = len(post.content)

        # Combine features
        features = np.array([
            recency_score,
            engagement_score,
            1.0 if is_following else 0.0,
            min(past_interactions / 10, 1.0),
            1.0 if has_media else 0.0,
            1.0 if has_hashtags else 0.0,
            min(content_length / 280, 1.0),
        ])

        return features

    def _apply_diversity(
        self,
        scored_posts: List[tuple],
        max_per_user: int = 3
    ) -> List[tuple]:
        """
        Apply diversity to prevent feed from being dominated by single user
        """

        user_counts = {}
        diverse_posts = []

        for post, score in scored_posts:
            user_id = post.user_id

            if user_counts.get(user_id, 0) < max_per_user:
                diverse_posts.append((post, score))
                user_counts[user_id] = user_counts.get(user_id, 0) + 1

        return diverse_posts
```

### 3. Trending Topics

```python
# backend/app/services/trends.py
from typing import List, Dict
from sqlalchemy.orm import Session
from datetime import datetime, timedelta
import re
from collections import Counter

class TrendingService:
    def __init__(self, db: Session):
        self.db = db

    async def get_trending_topics(
        self,
        location: str = 'worldwide',
        limit: int = 10
    ) -> List[Dict]:
        """
        Get trending topics/hashtags

        Algorithm:
        1. Extract hashtags from recent posts (24h)
        2. Count occurrences
        3. Calculate velocity (growth rate)
        4. Rank by score = volume * velocity
        """

        # Get recent posts
        since = datetime.now() - timedelta(hours=24)
        recent_posts = self.db.query(Post).filter(
            Post.created_at > since
        ).all()

        # Extract all hashtags
        all_hashtags = []
        for post in recent_posts:
            hashtags = re.findall(r'#(\w+)', post.content)
            all_hashtags.extend([h.lower() for h in hashtags])

        # Count occurrences
        hashtag_counts = Counter(all_hashtags)

        # Calculate velocity (compare to yesterday)
        yesterday = datetime.now() - timedelta(days=1)
        yesterday_posts = self.db.query(Post).filter(
            Post.created_at.between(
                yesterday - timedelta(hours=24),
                yesterday
            )
        ).all()

        yesterday_hashtags = []
        for post in yesterday_posts:
            hashtags = re.findall(r'#(\w+)', post.content)
            yesterday_hashtags.extend([h.lower() for h in hashtags])

        yesterday_counts = Counter(yesterday_hashtags)

        # Calculate trending score
        trends = []
        for hashtag, count in hashtag_counts.most_common(limit * 2):
            yesterday_count = yesterday_counts.get(hashtag, 0)

            # Velocity = growth rate
            velocity = (count - yesterday_count) / max(yesterday_count, 1)

            # Score = volume * velocity
            score = count * (1 + velocity)

            trends.append({
                'hashtag': hashtag,
                'count': count,
                'velocity': velocity,
                'score': score,
            })

        # Sort by score
        trends.sort(key=lambda x: x['score'], reverse=True)

        return trends[:limit]
```

### 4. Content Moderation with Claude

```python
# backend/app/services/moderation_service.py
from anthropic import Anthropic
import os

class ModerationService:
    def __init__(self):
        self.claude = Anthropic(api_key=os.getenv("ANTHROPIC_API_KEY"))

    async def moderate_content(self, content: str) -> dict:
        """
        Moderate content using Claude API

        Returns:
        {
            "is_safe": bool,
            "category": "safe" | "spam" | "hate" | "violence" | "nsfw",
            "confidence": float,
            "reason": str
        }
        """

        prompt = f"""
Analyze this social media post for policy violations:

Post: "{content}"

Determine if the post violates any of these policies:
1. Spam or scam
2. Hate speech or harassment
3. Violence or threats
4. NSFW/adult content
5. Misinformation
6. Self-harm

Return JSON with:
- is_safe (boolean)
- category (safe/spam/hate/violence/nsfw/misinfo/self-harm)
- confidence (0-1)
- reason (brief explanation)
"""

        response = await self.claude.messages.create(
            model="claude-3-5-sonnet-20241022",
            max_tokens=256,
            temperature=0,
            messages=[{
                "role": "user",
                "content": prompt
            }]
        )

        import json
        result = json.loads(response.content[0].text)

        return result
```

## 📊 Database Schema

```sql
-- Users table
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    display_name VARCHAR(50),
    bio TEXT,
    avatar_url TEXT,
    banner_url TEXT,
    is_verified BOOLEAN DEFAULT FALSE,
    follower_count INT DEFAULT 0,
    following_count INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Posts table
CREATE TABLE posts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id),
    content TEXT,
    media_urls TEXT[],
    like_count INT DEFAULT 0,
    retweet_count INT DEFAULT 0,
    comment_count INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_posts_user_created ON posts(user_id, created_at DESC);
CREATE INDEX idx_posts_created ON posts(created_at DESC);

-- Follows table
CREATE TABLE follows (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    follower_id UUID REFERENCES users(id),
    following_id UUID REFERENCES users(id),
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(follower_id, following_id)
);

CREATE INDEX idx_follows_follower ON follows(follower_id);
CREATE INDEX idx_follows_following ON follows(following_id);

-- Likes table
CREATE TABLE likes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id),
    post_id UUID REFERENCES posts(id),
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(user_id, post_id)
);

-- Notifications table
CREATE TABLE notifications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id),
    type VARCHAR(20), -- like, retweet, comment, follow, mention
    actor_id UUID REFERENCES users(id),
    post_id UUID REFERENCES posts(id),
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_notifications_user ON notifications(user_id, created_at DESC);
```

## 💰 Business Model

| Revenue Stream | Details |
|---------------|---------|
| Verification | $8/month (blue checkmark) |
| Ad Revenue | $50-200 CPM |
| API Access | $100-5000/month |
| Premium Features | No ads, advanced analytics |

**Revenue Projections**:
- 1M users, 10% premium = $80k MRR
- 10M users, 5% premium = $400k MRR
- 100M users (Twitter scale) = $40M-200M MRR

## 🚀 Deployment at Scale

**Infrastructure**:
- Frontend: Vercel Edge Network
- Backend: AWS ECS (auto-scaling)
- Database: AWS RDS PostgreSQL (read replicas)
- Cache: Redis Cluster
- Search: ElasticSearch cluster
- Media: CloudFront + S3
- WebSocket: AWS App Runner

**Performance**:
- Feed load: < 500ms
- Post creation: < 200ms
- Search: < 100ms
- Handles: 10k+ req/s

---

**Estimated Time**: 15-18 hours
**Difficulty**: Advanced 🔴
**Potential Revenue**: $400k - $200M MRR
**Users**: Potentially millions

**¡Claude Code puede construir la próxima red social viral!** 🐦✨
