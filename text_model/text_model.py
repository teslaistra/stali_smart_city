import joblib
import re


class TextModel:

    def __init__(self):
        self.classifier = joblib.load('text_model/model.pkl')

    def preprocess_text_(self, text):
        print(text)
        text = text.lower().replace("ё", "е")
        text = re.sub('[^a-zA-Zа-яА-Я1-9]+', ' ', text)
        text = re.sub(' +', ' ', text)
        return text.strip()

    def predict(self, samples):
        samples = [self.preprocess_text_(t) for t in samples]
        return self.classifier.predict_proba(samples)
