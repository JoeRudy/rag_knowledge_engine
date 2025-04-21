# rag_db_setup_guide.md

# 📂 RAG Knowledge Engine - Database Setup Guide

This guide explains how to set up the Postgres database (`supabase_db`) for the RAG Knowledge Engine.
It covers connecting to the running container, executing the schema script, and verifying the tables.

---

# 🔗 1. Prerequisites

- Docker and Docker Compose are installed and running.
- `supabase_db` service is running (started via `docker-compose up`).
- The `rag_schema.sql` file is available at the project root.


---

# 🔧 2. Connect to the supabase_db Container

In your terminal, execute:

```bash
docker exec -it supabase_db psql -U supabase_admin -d supabase_db
```

Explanation:
- `docker exec` - Run a command inside a running container.
- `-it` - Interactive terminal.
- `supabase_db` - Name of the container.
- `psql` - Postgres command-line client.
- `-U supabase_admin` - Connect as the `supabase_admin` user.
- `-d supabase_db` - Connect to the `supabase_db` database.

✅ If successful, you should see a `supabase_db=#` prompt.

---

# 📑 3. Create the Database Schema

There are two ways to apply the schema:

### Option A: Manual Paste

1. Open `rag_schema.sql` in your editor.
2. Copy the full contents.
3. Inside the `psql` prompt, paste the SQL commands.
4. Press Enter.

✅ You should see messages like `CREATE TABLE`, `CREATE INDEX`, etc.


### Option B: Direct File Import (More Professional)

First, copy `rag_schema.sql` into the container:

```bash
docker cp rag_schema.sql supabase_db:/rag_schema.sql
```

Then, inside the container shell, execute:

```bash
docker exec -it supabase_db psql -U supabase_admin -d supabase_db -f /rag_schema.sql
```

✅ This automatically runs the schema script.

---

# 📈 4. Verify Table Creation

Once the schema is applied, inside the `psql` prompt:

### List all tables
```bash
\dt
```
You should see:
- documents
- chunks
- metadata_fields
- versions


### View table structure (example: documents)
```bash
\d documents
```
It will show columns, types, and indexes.

✅ Repeat for `chunks`, `metadata_fields`, and `versions` to double-check.


---

# 🔢 5. Best Practices for Schema Management

- Always version your schema files (`rag_schema_v1.sql`, `rag_schema_v2.sql`) over time.
- Avoid manual ad-hoc changes directly in `psql` (always use versioned scripts).
- Document any future schema migrations cleanly.
- Backup your `supabase_db` periodically once real data is loaded.


---

# ✅ Database Setup Complete

Once you complete these steps:
- Your database is ready for Intake, Embedding, Retrieval, Authoring, Evaluation, and Enhancing workflows.
- All agents will be able to read/write to their respective tables as system coding progresses.

---

