# system_architecture_diagram.md

# 📚 System Architecture Diagram

This document provides a high-level visual and textual description of how the RAG Knowledge Engine system components interact with each other.

A Mermaid.js diagram is included for clean visualization.

---

# 📋 Mermaid Diagram

```mermaid
flowchart TD

subgraph Ingestion_and_Storage
    A[File Uploads] --> B[Intake Agent]
    B --> C[Embedding Service]
    C --> D[Vector Database (PostgreSQL + pgvector)]
end

subgraph Retrieval_and_Drafting
    E[User Query or Document Trigger] --> F[Retriever Service]
    F --> D
    F --> G[Author Agent]
end

subgraph Validation_and_Enhancement
    G --> H[Evaluator Agent]
    H --> I{Issues Detected?}
    I -- No Issues --> J[Ready for Human Review Layer]
    I -- Yes Issues --> K[Enhancer Agent]
    K --> H
    H --> J
end

subgraph Human_Review_and_Finalization
    J --> L{Human Reviewer Decision}
    L -- Approve --> M[Final Document Storage or Delivery]
    L -- Request Enhancement --> K
    L -- Reject --> G
end
```

---

# 📋 Textual Flow Explanation

1. **File Uploads** (audio, PDFs, documents, code, etc.) are monitored by the **Intake Agent**.
2. **Intake Agent** extracts metadata, chunks text, and forwards chunks to the **Embedding Service**.
3. **Embedding Service** generates vector embeddings and stores them in the **Vector Database (PostgreSQL + pgvector)**.
4. When drafting a document, a **User Query** or **Document Trigger** is sent to the **Retriever Service**.
5. **Retriever Service** searches for semantically relevant chunks from the **Vector Database**.
6. Retrieved chunks are passed to the **Author Agent** to draft a structured document.
7. Drafted documents pass through the **Evaluator Agent**.
    - If no issues are found, the document proceeds to **Human Review Layer**.
    - If issues are found, the **Enhancer Agent** attempts automatic fixes.
8. In **Human Review Layer**, users can:
    - Approve the document (move to Final Storage)
    - Request additional enhancement
    - Reject the document (send back to Author Agent)

---

# 📋 Key Principles

| Principle | Implementation |
|:----------|:---------------|
| Modular microservices | Each agent/service is independent |
| Vectorized retrieval | Semantic search based on embeddings |
| Metadata-first design | Enhances document traceability and relevance |
| Human-in-the-loop review | Ensures critical quality control |

---

# 📢 Notes

- Internal container ports are 8000 for all services.
- External access ports are unique (8000-8005).
- PostgreSQL runs locally on port 5432.
- n8n orchestrates agent workflows (planned post-MVP).

---

