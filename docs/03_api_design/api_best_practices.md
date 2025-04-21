# api_best_practices.md

# 📚 Internal API Best Practices

This document outlines the API best practices to be followed when designing internal APIs between all RAG Knowledge Engine components.

Consistency, validation, and simplicity are key to ensuring services remain modular and easy to evolve.

---

# 📋 General API Design Principles

| Principle | Description |
|:----------|:------------|
| JSON Everywhere | All requests and responses must use strict JSON. |
| POST for All Endpoints | Always use POST even for retrievals (to support complex payloads). |
| Typed Payloads | Use Pydantic models to validate request and response structures. |
| Small Surface Area | Keep API endpoints minimal and focused. |
| Versioned APIs | Prefix all routes with `/v1/`, allowing future versioning. |
| Clean Error Responses | All errors must return structured JSON error codes and messages. |

---

# 📋 Standard Error Response Format

```json
{
  "error_code": "string",
  "error_message": "string",
  "details": "optional string"
}
```

---

# 📋 Success Response Principles

- Always return 200 OK with a `status: success` field when an operation completes without error.
- Include counts or result summaries in success payloads.

Example:
```json
{
  "status": "success",
  "chunks_embedded": 25
}
```

---

# 📋 API Naming Conventions

- Endpoints should be descriptive and action-based:
  - `/v1/embed`
  - `/v1/retrieve`
  - `/v1/draft`
  - `/v1/evaluate`
  - `/v1/enhance`
- Avoid nouns like `/vector` or `/document` alone — emphasize **actions**.

---

# 📋 Data Validation Requirements

- **Strict schema validation**:
  - Type checks (e.g., date must match YYYY-MM-DD).
  - Required vs optional fields explicitly defined.
- **Default Values**:
  - Use reasonable defaults in schemas where applicable (e.g., `top_k = 5`).

---

# 📋 Versioning

- Always prefix endpoints with version number: `/v1/`
- Even internal API changes must respect versioning if contracts break.

---

# 📋 Security Considerations

- For MVP/local testing:
  - No authentication initially required between agents.
- Future:
  - Add API token authentication between services.

---

# 📢 Important Reminders

- Never return raw Python error traces to other services.
- Consistent API shapes allow easy reusability across agents.
- Structured error reporting saves massive debugging time later.

---

# 📋 Future Enhancements

- Add OpenAPI documentation generation.
- Implement service health check endpoints (`/healthz`).
- Add circuit breaker patterns for resilience.

---

