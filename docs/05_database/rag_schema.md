# rag_schema.md

# 📊 RAG Knowledge Engine - Database Schema Documentation

This document defines the database schema used for the RAG Knowledge Engine. It provides detailed explanations of each table, its purpose, and the rationale behind each column, key, and index.

---

# 📝 Table: `documents`

## Purpose:
Store metadata about every original document uploaded to the system (e.g., meeting recording, PDF spec, Excel pipeline input).

## Columns:

| Column Name | Data Type | Description |
|:------------|:----------|:------------|
| id | UUID (Primary Key) | Unique identifier for each document (auto-generated). |
| document_title | VARCHAR(512) | Human-readable title or topic of the document. |
| document_type | VARCHAR(50) | The file type (e.g., pdf, audio, word, excel). |
| project_name | VARCHAR(255) | Project or logical grouping associated with the document. |
| uploaded_by | VARCHAR(255) | Username or service that uploaded the document. |
| uploaded_at | TIMESTAMP | System-generated timestamp when the document was ingested. |

## Keys and Indexes:
- **Primary Key**: `id`
- **Indexes**:
  - `project_name` (optimized for filtering/searching documents by project)
  - `document_type` (optimized for filtering/searching documents by type)

## Special Notes:
- Only metadata is stored; file blobs are handled outside the database (e.g., object storage).

---

# 📝 Table: `chunks`

## Purpose:
Store extracted text chunks from documents, along with their vector embeddings for semantic retrieval.

## Columns:

| Column Name | Data Type | Description |
|:------------|:----------|:------------|
| id | UUID (Primary Key) | Unique identifier for each text chunk. |
| document_id | UUID (Foreign Key) | Reference to the parent document. |
| chunk_text | TEXT | Raw text content of the chunk. |
| chunk_index | INTEGER | The sequential order of this chunk within the original document. |
| embedding | VECTOR(1536) | The vector representation of the chunk text (1536 dimensions for OpenAI embeddings). |
| created_at | TIMESTAMP | System-generated timestamp when the chunk was created. |

## Keys and Indexes:
- **Primary Key**: `id`
- **Foreign Key**: `document_id` references `documents(id)` (with cascading delete)
- **Indexes**:
  - `document_id` (optimized for fast retrieval of all chunks belonging to a document)
  - `embedding` (indexed using ivfflat for approximate nearest neighbor searches)

## Special Notes:
- Embedding indexing requires pgvector extension.
- Chunking strategy (paragraph, sentence, etc.) is decided upstream during intake.

---

# 📝 Table: `metadata_fields`

## Purpose:
Manage the list of allowed and required metadata fields for uploaded documents (optional future enhancement).

## Columns:

| Column Name | Data Type | Description |
|:------------|:----------|:------------|
| id | SERIAL (Primary Key) | Unique auto-increment ID for metadata field. |
| field_name | VARCHAR(255) | Name of the metadata field (e.g., "Meeting Topic"). |
| required | BOOLEAN | Whether this field is mandatory for document intake. |

## Keys and Indexes:
- **Primary Key**: `id`
- **Unique Constraint**: `field_name` must be unique.

## Special Notes:
- Allows dynamic enforcement of required metadata during file intake validation.

---

# 📝 Table: `versions`

## Purpose:
Track changes and version history of system-generated documents (e.g., SRS v1, v2, etc.).

## Columns:

| Column Name | Data Type | Description |
|:------------|:----------|:------------|
| id | UUID (Primary Key) | Unique identifier for each version record. |
| document_id | UUID (Foreign Key) | Reference to the parent document being versioned. |
| version_number | INTEGER | The version sequence number (e.g., 1, 2, 3). |
| content | TEXT | Full text content of the generated document version. |
| created_at | TIMESTAMP | System-generated timestamp when this version was created. |

## Keys and Indexes:
- **Primary Key**: `id`
- **Foreign Key**: `document_id` references `documents(id)`
- **Indexes**:
  - `document_id` (optimized for fetching version history)

## Special Notes:
- Allows human-in-the-loop tracking and rollbacks of generated documentation over time.

---

# 📢 Important Best Practices

- Always batch insert chunks for performance when loading many chunks per document.
- Maintain consistency in embedding dimension across the entire database.
- Apply proper retention policies if storage grows large (e.g., prune obsolete versions).
- Maintain vector index health with periodic `REINDEX` or vector index maintenance commands.

---

# ✅ Schema Documentation Complete

