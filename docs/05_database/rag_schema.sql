-- rag_schema.sql

-- ===================================================
-- 📚 RAG Knowledge Engine - Postgres Schema Setup
-- ===================================================

-- Drop tables if they exist (for clean rebuilds)
DROP TABLE IF EXISTS versions;
DROP TABLE IF EXISTS chunks;
DROP TABLE IF EXISTS documents;
DROP TABLE IF EXISTS metadata_fields;

-- ========================================
-- 🗂️ documents table
-- ========================================
CREATE TABLE documents (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    document_title VARCHAR(512) NOT NULL,
    document_type VARCHAR(50) NOT NULL,
    project_name VARCHAR(255) NOT NULL,
    uploaded_by VARCHAR(255) NOT NULL,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_documents_project_name ON documents(project_name);
CREATE INDEX idx_documents_document_type ON documents(document_type);

-- ========================================
-- 📄 chunks table
-- ========================================
CREATE TABLE chunks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    document_id UUID REFERENCES documents(id) ON DELETE CASCADE,
    chunk_text TEXT NOT NULL,
    chunk_index INTEGER NOT NULL,
    embedding VECTOR(1536),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_chunks_document_id ON chunks(document_id);
CREATE INDEX idx_chunks_embedding ON chunks USING ivfflat (embedding vector_cosine_ops);

-- ========================================
-- 🧩 metadata_fields table (optional)
-- ========================================
CREATE TABLE metadata_fields (
    id SERIAL PRIMARY KEY,
    field_name VARCHAR(255) NOT NULL UNIQUE,
    required BOOLEAN DEFAULT FALSE
);

-- ========================================
-- 📚 versions table (optional)
-- ========================================
CREATE TABLE versions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    document_id UUID REFERENCES documents(id) ON DELETE CASCADE,
    version_number INTEGER NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_versions_document_id ON versions(document_id);

-- ===================================================
-- ✅ Schema setup complete
-- ===================================================
