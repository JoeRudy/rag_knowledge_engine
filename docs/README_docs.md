# readme_docs.md

# 📚 Documentation Table of Contents

This document provides a full index of all markdown documentation that defines, designs, and governs the RAG Knowledge Engine.

It is organized by logical phase/folder for ease of navigation.

---

# 📁 00_foundation

| File | Description |
|:-----|:------------|
| system_setup_detailed_steps.md | Detailed step-by-step system setup guide. |
| component_ownership.md | Defines ownership responsibilities for each system component. |
| system_architecture_diagram.md | High-level system architecture diagram (Mermaid). |
| system_stack.md | Overview of the entire technology stack chosen. |
| rag_checklist.md | Master checklist tracking project phases and deliverables. |

---

# 📁 01_problem_definition

| File | Description |
|:-----|:------------|
| problem_statement.md | Formal project problem statement and scope. |
| high_level_components.md | Overview of major components and their interactions. |
| detailed_component_design.md | Deep dive into individual component responsibilities and behavior. |

---

# 📁 02_agents_specs

| File | Description |
|:-----|:------------|
| author_agent.md | Author Agent specification (drafting documents). |
| embedding_service.md | Embedding Service specification (vectorizing chunks). |
| retriever_service.md | Retriever Service specification (semantic search). |
| evaluator_agent.md | Evaluator Agent specification (document validation). |
| enhancer_agent.md | Enhancer Agent specification (auto-improvements). |
| intake_agent.md | Intake Agent specification (file intake and preprocessing). |
| human_review_layer.md | Human Review Layer specification (human-in-the-loop validation). |

---

# 📁 03_api_design

| File | Description |
|:-----|:------------|
| payload_schemas.md | Defines internal API payload request/response schemas. |
| api_best_practices.md | Defines best practices for internal service API designs. |

---

# 📁 04_deployment

| File | Description |
|:-----|:------------|
| docker_setup.md | Full Docker + Docker Compose setup for local deployment. |
| docker_compose.md | Full documentation of docker-compose.yml orchestration. |
| dockerfiles.md | Standards and patterns for writing service Dockerfiles. |

---

# 📢 Important Reminders

- All documentation must be kept synchronized with system changes.
- Markdown naming conventions: lowercase, words separated by underscores (`_`).
- Folders organized by logical lifecycle phase.
- If a new phase or major module is added, update this `readme_docs.md` immediately.

---

