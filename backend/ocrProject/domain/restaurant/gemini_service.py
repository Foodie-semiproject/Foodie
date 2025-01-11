import google.generativeai as genai
from PIL import Image
from config import Settings

def initialize_gemini(settings: Settings):
    genai.configure(api_key=settings.GOOGLE_API_KEY)
    return genai.GenerativeModel('gemini-1.5-flash-latest')

def analyze_image_with_gemini(model: genai.GenerativeModel, image: Image.Image) -> str:
    prompt = """
            너는 사진을 보고 사진에 있는 식당 이름을 추출할 수 있는 지능적인 AI야.
            
            사진을 보고 간판에 있는 식당 이름을 추출해줘. 사진에 있는 글씨들 중에서
            가장 큰 것을 찾으면 돼.
            
            1. 영어로 되어있다면 한글로 읽어줘.
            2. 너의 답변에는 식당 이름 외에 다른 어떤 것도 포함시키지 말아줘.
            3. 식당이름을 찾지 못하겠다면 '인식불가'라고 답변해줘.
        """

    response = model.generate_content(
        [prompt, image],
    )

    return response.text