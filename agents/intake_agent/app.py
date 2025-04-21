from fastapi import FastAPI

app = FastAPI(
    title="Intake Agent",
    version="1.0.0"
)

@app.get("/healthz")
async def health_check():
    return {"status": "ok"}
