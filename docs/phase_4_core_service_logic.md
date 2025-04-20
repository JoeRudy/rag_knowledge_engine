# phase_4_core_service_logic.md

# Phase 4: Core Service Logic and Internal API Contracts

This document captures the detailed planning, design, and structure for building the real internal service logic for each agent in the RAG Knowledge Engine.

---

# 🔢 Overview

Each microservice will expand beyond a simple `/health` endpoint and will:
- Perform its core business logic
- Expose clean, minimal, professional FastAPI endpoints
- Operate independently yet modularly within the larger RAG system

---

# 💡 Core Responsibilities by Agent

| Agent | Core Responsibilities |
|:------|:----------------------|
| Intake Agent | Ingest uploaded files, extract text, detect metadata, send chunks for embedding |
| Embedding Service | Embed received text chunks into vector representations, insert into vector database |
| Retriever Service | Perform semantic search on vector DB and return top matching chunks |
| Author Agent | Generate initial draft documents based on retrieved knowledge chunks |
| Evaluator Agent | Review drafts, validate structure and content quality, flag issues |
| Enhancer Agent | Automatically fix issues and re-embed enhanced sections |

✅ Each service will operate independently with clear API inputs/outputs.

---

# 📚 Internal API Routes (Detailed)

(Previous agent APIs defined above)

---

## Evaluator Agent API: `/v1/evaluate`

| Attribute | Details |
|:----------|:--------|
| **Route** | `/v1/evaluate` |
| **Method** | `POST` |
| **Description** | Accepts a drafted document and validates both structure and content quality, returning an evaluation report |
| **Expected Request Body** | JSON containing the drafted document text and document metadata |
| **Expected Response** | An evaluation report detailing structure completeness, missing sections, quality notes, and severity flags |
| **Error Handling** | Return 400 if bad input, 500 for internal errors |
| **Authorization** | Not needed (internal service only) |

### Example Request JSON

```json
{
  "document_metadata": {
    "title": "Embedding Service Design Specification",
    "project_name": "RAG Knowledge Engine",
    "document_type": "SRS"
  },
  "draft_document": "### Embedding Service Design Specification\n\n**Overview:**\nThe Embedding Service converts text data into dense vector embeddings for semantic similarity comparison.\n\n**Importance:**\nEmbedding is the foundation of the retrieval process in the RAG architecture."
}
```

### Example Success Response

```json
{
  "status": "success",
  "evaluation_report": {
    "structure_valid": true,
    "missing_sections": [],
    "quality_issues": [
      {
        "section": "Overview",
        "severity": "info",
        "issue": "Section is concise but could include more details about input/output formats."
      }
    ],
    "overall_quality_score": 85
  }
}
```

### Example Error Response

```json
{
  "status": "error",
  "message": "Draft document text must not be empty."
}
```

✅ Document metadata and draft document are mandatory

✅ Returns evaluation report with structure validation, issues, and score

✅ Severity levels provided (critical, warning, info)

✅ Supports automatic and human review cycles

---

## Enhancer Agent API: `/v1/enhance`

| Attribute | Details |
|:----------|:--------|
| **Route** | `/v1/enhance` |
| **Method** | `POST` |
| **Description** | Accepts a document along with an evaluation report and attempts to automatically enhance/fix the issues found |
| **Expected Request Body** | JSON containing the draft document text, evaluation report, and document metadata |
| **Expected Response** | Enhanced document text along with a list of enhancements applied |
| **Error Handling** | Return 400 if bad input, 500 for internal errors |
| **Authorization** | Not needed (internal service only) |

### Example Request JSON

```json
{
  "document_metadata": {
    "title": "Embedding Service Design Specification",
    "project_name": "RAG Knowledge Engine",
    "document_type": "SRS"
  },
  "draft_document": "### Embedding Service Design Specification\n\n**Overview:**\nThe Embedding Service converts text data into dense vector embeddings for semantic similarity comparison.\n\n**Importance:**\nEmbedding is the foundation of the retrieval process in the RAG architecture.",
  "evaluation_report": {
    "structure_valid": true,
    "missing_sections": [],
    "quality_issues": [
      {
        "section": "Overview",
        "severity": "info",
        "issue": "Section is concise but could include more details about input/output formats."
      }
    ],
    "overall_quality_score": 85
  }
}
```

### Example Success Response

```json
{
  "status": "success",
  "enhanced_document": "### Embedding Service Design Specification\n\n**Overview:**\nThe Embedding Service converts text data into dense vector embeddings for semantic similarity comparison. It accepts plain text inputs and outputs 1536-dimensional vectors.\n\n**Importance:**\nEmbedding is the foundation of the retrieval process in the RAG architecture.",
  "enhancements_applied": [
    {
      "section": "Overview",
      "action": "Expanded description by adding input/output details",
      "severity": "info"
    }
  ]
}
```

### Example Error Response

```json
{
  "status": "error",
  "message": "Draft document and evaluation report must both be provided."
}
```

✅ Full traceability of enhancements

✅ Respects original document integrity

✅ Severity-based fixing prioritization

✅ Enhancements clearly listed for human audit

---

# 📈 Professional Best Practices Being Followed

| Practice | Why Important |
|:---------|:--------------|
| API versioning (`/v1/ingest`, `/v1/embed`, `/v1/retrieve`, `/v1/draft`, `/v1/evaluate`, `/v1/enhance`) | Future-proof evolution |
| Typed payloads (Pydantic models) | Validation, documentation, auto-completion support |
| Clear success and error responses | Reliable system integrations |
| Separation of concerns | Clean microservice boundaries |
| Minimal but expandable APIs | Agile, adaptable system growth |

---

# 📋 Phase 4 Task Checklist

| Step | Action | Status |
|:-----|:-------|:-------|
| 4.1 | Define Core Responsibilities | ✅ Completed |
| 4.2 | Define Internal API Routes for Each Agent | ✅ Completed |
| 4.3 | Define Input/Output Payloads (Schemas) | ⬜ To Do |
| 4.4 | Document Best Practices for API Design | ⬜ To Do |

✅ Each microservice now has real, working internal APIs tied to its business logic.

---

# 📆 Phase Status

✅ Step 4.1 Completed
✅ Step 4.2 Completed: (All six agents' APIs defined)

---

