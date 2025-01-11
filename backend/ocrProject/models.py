from sqlalchemy import Column, Integer, String, Text, Float, JSON
from database import Base


class RestaurantModel(Base):
    __tablename__ = "restaurant"

    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False)
    address = Column(String, nullable=False)
    type = Column(String, nullable=False)
    review_score = Column(Float, nullable=False)
    open_time = Column(String, nullable=False)
    phone_num = Column(String, nullable=False)
    homepage = Column(String, nullable=False)
    summary_reviews = Column(Text, nullable=False)
    description = Column(Text, nullable=False)
    reviews = Column(JSON, nullable=False)
    gemini_translation = Column(JSON, nullable=False)
