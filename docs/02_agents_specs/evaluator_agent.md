# evaluator_agent.md

# 📚 Evaluator Agent Detailed Specification

The Evaluator Agent is responsible for validating both the structure and content quality of drafted documents.

It flags issues, assigns severity levels, and produces structured evaluation reports that downstream agents (Enhancer Agent, Human Review Layer) consume.

---

# 📋 Core Responsibilities

| Responsibility | Detail |
|:---------------|:-------|
| Validate Structure | Ensure all required sections in the document template are filled. |
| Validate Content Quality | Detect empty sections, placeholder leakage, or obvious incoherencies. |
| Severity Classification | Classify issues as Critical, Warning, or Info. |
| Structured Reporting | Output a clean, machine-readable evaluation report. |
| Trigger Enhancements | Mark issues that the Enhancer Agent can attempt to fix automatically. |

---

# 📋 Inputs

- Drafted document from Author Agent
- Metadata references tied to the document
- Target document type (template definition)

---

# 📋 Outputs

- Structured Evaluation Report:
  - Overall pass/fail status
  - List of flagged issues
  - Severity level per issue
  - Section/location where issue occurred

---

# 📋 Severity Definitions

| Severity | Meaning |
|:---------|:--------|
| Critical | Must fix before document can be approved (e.g., missing major section). |
| Warning | Should fix to improve quality but not strictly required. |
| Info | Minor polish suggestions; optional. |

---

# 📋 Key Evaluation Rules

- **Structure Validation**
  - Every required section must exist.
  - Sections must appear in the correct order.

- **Content Validation**
  - Sections cannot be empty.
  - Placeholders must not leak into final drafts.
  - Summaries should be coherent.

- **Reference Validation**
  - Metadata references should match section content when cited.

---

# 📋 Error Handling

- If the document is entirely missing sections:
  - Fail fast and report a Critical issue.

- If metadata references are missing:
  - Mark as Warning.

---

# 📢 Important Reminders

- Always produce an evaluation report, even if no issues are found.
- Evaluator must be strict: missing sections or incomplete info must be flagged.
- Traceability between evaluation findings and document sections must be clear.

---

# 📋 Future Enhancements (Post-MVP)

- Add grammar/spelling linting.
- Semantic coherence scoring (e.g., detecting concept drift).
- Cross-document consistency checks (phase 2).

---

