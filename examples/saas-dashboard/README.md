# 📊 SaaS Dashboard - Multi-tenant Platform

Full-featured SaaS dashboard with team management, analytics, and subscription billing.

## 📋 Overview

**Descripción**: Plataforma SaaS completa con multi-tenancy, dashboard analytics, team management, y billing con Stripe.

**Stack**:
- **Frontend**: Nuxt 3, Vue 3, TypeScript, Tailwind CSS, Pinia
- **Backend**: Django 4, Django REST Framework, PostgreSQL, Redis, Celery
- **Payments**: Stripe subscriptions
- **Deployment**: Vercel (frontend) + Railway (backend)

**Tiempo estimado**: 5-6 horas

**Nivel**: 🟡 Intermedio

---

## ✨ Features

### Customer Features
- ✅ User registration and onboarding
- ✅ Interactive dashboard with charts
- ✅ Team management (invite, roles, permissions)
- ✅ Project/workspace management
- ✅ Real-time notifications
- ✅ User settings and preferences
- ✅ Subscription management
- ✅ Usage analytics and reports

### Admin Features
- ✅ Tenant management
- ✅ User management across tenants
- ✅ Subscription analytics
- ✅ System monitoring
- ✅ Feature flags per tenant
- ✅ Audit logs

### Technical Features
- ✅ Multi-tenant architecture (schema-based)
- ✅ SSR with Nuxt 3
- ✅ Real-time updates (Server-Sent Events)
- ✅ Stripe webhooks for billing events
- ✅ Background jobs with Celery
- ✅ Redis caching
- ✅ JWT authentication
- ✅ Role-based access control (RBAC)
- ✅ API rate limiting
- ✅ Comprehensive logging

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    FRONTEND (Nuxt 3 + Vue 3)                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐          │
│  │  Dashboard   │  │   Team       │  │   Settings   │          │
│  │  (SSR)       │  │   (SSR)      │  │   (Client)   │          │
│  └──────────────┘  └──────────────┘  └──────────────┘          │
│                                                                   │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐          │
│  │  Projects    │  │   Billing    │  │   Analytics  │          │
│  │  (SSR)       │  │   (Client)   │  │   (SSR)      │          │
│  └──────────────┘  └──────────────┘  └──────────────┘          │
│                                                                   │
│  State: Pinia stores (user, tenant, notifications)               │
│                                                                   │
└───────────────────────────┬─────────────────────────────────────┘
                            │ HTTP/REST + WebSocket
                            │
┌───────────────────────────▼─────────────────────────────────────┐
│                BACKEND (Django + DRF)                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐          │
│  │  Tenants     │  │  Users       │  │  Teams       │          │
│  │  API         │  │  API         │  │  API         │          │
│  └──────────────┘  └──────────────┘  └──────────────┘          │
│                                                                   │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐          │
│  │  Projects    │  │  Analytics   │  │  Billing     │          │
│  │  API         │  │  API         │  │  (Stripe)    │          │
│  └──────────────┘  └──────────────┘  └──────────────┘          │
│                                                                   │
│  ┌──────────────┐  ┌──────────────┐                            │
│  │  Celery      │  │  Channels    │                            │
│  │  (Tasks)     │  │  (WebSocket) │                            │
│  └──────────────┘  └──────────────┘                            │
│                                                                   │
└───────────────────────────┬─────────────────────────────────────┘
                            │
        ┌───────────────────┼───────────────────┬─────────────┐
        │                   │                   │             │
        ▼                   ▼                   ▼             ▼
  ┌──────────┐       ┌──────────┐       ┌──────────┐  ┌──────────┐
  │PostgreSQL│       │  Redis   │       │  Celery  │  │  Stripe  │
  │(Multi-   │       │ (Cache & │       │  Worker  │  │   API    │
  │ tenant)  │       │  Queue)  │       │          │  │          │
  └──────────┘       └──────────┘       └──────────┘  └──────────┘
```

---

## 🚀 Quick Start

### Prerequisites

```bash
# Required
- Node.js 18+
- Python 3.11+
- PostgreSQL 14+
- Redis 7+

# Optional
- Docker & Docker Compose
- Stripe account (for payments)
```

### Setup con Claude Code

#### Paso 1: Backend (Django)

```bash
# En Claude Code, en el directorio backend/
> Use django-architect to create a SaaS platform backend with:
  - Multi-tenant architecture (schema-based with django-tenants)
  - User authentication and authorization
  - Team management (invitations, roles: owner, admin, member)
  - Project/workspace management
  - Subscription billing with Stripe
  - Analytics API (usage stats, charts data)
  - Real-time notifications with Django Channels
  - Background tasks with Celery (email, reports, cleanup)
  - Redis caching for frequently accessed data
  - Comprehensive admin interface
  - API rate limiting per tenant
  - Audit logging
  - Tests with pytest-django

# El agente creará la estructura completa
```

#### Paso 2: Frontend (Nuxt 3)

```bash
# En Claude Code, en el directorio frontend/
> Use nuxt-architect to create a SaaS dashboard frontend with:
  - Dashboard page with charts (Chart.js/ApexCharts)
  - Team management (invite users, manage roles)
  - Project/workspace management
  - User settings (profile, preferences, notifications)
  - Billing page (subscription, invoices, payment methods)
  - Analytics page with filters and date ranges
  - Real-time notifications (Server-Sent Events)
  - Responsive layout (sidebar, header, mobile menu)
  - Dark mode support
  - Loading states and error handling
  - Pinia stores for state management
  - Type-safe API client
  - Middleware for auth and tenant context

# El agente creará la estructura completa
```

---

## 📁 Project Structure

### Backend Structure

```
backend/
├── apps/
│   ├── tenants/
│   │   ├── models.py              # Tenant model
│   │   ├── middleware.py          # Tenant context middleware
│   │   └── views.py               # Tenant API
│   ├── users/
│   │   ├── models.py              # User, Profile models
│   │   ├── serializers.py
│   │   ├── views.py               # User management API
│   │   └── permissions.py         # Custom permissions
│   ├── teams/
│   │   ├── models.py              # Team, TeamMember, Invitation
│   │   ├── serializers.py
│   │   └── views.py               # Team management API
│   ├── projects/
│   │   ├── models.py              # Project, ProjectMember
│   │   ├── serializers.py
│   │   └── views.py
│   ├── analytics/
│   │   ├── services.py            # Analytics calculations
│   │   └── views.py               # Analytics API
│   ├── billing/
│   │   ├── models.py              # Subscription, Invoice
│   │   ├── stripe_service.py      # Stripe integration
│   │   ├── webhooks.py            # Stripe webhooks
│   │   └── views.py
│   └── notifications/
│       ├── models.py              # Notification model
│       ├── consumers.py           # WebSocket consumers
│       └── tasks.py               # Celery tasks
├── config/
│   ├── settings/
│   │   ├── base.py
│   │   ├── development.py
│   │   └── production.py
│   ├── urls.py
│   ├── celery.py                  # Celery configuration
│   └── asgi.py                    # ASGI for Channels
├── tests/
├── manage.py
└── requirements.txt
```

### Frontend Structure

```
frontend/
├── app/
│   ├── (dashboard)/
│   │   ├── layout.vue             # Dashboard layout
│   │   ├── index.vue              # Dashboard home
│   │   ├── team/
│   │   │   ├── index.vue          # Team management
│   │   │   └── invite.vue         # Invite members
│   │   ├── projects/
│   │   │   ├── index.vue          # Projects list
│   │   │   ├── [id]/
│   │   │   │   └── index.vue      # Project detail
│   │   │   └── new.vue
│   │   ├── analytics/
│   │   │   └── index.vue          # Analytics dashboard
│   │   ├── billing/
│   │   │   ├── index.vue          # Subscription management
│   │   │   └── invoices.vue
│   │   └── settings/
│   │       ├── profile.vue
│   │       ├── preferences.vue
│   │       └── notifications.vue
│   ├── (auth)/
│   │   ├── login.vue
│   │   ├── register.vue
│   │   └── onboarding.vue         # Post-registration setup
│   └── admin/                     # Admin-only pages
├── components/
│   ├── dashboard/
│   │   ├── StatCard.vue
│   │   ├── ChartCard.vue
│   │   └── ActivityFeed.vue
│   ├── team/
│   │   ├── TeamMemberCard.vue
│   │   ├── InviteForm.vue
│   │   └── RoleSelector.vue
│   ├── layout/
│   │   ├── Sidebar.vue
│   │   ├── Header.vue
│   │   ├── NotificationBell.vue
│   │   └── UserMenu.vue
│   └── ui/                        # Base UI components
├── composables/
│   ├── useAuth.ts
│   ├── useTenant.ts
│   ├── useNotifications.ts
│   └── useSubscription.ts
├── stores/
│   ├── user.ts                    # User state (Pinia)
│   ├── tenant.ts                  # Tenant context
│   ├── notifications.ts           # Real-time notifications
│   └── ui.ts                      # UI state (sidebar, modals)
├── middleware/
│   ├── auth.ts                    # Require authentication
│   ├── tenant.ts                  # Require tenant context
│   └── subscription.ts            # Check subscription status
├── lib/
│   ├── api-client.ts              # Type-safe API client
│   ├── stripe.ts                  # Stripe utilities
│   └── charts.ts                  # Chart.js config
├── types/
│   ├── user.ts
│   ├── tenant.ts
│   ├── team.ts
│   └── analytics.ts
└── nuxt.config.ts
```

---

## 🔧 Multi-Tenant Architecture

### Schema-Based Isolation

```python
# backend/apps/tenants/models.py
from django_tenants.models import TenantMixin, DomainMixin

class Tenant(TenantMixin):
    name = models.CharField(max_length=100)
    slug = models.SlugField(unique=True)
    plan = models.CharField(max_length=20)  # free, pro, enterprise
    max_users = models.IntegerField(default=5)
    created_at = models.DateTimeField(auto_now_add=True)

    # Each tenant gets its own schema
    auto_create_schema = True

class Domain(DomainMixin):
    pass

# Each tenant has isolated data in separate database schema:
# tenant_acme.users
# tenant_acme.projects
# tenant_widget.users
# tenant_widget.projects
```

### Tenant Context Middleware

```python
# Automatically set tenant based on subdomain or header
# acme.saas-app.com → tenant: acme
# widget.saas-app.com → tenant: widget

# Frontend sends tenant in header:
# X-Tenant-Slug: acme
```

---

## 💳 Subscription & Billing

### Stripe Integration

**Plans**:
- **Free**: $0/month - 5 users, basic features
- **Pro**: $29/month - 20 users, advanced features
- **Enterprise**: $99/month - Unlimited users, all features

**Flow**:
1. User selects plan
2. Frontend calls `/api/billing/create-subscription`
3. Backend creates Stripe subscription
4. User enters payment details (Stripe Elements)
5. Stripe confirms subscription
6. Webhook updates tenant's plan
7. Features unlocked based on plan

**Webhooks Handled**:
- `customer.subscription.created`
- `customer.subscription.updated`
- `customer.subscription.deleted`
- `invoice.payment_succeeded`
- `invoice.payment_failed`

---

## 📊 Analytics & Charts

### Dashboard Metrics

```typescript
// Types for analytics data
interface DashboardStats {
  totalProjects: number
  activeProjects: number
  totalTeamMembers: number
  storageUsed: number      // in MB
  apiCallsThisMonth: number

  projectsOverTime: ChartData[]
  userActivityOverTime: ChartData[]
  topProjects: TopProjectData[]
}

// Charts displayed:
// - Projects created over time (Line chart)
// - User activity by day (Bar chart)
// - Storage usage (Donut chart)
// - Top 5 active projects (Table)
```

### Real-time Updates

```typescript
// composables/useNotifications.ts
export const useNotifications = () => {
  const eventSource = ref<EventSource | null>(null)

  const connect = () => {
    eventSource.value = new EventSource('/api/notifications/stream')

    eventSource.value.onmessage = (event) => {
      const notification = JSON.parse(event.data)
      // Update Pinia store
      notificationStore.add(notification)
      // Show toast
      toast.success(notification.message)
    }
  }

  return { connect }
}
```

---

## 👥 Team Management & RBAC

### Roles

```python
class TeamMember(models.Model):
    ROLE_CHOICES = [
        ('owner', 'Owner'),        # Full access, billing
        ('admin', 'Admin'),        # Manage team, projects
        ('member', 'Member'),      # Access projects
        ('viewer', 'Viewer'),      # Read-only
    ]

    team = models.ForeignKey(Team, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    role = models.CharField(max_length=20, choices=ROLE_CHOICES)
```

### Permission Checks

```python
# Backend
class IsTeamOwner(permissions.BasePermission):
    def has_object_permission(self, request, view, obj):
        return obj.team.members.filter(
            user=request.user,
            role='owner'
        ).exists()

# Frontend
<template>
  <button v-if="canManageTeam">
    Invite Member
  </button>
</template>

<script setup>
const { user } = useUser()
const canManageTeam = computed(() =>
  ['owner', 'admin'].includes(user.value?.role)
)
</script>
```

---

## 🔔 Real-time Notifications

### Types of Notifications

- **Team**: User joined, user left, role changed
- **Project**: Project created, updated, archived
- **Billing**: Subscription renewed, payment failed
- **System**: Maintenance scheduled, new features

### Implementation

```python
# backend/apps/notifications/tasks.py
@shared_task
def send_notification(user_id, notification_type, message):
    """Send real-time notification via WebSocket"""
    channel_layer = get_channel_layer()
    async_to_sync(channel_layer.group_send)(
        f"user_{user_id}",
        {
            "type": "notification.message",
            "message": message,
            "notification_type": notification_type
        }
    )
```

```vue
<!-- frontend/components/layout/NotificationBell.vue -->
<script setup lang="ts">
const { notifications, unreadCount } = useNotifications()

onMounted(() => {
  // Connect to Server-Sent Events
  useNotifications().connect()
})
</script>

<template>
  <button class="relative">
    <BellIcon />
    <span v-if="unreadCount > 0" class="badge">
      {{ unreadCount }}
    </span>
  </button>
</template>
```

---

## 🎨 UI/UX Features

### Dark Mode

```typescript
// composables/useDarkMode.ts
export const useDarkMode = () => {
  const isDark = useState('darkMode', () => false)

  const toggleDark = () => {
    isDark.value = !isDark.value
    // Persist to localStorage
    localStorage.setItem('darkMode', String(isDark.value))
    // Toggle class on html
    document.documentElement.classList.toggle('dark')
  }

  return { isDark, toggleDark }
}
```

### Responsive Sidebar

```vue
<!-- components/layout/Sidebar.vue -->
<script setup>
const uiStore = useUIStore()
const { sidebarOpen } = storeToRefs(uiStore)

// Close on mobile after navigation
const router = useRouter()
router.afterEach(() => {
  if (window.innerWidth < 768) {
    uiStore.closeSidebar()
  }
})
</script>

<template>
  <aside
    :class="[
      'sidebar',
      sidebarOpen ? 'open' : 'closed'
    ]"
  >
    <!-- Navigation -->
  </aside>
</template>
```

---

## 🧪 Testing

### Backend Tests

```python
# tests/test_teams.py
@pytest.mark.django_db
def test_invite_team_member(api_client, owner_user, tenant):
    """Test inviting a new team member"""
    api_client.force_authenticate(user=owner_user)

    response = api_client.post(
        '/api/teams/invite/',
        {
            'email': 'newuser@example.com',
            'role': 'member'
        }
    )

    assert response.status_code == 201
    assert Invitation.objects.filter(email='newuser@example.com').exists()
    # Email task should be queued
    assert len(mail.outbox) == 1

@pytest.mark.django_db
def test_team_member_permissions(api_client, member_user, team):
    """Test that member cannot delete team"""
    api_client.force_authenticate(user=member_user)

    response = api_client.delete(f'/api/teams/{team.id}/')

    assert response.status_code == 403
```

---

## 🎓 Learning Objectives

Al completar este ejemplo, aprenderás:

### Multi-Tenancy
- ✅ Schema-based tenant isolation
- ✅ Tenant context middleware
- ✅ Subdomain routing
- ✅ Per-tenant customization

### Full-Stack Integration
- ✅ Nuxt 3 SSR with Django backend
- ✅ Pinia state management
- ✅ Real-time updates (SSE/WebSocket)
- ✅ Type-safe API client

### Billing & Subscriptions
- ✅ Stripe integration
- ✅ Subscription plans
- ✅ Webhook handling
- ✅ Usage-based billing

### Team Management
- ✅ Invitations system
- ✅ Role-based access control
- ✅ Permission checking
- ✅ Team workflows

### Advanced Django
- ✅ Django REST Framework
- ✅ Custom permissions
- ✅ Celery background tasks
- ✅ Django Channels (WebSocket)
- ✅ Multi-database routing

### Modern Vue/Nuxt
- ✅ Composition API patterns
- ✅ Pinia stores
- ✅ Nuxt middleware
- ✅ Server-side rendering
- ✅ Composables

---

## 🚢 Deployment

### Backend (Railway)

```bash
# Procfile
web: gunicorn config.wsgi --workers 4 --threads 2
worker: celery -A config worker -l info
beat: celery -A config beat -l info
```

### Frontend (Vercel)

```bash
# nuxt.config.ts
export default defineNuxtConfig({
  nitro: {
    preset: 'vercel'
  }
})
```

---

## 💡 Next Steps

Después de completar este ejemplo:

1. **Add more features**:
   - File storage and sharing
   - Activity timeline
   - API keys management
   - Custom domains per tenant
   - White-label support

2. **Optimize performance**:
   - Database query optimization
   - Redis caching strategy
   - CDN for static assets
   - Background job optimization

3. **Scale to production**:
   - Load testing
   - Monitoring (Sentry, DataDog)
   - Backup strategy
   - Disaster recovery plan

---

## 🔗 Resources

- **Nuxt Architect Agent**: [`../../agents/stacks/vue-nuxt/nuxt-architect.md`](../../agents/stacks/vue-nuxt/nuxt-architect.md)
- **Django Architect Agent**: [`../../agents/stacks/python-django/django-architect.md`](../../agents/stacks/python-django/django-architect.md)
- **Multi-Agent Orchestration**: [`../../docs/guides/02-intermediate/multi-agent-orchestration.md`](../../docs/guides/02-intermediate/multi-agent-orchestration.md)

---

**¿Listo para empezar?** Usa los agentes `nuxt-architect` y `django-architect` para crear este proyecto en 5-6 horas.

**Próximo paso**: Después de dominar este ejemplo, puedes crear tu propia SaaS app o explorar el [Multi-tenant SaaS](../multitenant-saas/) example para enterprise features.
