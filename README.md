# RAG Knowledge Engine

🚀 The RAG Knowledge Engine is a fully local, Dockerized Retrieval-Augmented Generation (RAG) system designed to automate the creation of technical documentation for data and software engineering teams.

Built for serious projects that demand:
- Local ownership of data
- Structured document generation
- Metadata-driven retrieval and search
- Human-in-the-loop review and approval

---

# 📚 Features

- 🔄 Multi-format file intake (audio, PDF, Word, Excel, images, source code)
- 🧐 Local vector storage with PostgreSQL + pgvector
- 🔎 Hybrid semantic + metadata search
- ✍️ AI-driven document drafting and enhancement
- ✅ Document validation and quality enforcement
- 🧑‍💻 Human review layer (Approve / Request Enhancement / Reject)
- 🐳 Fully containerized with Docker Compose
- ☁️ Outbound-only calls to external LLM APIs (e.g., OpenAI)

---

# 🛠️ Technology Stack

| Layer | Technology |
|:------|:-----------|
| Orchestration | n8n (Dockerized) |
| Microservices | Python 3.11 + FastAPI |
| Vector Database | Supabase (Postgres + pgvector extension) |
| Text Extraction | PyMuPDF, python-docx, pandas, pytesseract, SpeechRecognition |
| Embedding Models | OpenAI embeddings or compatible models |
| Deployment | Docker + Docker Compose |

---

# ⚡ Quick Start

## Requirements
- Docker
- Docker Compose

## Setup Instructions

1. Clone the repository:

```bash
git clone https://github.com/YOUR_USERNAME/rag_knowledge_engine.git
cd rag_knowledge_engine
```

2. Create your `.env` file:

```bash
cp .env.example .env
# Fill in required environment variables
```

3. Build and run all services:

```bash
docker compose up --build
```

4. Access the system:

- n8n Orchestration: [http://localhost:5678](http://localhost:5678)
- Intake Agent: [http://localhost:8001](http://localhost:8001)
- Other microservices on respective ports (8002-8006)
- Supabase (Postgres) available on port 5432 for vector storage
