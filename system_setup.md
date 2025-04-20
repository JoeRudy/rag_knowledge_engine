# system_setup.md

# System Setup Guide - RAG Knowledge Engine (Fully Local, Dockerized)

This guide covers the full setup of the project, including folder structure, Docker deployment, and environment configuration.

---

# 📂 Project Folder Structure

```plaintext
rag_knowledge_engine/
├── README.md
├── system_setup.md
├── docker-compose.yml         # Docker Compose file to orchestrate everything
├── .env.example                # Example environment variables
├── requirements.txt            # Python dependencies for agents
│
├── /n8n/
│   ├── /workflows/
│   │   ├── intake_workflow.json
│   │   ├── document_generation_workflow.json
│   │   ├── evaluation_workflow.json
│   │   └── enhancement_workflow.json
│   └── n8n_deployment_notes.md
│
├── /agents/
│   ├── /intake_agent/
│   ├── /embedding_service/
│   ├── /retriever_service/
│   ├── /author_agent/
│   ├── /evaluator_agent/
│   └── /enhancer_agent/
│
├── /shared/
│   ├── pinecone_client.py (to be deprecated, replaced by supabase_client.py)
│   ├── embedding_utils.py
│   ├── document_utils.py
│   └── logging_utils.py
│
└── /docs/
    ├── system_architecture_diagram.md
    ├── component_ownership.md
    ├── intake_agent.md
    ├── embedding_service.md
    ├── retriever_service.md
    ├── author_agent.md
    ├── evaluator_agent.md
    ├── enhancer_agent.md
    ├── human_review_layer.md
    └── README.md
```

---

# 🛠 Full Local System Stack (Dockerized)

| Service | Purpose |
|:--------|:--------|
| n8n | Orchestrates workflows between agents |
| Intake Agent | Handles file intake, metadata extraction, chunking |
| Embedding Service | Embeds chunks into vector form |
| Retriever Service | Retrieves semantically relevant chunks |
| Author Agent | Drafts structured documents |
| Evaluator Agent | Validates and quality checks documents |
| Enhancer Agent | Enhances or corrects documents |
| Supabase (Postgres + pgvector) | Stores vectors and rich metadata |

✅ All services are Dockerized and run locally on your Azure VM.

---

# 🐳 Dockerized Setup

## 1. Requirements

- Docker installed
- Docker Compose installed
- Basic familiarity with Docker commands (`docker compose up`, etc.)

## 2. Docker Compose

The `docker-compose.yml` defines:

- **n8n service** (official n8n image)
- **Python agents** (built from your `/agents/` folders)
- **Supabase** (Postgres with pgvector enabled)

## 3. .env Setup

Create a `.env` file from `.env.example` and provide:

```plaintext
POSTGRES_PASSWORD=your_postgres_password
POSTGRES_USER=supabase_admin
POSTGRES_DB=supabase_db
SUPABASE_URL=http://localhost:5432
OPENAI_API_KEY=your-openai-api-key
VECTOR_NAMESPACE=rag_knowledge_engine
```

✅ These variables will be passed to the containers securely.

---

# 🚀 Running the Full System Locally

```bash
docker compose up --build
```

- Builds all agents
- Spins up n8n
- Spins up Supabase/Postgres with pgvector extension
- Exposes services on localhost:

| Service | Port |
|:--------|:-----|
| n8n | 5678 |
| Intake Agent | 8001 |
| Embedding Service | 8002 |
| Retriever Service | 8003 |
| Author Agent | 8004 |
| Evaluator Agent | 8005 |
| Enhancer Agent | 8006 |
| Supabase (Postgres + pgvector) | 5432 |

---

# 📋 Required Python Libraries (requirements.txt)

```plaintext
openai
supabase
psycopg2-binary
python-dotenv
PyMuPDF
python-docx
pandas
SpeechRecognition
pytesseract
Pillow
loguru
requests
fastapi
uvicorn
```

✅ Updated to remove pinecone-client.  
✅ Added `supabase` and `psycopg2-binary` for database connection.

---

# ⚡ Quick Setup Recap

1. Clone the project repository.
2. Create `.env` file from `.env.example`.
3. Run `docker compose up --build`.
4. Access n8n at `http://localhost:5678`.
5. Microservices will be accessible on their respective localhost ports.
6. Supabase Postgres+pgvector runs locally on port 5432.

✅ Your entire RAG system is running locally, cleanly Dockerized, fully self-contained.

---

# 📋 First Steps Checklist

1. [ ] Create the folder structure exactly as shown.
2. [ ] Create a `.env` file by copying `.env.example` and filling your keys.
3. [ ] Prepare your `docker-compose.yml` and `Dockerfile` files (initial versions).
4. [ ] Build and run everything using `docker compose up --build`.
5. [ ] Access services via localhost.
6. [ ] Start building and connecting workflows inside n8n.

✅ After completing these steps, you will have a fully structured, locally-running project ready for feature development and integration!

---

# Status
✅ Local-only architecture updated  
✅ Docker setup documented  
✅ Supabase replacing Pinecone  
✅ Full self-hosted system

