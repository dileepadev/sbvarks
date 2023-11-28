import joblib

# Load the trained model and the vectorizer from the files
model_filename = 'models/sad/sentiment_analysis_model.joblib'
vectorizer_filename = 'models/sad/vectorizer.joblib'
loaded_classifier = joblib.load(model_filename)
loaded_vectorizer = joblib.load(vectorizer_filename)


def perform_sentiment_analysis(texts):
    # Transform the new text data using the loaded vectorizer
    texts_vectorized = loaded_vectorizer.transform(texts)

    # Predict sentiment using the loaded model
    predicted_sentiments = loaded_classifier.predict(texts_vectorized)

    # Return the list of predicted sentiments
    return predicted_sentiments
