# system_architecture_diagram.md

# System Architecture Diagram - RAG Knowledge Engine (Fully Local, Dockerized)

```mermaid
flowchart TD

subgraph Ingestion and Storage
    A[File Uploads] --> B[Intake Agent]
    B --> C[Embedding Service]
    C --> D[Supabase (Postgres + pgvector)]
end

subgraph Retrieval and Drafting
    E[User Query or Document Trigger] --> F[Retriever Service]
    F --> D
    F --> G[Author Agent]
end

subgraph Validation and Enhancement
    G --> H[Evaluator Agent]
    H --> I{Issues Detected?}
    I -- No Issues --> J[Ready for Human Review Layer]
    I -- Yes Issues --> K[Enhancer Agent]
    K --> H
    H --> J
end

subgraph Human Review and Finalization
    J --> L{Human Reviewer Decision}
    L -- Approve --> M[Final Document Storage or Delivery]
    L -- Request Enhancement --> K
    L -- Reject --> G
end
```

# Diagram Description

- **Ingestion**: Files are uploaded and processed by the Intake Agent. Metadata and chunks are stored in Supabase.
- **Retrieval**: Retriever Service fetches relevant vectors and metadata.
- **Drafting**: Author Agent builds the document based on retrieved content.
- **Validation**: Evaluator Agent checks the quality and completeness.
- **Enhancement**: Enhancer Agent fixes any detected issues.
- **Human Review**: Final quality control and approval/rejection loop.

---

# Status
✅ Updated architecture diagram  
✅ Reflects fully Dockerized local system  
✅ Supabase (Postgres+pgvector) integrated  
✅ All components linked properly

---

