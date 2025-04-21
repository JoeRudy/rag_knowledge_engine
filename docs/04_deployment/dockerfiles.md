# dockerfiles.md

# 📚 Dockerfiles Structure and Standards

This document defines the structure, best practices, and conventions used for all service Dockerfiles in the RAG Knowledge Engine.

Consistency across service containers ensures easier maintenance, smaller image sizes, and faster deployments.

---

# 📋 Dockerfile Common Base

All service Dockerfiles are based on:

```Dockerfile
FROM python:3.11-slim
```

| Reason | Benefit |
|:-------|:--------|
| Smaller base image | Faster builds, smaller container size |
| Official Python image | Security patches, reliability |
| Slim variant | Stripped down, minimal OS footprint |

---

# 📋 Common Layers Across All Services

| Step | Purpose |
|:-----|:--------|
| `WORKDIR /app` | Standard working directory inside container. |
| `COPY . .` | Copy all service code into container. |
| Install system packages | `gcc`, `libpq-dev` installed for database and deep learning support. |
| Clean cache | `rm -rf /var/lib/apt/lists/*` reduces final image size. |
| Upgrade pip | Ensure latest pip during build. |
| Install Python dependencies | `pip install -r requirements.txt` ensures isolated, reproducible builds. |
| Expose service port | Unique to each service, matches docker-compose.yml. |
| CMD to run FastAPI app | Use Uvicorn to launch app server. |

---

# 📋 Example Standard Service Dockerfile

```Dockerfile
# Start from official Python slim image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Copy service code
COPY . .

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Expose correct service port
EXPOSE 8002  # (example: embedding_service)

# Command to run FastAPI server
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8002"]
```

---

# 📋 Unique Exposed Ports per Service

| Service | Exposed Port |
|:--------|:-------------|
| intake_agent | 8001 |
| embedding_service | 8002 |
| retriever_service | 8003 |
| author_agent | 8004 |
| evaluator_agent | 8005 |
| enhancer_agent | 8006 |

---

# 📋 Important Best Practices

- **No unnecessary layers**: Always clean apt cache after installing system packages.
- **One Dockerfile per service**: Never reuse Dockerfiles across different agents.
- **Keep CMD uniform**: All FastAPI apps launched with Uvicorn.
- **Environment consistency**: Always set `PYTHONDONTWRITEBYTECODE` and `PYTHONUNBUFFERED`.

---

# 📋 Future Enhancements

- Move to multi-stage builds (separate build/runtime stages) to shrink production image size further.
- Add linter and type checker installation (e.g., `black`, `mypy`) for optional development builds.
- Add healthcheck instructions inside Dockerfile (or define in Compose).

---

# 📢 Reminder

Maintaining consistent, minimal, and fast-building Dockerfiles across all agents is key to achieving scalable and maintainable microservices in production.

---

