from pydantic import BaseModel
from typing import List

# 이미지 스키마
class ImageAnalysisResponse(BaseModel):
    description: str

# 레스토랑 스키마
class RestaurantBase(BaseModel):
    name: str
    address: str
    type: str
    review_score: float
    open_time: str
    phone_num: str
    homepage: str
    description: str
    reviews: List[str]
    gemini_translation: List[str]
    summary_reviews: str
    

class Restaurant(RestaurantBase):
    id: int

    class Config:
        orm_mode = True

class RestaurantTranslated(RestaurantBase):
    summary_reviews_en: str

    class Config:
        orm_mode = True

