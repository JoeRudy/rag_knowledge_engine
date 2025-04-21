# docker_compose.md

# 📚 Docker Compose Setup

This document provides a full breakdown of the `docker-compose.yml` file used to orchestrate the RAG Knowledge Engine system locally.

It covers each service, network configuration, environment setup, and important design choices.

---

# 📋 Docker Compose Basics

- **Compose Version**: `3.8`
- **Network**: All containers share a custom bridge network called `rag_network`.
- **Restart Policy**: All services use `restart: unless-stopped` for resilience.
- **Build Contexts**: Each service builds from its local `/agents/` subfolder.
- **Service Isolation**: Each microservice runs independently inside its own container.

---

# 📋 Services Defined

| Service | Purpose | Build Context | Exposed Port |
|:--------|:--------|:--------------|:-------------|
| intake_agent | File intake, chunking, metadata extraction | `./agents/intake_agent` | 8001 |
| embedding_service | Text embedding into pgvector | `./agents/embedding_service` | 8002 |
| retriever_service | Semantic search retrieval from pgvector | `./agents/retriever_service` | 8003 |
| author_agent | Draft structured technical documents | `./agents/author_agent` | 8004 |
| evaluator_agent | Validate document structure and quality | `./agents/evaluator_agent` | 8005 |
| enhancer_agent | Auto-enhance documents based on evaluations | `./agents/enhancer_agent` | 8006 |
| supabase_db | PostgreSQL with pgvector extension | Supabase official Postgres image | 5432 |
| n8n | Workflow orchestration and scheduling | n8n Docker image | 5678 |

---

# 📋 Example docker-compose.yml Structure

```yaml
version: '3.8'

services:
  intake_agent:
    build:
      context: ./agents/intake_agent
      dockerfile: Dockerfile
    container_name: intake_agent
    ports:
      - "8001:8001"
    networks:
      - rag_network
    restart: unless-stopped

  embedding_service:
    build:
      context: ./agents/embedding_service
      dockerfile: Dockerfile
    container_name: embedding_service
    ports:
      - "8002:8002"
    networks:
      - rag_network
    restart: unless-stopped

  retriever_service:
    build:
      context: ./agents/retriever_service
      dockerfile: Dockerfile
    container_name: retriever_service
    ports:
      - "8003:8003"
    networks:
      - rag_network
    restart: unless-stopped

  author_agent:
    build:
      context: ./agents/author_agent
      dockerfile: Dockerfile
    container_name: author_agent
    ports:
      - "8004:8004"
    networks:
      - rag_network
    restart: unless-stopped

  evaluator_agent:
    build:
      context: ./agents/evaluator_agent
      dockerfile: Dockerfile
    container_name: evaluator_agent
    ports:
      - "8005:8005"
    networks:
      - rag_network
    restart: unless-stopped

  enhancer_agent:
    build:
      context: ./agents/enhancer_agent
      dockerfile: Dockerfile
    container_name: enhancer_agent
    ports:
      - "8006:8006"
    networks:
      - rag_network
    restart: unless-stopped

  supabase_db:
    image: supabase/postgres
    container_name: supabase_db
    ports:
      - "5432:5432"
    networks:
      - rag_network
    restart: unless-stopped
    environment:
      POSTGRES_PASSWORD: your_password
      POSTGRES_USER: supabase_admin
      POSTGRES_DB: supabase_db

  n8n:
    image: n8nio/n8n
    container_name: n8n
    ports:
      - "5678:5678"
    networks:
      - rag_network
    restart: unless-stopped
    environment:
      - GENERIC_TIMEZONE=America/New_York

networks:
  rag_network:
    driver: bridge
```

---

# 📋 Environment Variables Overview

| Variable | Description |
|:---------|:------------|
| POSTGRES_PASSWORD | Password for Postgres admin user (change for production). |
| POSTGRES_USER | Username for Postgres (admin level). |
| POSTGRES_DB | Default database name created on startup. |
| GENERIC_TIMEZONE | Timezone setting for n8n scheduler. |

---

# 📋 Key Architectural Notes

- **Postgres container must be healthy** before agents start making DB calls.
- **Ports are unique and explicitly mapped** to prevent container conflicts.
- **All services auto-restart** unless manually stopped (good for local resiliency).
- **Bridge network (`rag_network`) ensures secure internal communication** between services.

---

# 📋 Future Enhancements

- Add service healthchecks using FastAPI `/healthz` endpoints.
- Add `depends_on` in Compose (to enforce startup ordering if needed).
- Expand with optional monitoring stack (e.g., Prometheus, Grafana).

---

