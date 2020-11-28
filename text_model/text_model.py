import joblib
import re

class TextModel:

    def __init__(self):
        self.classifier = joblib.load('model.pkl')

    def preprocess_text_(self, text):
        text = text.lower().replace("ё", "е")
        text = re.sub('[^a-zA-Zа-яА-Я1-9]+', ' ', text)
        text = re.sub(' +',' ', text)
        return text.strip()

    def predict(self, samples):
        samples = self.preprocess_text_(t for t in samples)
        return self.classifier.predict(samples)
