# Contributing Guide

## Setup

```bash
git clone https://github.com/nareswara353-ux/Project-Ruby.git
cd Project-Ruby
bundle install
bin/rails db:setup
bin/rails db:seed
Code Style
Ruby style enforced by RuboCop (see .rubocop.yml)

No comments in code — use expressive naming

Prefer service objects over fat models/controllers

Every service, policy, and job must have a spec

Commit Convention
text
<type>(<scope>): <description>

feat, fix, chore, docs, test, refactor, ci, perf
Pull Request Checklist
□ All specs pass: bundle exec rspec
□ RuboCop clean: bundle exec rubocop
□ Brakeman clean: bundle exec brakeman
□ Migrations run cleanly from scratch