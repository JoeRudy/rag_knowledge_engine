# phase_1_docker_compose.md

# Phase 1: Docker Compose Setup - Detailed Steps

This document captures all detailed instructions for building and configuring the Docker Compose orchestration layer for the RAG Knowledge Engine.

---

# 🔢 Step 1.1: Create Base `docker-compose.yml`

### Purpose:
- Create a master file to orchestrate all services together.
- Define each microservice, database, and orchestrator.

### Key Concepts:
- **Docker Compose** allows starting all services with a single command.
- **Services** represent containers (agents, n8n, Supabase DB).
- **Networks** allow containers to communicate internally.

### Actions:
1. In the project root folder (`rag_knowledge_engine/`), create a file called `docker-compose.yml`.
2. Paste the starter structure:

```yaml
version: '3.8'

services:
  intake_agent:
    build: ./agents/intake_agent
    ports:
      - "8001:8001"
    networks:
      - rag_network

  embedding_service:
    build: ./agents/embedding_service
    ports:
      - "8002:8002"
    networks:
      - rag_network

  retriever_service:
    build: ./agents/retriever_service
    ports:
      - "8003:8003"
    networks:
      - rag_network

  author_agent:
    build: ./agents/author_agent
    ports:
      - "8004:8004"
    networks:
      - rag_network

  evaluator_agent:
    build: ./agents/evaluator_agent
    ports:
      - "8005:8005"
    networks:
      - rag_network

  enhancer_agent:
    build: ./agents/enhancer_agent
    ports:
      - "8006:8006"
    networks:
      - rag_network

  n8n:
    image: n8nio/n8n
    ports:
      - "5678:5678"
    networks:
      - rag_network
    environment:
      - GENERIC_TIMEZONE=America/New_York

  supabase_db:
    image: supabase/postgres
    ports:
      - "5432:5432"
    networks:
      - rag_network
    environment:
      POSTGRES_PASSWORD=your_password
      POSTGRES_USER=supabase_admin
      POSTGRES_DB=supabase_db

networks:
  rag_network:
    driver: bridge
```

3. Save the file.

✅ Step 1.1 Completed

---

# 🔢 Step 1.2: Define Final Service Blocks

### Purpose:
- Make sure every service block is clean and ready to build.
- Ensure future extensibility and reliability.

### Key Concepts:
- **build.context** points to the folder containing the `Dockerfile`.
- **container_name** gives an explicit container name.
- **restart: unless-stopped** means services restart automatically if server reboots.

### Finalized Service Block Example:

```yaml
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
```

✅ Every service now includes:
- Proper build path
- Explicit container name
- Restart policy
- Correct port mapping
- Connected to the dedicated network

✅ Full corrected service blocks now exist for:
- intake_agent
- embedding_service
- retriever_service
- author_agent
- evaluator_agent
- enhancer_agent
- n8n
- supabase_db

✅ Step 1.2 Completed

---

# 👉 Best Practices Followed in Phase 1

| Practice | Why Important |
|:---------|:--------------|
| Use `restart: unless-stopped` | Ensures reliability after reboot |
| Explicit container names | Easier management and debugging |
| Dedicated network `rag_network` | Clean internal container communication |
| Proper port mapping | Makes services available on localhost for dev |
| Separate build contexts | Clear separation of service codebases |

---

# 🔍 Key Docker Terms Explained

| Term | Meaning |
|:-----|:--------|
| Service | One container (microservice) defined in docker-compose.yml |
| Build Context | The directory where Docker looks for Dockerfile and app files |
| Port Mapping | Exposing container ports to host machine ports (e.g., 8001:8001) |
| Network | Virtual internal bridge where containers talk to each other |
| Environment Variables | Key/values passed inside container at runtime |

---

# ⚡ Quick Commands Cheat Sheet

| Command | Purpose |
|:--------|:--------|
| `docker compose up --build` | Build images and start all containers |
| `docker compose down` | Stop and remove all containers and networks |
| `docker ps` | List running containers |
| `docker logs <container_name>` | View logs for a specific container |
| `docker exec -it <container_name> /bin/bash` | Open shell inside running container |

---

# 📆 Phase Status

✅ Step 1.1 Completed
✅ Step 1.2 Completed

---

