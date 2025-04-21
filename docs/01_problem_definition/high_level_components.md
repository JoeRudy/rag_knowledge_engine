# high_level_components.md

# 📚 High-Level Components Overview

This document describes the major system components of the RAG Knowledge Engine at a high level. It defines each core module's role in the system without diving into detailed implementation.

This serves as a system "map" to ensure consistent design thinking across all phases.

---

# 📋 Major Components

| Component | Purpose |
|:----------|:--------|
| Intake Agent | Handles intake of diverse file types, metadata extraction, chunking, and pre-storage preparation. |
| Embedding Service | Converts text chunks into vector embeddings with enforced metadata tagging. |
| Retriever Service | Executes semantic search queries against the vector database and retrieves top-k relevant chunks. |
| Author Agent | Drafts structured technical documents based on retrieved information using templates. |
| Evaluator Agent | Validates document completeness, structure, and quality based on pre-defined rules. |
| Enhancer Agent | Attempts to automatically enhance and fix issues found during evaluation. |
| Human Review Layer | Allows optional human oversight to approve, request enhancements, or reject generated documents. |
| Vector Database (PostgreSQL + pgvector) | Stores vector embeddings, metadata, and tracks enhanced vs. original versions. |
| n8n Orchestration Layer | Manages the end-to-end workflow of document generation, evaluation, enhancement, and approval. |

---

# 📋 Component Interaction Overview

1. **File uploads** trigger the **Intake Agent**.
2. **Intake Agent** prepares and stores chunks via the **Embedding Service** into the **Vector Database**.
3. **Retriever Service** searches for relevant information based on document drafting triggers.
4. **Author Agent** drafts an initial structured document.
5. **Evaluator Agent** reviews the draft for issues.
6. If issues exist, the **Enhancer Agent** attempts fixes.
7. Final drafts pass through the **Human Review Layer**.
8. Upon approval, documents are stored and versioned.

---

# 📋 Key System Attributes

| Attribute | Implementation |
|:----------|:----------------|
| Modularity | Each service is independently replaceable and scalable. |
| Metadata-first Design | Metadata enforced at intake ensures smarter retrieval and evaluation. |
| Human-in-the-Loop Optionality | Supports both fully automated and semi-automated modes. |
| Local-first Deployment | Everything can run locally for privacy, security, and control. |
| Embedding Flexibility | Embedding model choice based on file type and configurability. |

---

# 📢 Important Reminders

- Maintain separation of concerns between components.
- No agent directly calls another agent: all communication happens through API or orchestrator.
- Every major service must expose a clean, minimal internal API.

---

