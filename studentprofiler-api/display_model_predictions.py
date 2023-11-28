def display_sad_predictions(sentiments, feedback_texts):
    print(f"(V) Teacher Feedback: {feedback_texts[0]}")
    print(f"(V) Predicted Sentiment Teacher: {sentiments[0]}")
    print(f"(V) Student Feedback: {feedback_texts[1]}")
    print(f"(V) Predicted Sentiment Student: {sentiments[1]}")

    print(f"(A) Teacher Feedback: {feedback_texts[2]}")
    print(f"(A) Predicted Sentiment Teacher: {sentiments[2]}")
    print(f"(A) Student Feedback: {feedback_texts[3]}")
    print(f"(A) Predicted Sentiment Student: {sentiments[3]}")

    print(f"(R) Teacher Feedback: {feedback_texts[4]}")
    print(f"(R) Predicted Sentiment Teacher: {sentiments[4]}")
    print(f"(R) Student Feedback: {feedback_texts[5]}")
    print(f"(R) Predicted Sentiment Student: {sentiments[5]}")

    print(f"(K) Teacher Feedback: {feedback_texts[6]}")
    print(f"(K) Predicted Sentiment Teacher: {sentiments[6]}")
    print(f"(K) Student Feedback: {feedback_texts[7]}")
    print(f"(K) Predicted Sentiment Student: {sentiments[7]}")
