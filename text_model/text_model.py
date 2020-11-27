import re

from sklearn.pipeline import Pipeline
from sklearn.naive_bayes import MultinomialNB
from sklearn.feature_extraction.text import CountVectorizer, TfidfTransformer


class TextModel:

    def __init__(self):
        self.classifier = Pipeline([
            ('vect', CountVectorizer(ngram_range=(1,2))),
            ('tfidf', TfidfTransformer(norm='l2', use_idf=True)),
            ('clf', MultinomialNB(alpha=1))
        ])

    def preprocess_text_(self, text):
        text = text.lower().replace("ё", "е")
        text = re.sub('[^a-zA-Zа-яА-Я1-9]+', ' ', text)
        text = re.sub(' +',' ', text)
        return text.strip()

    def predict(self, samples):
        samples = self.preprocess_text_(t for t in samples)
        return self.classifier.predict(samples)
