from transformers import AutoTokenizer, AutoModelForSeq2SeqLM
import torch 

# T5 모델
# model_path = "watertiger0704/ket5_restaurant_reviews"
# tokenizer_path = "KETI-AIR/ke-t5-base"

# BART 모델
model_path = "watertiger0704/bart_restaurant_reviews"
tokenizer_path = "facebook/mbart-large-50-many-to-many-mmt"


class T5ModelSingleton:
    _instance = None
    _model = None
    _tokenizer = None

    def __new__(cls):
        if cls._instance is None:
            cls._instance = super(T5ModelSingleton, cls).__new__(cls)
            cls._instance._initialize_model()
        return cls._instance
    
    def _initialize_model(self):
        if self._model is None:
            self.device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
            self._model = AutoModelForSeq2SeqLM.from_pretrained(model_path).to(self.device)
            # self._tokenizer = AutoTokenizer.from_pretrained(tokenizer_path) # T5 모델
            self._tokenizer = AutoTokenizer.from_pretrained(tokenizer_path, src_lang='ko_KR', tgt_lang='en_XX') # BART 모델
            self._tokenizer.model_max_length = self._model.config.max_position_embeddings # BART 모델
            self._model.eval()
    
    @property
    def model(self):
        return self._model
    
    @property
    def tokenizer(self):
        return self._tokenizer
    
