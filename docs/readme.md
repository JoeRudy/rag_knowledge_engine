# README.md

# RAG Knowledge Engine (Fully Local, Dockerized)

## Overview

The RAG Knowledge Engine automates the generation of high-quality technical documentation (e.g., Software Requirements Specifications, Design Documents) using a Retrieval-Augmented Generation (RAG) architecture combined with specialized AI agents and a human-in-the-loop review layer.

✅ The entire system is orchestrated locally via **Docker Compose**.  
✅ All services run on an **Azure VM** (or any Linux server) without external SaaS dependencies except for outbound API calls to models like OpenAI if needed.

---

# 📈 System Features

- Multi-format intake (audio recordings, PDFs, Word documents, Excel/CSV files, images, source code)
- Text extraction, metadata enrichment, intelligent chunking
- Semantic vector embedding and fast similarity retrieval
- Local storage of vectors and metadata via **Supabase (Postgres+pgvector)**
- AI-driven drafting of structured documents
- Automated document validation (structure and quality enforcement)
- AI-based enhancement and re-drafting of issues
- Human-in-the-loop review with approval, request enhancement, or rejection workflows
- Modular Dockerized microservices architecture
- Easily scalable or deployable to other environments

---

# 🛠 Full Local Stack (Dockerized)

| Component | Purpose |
|:----------|:--------|
| n8n (localhost:5678) | Orchestrates workflow execution across all services |
| Intake Agent (localhost:8001) | Ingests files and chunks content |
| Embedding Service (localhost:8002) | Embeds chunks into vector representations |
| Retriever Service (localhost:8003) | Retrieves relevant chunks via vector search |
| Author Agent (localhost:8004) | Drafts structured documents |
| Evaluator Agent (localhost:8005) | Validates structure and quality of drafts |
| Enhancer Agent (localhost:8006) | Enhances and fixes flagged issues |
| Supabase (localhost:5432) | Hosts structured metadata and vectors using Postgres+pgvector |

✅ All services are containerized and run locally on the VM.  
✅ No public exposure required unless you want it.

---

# Updated Workflow Summary

1. User uploads a file ➔ n8n detects upload
2. Intake Agent processes the file (chunks and metadata extraction)
3. Embedding Service embeds the text chunks into vector space
4. Retriever Service performs semantic search based on prompts
5. Author Agent generates the initial document
6. Evaluator Agent checks for quality, structure, missing sections
7. Enhancer Agent auto-corrects issues if possible
8. Human Review Layer approves, requests enhancement, or rejects
9. Final approved document is stored/delivered

---

# Technologies Used

| Layer | Technology |
|:------|:-----------|
| Orchestration | n8n |
| Language | Python 3.11+ |
| Vector Database | Supabase (Postgres + pgvector) |
| Text Extraction | PyMuPDF, python-docx, pandas, pytesseract, SpeechRecognition |
| Embedding Models | OpenAI (text-embedding-ada-002) or other LLMs |
| File Storage | Local filesystem inside VM |

---

# 🚀 Local Development Instructions

## 1. Requirements

- Docker installed
- Docker Compose installed

## 2. Setup

- Clone the repository.
- Create a `.env` file from `.env.example` and fill in necessary keys.
- Run:

```bash
docker compose up --build
```

- Access n8n at: [http://localhost:5678](http://localhost:5678)

✅ All microservices will automatically register on their respective ports.

---

# Status
✅ Local Docker Compose system defined  
✅ Supabase Postgres+pgvector configured for vector and metadata storage  
✅ Microservice architecture ready for development

---

