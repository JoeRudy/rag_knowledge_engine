# component_ownership.md

# 📚 Component Ownership Overview

This document defines the official ownership and responsibility assignments for each major agent and service within the RAG Knowledge Engine.

Every core service has a single clear owner role to ensure accountability, traceability, and clean system modularity.

---

# 📋 Ownership Table

| Component | Ownership Responsibility |
|:----------|:-------------------------|
| Intake Agent | File ingestion, metadata extraction, chunking, and initial vector storage |
| Embedding Service | Generating vector embeddings, enriching metadata, and storing to vector DB |
| Retriever Service | Semantic search and retrieval of relevant chunks based on queries |
| Author Agent | Drafting structured documents based on retrieved information and document templates |
| Evaluator Agent | Evaluating document quality, structure, and completeness based on predefined rules |
| Enhancer Agent | Automatically enhancing and improving documents based on Evaluator feedback |
| Human Review Layer | Managing optional human approval, feedback, and document finalization decisions |
| Supabase/Postgres DB | Storing all vector embeddings, metadata, and supporting information |
| n8n Orchestrator | Coordinating workflows across all agents and services |

---

# 📋 Ownership Key Responsibilities

## Intake Agent
- Monitor file drop zones.
- Extract or infer metadata.
- Chunk files intelligently.
- Store prepared chunks into the vector database.

## Embedding Service
- Batch embeddings creation.
- Select appropriate embedding model based on file type.
- Attach versioned model metadata.
- Update success/failure operational counters.

## Retriever Service
- Handle semantic queries.
- Retrieve top-k relevant chunks.
- Support metadata-based filtering.
- Apply relevance thresholds.

## Author Agent
- Structure documents based on templates.
- Fill all required sections.
- Source metadata references per section.

## Evaluator Agent
- Validate document structure.
- Validate basic content quality.
- Flag issues with severity levels.
- Generate structured evaluation reports.

## Enhancer Agent
- Attempt to fix flagged issues.
- Handle Critical, Warning, and Info levels.
- Auto-enhance documents where possible.
- Re-embed enhanced sections.

## Human Review Layer
- Support Approve / Request Enhancement / Reject actions.
- Allow manual editing if needed.
- Ensure Critical issues require human approval.

## Supabase/Postgres DB
- Store all chunk embeddings.
- Store metadata fields.
- Support semantic retrieval queries.

## n8n Orchestrator
- Sequence service calls.
- Manage document state transitions.
- Track workflow success/failure logs.

---

# 📢 Important Reminders

- Every service must be loosely coupled and replaceable.
- Ownership of each component is **exclusive** to prevent responsibility overlaps.
- Updates to ownership must be formally documented here.

---

