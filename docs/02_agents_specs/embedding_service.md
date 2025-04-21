# embedding_service.md

# 📚 Embedding Service Detailed Specification

The Embedding Service is responsible for converting cleaned text chunks into semantic vector embeddings, enriching them with metadata, and storing them into the vector database.

It acts as a critical bridge between raw document chunks and retrieval-ready semantic storage.

---

# 📋 Core Responsibilities

| Responsibility | Detail |
|:---------------|:-------|
| Accept Cleaned Chunks | Receive chunked text and metadata from Intake Agent. |
| Model Selection | Choose embedding model based on file type (text, code, etc.). |
| Embedding Generation | Produce dense vector representations from chunks. |
| Metadata Enrichment | Attach enforced metadata fields and embedding model version. |
| Batch Processing | Support batch embedding of multiple chunks for efficiency. |
| Storage | Save resulting embeddings and metadata into PostgreSQL + pgvector. |
| Operational Metrics | Track success/failure counters for monitoring. |

---

# 📋 Inputs

- Chunked text
- Metadata per chunk
- File type (to aid model selection)

---

# 📋 Outputs

- Vector embeddings (stored into vector database)
- Updated metadata with model versioning info

---

# 📋 Metadata Enrichment Rules

- Always enforce presence of:
  - `project_name`
  - `document_type`
  - `meeting_topic`
  - `date`
  - `uploader_name`
- Auto-attach:
  - `embedding_model_name`
  - `embedding_model_version`

---

# 📋 Model Selection Strategy

- Text documents ➔ Primary LLM embedding model (e.g., OpenAI, HuggingFace)
- Source code ➔ Specialized code embedding model
- Configurable via service settings (model_config.json)

---

# 📋 Error Handling

- If chunk cannot be embedded:
  - Log failure
  - Continue embedding other chunks (do not block batch)

- If metadata is incomplete:
  - Attempt to infer based on chunk context
  - Otherwise reject with error

---

# 📋 Storage

- Use PostgreSQL + pgvector extension
- Insert:
  - Embedding vector
  - Full metadata (JSONB field)
  - Timestamps for creation/update

---

# 📋 Batch Embedding Policy

- Embedding service should process chunks in configurable batch sizes (e.g., 32 chunks per batch).
- Retry embedding failures once before logging permanent failure.

---

# 📢 Important Reminders

- Metadata integrity is critical for downstream retrieval.
- Always attach embedding model info to every embedded chunk.
- Focus on reliability: better to fail fast and log issues than silently corrupt data.

---

# 📋 Future Enhancements (Post-MVP)

- Dynamic model switching based on chunk content characteristics.
- Embedding compression for faster storage and retrieval.
- Support for multiple embedding providers.

---

