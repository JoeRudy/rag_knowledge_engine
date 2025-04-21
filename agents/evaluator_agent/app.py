from fastapi import FastAPI

app = FastAPI(
    title="Evaluator Agent",
    version="1.0.0"
)

@app.get("/healthz")
async def health_check():
    return {"status": "ok"}
