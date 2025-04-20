# phase_5_docker_setup.md

# Phase 5: Docker Compose Setup for RAG Knowledge Engine

This document defines the **official process** to build and manage the local Docker Compose environment for the RAG Knowledge Engine.

✅ Docker Compose will orchestrate all required services consistently:
- FastAPI microservices
- PostgreSQL + pgvector
- (Future) Local N8N orchestrator (optional)

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
| embedding_service | Handles text-to-vector embedding |
| retriever_service | Handles semantic retrieval from vector DB |
| author_agent | Drafts initial documents |
| evaluator_agent | Evaluates document structure/quality |
| enhancer_agent | Enhances documents based on evaluation |
| human_review_layer | (Optional) Human sign-off layer |
| postgres | PostgreSQL database with pgvector extension |

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

# 📆 Phase Status

✅ Docker Compose documentation initialized
⬜ Service-by-service Dockerfile creation in progress
⬜ Full docker-compose.yml building in progress

---

# 🚀 Next Actions

- Create consistent Dockerfiles per service
- Define volumes, ports, networking cleanly
- Build minimal `docker-compose.yml`
- Test service bootstrapping end-to-end locally

---

