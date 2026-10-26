# Personal Library — Development Log

A chronological record of engineering decisions, completed milestones, and architecture notes for the Personal Library project.

---

## [2026-10-26] — Environment Setup, Database Schema & Database Connection

### Objective
- Set up development environment, initialize project architecture, define PostgreSQL schema, and establish verified Node.js database connectivity.

### Accomplished
1. **Toolchain & Environment Upgrades:**
   - Diagnosed and resolved legacy toolchain issues on macOS (updated legacy VS Code from 2021 and upgraded Node.js runtime from `v10.16` to current LTS to support modern JavaScript syntax like optional chaining `?.` and nullish coalescing `??`).
   - Disabled unnecessary background extensions (C/C++ language tools).
   - Local PostgreSQL instance configured and running on port 5432 using Postgres.app; command-line tools (`psql`, `createdb`) integrated into `.zshrc`.

2. **Database Design & Schema (`schema.sql`):**
   - Created database `personal_library`.
   - Designed normalized schema with two core tables:
     - `authors`: Auto-incrementing primary key (`GENERATED ALWAYS AS IDENTITY`), required `name`, and case-insensitive uniqueness enforced via `CREATE UNIQUE INDEX idx_authors_name_lower ON authors (LOWER(name))`.
     - `books`: Auto-incrementing primary key, required `title`, foreign key `author_id` referencing `authors(id)` with `ON DELETE RESTRICT` (preventing orphan records), default status `'pending'`, and timestamped creation (`created_at TIMESTAMPTZ`).
   - Verified constraints and referential integrity directly in interactive `psql`.

3. **Version Control:**
   - Git repository initialized with `.gitignore` (ignoring `.env` and `node_modules`).
   - Remote repository established at `https://github.com/mgambina/personal-library` using GitHub Personal Access Token (classic) over HTTPS.
   - Pushed initial setup and schema definitions to branch `main`.

4. **Node.js Database Connectivity:**
   - Installed `pg` (node-postgres) and `dotenv`.
   - Created `src/db.js` using `pg.Pool` initialized from `DATABASE_URL` in `.env`.
   - Tested and verified live database querying via `src/test-connection.js`.

### Next Steps
- Clean up test files.
- Implement data access modules:
  - `src/models/author.js` (parameterized queries: `findByName`, `create`, `findOrCreate`).
  - `src/models/book.js` (insert, retrieve with author join, status update).

---