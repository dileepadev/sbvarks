import joblib

# Load the trained model and the vectorizer from the files
model_filename = 'Model/sentiment_analysis_model.joblib'
vectorizer_filename = 'Model/vectorizer.joblib'
loaded_classifier = joblib.load(model_filename)
loaded_vectorizer = joblib.load(vectorizer_filename)

# Example new text data for sentiment analysis
new_texts = [
    "student liked it.",
]

# Transform the new text data using the loaded vectorizer
new_texts_vectorized = loaded_vectorizer.transform(new_texts)

# Predict sentiment using the loaded model
predicted_sentiments = loaded_classifier.predict(new_texts_vectorized)

# Print the predicted sentiments
for text, sentiment in zip(new_texts, predicted_sentiments):
    print(f"Text: '{text}'")
    print(f"Predicted Sentiment: '{sentiment}'")
    print()
