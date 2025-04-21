# intake_agent.md

# 📚 Intake Agent Detailed Specification

The Intake Agent is responsible for detecting new file uploads, validating and extracting metadata, chunking files appropriately based on their type, and preparing content for embedding.

It is the critical entry point for raw knowledge entering the RAG Knowledge Engine.

---

# 📋 Core Responsibilities

| Responsibility | Detail |
|:---------------|:-------|
| File Detection | Monitor storage for new file uploads. |
| Max File Size Enforcement | Reject files larger than the configured limit (e.g., 250MB). |
| File Type Identification | Determine if input is audio, text, PDF, spreadsheet, source code, or image. |
| Metadata Extraction | Parse embedded metadata if available; otherwise infer from content. |
| Intelligent Chunking | Chunk content based on type (sentence, paragraph, headings, table rows, etc.). |
| Light Cleaning | Normalize text: fix encoding, clean artifacts, basic format repairs. |
| Prepare for Embedding | Forward processed chunks + metadata to Embedding Service.

---

# 📋 Inputs

- New uploaded files
- Optional user-supplied metadata at upload time

---

# 📋 Outputs

- List of cleaned text chunks
- Metadata per chunk
- Passed to Embedding Service for vectorization

---

# 📋 Supported File Types

| File Type | Handling |
|:----------|:---------|
| Audio (e.g., .mp3, .wav) | Transcribe via Speech-to-Text, chunk by speaker/topic. |
| Text (.txt) | Chunk by paragraph/sentences. |
| Word Documents (.docx) | Chunk based on headings, paragraphs, and preserve bullets. |
| PDFs | OCR if needed, chunk like Word documents. |
| Excel/CSV (.xlsx/.csv) | Chunk each significant row or block as a unit. |
| Source Code (.py, .sql, .json, .xml, .yaml, .jsx, .html, etc.) | Parse function/class blocks or logical sections. |
| Images (architecture diagrams) | OCR if text-heavy; otherwise store metadata reference. |

---

# 📋 Metadata Fields

- `project_name`
- `document_type`
- `meeting_topic` (or `document_topic` if not meeting-related)
- `date`
- `uploader_name`
- (Auto-attached later by embedding service: `embedding_model_name`, `embedding_model_version`)

---

# 📋 Chunking Strategy

- Text: Paragraphs (prefer short logical blocks)
- Word/PDF: Headings ➔ Sections ➔ Paragraphs
- Spreadsheets: Logical row/column blocks
- Source Code: By function, class, or logical unit

---

# 📋 Error Handling

- Reject file if size exceeds max limit.
- Log and quarantine file if format is unsupported.
- If metadata missing, attempt inference; if critical fields cannot be inferred, reject upload.

---

# 📢 Important Reminders

- Early metadata enforcement improves retrieval downstream.
- Chunk size matters: prefer semantically complete but not oversized chunks.
- Light cleaning must not destroy original meaning.

---

# 📋 Future Enhancements (Post-MVP)

- Support file drag-and-drop intake UI (n8n integration).
- Advanced chunk sizing algorithms based on LLM token limits.
- Multi-language intake (e.g., English, Spanish).

---

