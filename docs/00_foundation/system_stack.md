# system_stack.md

# 📚 System Stack Overview

This document defines the complete technology stack selected for building, running, and managing the RAG Knowledge Engine.

It ensures all contributors and future maintainers understand the foundational system architecture.

---

# 📋 Core Technology Stack

| Layer | Stack |
|:------|:------|
| API Framework | FastAPI (Python 3.11) |
| Programming Language | Python 3.11 |
| Containerization | Docker + Docker Compose |
| Database | PostgreSQL with pgvector extension (self-hosted via Supabase container) |
| Vector Storage | pgvector extension in PostgreSQL |
| Workflow Orchestration | n8n (self-hosted container) |
| Document Storage | Supabase (Postgres backend) |
| Embedding Models | Configurable: Huggingface sentence transformers preferred (local) |
| Version Control | Git + GitHub (private repo) |

---

# 📋 Design Principles Behind Technology Choices

| Principle | How It's Satisfied |
|:----------|:------------------|
| Full Local Deployment | No mandatory cloud services; everything runs on a single VM. |
| Modular Microservices | Every major agent is isolated into its own service. |
| Reproducibility | Docker Compose allows full environment recreation on any machine. |
| Scalability Ready | FastAPI + Postgres architecture supports future scaling without major rewrites. |
| Open Source Priority | All major components are open-source and extensible. |
| Minimal External Dependency | No dependence on proprietary APIs at runtime (local models preferred). |

---

# 📋 Core Services Breakdown

| Service | Port | Description |
|:--------|:-----|:------------|
| intake_agent | 8001 | Handles file intake, metadata extraction, and chunking. |
| embedding_service | 8002 | Converts chunks into embeddings and stores in pgvector. |
| retriever_service | 8003 | Performs semantic search queries on stored vectors. |
| author_agent | 8004 | Drafts initial documents based on retrieved data. |
| evaluator_agent | 8005 | Validates document structure and quality. |
| enhancer_agent | 8006 | Auto-enhances and fixes drafts before human review. |
| supabase_db (Postgres + pgvector) | 5432 | Central database for embeddings and metadata. |
| n8n | 5678 | Orchestrates workflows between all services. |

---

# 📋 Local Environment Requirements

| Requirement | Minimum Version |
|:------------|:----------------|
| Docker Engine | 24.x or later |
| Docker Compose | 2.x or later |
| Python | 3.11.x |
| Git | Latest stable |

---

# 📋 Important Deployment Notes

- Supabase/Postgres container must start **before** any agent services.
- All FastAPI services expose internal APIs at `/v1/` versioned endpoints.
- Service containers communicate over a shared `rag_network` Docker bridge network.
- Embedding service must support dynamic model selection (based on file type).
- Vector searches are powered by cosine similarity via pgvector.

---

# 📋 Future Enhancements

- Add Prometheus + Grafana for monitoring agent metrics.
- Add Traefik or nginx as reverse proxy for external exposure (optional).
- Add live model switching capability for Embedding Service.

---

# 📢 Reminder

This stack provides a **highly modular**, **completely local**, and **future-scalable** foundation for evolving the RAG Knowledge Engine into a full documentation intelligence platform.

---

