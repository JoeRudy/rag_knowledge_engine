# retriever_service.md

# 📚 Retriever Service Detailed Specification

The Retriever Service is responsible for executing semantic search queries against the vector database, retrieving the most relevant chunks based on similarity, and returning results along with full metadata.

It plays a critical role in grounding document generation in real, factual context.

---

# 📋 Core Responsibilities

| Responsibility | Detail |
|:---------------|:-------|
| Accept Queries | Accept text queries (document creation triggers or user prompts). |
| Vector Similarity Search | Perform top-k nearest neighbor search against the vector database. |
| Apply Relevance Threshold | Only return results above a configurable similarity threshold. |
| Return Full Metadata | Always return chunk text + all associated metadata. |
| Support Metadata Filtering | Optionally allow queries to filter by metadata fields (e.g., project_name, document_type). |

---

# 📋 Inputs

- Semantic text query
- Optional metadata filters
- Configured top-k value (e.g., top 5 results)
- Configured minimum relevance threshold

---

# 📋 Outputs

- List of retrieved chunks (text + metadata)
- Ranked by similarity score (highest first)

---

# 📋 Key Behaviors

- **Strict Thresholding**: If no chunk meets the minimum relevance, return no results.
- **Batch Retrievals**: Allow multiple queries to be processed in batch mode (future enhancement).
- **Ranking**: Always return results ordered by highest similarity.
- **Metadata Exposure**: Metadata must travel with chunk text to downstream agents.

---

# 📋 Search Configuration Parameters

- `top_k`: Number of results to retrieve (default: 5)
- `similarity_threshold`: Minimum score required to consider a match (e.g., 0.75)
- `metadata_filter`: Optional filters like `project_name = 'ABC Project'`

---

# 📋 Error Handling

- If database connection fails:
  - Return 500 error with descriptive message.
- If no results meet threshold:
  - Return empty list (not an error).

---

# 📋 Storage Dependency

- PostgreSQL database with pgvector extension enabled.
- Table contains:
  - vector column
  - metadata JSONB column

---

# 📢 Important Reminders

- Retrieval quality is critical for accurate document drafting.
- Never "force" matches: strict threshold enforcement preserves document integrity.
- Metadata filtering allows targeted retrieval (e.g., "only from meetings tagged 'architecture'").

---

# 📋 Future Enhancements (Post-MVP)

- Multi-stage retrieval: rough match followed by re-ranking.
- Context window optimization for long query responses.
- Multi-metadata field boosting.

---

