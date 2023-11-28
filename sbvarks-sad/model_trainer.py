import csv
import joblib
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.metrics import accuracy_score
from sklearn.model_selection import train_test_split
from sklearn.naive_bayes import MultinomialNB

# Read data from CSV file
data = []
with open('Form/form_responses.csv', 'r', encoding='utf-8') as csv_file:
    csv_reader = csv.DictReader(csv_file)
    for row in csv_reader:
        data.append((
            row["What are your thoughts or comments about the activity?"],
            row["How did you feel during the activity?"]
        ))

# Split data into text and labels
text_data = [entry[0] for entry in data]
labels = [entry[1] for entry in data]

# Split data into training and testing sets
print("Splitting data into training and testing sets...")
X_train, X_test, y_train, y_test = train_test_split(text_data, labels, test_size=0.2, random_state=42)
print("Data split completed.")

# Create Bag-of-Words representation of the text data
print("Creating Bag-of-Words representation...")
vectorizer = CountVectorizer()
X_train_vectorized = vectorizer.fit_transform(X_train)
X_test_vectorized = vectorizer.transform(X_test)
print("Bag-of-Words representation created.")

# Train a Naive Bayes classifier
print("Training Naive Bayes classifier...")
classifier = MultinomialNB()
classifier.fit(X_train_vectorized, y_train)
print("Classifier training completed.")

# Save the trained model to a file using joblib
model_filename = 'Model/sentiment_analysis_model.joblib'
vectorizer_filename = 'Model/vectorizer.joblib'
joblib.dump(classifier, model_filename)
joblib.dump(vectorizer, vectorizer_filename)
print("Trained model and vectorizer saved.")

# Load the model from the file (just to demonstrate loading)
print("Loading the trained model...")
loaded_classifier = joblib.load(model_filename)
print("Model loaded.")

# Predict on the test set
print("Predicting on the test set...")
y_pred = loaded_classifier.predict(X_test_vectorized)
print("Prediction completed.")

# Calculate accuracy
accuracy = accuracy_score(y_test, y_pred)
print(f"Accuracy: {accuracy:.2f}")
