# Social Media Platform - Project Memory

## Project Overview

**Name**: Social Media Platform (Twitter/X Clone)
**Type**: Full-stack social networking platform
**Stack**: Next.js 15 + FastAPI + PostgreSQL + Redis + ElasticSearch + S3 + ML (Python)
**Status**: Production-ready template

## Core Purpose

Complete social media platform with:
- User profiles and follow system
- Post creation (text, images, videos)
- Algorithmic feed with ML ranking
- Real-time notifications via WebSocket
- Full-text search with ElasticSearch
- Content moderation using Claude AI
- Direct messages
- Trending topics

## Architecture

### High-Level Flow

```
Next.js Frontend (SSR + CSR)
       ↓
   REST API ← FastAPI Backend (async)
       ↓                ↓
   WebSocket ← Redis Pub/Sub → PostgreSQL
       ↓                ↓             ↓
Notifications    Cache Layer   Core Data
                       ↓             ↓
                ElasticSearch   ML Feed Ranker
                  (search)      (Python/sklearn)
                                      ↓
                              Claude AI Moderator
```

### Service Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    Frontend (Next.js)                    │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐              │
│  │   Feed   │  │ Profile  │  │ Messages │              │
│  └──────────┘  └──────────┘  └──────────┘              │
└─────────────────────────────────────────────────────────┘
                         ↓
┌─────────────────────────────────────────────────────────┐
│                  API Layer (FastAPI)                     │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐              │
│  │  Posts   │  │  Users   │  │   Feed   │              │
│  └──────────┘  └──────────┘  └──────────┘              │
└─────────────────────────────────────────────────────────┘
       ↓              ↓              ↓
┌──────────┐   ┌──────────┐   ┌──────────┐
│PostgreSQL│   │  Redis   │   │ElasticSrch│
│ (primary)│   │ (cache)  │   │ (search) │
└──────────┘   └──────────┘   └──────────┘
                     ↓
              ┌──────────┐
              │WebSocket │
              │  Server  │
              └──────────┘
```

## Database Schema (PostgreSQL)

### Core Models

```prisma
// prisma/schema.prisma

model User {
  id            String   @id @default(cuid())
  username      String   @unique
  email         String   @unique
  passwordHash  String
  displayName   String?
  bio           String?  @db.Text
  avatar        String?
  coverImage    String?
  location      String?
  website       String?
  verified      Boolean  @default(false)
  createdAt     DateTime @default(now())
  updatedAt     DateTime @updatedAt

  // Relations
  posts         Post[]
  likes         Like[]
  retweets      Retweet[]
  comments      Comment[]
  followers     Follow[]  @relation("following")
  following     Follow[]  @relation("follower")
  directMessages DirectMessage[]
  notifications Notification[]

  // Stats (denormalized for performance)
  followersCount Int @default(0)
  followingCount Int @default(0)
  postsCount     Int @default(0)

  @@index([username])
  @@index([email])
  @@index([createdAt])
}

model Post {
  id            String   @id @default(cuid())
  content       String   @db.Text
  authorId      String
  author        User     @relation(fields: [authorId], references: [id], onDelete: Cascade)

  // Media
  images        String[]
  videos        String[]

  // Engagement
  likes         Like[]
  retweets      Retweet[]
  comments      Comment[]
  hashtags      Hashtag[]
  mentions      Mention[]

  // Metadata
  replyToId     String?
  replyTo       Post?    @relation("Replies", fields: [replyToId], references: [id], onDelete: Cascade)
  replies       Post[]   @relation("Replies")

  // Stats (denormalized)
  likeCount     Int      @default(0)
  retweetCount  Int      @default(0)
  commentCount  Int      @default(0)
  viewCount     Int      @default(0)

  // ML Features
  engagementScore Float  @default(0)

  // Moderation
  flagged       Boolean  @default(false)
  moderationResult Json?

  createdAt     DateTime @default(now())
  updatedAt     DateTime @updatedAt

  @@index([authorId, createdAt])
  @@index([createdAt])
  @@index([engagementScore])
}

model Like {
  id        String   @id @default(cuid())
  userId    String
  user      User     @relation(fields: [userId], references: [id], onDelete: Cascade)
  postId    String
  post      Post     @relation(fields: [postId], references: [id], onDelete: Cascade)
  createdAt DateTime @default(now())

  @@unique([userId, postId])
  @@index([postId])
  @@index([userId])
}

model Retweet {
  id        String   @id @default(cuid())
  userId    String
  user      User     @relation(fields: [userId], references: [id], onDelete: Cascade)
  postId    String
  post      Post     @relation(fields: [postId], references: [id], onDelete: Cascade)
  comment   String?  @db.Text  // Quote retweet
  createdAt DateTime @default(now())

  @@unique([userId, postId])
  @@index([postId])
  @@index([userId])
  @@index([createdAt])
}

model Comment {
  id        String   @id @default(cuid())
  content   String   @db.Text
  userId    String
  user      User     @relation(fields: [userId], references: [id], onDelete: Cascade)
  postId    String
  post      Post     @relation(fields: [postId], references: [id], onDelete: Cascade)
  createdAt DateTime @default(now())

  @@index([postId, createdAt])
  @@index([userId])
}

model Follow {
  id          String   @id @default(cuid())
  followerId  String
  follower    User     @relation("follower", fields: [followerId], references: [id], onDelete: Cascade)
  followingId String
  following   User     @relation("following", fields: [followingId], references: [id], onDelete: Cascade)
  createdAt   DateTime @default(now())

  @@unique([followerId, followingId])
  @@index([followerId])
  @@index([followingId])
}

model Hashtag {
  id        String   @id @default(cuid())
  tag       String   @unique
  posts     Post[]
  trendingScore Float @default(0)
  createdAt DateTime @default(now())

  @@index([trendingScore])
  @@index([tag])
}

model Mention {
  id        String   @id @default(cuid())
  postId    String
  post      Post     @relation(fields: [postId], references: [id], onDelete: Cascade)
  username  String
  createdAt DateTime @default(now())

  @@index([username])
  @@index([postId])
}

model DirectMessage {
  id          String   @id @default(cuid())
  senderId    String
  sender      User     @relation(fields: [senderId], references: [id], onDelete: Cascade)
  recipientId String
  content     String   @db.Text
  read        Boolean  @default(false)
  createdAt   DateTime @default(now())

  @@index([senderId, recipientId, createdAt])
  @@index([recipientId, read])
}

model Notification {
  id        String   @id @default(cuid())
  userId    String
  user      User     @relation(fields: [userId], references: [id], onDelete: Cascade)
  type      String   // 'like', 'retweet', 'comment', 'follow', 'mention'
  actorId   String?  // User who triggered the notification
  postId    String?  // Related post (if applicable)
  read      Boolean  @default(false)
  createdAt DateTime @default(now())

  @@index([userId, read, createdAt])
}

model TrendingTopic {
  id        String   @id @default(cuid())
  topic     String   @unique
  count     Int      @default(0)
  score     Float    @default(0)  // Time-decayed score
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt

  @@index([score])
}
```

## API Architecture (FastAPI)

### Directory Structure

```
backend/
├── app/
│   ├── main.py                     # FastAPI app
│   ├── api/
│   │   └── v1/
│   │       ├── endpoints/
│   │       │   ├── auth.py         # POST /login, /register
│   │       │   ├── posts.py        # CRUD posts
│   │       │   ├── users.py        # User profiles
│   │       │   ├── feed.py         # GET /feed (personalized)
│   │       │   ├── search.py       # Search users/posts
│   │       │   ├── notifications.py
│   │       │   └── messages.py     # Direct messages
│   │       └── router.py
│   │
│   ├── services/
│   │   ├── feed_service.py         # Feed generation
│   │   ├── ml_ranker.py            # ML ranking
│   │   ├── moderation_service.py   # Claude AI moderation
│   │   ├── search_service.py       # ElasticSearch
│   │   └── notification_service.py # Push notifications
│   │
│   ├── models/                     # Pydantic models
│   │   ├── user.py
│   │   ├── post.py
│   │   └── feed.py
│   │
│   ├── schemas/                    # Request/response schemas
│   │   ├── auth.py
│   │   ├── post.py
│   │   └── user.py
│   │
│   ├── db/
│   │   ├── database.py             # Prisma client
│   │   └── redis.py                # Redis client
│   │
│   ├── core/
│   │   ├── config.py               # Settings
│   │   ├── security.py             # JWT, password hashing
│   │   └── dependencies.py         # FastAPI dependencies
│   │
│   ├── websocket/
│   │   ├── manager.py              # WebSocket connection manager
│   │   └── handlers.py             # WS event handlers
│   │
│   └── ml/
│       ├── models/
│       │   └── feed_ranker.pkl     # Trained model
│       └── train_ranker.py         # Training script
│
├── tests/
├── requirements.txt
└── Dockerfile
```

### Key API Endpoints

```python
# app/api/v1/endpoints/feed.py
from fastapi import APIRouter, Depends
from app.services.feed_service import FeedService

router = APIRouter()

@router.get("/feed")
async def get_personalized_feed(
    user_id: str = Depends(get_current_user_id),
    limit: int = 20,
    cursor: str | None = None,
    feed_service: FeedService = Depends()
):
    """
    Returns personalized feed for user

    Algorithm:
    1. Get candidate posts (follows + trending)
    2. Score each post with ML ranker
    3. Apply diversity (max 3 posts per user)
    4. Return top N
    """
    posts = await feed_service.get_personalized_feed(user_id, limit, cursor)
    return {"posts": posts, "nextCursor": posts[-1].id if posts else None}

@router.post("/posts")
async def create_post(
    post: CreatePostSchema,
    user_id: str = Depends(get_current_user_id),
    moderation: ModerationService = Depends()
):
    """
    Create new post

    Flow:
    1. Validate content
    2. Moderate with Claude AI
    3. Extract hashtags/mentions
    4. Save to DB
    5. Index in ElasticSearch
    6. Update feed cache
    """
    # Moderate content
    moderation_result = await moderation.moderate_content(post.content)
    if not moderation_result["is_safe"]:
        raise HTTPException(400, "Content violates community guidelines")

    # Create post
    new_post = await prisma.post.create({
        "data": {
            "content": post.content,
            "authorId": user_id,
            "images": post.images,
            "moderationResult": moderation_result
        }
    })

    # Extract hashtags
    hashtags = extract_hashtags(post.content)
    for tag in hashtags:
        await prisma.hashtag.upsert({
            "where": {"tag": tag},
            "update": {},
            "create": {"tag": tag}
        })
        await prisma.post.update({
            "where": {"id": new_post.id},
            "data": {"hashtags": {"connect": [{"tag": tag}]}}
        })

    # Index in ElasticSearch
    await search_service.index_post(new_post)

    return new_post
```

## Feed Algorithm (ML Ranking)

### Architecture

```
User Request → Candidate Generation → Feature Extraction → ML Ranker → Diversity → Response
                     ↓                        ↓                ↓            ↓
              (follows + trending)      (engagement,      (LightGBM)  (max 3 per user)
                                         recency, etc.)
```

### Feed Service Implementation

```python
# app/services/feed_service.py
import numpy as np
from typing import List
from datetime import datetime, timedelta
from app.ml.ranker import FeedRanker

class FeedService:
    def __init__(self, ranker: FeedRanker):
        self.ranker = ranker

    async def get_personalized_feed(
        self, user_id: str, limit: int = 20, cursor: str | None = None
    ) -> List[Post]:
        """
        Generate personalized feed using ML ranking
        """
        # 1. Get candidate posts (5x limit for diversity)
        candidates = await self._get_candidate_posts(user_id, limit * 5, cursor)

        # 2. Extract features for each post
        scored_posts = []
        for post in candidates:
            features = self._extract_features(user_id, post)
            score = self.ranker.predict(features)
            scored_posts.append((post, score))

        # 3. Sort by score
        scored_posts.sort(key=lambda x: x[1], reverse=True)

        # 4. Apply diversity (max 3 posts per user)
        diverse_posts = self._apply_diversity(scored_posts, max_per_user=3)

        # 5. Return top N
        return [post for post, _ in diverse_posts[:limit]]

    async def _get_candidate_posts(
        self, user_id: str, limit: int, cursor: str | None
    ) -> List[Post]:
        """
        Get candidate posts from:
        - Followed users (60%)
        - Trending posts (30%)
        - Recommended posts (10%)
        """
        # Get user's followings
        followings = await prisma.follow.find_many({
            "where": {"followerId": user_id},
            "select": {"followingId": True}
        })
        following_ids = [f.followingId for f in followings]

        # Get posts from followed users
        followed_posts = await prisma.post.find_many({
            "where": {
                "authorId": {"in": following_ids},
                "createdAt": {"gte": datetime.now() - timedelta(days=7)}
            },
            "orderBy": {"createdAt": "desc"},
            "take": int(limit * 0.6),
            "include": {"author": True, "likes": True, "retweets": True}
        })

        # Get trending posts
        trending_posts = await prisma.post.find_many({
            "where": {
                "createdAt": {"gte": datetime.now() - timedelta(days=1)},
                "engagementScore": {"gte": 10}
            },
            "orderBy": {"engagementScore": "desc"},
            "take": int(limit * 0.3),
            "include": {"author": True, "likes": True, "retweets": True}
        })

        # Combine and deduplicate
        all_posts = {post.id: post for post in followed_posts + trending_posts}
        return list(all_posts.values())

    def _extract_features(self, user_id: str, post: Post) -> np.ndarray:
        """
        Extract features for ML ranking

        Features:
        - Recency score (time decay)
        - Engagement score (likes + retweets + comments)
        - Author affinity (user's past engagement with author)
        - Content similarity (based on user's interests)
        - Virality (engagement rate)
        """
        # Time decay (exponential)
        age_hours = (datetime.now() - post.createdAt).total_seconds() / 3600
        recency_score = np.exp(-age_hours / 24)  # Half-life of 24 hours

        # Engagement score
        engagement_score = (
            post.likeCount * 1.0 +
            post.retweetCount * 2.0 +  # Retweets weighted higher
            post.commentCount * 3.0    # Comments weighted highest
        ) / 100

        # Engagement rate (normalized by follower count)
        author_followers = post.author.followersCount or 1
        engagement_rate = (post.likeCount + post.retweetCount) / author_followers

        # Author affinity (TODO: track user's past engagement with author)
        author_affinity = 0.5  # Placeholder

        # Has media (images/videos tend to perform better)
        has_media = 1.0 if (post.images or post.videos) else 0.0

        # Feature vector
        features = np.array([
            recency_score,
            engagement_score,
            engagement_rate,
            author_affinity,
            has_media,
            post.viewCount / 1000,  # Normalized view count
            len(post.content) / 280,  # Content length (normalized)
        ])

        return features

    def _apply_diversity(
        self, scored_posts: List[tuple[Post, float]], max_per_user: int = 3
    ) -> List[tuple[Post, float]]:
        """
        Apply diversity to avoid feed dominated by single user
        """
        diverse_posts = []
        author_counts = {}

        for post, score in scored_posts:
            author_id = post.authorId
            if author_counts.get(author_id, 0) < max_per_user:
                diverse_posts.append((post, score))
                author_counts[author_id] = author_counts.get(author_id, 0) + 1

        return diverse_posts
```

### ML Ranker (LightGBM)

```python
# app/ml/ranker.py
import numpy as np
import lightgbm as lgb
from typing import List

class FeedRanker:
    def __init__(self, model_path: str = "app/ml/models/feed_ranker.pkl"):
        self.model = lgb.Booster(model_file=model_path)

    def predict(self, features: np.ndarray) -> float:
        """
        Predict engagement score for a post

        Args:
            features: [recency, engagement, rate, affinity, has_media, views, length]

        Returns:
            Predicted engagement score (0-1)
        """
        return self.model.predict([features])[0]

    def predict_batch(self, features_batch: List[np.ndarray]) -> np.ndarray:
        """Batch prediction for efficiency"""
        return self.model.predict(features_batch)
```

### Training the Ranker

```python
# app/ml/train_ranker.py
import pandas as pd
import lightgbm as lgb
from sklearn.model_selection import train_test_split

def train_feed_ranker():
    """
    Train feed ranking model

    Target: User engagement (like/retweet/comment = 1, impression only = 0)
    Features: recency, engagement_score, engagement_rate, affinity, has_media, views, length
    """
    # Load training data (impressions + engagements)
    df = pd.read_csv("training_data.csv")

    # Features
    feature_cols = [
        "recency_score", "engagement_score", "engagement_rate",
        "author_affinity", "has_media", "view_count", "content_length"
    ]
    X = df[feature_cols]
    y = df["engaged"]  # Binary: 1 if user engaged, 0 otherwise

    # Split
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    # Train LightGBM
    params = {
        "objective": "binary",
        "metric": "auc",
        "learning_rate": 0.05,
        "num_leaves": 31,
        "max_depth": 6,
    }

    train_data = lgb.Dataset(X_train, label=y_train)
    model = lgb.train(params, train_data, num_boost_round=100)

    # Save model
    model.save_model("app/ml/models/feed_ranker.pkl")

    # Evaluate
    y_pred = model.predict(X_test)
    auc = roc_auc_score(y_test, y_pred)
    print(f"Model AUC: {auc:.4f}")

if __name__ == "__main__":
    train_feed_ranker()
```

## Content Moderation (Claude AI)

### Moderation Service

```python
# app/services/moderation_service.py
import anthropic
from typing import Dict
import json

class ModerationService:
    def __init__(self):
        self.client = anthropic.Anthropic(api_key=os.getenv("ANTHROPIC_API_KEY"))

    async def moderate_content(self, content: str) -> Dict:
        """
        Moderate content using Claude AI

        Returns:
            {
                "is_safe": bool,
                "category": str | None,  # "spam", "hate", "violence", "nsfw"
                "confidence": float,
                "reason": str | None
            }
        """
        prompt = f"""
Analyze this social media post for policy violations:

Post: "{content}"

Determine if the post violates any of these policies:
1. Spam or scam
2. Hate speech or harassment
3. Violence or threats
4. NSFW content (explicit)
5. Misinformation (extreme cases only)

Return a JSON response with:
- is_safe: boolean (true if no violations)
- category: string or null (one of: "spam", "hate", "violence", "nsfw", "misinfo")
- confidence: float (0-1)
- reason: string or null (brief explanation if flagged)

Post content: "{content}"
"""

        try:
            message = await self.client.messages.create(
                model="claude-3-5-sonnet-20241022",
                max_tokens=500,
                temperature=0,
                system="You are a content moderation expert. Respond with valid JSON only.",
                messages=[{"role": "user", "content": prompt}]
            )

            result = json.loads(message.content[0].text)
            return result

        except Exception as e:
            # Default to safe if moderation fails
            print(f"Moderation error: {e}")
            return {
                "is_safe": True,
                "category": None,
                "confidence": 0.0,
                "reason": "Moderation service unavailable"
            }

    async def moderate_batch(self, contents: List[str]) -> List[Dict]:
        """Batch moderation for efficiency"""
        return await asyncio.gather(*[self.moderate_content(c) for c in contents])
```

### Moderation Flow

```
User submits post
       ↓
Validate content
       ↓
Claude AI moderation ← Async
       ↓
If safe → Save to DB → Publish
       ↓
If unsafe → Return error → User sees message
```

## Trending Topics Algorithm

### Trending Service

```python
# app/services/trending_service.py
from datetime import datetime, timedelta
import math

class TrendingService:
    async def calculate_trending_topics(self) -> List[TrendingTopic]:
        """
        Calculate trending topics using time-decayed scoring

        Algorithm (Hackernews-style):
        score = (count - 1) / (age_hours + 2)^1.5
        """
        # Get hashtags from last 24 hours
        yesterday = datetime.now() - timedelta(hours=24)

        recent_hashtags = await prisma.$queryRaw("""
            SELECT h.tag, COUNT(p.id) as post_count, MIN(p."createdAt") as first_seen
            FROM "Hashtag" h
            JOIN "_HashtagToPost" hp ON h.id = hp."A"
            JOIN "Post" p ON hp."B" = p.id
            WHERE p."createdAt" >= $1
            GROUP BY h.tag
            HAVING COUNT(p.id) >= 3
        """, yesterday)

        trending = []
        for row in recent_hashtags:
            age_hours = (datetime.now() - row.first_seen).total_seconds() / 3600

            # Hackernews formula
            score = (row.post_count - 1) / math.pow(age_hours + 2, 1.5)

            trending.append({
                "tag": row.tag,
                "count": row.post_count,
                "score": score
            })

        # Sort by score and update DB
        trending.sort(key=lambda x: x["score"], reverse=True)

        for item in trending[:20]:
            await prisma.trendingTopic.upsert({
                "where": {"topic": item["tag"]},
                "update": {"count": item["count"], "score": item["score"]},
                "create": {"topic": item["tag"], "count": item["count"], "score": item["score"]}
            })

        return trending[:10]
```

## Real-Time Notifications (WebSocket)

### WebSocket Manager

```python
# app/websocket/manager.py
from fastapi import WebSocket
from typing import Dict, Set

class ConnectionManager:
    def __init__(self):
        # user_id -> set of WebSocket connections
        self.active_connections: Dict[str, Set[WebSocket]] = {}

    async def connect(self, user_id: str, websocket: WebSocket):
        await websocket.accept()
        if user_id not in self.active_connections:
            self.active_connections[user_id] = set()
        self.active_connections[user_id].add(websocket)

    def disconnect(self, user_id: str, websocket: WebSocket):
        if user_id in self.active_connections:
            self.active_connections[user_id].discard(websocket)
            if not self.active_connections[user_id]:
                del self.active_connections[user_id]

    async def send_personal_message(self, user_id: str, message: dict):
        """Send message to all connections for a user"""
        if user_id in self.active_connections:
            for connection in self.active_connections[user_id]:
                try:
                    await connection.send_json(message)
                except:
                    # Connection closed
                    self.disconnect(user_id, connection)

manager = ConnectionManager()
```

### WebSocket Endpoint

```python
# app/main.py
from app.websocket.manager import manager

@app.websocket("/ws/{user_id}")
async def websocket_endpoint(websocket: WebSocket, user_id: str):
    await manager.connect(user_id, websocket)
    try:
        while True:
            # Keep connection alive
            data = await websocket.receive_text()
            # Could handle client-side events here
    except WebSocketDisconnect:
        manager.disconnect(user_id, websocket)
```

### Notification Service

```python
# app/services/notification_service.py
from app.websocket.manager import manager

class NotificationService:
    async def send_notification(
        self,
        user_id: str,
        type: str,  # 'like', 'retweet', 'comment', 'follow', 'mention'
        actor_id: str,
        post_id: str | None = None
    ):
        """
        Send notification to user

        Flow:
        1. Save to DB
        2. Send via WebSocket (if online)
        3. Mark as unread
        """
        # Create notification in DB
        notification = await prisma.notification.create({
            "data": {
                "userId": user_id,
                "type": type,
                "actorId": actor_id,
                "postId": post_id,
                "read": False
            },
            "include": {
                "user": True,
                "actor": True,
                "post": True
            }
        })

        # Send via WebSocket
        await manager.send_personal_message(user_id, {
            "type": "notification",
            "data": notification
        })

        return notification
```

### Notification Triggers

```python
# app/api/v1/endpoints/posts.py

@router.post("/posts/{post_id}/like")
async def like_post(
    post_id: str,
    user_id: str = Depends(get_current_user_id),
    notification_service: NotificationService = Depends()
):
    # Create like
    like = await prisma.like.create({
        "data": {"userId": user_id, "postId": post_id}
    })

    # Update like count
    post = await prisma.post.update({
        "where": {"id": post_id},
        "data": {"likeCount": {"increment": 1}},
        "include": {"author": True}
    })

    # Send notification to post author
    if post.authorId != user_id:  # Don't notify self
        await notification_service.send_notification(
            user_id=post.authorId,
            type="like",
            actor_id=user_id,
            post_id=post_id
        )

    return like
```

## Search (ElasticSearch)

### Index Configuration

```python
# app/services/search_service.py
from elasticsearch import AsyncElasticsearch

class SearchService:
    def __init__(self):
        self.es = AsyncElasticsearch(hosts=[os.getenv("ELASTICSEARCH_URL")])

    async def create_indices(self):
        """Create ElasticSearch indices"""
        # Posts index
        await self.es.indices.create(
            index="posts",
            body={
                "mappings": {
                    "properties": {
                        "id": {"type": "keyword"},
                        "content": {"type": "text", "analyzer": "standard"},
                        "authorId": {"type": "keyword"},
                        "authorUsername": {"type": "keyword"},
                        "authorDisplayName": {"type": "text"},
                        "hashtags": {"type": "keyword"},
                        "createdAt": {"type": "date"},
                        "likeCount": {"type": "integer"},
                        "retweetCount": {"type": "integer"}
                    }
                }
            }
        )

        # Users index
        await self.es.indices.create(
            index="users",
            body={
                "mappings": {
                    "properties": {
                        "id": {"type": "keyword"},
                        "username": {"type": "keyword"},
                        "displayName": {"type": "text"},
                        "bio": {"type": "text"},
                        "verified": {"type": "boolean"},
                        "followersCount": {"type": "integer"}
                    }
                }
            }
        )

    async def index_post(self, post: Post):
        """Index a post for search"""
        await self.es.index(
            index="posts",
            id=post.id,
            body={
                "id": post.id,
                "content": post.content,
                "authorId": post.authorId,
                "authorUsername": post.author.username,
                "authorDisplayName": post.author.displayName,
                "hashtags": [h.tag for h in post.hashtags],
                "createdAt": post.createdAt,
                "likeCount": post.likeCount,
                "retweetCount": post.retweetCount
            }
        )

    async def search_posts(
        self, query: str, limit: int = 20, filters: dict = None
    ) -> List[Dict]:
        """Full-text search for posts"""
        body = {
            "query": {
                "bool": {
                    "must": [
                        {"multi_match": {
                            "query": query,
                            "fields": ["content^2", "authorUsername", "authorDisplayName"],
                            "fuzziness": "AUTO"
                        }}
                    ],
                    "filter": []
                }
            },
            "sort": [
                {"_score": "desc"},
                {"createdAt": "desc"}
            ],
            "size": limit
        }

        # Apply filters
        if filters:
            if filters.get("from_date"):
                body["query"]["bool"]["filter"].append({
                    "range": {"createdAt": {"gte": filters["from_date"]}}
                })

        results = await self.es.search(index="posts", body=body)
        return [hit["_source"] for hit in results["hits"]["hits"]]

    async def search_users(self, query: str, limit: int = 20) -> List[Dict]:
        """Search for users"""
        results = await self.es.search(
            index="users",
            body={
                "query": {
                    "multi_match": {
                        "query": query,
                        "fields": ["username^3", "displayName^2", "bio"],
                        "fuzziness": "AUTO"
                    }
                },
                "sort": [
                    {"_score": "desc"},
                    {"followersCount": "desc"}
                ],
                "size": limit
            }
        )
        return [hit["_source"] for hit in results["hits"]["hits"]]
```

## Frontend Architecture (Next.js)

### Directory Structure

```
frontend/
├── src/
│   ├── app/
│   │   ├── page.tsx                    # Homepage (redirect to /home or /landing)
│   │   ├── home/page.tsx               # Main feed
│   │   ├── explore/page.tsx            # Trending/Discover
│   │   ├── notifications/page.tsx      # Notifications
│   │   ├── messages/page.tsx           # Direct messages
│   │   ├── search/page.tsx             # Search results
│   │   ├── [username]/page.tsx         # User profile
│   │   ├── [username]/status/[postId]/page.tsx  # Post detail
│   │   ├── settings/page.tsx           # User settings
│   │   └── api/
│   │       ├── auth/[...nextauth]/route.ts  # NextAuth
│   │       └── upload/route.ts         # Image upload to S3
│   │
│   ├── components/
│   │   ├── feed/
│   │   │   ├── Feed.tsx                # Main feed component
│   │   │   ├── PostCard.tsx            # Single post card
│   │   │   ├── PostComposer.tsx        # Create post form
│   │   │   └── InfiniteScroll.tsx      # Pagination
│   │   ├── post/
│   │   │   ├── PostActions.tsx         # Like/Retweet/Comment buttons
│   │   │   ├── PostStats.tsx           # Engagement counts
│   │   │   ├── PostMedia.tsx           # Image/video display
│   │   │   └── PostThread.tsx          # Thread view
│   │   ├── user/
│   │   │   ├── UserCard.tsx            # User preview card
│   │   │   ├── FollowButton.tsx        # Follow/Unfollow
│   │   │   └── UserStats.tsx           # Follower/following counts
│   │   ├── sidebar/
│   │   │   ├── TrendingSidebar.tsx     # Trending topics
│   │   │   ├── WhoToFollow.tsx         # Recommendations
│   │   │   └── SearchBar.tsx           # Search input
│   │   ├── notifications/
│   │   │   ├── NotificationsList.tsx
│   │   │   └── NotificationItem.tsx
│   │   └── layout/
│   │       ├── Header.tsx
│   │       ├── Sidebar.tsx
│   │       └── MobileNav.tsx
│   │
│   ├── hooks/
│   │   ├── useWebSocket.ts             # WebSocket connection
│   │   ├── useFeed.ts                  # Feed queries
│   │   ├── usePost.ts                  # Post mutations
│   │   ├── useInfiniteScroll.ts        # Pagination
│   │   └── useNotifications.ts         # Real-time notifications
│   │
│   ├── lib/
│   │   ├── api.ts                      # API client
│   │   ├── auth.ts                     # NextAuth config
│   │   ├── websocket.ts                # WS client
│   │   └── utils.ts                    # Utilities
│   │
│   └── types/
│       ├── post.ts
│       ├── user.ts
│       └── notification.ts
│
└── public/
```

### Key React Components

#### Feed Component

```typescript
// components/feed/Feed.tsx
'use client'

import { useInfiniteQuery } from '@tanstack/react-query'
import { useInView } from 'react-intersection-observer'
import { PostCard } from './PostCard'

export function Feed({ userId }: { userId?: string }) {
  const { ref, inView } = useInView()

  const {
    data,
    fetchNextPage,
    hasNextPage,
    isFetchingNextPage,
  } = useInfiniteQuery({
    queryKey: ['feed', userId],
    queryFn: ({ pageParam }) =>
      fetch(`/api/feed?cursor=${pageParam || ''}`).then(res => res.json()),
    getNextPageParam: (lastPage) => lastPage.nextCursor,
  })

  // Fetch next page when sentinel is in view
  useEffect(() => {
    if (inView && hasNextPage) {
      fetchNextPage()
    }
  }, [inView, hasNextPage, fetchNextPage])

  const posts = data?.pages.flatMap(page => page.posts) || []

  return (
    <div className="space-y-4">
      {posts.map((post) => (
        <PostCard key={post.id} post={post} />
      ))}

      {/* Sentinel for infinite scroll */}
      <div ref={ref} className="h-10">
        {isFetchingNextPage && <Spinner />}
      </div>
    </div>
  )
}
```

#### Post Card Component

```typescript
// components/feed/PostCard.tsx
'use client'

import { usePost } from '@/hooks/usePost'
import { PostActions } from '@/components/post/PostActions'
import { PostMedia } from '@/components/post/PostMedia'
import Link from 'next/link'

export function PostCard({ post }: { post: Post }) {
  const { likePost, retweetPost, isLiked, isRetweeted } = usePost(post.id)

  return (
    <article className="border-b p-4 hover:bg-gray-50">
      {/* Author info */}
      <div className="flex gap-3">
        <Link href={`/${post.author.username}`}>
          <img
            src={post.author.avatar}
            alt={post.author.displayName}
            className="w-12 h-12 rounded-full"
          />
        </Link>

        <div className="flex-1">
          <div className="flex items-center gap-2">
            <Link href={`/${post.author.username}`} className="font-bold hover:underline">
              {post.author.displayName}
            </Link>
            <span className="text-gray-500">@{post.author.username}</span>
            <span className="text-gray-500">·</span>
            <time className="text-gray-500">{formatDate(post.createdAt)}</time>
          </div>

          {/* Content */}
          <Link href={`/${post.author.username}/status/${post.id}`}>
            <p className="mt-1 whitespace-pre-wrap">{renderContent(post.content)}</p>
          </Link>

          {/* Media */}
          {(post.images || post.videos) && (
            <PostMedia images={post.images} videos={post.videos} />
          )}

          {/* Actions */}
          <PostActions
            post={post}
            isLiked={isLiked}
            isRetweeted={isRetweeted}
            onLike={likePost}
            onRetweet={retweetPost}
          />
        </div>
      </div>
    </article>
  )
}
```

#### WebSocket Hook

```typescript
// hooks/useWebSocket.ts
import { useEffect, useState } from 'react'
import { useSession } from 'next-auth/react'

export function useWebSocket() {
  const { data: session } = useSession()
  const [socket, setSocket] = useState<WebSocket | null>(null)
  const [notifications, setNotifications] = useState<Notification[]>([])

  useEffect(() => {
    if (!session?.user?.id) return

    const ws = new WebSocket(`ws://localhost:8000/ws/${session.user.id}`)

    ws.onopen = () => {
      console.log('WebSocket connected')
    }

    ws.onmessage = (event) => {
      const data = JSON.parse(event.data)

      if (data.type === 'notification') {
        setNotifications(prev => [data.data, ...prev])

        // Show toast notification
        toast.info(`${data.data.actor.displayName} ${data.data.type}d your post`)
      }
    }

    ws.onerror = (error) => {
      console.error('WebSocket error:', error)
    }

    ws.onclose = () => {
      console.log('WebSocket disconnected')
      // Reconnect after 3 seconds
      setTimeout(() => setSocket(null), 3000)
    }

    setSocket(ws)

    return () => {
      ws.close()
    }
  }, [session?.user?.id])

  return { socket, notifications }
}
```

## Caching Strategy (Redis)

### Cache Patterns

```python
# app/db/redis.py
import redis.asyncio as redis
import json
from typing import Optional

class RedisCache:
    def __init__(self):
        self.redis = redis.from_url(os.getenv("REDIS_URL"))

    async def get_feed(self, user_id: str) -> Optional[List[Post]]:
        """Get cached feed"""
        key = f"feed:{user_id}"
        data = await self.redis.get(key)
        return json.loads(data) if data else None

    async def set_feed(self, user_id: str, posts: List[Post], ttl: int = 300):
        """Cache feed (5 minute TTL)"""
        key = f"feed:{user_id}"
        await self.redis.setex(key, ttl, json.dumps(posts))

    async def invalidate_feed(self, user_id: str):
        """Invalidate feed cache when user posts"""
        # Invalidate user's own feed
        await self.redis.delete(f"feed:{user_id}")

        # Invalidate feeds of all followers
        followers = await prisma.follow.find_many({
            "where": {"followingId": user_id},
            "select": {"followerId": True}
        })
        for follower in followers:
            await self.redis.delete(f"feed:{follower.followerId}")

    async def get_trending(self) -> Optional[List[Dict]]:
        """Get cached trending topics"""
        data = await self.redis.get("trending:topics")
        return json.loads(data) if data else None

    async def set_trending(self, topics: List[Dict], ttl: int = 600):
        """Cache trending topics (10 minute TTL)"""
        await self.redis.setex("trending:topics", ttl, json.dumps(topics))
```

## Performance Optimizations

### Database Optimizations

1. **Indexes**: Critical indexes on `authorId`, `createdAt`, `engagementScore`
2. **Denormalization**: Store counts (likes, retweets, followers) directly on posts/users
3. **Cursor pagination**: Use `cursor` instead of `offset` for large datasets
4. **Connection pooling**: Use Prisma connection pool (max 10 connections)

### API Optimizations

1. **N+1 Prevention**: Use Prisma `include` to fetch relations in single query
2. **Caching**: Cache feed, trending, user profiles in Redis
3. **Async operations**: Use FastAPI async for I/O-bound operations
4. **Batch operations**: Batch notifications, moderation checks

### Frontend Optimizations

1. **Code splitting**: Next.js automatic code splitting
2. **Image optimization**: Next.js Image component + S3 CDN
3. **Virtual scrolling**: For long feeds (react-window)
4. **Optimistic updates**: Update UI immediately before API confirmation
5. **Prefetching**: Prefetch next page of feed

## Environment Variables

```bash
# Backend (.env)
DATABASE_URL=postgresql://user:pass@localhost:5432/social_media
REDIS_URL=redis://localhost:6379
ELASTICSEARCH_URL=http://localhost:9200
ANTHROPIC_API_KEY=sk-ant-...
JWT_SECRET=your-secret-key
AWS_ACCESS_KEY_ID=...
AWS_SECRET_ACCESS_KEY=...
AWS_S3_BUCKET=social-media-uploads

# Frontend (.env.local)
NEXT_PUBLIC_API_URL=http://localhost:8000
NEXT_PUBLIC_WS_URL=ws://localhost:8000
NEXTAUTH_SECRET=your-nextauth-secret
NEXTAUTH_URL=http://localhost:3000
```

## Deployment Architecture

```
CloudFront CDN (static assets)
       ↓
Load Balancer
       ↓
Next.js (Vercel) ← Frontend
       ↓
API Gateway
       ↓
FastAPI (ECS Fargate) ← Backend (autoscaling 2-10 instances)
       ↓
┌──────────────┬──────────────┬──────────────┐
│              │              │              │
RDS PostgreSQL  ElastiCache   ElasticSearch
(read replicas) (Redis)       (cluster)
│
S3 (media files)
```

## Business Model

### Revenue Streams

1. **Ads**: Promoted posts in feed ($50k-$150k MRR)
2. **Premium subscriptions**: $8/month for verified badge, longer posts, analytics ($20k-$50k MRR)
3. **API access**: For third-party apps ($5k-$20k MRR)

### Projected MRR

- Low estimate: $75k MRR (10k premium users + ads)
- High estimate: $220k MRR (100k premium users + scaled ads)

## Known Limitations

1. **Feed algorithm**: Simple ML model (needs more training data for production)
2. **Moderation latency**: Claude API adds ~1-2 second latency to posts
3. **WebSocket scaling**: Need Redis pub/sub for multi-server deployment
4. **Search cost**: ElasticSearch can be expensive at scale (consider Algolia)

## Future Enhancements

- [ ] Spaces (audio chat rooms)
- [ ] Communities (like Reddit subreddits)
- [ ] Bookmarks
- [ ] Lists
- [ ] Advanced search filters
- [ ] Thread view improvements
- [ ] Mobile apps (React Native)
- [ ] Video encoding for uploads
- [ ] Recommendation engine for "Who to Follow"
- [ ] Analytics dashboard for creators

---

**Last Updated**: 2025-10-15
**Project Status**: Production-ready template
**Complexity**: Advanced (12-16 hours to complete)
