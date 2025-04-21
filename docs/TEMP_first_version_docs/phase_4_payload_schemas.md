# phase_4_payload_schemas.md

# Phase 4: Payload Schemas for All Core Services

This document defines the **Request** and **Response** data schemas for each agent in the RAG Knowledge Engine.

✅ These schemas formalize the **data contracts** used between microservices.

✅ Each field specifies:
- Type
- Required/Optional status
- Description

✅ These schemas will evolve in future versions but are locked for v1.

---

# 📒 Professional Best Practices for Schemas

| Practice | Why Important |
|:---------|:--------------|
| Explicit fields and types | Prevents hidden errors at runtime |
| Required vs Optional clarity | Reliable integration between services |
| Consistent naming conventions | Clean, understandable APIs |
| JSON-friendly types (string, int, bool, list) | Easy cross-platform compatibility |
| Expandable for versioning (v1, v2, etc.) | Future-proof design |

---

# 📋 Step-by-Step Agent Payload Definitions

## 📦 Intake Agent Schemas

### ➡️ Request Schema (`POST /v1/ingest`)

| Field | Type | Required | Description |
|:------|:-----|:---------|:------------|
| `file_id` | string | ✅ | Unique ID assigned to the uploaded file |
| `file_name` | string | ✅ | Name of the file (e.g., `meeting_notes.pdf`) |
| `file_type` | string | ✅ | File type (`pdf`, `txt`, `csv`, `audio`, etc.) |
| `uploaded_by` | string | ✅ | Username of the person who uploaded the file |
| `upload_timestamp` | string (ISO 8601) | ✅ | Upload timestamp (e.g., `2024-04-20T14:30:00Z`) |
| `storage_location` | string | ✅ | Filepath where the file is stored (e.g., `/pending/intake/`) |

### ⬅️ Response Schema (Success)

| Field | Type | Description |
|:------|:-----|:------------|
| `status` | string | "success" |
| `message` | string | Human-readable confirmation message |
| `processing_id` | string | Unique ID assigned to track the intake processing |

### ⬅️ Response Schema (Error)

| Field | Type | Description |
|:------|:-----|:------------|
| `status` | string | "error" |
| `message` | string | Description of the validation or server error encountered |

---

## 📦 Embedding Service Schemas

### ➡️ Request Schema (`POST /v1/embed`)

| Field | Type | Required | Description |
|:------|:-----|:---------|:------------|
| `chunks` | list of objects | ✅ | List of text chunks to embed |

Each chunk object:

| Chunk Field | Type | Required | Description |
|:------------|:-----|:---------|:------------|
| `chunk_id` | string | ✅ | Unique ID for the chunk |
| `text` | string | ✅ | Text content to be embedded |
| `metadata` | object | ⬜ | Optional dictionary with metadata about the chunk |

### ⬅️ Response Schema (Success)

| Field | Type | Description |
|:------|:-----|:------------|
| `status` | string | "success" |
| `embeddings` | list of objects | List of embeddings for each chunk |

Each embedding object:

| Embedding Field | Type | Description |
|:----------------|:-----|:------------|
| `chunk_id` | string | ID of the chunk that was embedded |
| `vector` | list of floats | The generated embedding vector |

### ⬅️ Response Schema (Error)

| Field | Type | Description |
|:------|:-----|:------------|
| `status` | string | "error" |
| `message` | string | Description of the validation or server error encountered |

---

## 📦 Retriever Service Schemas

### ➡️ Request Schema (`POST /v1/retrieve`)

| Field | Type | Required | Description |
|:------|:-----|:---------|:------------|
| `query` | string | ✅ | Search query text |
| `top_k` | integer | ⬜ (default = 5) | Number of top matches to retrieve |
| `filters` | object | ⬜ | Optional metadata filters to narrow retrieval |

Each optional `filters` object may have:

| Filter Field | Type | Description |
|:-------------|:-----|:------------|
| `project_name` | string | Optional project name filter |
| `document_type` | string | Optional document type filter |
| `file_id` | string | Optional file ID filter |

### ⬅️ Response Schema (Success)

| Field | Type | Description |
|:------|:-----|:------------|
| `status` | string | "success" |
| `matches` | list of objects | Top matching chunks based on semantic similarity |

Each match object:

| Match Field | Type | Description |
|:------------|:-----|:------------|
| `chunk_id` | string | ID of the matching chunk |
| `text` | string | Text content of the matched chunk |
| `metadata` | object | Metadata associated with the chunk |
| `score` | float | Similarity score (higher = better match) |

### ⬅️ Response Schema (Error)

| Field | Type | Description |
|:------|:-----|:------------|
| `status` | string | "error" |
| `message` | string | Description of the error encountered |

---

## 📦 Author Agent Schemas

### ➡️ Request Schema (`POST /v1/draft`)

| Field | Type | Required | Description |
|:------|:-----|:---------|:------------|
| `document_metadata` | object | ✅ | Metadata about the document to be drafted |
| `chunks` | list of objects | ✅ | List of text chunks retrieved for drafting |

Each field inside `document_metadata`:

| Metadata Field | Type | Required | Description |
|:---------------|:-----|:---------|:------------|
| `title` | string | ✅ | Title of the document |
| `project_name` | string | ✅ | Name of the project |
| `document_type` | string | ✅ | Type of document (e.g., SRS, Design Spec) |

Each chunk object:

| Chunk Field | Type | Required | Description |
|:------------|:-----|:---------|:------------|
| `chunk_id` | string | ✅ | Unique ID for the chunk |
| `text` | string | ✅ | Text content of the chunk |
| `metadata` | object | ⬜ | Optional metadata associated with the chunk |

### ⬅️ Response Schema (Success)

| Field | Type | Description |
|:------|:-----|:------------|
| `status` | string | "success" |
| `draft_document` | string | Full drafted document text (following a template) |

### ⬅️ Response Schema (Error)

| Field | Type | Description |
|:------|:-----|:------------|
| `status` | string | "error" |
| `message` | string | Description of validation or server error encountered |

---

## 📦 Evaluator Agent Schemas

### ➡️ Request Schema (`POST /v1/evaluate`)

| Field | Type | Required | Description |
|:------|:-----|:---------|:------------|
| `document_metadata` | object | ✅ | Metadata about the document being evaluated |
| `draft_document` | string | ✅ | Full draft text that needs evaluation |

Each field inside `document_metadata`:

| Metadata Field | Type | Required | Description |
|:---------------|:-----|:---------|:------------|
| `title` | string | ✅ | Title of the document |
| `project_name` | string | ✅ | Name of the project |
| `document_type` | string | ✅ | Type of document (e.g., SRS, Design Spec) |

### ⬅️ Response Schema (Success)

| Field | Type | Description |
|:------|:-----|:------------|
| `status` | string | "success" |
| `evaluation_report` | object | Structured report of the evaluation |

Each field inside `evaluation_report`:

| Report Field | Type | Description |
|:-------------|:-----|:------------|
| `structure_valid` | boolean | Whether required sections were found |
| `missing_sections` | list of strings | List of missing section names (if any) |
| `quality_issues` | list of objects | List of issues found in content quality |
| `overall_quality_score` | integer | Document quality score (0–100) |

Each object inside `quality_issues`:

| Issue Field | Type | Description |
|:------------|:-----|:------------|
| `section` | string | Name of the section where issue was found |
| `severity` | string | One of `critical`, `warning`, or `info` |
| `issue` | string | Description of the quality issue |

### ⬅️ Response Schema (Error)

| Field | Type | Description |
|:------|:-----|:------------|
| `status` | string | "error" |
| `message` | string | Description of the validation or server error encountered |

---

## 📦 Enhancer Agent Schemas

### ➡️ Request Schema (`POST /v1/enhance`)

| Field | Type | Required | Description |
|:------|:-----|:---------|:------------|
| `document_metadata` | object | ✅ | Metadata about the document being enhanced |
| `draft_document` | string | ✅ | Full draft text to enhance |
| `evaluation_report` | object | ✅ | Structured report describing what needs to be fixed |

Each field inside `document_metadata`:

| Metadata Field | Type | Required | Description |
|:---------------|:-----|:---------|:------------|
| `title` | string | ✅ | Title of the document |
| `project_name` | string | ✅ | Name of the project |
| `document_type` | string | ✅ | Type of document (e.g., SRS, Design Spec) |

### ⬅️ Response Schema (Success)

| Field | Type | Description |
|:------|:-----|:------------|
| `status` | string | "success" |
| `enhanced_document` | string | Updated document text after enhancements |
| `enhancements_applied` | list of objects | List of enhancements made |

Each object inside `enhancements_applied`:

| Enhancement Field | Type | Description |
|:------------------|:-----|:------------|
| `section` | string | Name of the section enhanced |
| `action` | string | Brief description of what was fixed/added |
| `severity` | string | Severity that triggered the enhancement (critical, warning, info) |

### ⬅️ Response Schema (Error)

| Field | Type | Description |
|:------|:-----|:------------|
| `status` | string | "error" |
| `message` | string | Description of the validation or server error encountered |

---

# 📆 Phase Status

✅ Document structure initialized
✅ Intake Agent schemas completed
✅ Embedding Service schemas completed
✅ Retriever Service schemas completed
✅ Author Agent schemas completed
✅ Evaluator Agent schemas completed
✅ Enhancer Agent schemas completed

✅ Phase 4.3 (Define Input/Output Payloads) fully complete.

---

