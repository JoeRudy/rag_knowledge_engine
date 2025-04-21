# component_ownership.md

# Component Ownership Table

This document defines the ownership split between n8n and Python microservices for the RAG Documentation Generation System.

---

| Component | Ownership | Description | Trigger | Output |
|:----------|:-----------|:------------|:--------|:-------|
| **File Intake Watcher** | n8n | Watch storage for new files and trigger workflow | File uploaded (n8n trigger) | File path passed to Intake Agent |
| **Intake Agent** | Python | Extract text, metadata, and chunk into meaningful pieces | Triggered by n8n after file detection | Text chunks + extracted metadata |
| **Embedding Service** | Python | Generate embeddings for text chunks and store them in Pinecone | Triggered after Intake Agent success | Stored vectors in Pinecone |
| **Retriever Service** | Python | Search vectors based on query to retrieve relevant chunks | Triggered by document request | Retrieved chunks for drafting |
| **Author Agent** | Python | Draft the initial document from retrieved chunks | Triggered after Retriever Service | Drafted document content |
| **Evaluator Agent** | Python | Validate the document structure, completeness, and quality | Triggered after Author Agent finishes draft | Evaluation report listing issues or approval |
| **Enhancer Agent** | Python | Auto-fix flagged issues (Critical, Warning, Info) | Triggered if Evaluator detects issues | Enhanced document ready for review |
| **Human Review Layer** | n8n + Python | Present documents for human validation; approve, request enhancement, or reject | Triggered after Evaluator or Enhancer | Approved document or feedback for rework |
| **Final Document Storage** | n8n | Save the approved final document in designated storage | After human approval | Finalized, approved document |
| **Alerting & Notifications** | n8n | Send Slack/email alerts on review readiness, failures, approvals | On key workflow transitions or failures | Notifications to users/admins |
| **Audit Logging** | n8n | Record success/failure events for each agent call | On every agent execution outcome | Logs (optional: Postgres DB or JSON files) |

---

# Ownership Summary

| Stack Layer | Owner |
|:------------|:-----|
| Automation, Orchestration, Monitoring | n8n |
| AI/NLP Processing (text extraction, embeddings, document generation) | Python Microservices |
| Vector Storage | Pinecone |
| Raw File & Final Doc Storage | Local filesystem (expand to cloud later) |
| Configuration Management | `.env` files for Python, n8n credentials store |
| Secrets Management | `.env` for Python agents, n8n native secrets manager |

---

# Key Principles

- **n8n** controls the workflow logic, task triggering, retries, alerting, and orchestration.
- **Python Microservices** are responsible for actual content understanding, generation, validation, and fixing.
- **Pinecone** is solely for vector search.
- **Storage** initially local but designed for future cloud scaling.

---

# Status
✅ Component Ownership finalized.
✅ Ready to define folder structure and system scaffolding next.

