
# LMS Enterprise — SaaS Learning Management System

Enterprise-grade Learning Management System built with Ruby on Rails 8.1, featuring Hotwire, REST API, background jobs, and full CI/CD pipeline.

## Tech Stack

- **Ruby 3.4.10** + **Rails 8.1.3.1**
- **PostgreSQL 18** + **Redis 7**
- **Sidekiq** for background jobs
- **Hotwire** (Turbo + Stimulus) for real-time UI
- **Devise** + **Pundit** for auth & authorization
- **Stripe** for payments, **AWS S3** for storage
- **RSpec** + **FactoryBot** + **Faker** for testing
- **RuboCop** + **Brakeman** for code quality & security
- **GitHub Actions** CI (lint + security + test)

## Features

- Multi-role authentication (Admin / Instructor / Student)
- Course & module management with lessons
- Enrollment system (free & paid via Stripe)
- Progress tracking & lesson completion
- Quiz engine with auto-grading
- Certificate generation (PDF via Sidekiq)
- Discussion forum per course
- Real-time notifications
- Global search (pg_search)
- Health check endpoint for load balancer

## Architecture

- **15+ database migrations** with proper indexing
- **Service Objects** for complex business logic
- **Query & Policy Objects** (Pundit)
- **Background Jobs** (Sidekiq)
- **API v1** namespace for external clients
- **Hotwire/Turbo** for interactive UI without heavy JS

## Getting Started

### Prerequisites

- Ruby 3.4+
- PostgreSQL 14+
- Redis 7+

### Setup

```bash
git clone https://github.com/nareswara353-ux/Project-Ruby.git
cd Project-Ruby
bundle install
bin/rails db:create db:migrate db:seed
bin/rails server
Run Tests
bash
bundle exec rspec
Lint & Security
bash
bundle exec rubocop
bundle exec brakeman
Demo Credentials
After db:seed:

Admin: admin@lms.test / password123

Instructor: instructor1@lms.test / password123

Student: student1@lms.test / password123

License
MIT# Test
