# system_setup_detailed_steps.md

# 📚 System Setup Detailed Steps

This document provides a **detailed walkthrough** of how the RAG Knowledge Engine system is designed, structured, and built step-by-step. It tracks critical design decisions, implementation phases, and environment setup requirements.

---

# 📋 Phase 1: Problem Statement and System Purpose

- Define clear problem statement.
- Focus: Build a RAG system to automate software documentation for data engineers.
- Primary Inputs: Meeting recordings, text documents, PDFs, Excel files, source code.
- Primary Outputs: Structured technical documents (SRS, Architecture Design, etc.).

---

# 📋 Phase 2: High-Level Components

- Intake Agent
- Embedding Service
- Retriever Service
- Author Agent
- Evaluator Agent
- Enhancer Agent
- Human Review Layer
- PostgreSQL + pgvector Vector Database
- n8n Orchestration Layer

---

# 📋 Phase 3: Deep Component Design

- Define detailed responsibilities for each agent.
- Define internal API endpoints for each service.
- Define input/output payload schemas.
- Introduce metadata enforcement in Intake and Embedding stages.

---

# 📋 Phase 4: API and Payload Schemas

- Design consistent internal API request/response payloads.
- Documented best practices for API design, error handling, and versioning.
- Enforced mandatory metadata fields:
  - project_name
  - document_type
  - meeting_topic
  - date
  - uploader_name

---

# 📋 Phase 5: Docker-Based Local Deployment

- Built individual Dockerfiles per microservice.
- Unified services under docker-compose.yml.
- Mapped ports cleanly:
  - All internal container ports = 8000
  - External mapped ports (8000-8005).
- Supabase/Postgres runs inside docker-compose.
- Local-only operation confirmed (no dependency on cloud services).

---

# 📋 Tech Stack

- Python 3.11
- FastAPI
- Docker + Docker Compose
- PostgreSQL 14 with pgvector
- Supabase self-hosted (Postgres)
- n8n (workflow orchestrator)

---

# 📋 Folder Structure

```plaintext
/docs/
├── 00_foundation/
│   ├── system_setup_detailed_steps.md
│   ├── component_ownership.md
│   ├── system_architecture_diagram.md
│   ├── rag_checklist.md
├── 01_problem_definition/
├── 02_agents_specs/
├── 03_api_design/
├── 04_deployment/
```

✅ Modular
✅ Scalable
✅ Clean project organization

---

# 📋 Key Design Principles

| Principle | Reason |
|:----------|:-------|
| Minimal container variation | Simplify scaling and service maintenance |
| Consistent metadata tagging | Better retrieval, reindexing, and versioning |
| Centralized vector database | Single source of semantic truth |
| Microservice-first architecture | Easy to replace or scale agents individually |
| Human-in-the-loop review supported | Critical for production-quality outputs |

---

# 📋 Known Next Steps

- Add Monitoring Layer (future phase)
- Add full document versioning and rollback (future phase)
- Add multi-user access control (future phase)

---

# 📢 Important Reminders

- Always use underscore_case for filenames.
- No files renamed from approved versions.
- Every Markdown file tracked in `/docs/` cleanly and precisely.

---

