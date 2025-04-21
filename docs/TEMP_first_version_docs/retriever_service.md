# retriever_service.md

# Component Deep Dive - Retriever Service

## Component Name
Retriever Service

## Primary Responsibility
Perform semantic vector search over embedded content in the vector database (Pinecone) to retrieve the most relevant chunks based on a query.

## Inputs
- User query (text to search against the vector database)
- Optional metadata filters (e.g., document type, project name)

## Outputs
- Retrieved chunks (text + full metadata)
- Logs of no-result events if no chunks meet the relevance threshold

## Subcomponents/Modules
- **Query Embedder**: Embeds the user query using the appropriate embedding model
- **Vector Search Engine**: Executes semantic search against Pinecone
- **Result Filter**: Applies minimum relevance threshold filtering
- **Metadata Enricher**: Ensures all retrieved chunks include full metadata
- **Optional Filter/Booster**: Applies metadata-based filtering or boosting if requested
- **Monitoring Logger**: Records no-result events for observability

## Dependencies
- Embedding Service (for query embedding)
- Pinecone Vector Database
- Metadata attached to each chunk
- Configuration file (for top K and relevance threshold settings)

## Special Behavior
- **Semantic Vector Search Only**: No hybrid search (no keyword + vector mix) in MVP
- **Configurable Top K**: Number of chunks retrieved is adjustable (default 5 or 10)
- **Minimum Relevance Threshold**: Chunks below a configured similarity score are discarded
- **Return Full Metadata**: Each retrieved chunk includes all original metadata fields
- **Metadata-Based Filtering/Boosting**: Optionally prioritize chunks based on metadata criteria
- **No Result if Threshold Not Met**: If no results meet threshold, return nothing and log event

## Future Enhancements
- Add hybrid search support (vector + keyword)
- Add weighted boosting across multiple metadata fields
- Enable dynamic relevance threshold adjustments per query type
- Advanced retrieval ranking models (re-ranker integration)
- Better error handling and user feedback if no relevant results are found

