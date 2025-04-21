# payload_schemas.md

# 📚 Payload Schemas

This document defines the internal API request and response payload schemas for all major agents and services within the RAG Knowledge Engine.

All payloads must adhere to these structures for consistency, validation, and reliability.

---

# 📋 General API Standards

- All APIs use **FastAPI** framework.
- All requests and responses are **JSON**.
- Input validation is strict (FastAPI Pydantic schemas).
- Error handling must return:
  - `error_code`
  - `error_message`

---

# 📋 Intake Agent

## `/v1/intake`

### Request
```json
{
  "file_path": "string",
  "file_type": "audio | text | pdf | word | excel | csv | source_code | image",
  "metadata": {
    "project_name": "string",
    "document_type": "string",
    "meeting_topic": "string",
    "date": "YYYY-MM-DD",
    "uploader_name": "string"
  }
}
```

### Response
```json
{
  "status": "success",
  "chunks_created": int
}
```

---

# 📋 Embedding Service

## `/v1/embed`

### Request
```json
{
  "chunks": [
    {
      "chunk_text": "string",
      "metadata": {
        "project_name": "string",
        "document_type": "string",
        "meeting_topic": "string",
        "date": "YYYY-MM-DD",
        "uploader_name": "string"
      }
    }
  ]
}
```

### Response
```json
{
  "status": "success",
  "chunks_embedded": int
}
```

---

# 📋 Retriever Service

## `/v1/retrieve`

### Request
```json
{
  "query": "string",
  "top_k": int,
  "similarity_threshold": float,
  "metadata_filters": {
    "project_name": "optional string",
    "document_type": "optional string"
  }
}
```

### Response
```json
{
  "results": [
    {
      "chunk_text": "string",
      "metadata": { }
    }
  ]
}
```

---

# 📋 Author Agent

## `/v1/draft`

### Request
```json
{
  "retrieved_chunks": [
    {
      "chunk_text": "string",
      "metadata": { }
    }
  ],
  "document_type": "string"
}
```

### Response
```json
{
  "draft_document": "full drafted document text",
  "document_version": "UUID string"
}
```

---

# 📋 Evaluator Agent

## `/v1/evaluate`

### Request
```json
{
  "draft_document": "string",
  "document_version": "UUID string",
  "document_type": "string"
}
```

### Response
```json
{
  "evaluation_report": {
    "overall_status": "pass | fail",
    "issues": [
      {
        "section": "string",
        "issue_description": "string",
        "severity": "Critical | Warning | Info"
      }
    ]
  }
}
```

---

# 📋 Enhancer Agent

## `/v1/enhance`

### Request
```json
{
  "draft_document": "string",
  "evaluation_report": { }
}
```

### Response
```json
{
  "enhanced_document": "string",
  "enhanced_sections": [
    "section_name_1",
    "section_name_2"
  ]
}
```

---

# 📢 Important Reminders

- All fields must be validated at ingestion.
- Strict typing: dates must use ISO format (YYYY-MM-DD).
- Empty results must be handled gracefully.
- Optional fields must still be declared (e.g., empty objects if no metadata filter applied).

---

# 📋 Future Enhancements

- Add pagination for large retrieval responses.
- Support multi-document batching (draft/evaluate/enhance multiple docs at once).

---

