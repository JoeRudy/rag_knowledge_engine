# phase_2_dockerfiles.md

# Phase 2: Dockerfiles for Each Service - Detailed Steps

This document captures all detailed instructions for creating and configuring Dockerfiles for each microservice in the RAG Knowledge Engine.

---

# 🔢 Step 2.1: Create Dockerfile for Intake Agent

### Purpose:
- Define how to build the container for the `intake_agent` service.
- Set up a minimal, production-ready Python environment.

### Actions:
- Navigate to: `rag_knowledge_engine/agents/intake_agent/`
- Create a `Dockerfile` with service port 8001.

✅ Step 2.1 Completed

---

# 🔢 Step 2.2: Create Dockerfile for Embedding Service

### Purpose:
- Define how to build the container for the `embedding_service`.

### Actions:
- Navigate to: `rag_knowledge_engine/agents/embedding_service/`
- Create a `Dockerfile` with service port 8002.

✅ Step 2.2 Completed

---

# 🔢 Step 2.3: Create Dockerfile for Retriever Service

### Purpose:
- Define how to build the container for the `retriever_service`.

### Actions:
- Navigate to: `rag_knowledge_engine/agents/retriever_service/`
- Create a `Dockerfile` with service port 8003.

✅ Step 2.3 Completed

---

# 🔢 Step 2.4: Create Dockerfile for Author Agent

### Purpose:
- Define how to build the container for the `author_agent`.

### Actions:
- Navigate to: `rag_knowledge_engine/agents/author_agent/`
- Create a `Dockerfile` with service port 8004.

✅ Step 2.4 Completed

---

# 👉 Professional Best Practices Being Followed

| Practice | Why Important |
|:---------|:--------------|
| Use official Python slim images | Reduces image size and attack surface |
| Set environment variables (`PYTHONDONTWRITEBYTECODE`, `PYTHONUNBUFFERED`) | Better performance and logging clarity |
| Install only necessary system packages | Keep containers small and fast |
| Clean up apt cache (`rm -rf /var/lib/apt/lists/*`) | Minimizes image size |
| Use `uvicorn` to run FastAPI | Optimized, production-grade ASGI server |

---

# 🔍 Key Dockerfile Sections Explained

| Section | Meaning |
|:--------|:--------|
| `FROM python:3.11-slim` | Start from a minimal Python image |
| `WORKDIR /app` | Set working directory inside container |
| `COPY . .` | Copy all local code into container's working dir |
| `RUN apt-get update && install gcc libpq-dev` | Install compiler and Postgres client libraries |
| `RUN pip install -r requirements.txt` | Install Python packages |
| `EXPOSE` | Document container expects to serve on a given port |
| `CMD` | Launch FastAPI server with Uvicorn |

---

# 📆 Phase Status

✅ Step 2.1 Completed
✅ Step 2.2 Completed
✅ Step 2.3 Completed
✅ Step 2.4 Completed
☑ Step 2.5 Next (Evaluator Service Dockerfile)

---

