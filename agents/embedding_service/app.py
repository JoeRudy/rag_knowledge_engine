from fastapi import FastAPI

app = FastAPI(
    title="Embedding Service",
    version="1.0.0"
)

@app.get("/healthz")
async def health_check():
    return {"status": "ok"}
