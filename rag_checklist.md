# rag_checklist.md

# 🔢 RAG Knowledge Engine - Master Build Checklist

This document tracks the detailed build tasks, following the strategic priority order, and will be continuously updated as tasks are completed or new tasks are added.

---

# 🔍 Phase 1: Docker Compose Setup

| Task | Status |
|:-----|:-------|
| 1.1 Create base `docker-compose.yml` for full system | ✅ Completed |
| 1.2 Define service blocks for all microservices | ☑ To Do |
| 1.3 Define service block for Supabase Postgres + pgvector | ☑ To Do |
| 1.4 Define service block for n8n | ☑ To Do |
| 1.5 Define networks and volumes cleanly | ☑ To Do |

---

# 📦 Phase 2: Dockerfiles for Each Service

| Task | Status |
|:-----|:-------|
| 2.1 Create `Dockerfile` for Intake Agent | ☑ To Do |
| 2.2 Create `Dockerfile` for Embedding Service | ☑ To Do |
| 2.3 Create `Dockerfile` for Retriever Service | ☑ To Do |
| 2.4 Create `Dockerfile` for Author Agent | ☑ To Do |
| 2.5 Create `Dockerfile` for Evaluator Agent | ☑ To Do |
| 2.6 Create `Dockerfile` for Enhancer Agent | ☑ To Do |

---

# 🖋️ Phase 3: FastAPI Skeletons

| Task | Status |
|:-----|:-------|
| 3.1 Create minimal `app.py` for Intake Agent | ☑ To Do |
| 3.2 Create minimal `app.py` for Embedding Service | ☑ To Do |
| 3.3 Create minimal `app.py` for Retriever Service | ☑ To Do |
| 3.4 Create minimal `app.py` for Author Agent | ☑ To Do |
| 3.5 Create minimal `app.py` for Evaluator Agent | ☑ To Do |
| 3.6 Create minimal `app.py` for Enhancer Agent | ☑ To Do |

---

# 🔒 Phase 4: Environment Variable Setup

| Task | Status |
|:-----|:-------|
| 4.1 Create `.env.example` with needed keys | ☑ To Do |
| 4.2 Create local `.env` file for development | ☑ To Do |

---

# 📁 Phase 5: Supabase Local Database Setup

| Task | Status |
|:-----|:-------|
| 5.1 Configure Supabase Postgres with pgvector locally | ☑ To Do |
| 5.2 Define initial database schema for metadata storage | ☑ To Do |

---

# 📢 Phase 6: Basic n8n Workflow Initialization

| Task | Status |
|:-----|:-------|
| 6.1 Create initial intake workflow in n8n | ☑ To Do |
| 6.2 Create initial retrieval workflow in n8n | ☑ To Do |

---

# Status Key
- ✅ Completed
- ☑ To Do
- ⚠️ Blocked

---

# Notes
- As new tasks arise, they will be added to the checklist dynamically.
- Completed tasks will be updated in this document.
- Each phase builds on the previous phase's successful completion.

---

# Master Status
✅ System Design Complete  
✅ Documentation Complete  
☑ Build Phase Initiated (Current Step: Phase 1)

---

