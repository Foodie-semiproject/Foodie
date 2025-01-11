from fastapi import APIRouter, Depends, HTTPException, UploadFile, File
from sqlalchemy.orm import Session
from typing import List
from database import SessionLocal
from models import RestaurantModel
from translator import T5TranslationService

from database import get_db
from domain.restaurant.restaurant_schema import ImageAnalysisResponse, Restaurant, RestaurantTranslated
from domain.restaurant.gemini_service import initialize_gemini, analyze_image_with_gemini

from PIL import Image
import io
from config import Settings, get_settings

router = APIRouter(
    prefix="/restaurants",
    tags=["restaurants"]
)

translation_service = T5TranslationService()

@router.post("/analyze-image/", response_model=ImageAnalysisResponse)
async def analyze_image(file: UploadFile = File(...), settings: Settings = Depends(get_settings)):
    try: 
        contents = await file.read()
        image = Image.open(io.BytesIO(contents))

        model = initialize_gemini(settings)
        description = analyze_image_with_gemini(model, image)

        return ImageAnalysisResponse(description=description)
    
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/search/{name}", response_model=List[Restaurant])
def search_restaurant(name: str, db: Session = Depends(get_db)):
    restaurants = db.query(RestaurantModel).filter(
        RestaurantModel.name.ilike(f"%{name}%")
    ).all()

    if not restaurants:
        raise HTTPException(status_code=404, detail="Restaurant not found")

    return restaurants


@router.get("/translate/{restaurant_name}", response_model=RestaurantTranslated)
def search_restaurant(restaurant_name: str, db: Session = Depends(get_db)):

    restaurant = db.query(RestaurantModel).filter(
        RestaurantModel.name.ilike(f"%{restaurant_name}%")
    ).first()

    if not restaurant:
        raise HTTPException(status_code=404, detail="Restaurant not found")

    translation_target = {
        "name": restaurant.name,
        "address": restaurant.address,
        "type": restaurant.type,
        "review_score": restaurant.review_score,
        "open_time": restaurant.open_time,
        "phone_num": restaurant.phone_num,
        "homepage": restaurant.homepage,
        "reviews": restaurant.reviews,
        "summary_reviews": restaurant.summary_reviews,
        "description": restaurant.description,
        "gemini_translation": restaurant.gemini_translation
    }

    translated_data = translation_service.translate_restaurant_data(translation_target)

    return RestaurantTranslated(**translated_data)