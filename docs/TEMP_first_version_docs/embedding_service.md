# embedding_service.md

# Component Deep Dive - Embedding Service

## Component Name
Embedding Service

## Primary Responsibility
Convert cleaned, chunked, and metadata-tagged text/code blocks into dense vector embeddings that can be efficiently stored and semantically retrieved from the vector database.

## Inputs
- Cleaned and chunked text or code content
- Attached metadata (document title, document type, project name, etc.)

## Outputs
- Dense vector embeddings associated with enriched text and full metadata
- Ready-to-store entries for the vector database (e.g., Pinecone)
- Operational counters for monitoring (successes, retries, failures)

## Subcomponents/Modules
- **Chunk Receiver**: Receives and validates incoming chunked content
- **Embedding Model Selector**: Looks up the correct model from a configuration file based on file type (e.g., text vs code)
- **Chunk Enricher**: Prepends lightweight metadata hints (e.g., Document Type, Project Name) into the chunk text before embedding
- **Embedding Model Interface**: Connects to the correct embedding model
- **Embedding Batcher**: Groups multiple chunks together into a single API call to improve efficiency
- **Embedding Retry Handler**: Retries transient failures up to 3 times with a short delay
- **Embedding Formatter**: Packages embeddings and metadata into the format required by the vector database
- **Monitoring Counters**: Tracks successes, retries, and failures

## Dependencies
- LLM-based Embedding APIs (e.g., OpenAI, Hugging Face, Azure OpenAI Service)
- Vector Database (Pinecone)
- Metadata Manager (for consistent metadata tagging from Intake Manager)
- Configuration file for model selection mapping

## Special Behavior
- **Smart Model Selection**: Selects embedding model dynamically based on file type from config file
- **Chunk Enrichment**: Prepends metadata hints to the text before embedding
- **Batch Embedding**: Embeds chunks in batches (configurable batch size)
- **Retry Logic**: Retries transient errors up to 3 times; logs and skips permanent errors
- **Model Version Tracking**: Includes `model_version` field in stored metadata
- **Monitoring**: Tracks success, retry, and failure counters during operation

## Future Enhancements
- Support multiple embedding models dynamically by content type
- Add average latency tracking per embedding batch
- Integrate local embedding models to reduce dependency on external APIs
- Advanced backoff strategies for retries (exponential backoff)
- Enrich embedding input further using prompt engineering techniques
- Upgrade to larger context windows (8k/32k tokens) when model support increases
