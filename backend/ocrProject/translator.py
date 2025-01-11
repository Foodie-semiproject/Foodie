import torch 
from model_singleton import T5ModelSingleton
from typing import Dict, Any

class T5TranslationService:
    def __init__(self):
        model_singleton = T5ModelSingleton()
        self.model = model_singleton.model
        self.tokenizer = model_singleton.tokenizer
        self.device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
    
    def translate_text(self, text: str, max_length: int = 128) -> str:

        if not text or not isinstance(text, str):
            return ""
        
        try:
            inputs = self.tokenizer(
                text,
                return_tensors="pt",
                padding=True,
                truncation=True,
                # max_length=max_length
            ).to(self.device)
            
            with torch.no_grad():
                outputs = self.model.generate(
                    **inputs,
                    max_length=max_length,
                    num_beams=4,
                    # length_penalty=0.6,
                )
            
            translated_text = self.tokenizer.decode(outputs[0], skip_special_tokens=True)
            return translated_text
        
        except Exception as e:
            print(f"Translation error: {e}")
            return text
        
    # 요약된 리뷰 번역
    def translate_restaurant_data(self, restaurant_data: Dict[str, Any]) -> Dict[str, Any]:
        translated_data = restaurant_data.copy()

        fields_to_translate = [
            'summary_reviews',
        ]
        
        for field in fields_to_translate:
            if field in translated_data and isinstance(translated_data[field], str):
                translated_data[f'{field}_en'] = self.translate_text(translated_data[field])

        return translated_data