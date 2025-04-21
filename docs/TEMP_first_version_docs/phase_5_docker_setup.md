# phase_5_docker_setup.md

# Phase 5: Docker Compose Setup for RAG Knowledge Engine

This document defines the **official process** to build and manage the local Docker Compose environment for the RAG Knowledge Engine.

✅ Docker Compose orchestrates all required services consistently:
- FastAPI microservices
- PostgreSQL + pgvector

✅ Everything runs locally for testing, development, and eventual productionization.

---

# 📚 Overview

Running services independently is painful — Docker Compose solves that:
- Spawns entire microservice stack with one command
- Handles networking, volumes, restart policies
- Reproducible, easy deployments for local development or cloud

Every engineer can spin up or tear down the environment easily.

---

# 📋 Services to Be Deployed

| Service | Purpose |
|:--------|:--------|
| intake_agent | Handles file intake and preprocessing |
| embedding_service | Handles text-to-vector embedding |
| retriever_service | Handles semantic retrieval from vector DB |
| author_agent | Drafts initial documents |
| evaluator_agent | Evaluates document structure/quality |
| enhancer_agent | Enhances documents based on evaluation |
| supabase_db | PostgreSQL database with pgvector extension |

✅ Future: Add n8n orchestrator container

---

# 🏗️ Docker Compose Base Structure

| Component | Detail |
|:----------|:------|
| `docker-compose.yml` | Central orchestrator file |
| `Dockerfile` (per service) | Build definitions for each microservice |
| `.env` file | Store environment variables (e.g., DB creds) |
| Volumes | Persist PostgreSQL data locally |
| Networks | Internal network for service-to-service communication |

---

# 📦 Key Features of Compose Setup

| Feature | Benefit |
|:--------|:--------|
| Separate container per service | Isolation, modularity |
| Automatic PostgreSQL startup | No manual DB setup needed |
| Healthchecks | Auto-restart unhealthy containers |
| Scalable | Easily add more services later |

---

# 📋 Corrected Port Mapping

| Service | Host Port | Container Port |
|:--------|:----------|:----------------|
| intake_agent | 8000 | 8000 |
| embedding_service | 8001 | 8000 |
| retriever_service | 8002 | 8000 |
| author_agent | 8003 | 8000 |
| evaluator_agent | 8004 | 8000 |
| enhancer_agent | 8005 | 8000 |
| supabase_db | 5432 | 5432 |

✅ Internally all FastAPI apps run on port 8000
✅ Host-side ports differ per service

---

# 📆 Phase Status

✅ Docker Compose documentation initialized
✅ Service-by-service Dockerfile creation completed
✅ Full docker-compose.yml built
✅ Local system bootstrap testing ready

---

# 🚀 Next Actions

- Build and run containers locally
- Test agent-to-agent communication
- Validate PostgreSQL database accessibility

---
