from fastapi import FastAPI

app = FastAPI(
    title="Enhancer Agent",
    version="1.0.0"
)

@app.get("/healthz")
async def health_check():
    return {"status": "ok"}
