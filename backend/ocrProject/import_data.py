import json
from database import SessionLocal
from models import Restaurant
from sqlalchemy.exc import SQLAlchemyError
from typing import List, Dict, Any

# 데이터 검증
def validate_and_transform_data(item: Dict[str, Any]) -> Dict[str, Any]:
    transformed = item.copy()

    if 'reviews' in transformed and not isinstance(transformed['reviews'], list):
        transformed['reviews'] = [transformed['reviews']]

    if 'gemini_translation' not in transformed:
        transformed['gemini_translation'] = []

    elif not isinstance(transformed['gemini_translation'], list):
        transformed['gemini_translation'] = [transformed['gemini_translation']]

    if 'review_score' in transformed and isinstance(transformed['review_score'], str):
        transformed['review_score'] = float(transformed['review_score'])

    return transformed

# 데이터베이스에 데이터 import
def import_data(json_file_path):
    db = SessionLocal()
    try:
        with open(json_file_path, 'r', encoding='utf-8') as f:
            data = json.load(f)

        # 단일 레스토랑 데이터인 경우
        if isinstance(data, dict):
            data = [data]
        
        elif isinstance(data, list):
            for item in data:
                try: 

                    transformed_data = validate_and_transform_data(item)
                    restaurant = Restaurant(**transformed_data) 
                    db.add(restaurant)

                    db.commit()
                    print(f"Successfully imported restaurant: {item.get('name', 'Unknown')}")

                except SQLAlchemyError as e:
                    db.rollback()
                    continue

    except Exception as e:
        print(f"Error during import: {str(e)}")
    finally:
        db.close()

if __name__ == "__main__":
    import_data('review_dataset.json')