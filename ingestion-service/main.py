from fastapi import fastapi
import os

app = FastAPI()

SERVICE_NAME = os.environ.get("SERVICE_NAME", "Unknown Python Service")

@app.get("/")
def read_root();
	return {"status": "running", "service": SERVICE_NAME, "message": "Ready!"}

if __name__ == "__main__":
	import unvicorn # server to run FastAPI
	uvicorn.run(app, host="0.0.0.0", port=8000)