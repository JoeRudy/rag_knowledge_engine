# author_agent.md

# 📚 Author Agent Detailed Specification

The Author Agent is responsible for drafting structured technical documents from retrieved chunks of embedded knowledge. It follows strict document templates and produces complete, verifiable first drafts.

---

# 📋 Core Responsibilities

| Responsibility | Detail |
|:---------------|:-------|
| Accept Retrieved Chunks | Receive a list of chunk text and metadata from the Retriever Service. |
| Follow Document Templates | Always structure drafts based on predefined templates (e.g., SRS, Architecture Document). |
| Summarization | Summarize large blocks of related retrieved content where appropriate. |
| Rephrasing and Restructuring | Improve clarity without losing original meaning. |
| Placeholder Management | Insert clear placeholders if a template section cannot be fully populated. |
| Source Metadata Referencing | Tie sections back to retrieved metadata for traceability. |

---

# 📋 Inputs

- Retrieved chunks from Retriever Service
- Associated metadata per chunk
- Target document type (e.g., SRS, Architecture Overview)

---

# 📋 Outputs

- Drafted document following the full structure
- Sections filled based on retrieved context
- Placeholders inserted where data is missing
- Metadata references embedded throughout

---

# 📋 Key Behaviors

- **Do not hallucinate**: Only draft based on actual retrieved chunks.
- **Always fill** all sections (even if with a placeholder).
- **Respect section ordering** from the template.
- **Support document versioning** by outputting a version ID.
- **Light editing allowed** to make summaries more natural.

---

# 📋 Document Template Enforcement

The Author Agent must always:
- Validate that the draft includes all required sections.
- Use consistent section headings.
- Create an introductory section summarizing the overall document.
- Create a final "References" section listing metadata sources.

---

# 📋 Error Handling

- If no sufficient chunks are retrieved to populate a document:
  - Return a draft with maximum placeholders.
  - Flag document as incomplete for the Evaluator Agent.

---

# 📢 Important Reminders

- No free-form invention: stick to the data retrieved.
- Templates are rigid: missing sections must be obvious.
- Metadata traceability is mandatory: cite where information came from.

---

# 📋 Future Enhancements (Post-MVP)

- Dynamically suggest new sections based on retrieved topics.
- Auto-classify documents by complexity based on chunk metadata.

---

