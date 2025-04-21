# detailed_component_design.md

# 📚 Detailed Component Design

This document provides a detailed breakdown of each major agent and service's responsibilities within the RAG Knowledge Engine. It expands upon the high-level components by defining expected behaviors, flows, and key technical expectations.

---

# 📋 Detailed Responsibilities by Component

## Intake Agent
- Monitor storage location for new uploaded files.
- Enforce max file size (e.g., 250MB limit).
- Identify file type (audio, PDF, text, Excel, source code, image).
- Extract embedded metadata if present.
- Infer missing metadata if needed.
- Chunk content intelligently based on type (e.g., by paragraphs for text, by heading for docs).
- Light cleaning of text (remove noise, fix formatting).
- Insert raw chunks into the Embedding Service.

## Embedding Service
- Accept cleaned text chunks with metadata.
- Select appropriate embedding model based on file type.
- Generate vector embeddings.
- Attach model version and enrich metadata.
- Batch embedding requests for efficiency.
- Track operational counters (successes/failures).
- Store resulting vectors + metadata into PostgreSQL with pgvector.

## Retriever Service
- Accept semantic search queries (or document creation triggers).
- Retrieve top-k similar vectors.
- Apply minimum relevance threshold filtering.
- Optionally apply metadata-based filters.
- Return both chunk text and metadata for use by Author Agent.

## Author Agent
- Receive retrieved chunks.
- Draft a document based on a defined template structure.
- Rephrase, restructure, and summarize content as needed.
- Insert placeholders if a required section lacks sufficient data.
- Cite metadata references where possible.

## Evaluator Agent
- Validate full document structure.
- Validate basic content quality (e.g., no empty sections, no placeholder leakage).
- Flag issues with severity levels (Critical, Warning, Info).
- Produce structured evaluation report.

## Enhancer Agent
- Attempt to fix flagged issues.
- Prioritize Critical issues.
- Auto-enhance Warning/Info level issues if possible.
- Mark enhanced sections for traceability.
- Re-embed enhanced sections into vector database if applicable.

## Human Review Layer
- Allow users to Approve, Request Enhancement, or Reject a document.
- Allow optional review even when no critical issues are found.
- Critical issues always require human sign-off.

## Vector Database (PostgreSQL + pgvector)
- Store chunk embeddings.
- Store metadata fields.
- Allow vector similarity search.
- Maintain versioned records (for tracking enhanced vs. original versions).

## n8n Orchestration Layer
- Chain together:
  - Intake ➔ Embedding ➔ Storage
  - Retrieval ➔ Author ➔ Evaluate ➔ (Enhance if needed) ➔ Human Review
- Handle document state transitions.
- Track success/failure of service-to-service flows.

---

# 📋 Internal API Standards

- Every service must expose clean FastAPI endpoints.
- All input/output must be JSON.
- Payloads must match defined schemas.
- Errors must be standardized.

---

# 📢 Important Reminders

- No service should tightly couple itself to another.
- Vector Database is the system's "truth layer."
- Metadata enforcement happens early (at intake) and persists through every stage.
- Human Review is a first-class citizen, not an afterthought.

---

