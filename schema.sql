-- 1. Create the authors table
CREATE TABLE IF NOT EXISTS authors (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL
);

-- Case-insensitive unique index to prevent duplicate authors
CREATE UNIQUE INDEX IF NOT EXISTS idx_authors_name_lower 
ON authors (LOWER(name));

-- 2. Create the books table
CREATE TABLE IF NOT EXISTS books (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title TEXT NOT NULL,
    author_id INTEGER NOT NULL REFERENCES authors(id) ON DELETE RESTRICT,
    status TEXT NOT NULL DEFAULT 'pending',
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);