# Architecture Overview

## High-Level Diagram
┌─────────────────────────────────────────────────────────┐
│ Client Layer │
│ Hotwire (Turbo + Stimulus) │ REST API v1 (JSON) │
└─────────────────────────────────────────────────────────┘
│
┌─────────────────────────────────────────────────────────┐
│ Controllers Layer │
│ Web Controllers │ API v1 Controllers │ Devise │
└─────────────────────────────────────────────────────────┘
│
┌─────────────────────────────────────────────────────────┐
│ Application Logic Layer │
│ Service Objects │ Query Objects │ Pundit Policies │
└─────────────────────────────────────────────────────────┘
│
┌─────────────────────────────────────────────────────────┐
│ Domain Layer │
│ Models │ Concerns │ Validations │ Business Rules │
└─────────────────────────────────────────────────────────┘
│
┌─────────────────────────────────────────────────────────┐
│ Infrastructure Layer │
│ PostgreSQL │ Redis │ Sidekiq │ S3 │ Stripe │
└─────────────────────────────────────────────────────────┘

text

## Directory Structure

- `app/controllers/` — Web + API controllers with Pundit authorization
- `app/controllers/api/v1/` — RESTful JSON API with token auth
- `app/controllers/concerns/` — Shared controller behavior
- `app/models/` — ActiveRecord models with business rules
- `app/policies/` — Pundit authorization policies
- `app/services/` — Single-responsibility service objects
- `app/jobs/` — Sidekiq background jobs
- `app/serializers/` — JSON serialization for API
- `app/components/` — ViewComponents for reusable UI
- `app/views/` — ERB templates with Hotwire

## Testing Strategy

- **Unit specs** — Models, services, policies, components
- **Request specs** — API endpoints
- **System specs** — End-to-end user flows (Capybara)

## CI Pipeline

GitHub Actions runs three parallel jobs on every push to `main`:

1. **Lint** — RuboCop
2. **Security** — Brakeman
3. **Test** — RSpec with PostgreSQL and Redis service containers