from fastapi import FastAPI
import models
from database import engine
from domain.restaurant import restaurant_router
from model_singleton import T5ModelSingleton


models.Base.metadata.create_all(bind=engine)

app = FastAPI(docs_url="/docs", openapi_url="/open_api-docs")

@app.on_event("startup")
async def startup_event():
    T5ModelSingleton() # 모델 초기화

app.include_router(restaurant_router.router)
