# intake_agent.md

# Component Deep Dive - Intake Agent

## Component Name
Intake Agent

## Primary Responsibility
Ingest source files of various types, extract and normalize content, extract metadata, chunk text intelligently, and prepare cleaned inputs for embedding.

## Inputs
- Uploaded files (audio, plain text, Word documents, PDFs, images, Excel/CSV files, source code files)

## Outputs
- Cleaned and normalized text chunks
- Metadata-enriched chunk objects ready for embedding

## Subcomponents/Modules
- **File Type Detector**: Identifies the type of incoming file (e.g., .docx, .csv, .mp3, .py).
- **Metadata Extractor**: Pulls metadata from the file (embedded metadata or inferred from text if missing).
- **Content Cleaner**: Performs light cleaning without altering important details.
- **Chunker**: Splits content into logical chunks based on file type (sentences, paragraphs, headers, tables, etc.).
- **Pending Processing Handler**: Moves files to a pending location during ingestion to maintain atomic processing.

## Supported File Types and Specific Flows
- **Audio**: Transcribe to text; extract meeting details if possible.
- **Plain Text / Word**: Directly read; extract and structure content; preserve bullet points.
- **Excel/CSV**: Summarize tables; treat table descriptions as chunks.
- **PDFs**: Extract text; attempt to detect headings, bullet lists.
- **Images**: OCR text extraction; tag diagrams separately.
- **Source Code** (.py, .sql, .js, .yaml, .json, .xml, .html, .jsx, .cs): Parse code structure-aware; treat functions, classes, and config blocks as chunks.

## Detailed Intake Flows for File Types

### Audio Files
1. Move file to pending processing location.
2. Transcribe audio using external transcription service.
3. Extract meeting metadata if available (e.g., meeting title, participants).
4. Chunk transcript by speaker turn or time block.
5. Clean lightly, preserving names and timestamps.
6. Attach metadata and pass to Embedding Service.

### Plain Text and Word Documents
1. Move file to pending processing location.
2. Extract text content.
3. Attempt to detect and use document headings for chunking.
4. Preserve bullet points and numbered lists.
5. Extract embedded metadata if present; otherwise infer.
6. Clean text lightly (normalize spacing, remove irrelevant formatting).
7. Attach metadata and pass to Embedding Service.

### Excel/CSV Files
1. Move file to pending processing location.
2. Read sheets or tables.
3. Summarize table contents if appropriate.
4. Chunk based on table logical blocks (e.g., one table = one chunk).
5. Extract metadata (worksheet titles, dataset descriptions if provided).
6. Attach metadata and pass to Embedding Service.

### PDFs
1. Move file to pending processing location.
2. Extract text using PDF parsing library.
3. Detect sections based on font size, bold headings.
4. Preserve lists and sublists.
5. Extract embedded document metadata if available.
6. Attach metadata and pass to Embedding Service.

### Images
1. Move file to pending processing location.
2. OCR image to extract any visible text.
3. Tag extracted text separately (e.g., "Diagram Description").
4. Extract file metadata if available.
5. Attach metadata and pass to Embedding Service.

### Source Code Files
1. Move file to pending processing location.
2. Read code file preserving formatting.
3. Chunk code by logical unit (functions, classes, configs).
4. Identify file language/type from extension.
5. Extract or infer metadata (e.g., main purpose, project linkage).
6. Attach metadata and pass to Embedding Service.

## Dependencies
- External transcription/OCR services for audio and images
- Text extraction libraries for PDFs, Word files
- Chunking logic libraries (or custom modules based on file type)

## Special Behavior
- **Max File Size Enforcement**: 250MB max file size limit.
- **Metadata Fallback**: Infer missing metadata from file content.
- **Metadata Fields Enforced**:
  - Document Title
  - Author/User Uploading
  - Project Name
  - Document Type
  - Language
- **Tagging**: Assign content type tags (e.g., meeting_transcript, table_summary, source_code_function).
- **Move-and-Process Model**: Move to pending folder before processing, then delete original after success.

## Future Enhancements
- Automatic language detection
- Content summarization for huge documents before full chunking
- Smart file pre-validation (e.g., encoding checks)
- Duplicate file detection based on hashes

