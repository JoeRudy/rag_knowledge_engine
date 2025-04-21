# phase_5_docker_setup.md

# 📚 Phase 5: Docker Setup and Deployment

This document describes how the RAG Knowledge Engine is deployed locally using Docker and Docker Compose.

The goal is to allow fully local, isolated, and reproducible setups across machines.

---

# 📋 Core Services in Docker

| Service | Purpose |
|:--------|:--------|
| intake_agent | Detect file uploads, extract metadata, chunk content. |
| embedding_service | Embed text chunks into semantic vectors. |
| retriever_service | Perform semantic retrievals from vector database. |
| author_agent | Draft structured technical documents. |
| evaluator_agent | Validate structure and content of drafts. |
| enhancer_agent | Auto-enhance and fix flagged issues. |
| supabase_db (Postgres + pgvector) | Store vector embeddings and metadata. |
| n8n | Manage and orchestrate service workflows. |

---

# 📋 Key Docker Concepts Applied

- Each agent/service runs as its own container.
- Internal service ports are standardized to 8000.
- External ports are mapped uniquely to avoid conflicts (8001-8006).
- All containers join the `rag_network` bridge network.
- Supabase/Postgres uses port 5432.

---

# 📋 Docker Compose Overview

- **Single `docker-compose.yml`** file defines the full multi-container system.
- **Services auto-build** from their respective local Dockerfiles.
- **Restart policies** ensure containers restart unless manually stopped.
- **Shared network** (`rag_network`) allows internal communication without exposing everything externally.

---

# 📋 Basic Local Deployment Commands

```bash
# Build and start all containers
$ docker-compose up --build

# Start already built containers
$ docker-compose up

# Stop containers
$ docker-compose down

# View running containers
$ docker ps

# Tail logs for a specific service
$ docker logs -f intake_agent
```

---

# 📋 Ports Allocation

| Service | External Port |
|:--------|:--------------|
| intake_agent | 8001 |
| embedding_service | 8002 |
| retriever_service | 8003 |
| author_agent | 8004 |
| evaluator_agent | 8005 |
| enhancer_agent | 8006 |
| supabase_db (Postgres) | 5432 |
| n8n | 5678 |

---

# 📋 Environment Variables

| Variable | Usage |
|:---------|:------|
| POSTGRES_USER | Supabase/Postgres admin username |
| POSTGRES_PASSWORD | Supabase/Postgres admin password |
| POSTGRES_DB | Default database name |
| GENERIC_TIMEZONE | Timezone for n8n orchestrator |

---

# 📋 Folder Structure for Services

```plaintext
/agents/
├── intake_agent/
│   ├── Dockerfile
│   └── app/
├── embedding_service/
├── retriever_service/
├── author_agent/
├── evaluator_agent/
├── enhancer_agent/
```

Each service folder contains its own codebase and Dockerfile.

---

# 📢 Important Reminders

- Always clean old containers before major rebuilds (`docker-compose down && docker system prune`).
- Keep container names and network names consistent.
- Update ports carefully to avoid conflicts if expanding system.
- Supabase/Postgres must always start **before** agents try to connect.

---

# 📋 Future Enhancements (Post-MVP)

- Split services into multiple docker-compose.yml files (for dev vs prod setups).
- Add monitoring container (e.g., Prometheus + Grafana).
- Add service health checks (FastAPI `/healthz` endpoints).

---

