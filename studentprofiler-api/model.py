import json

import cv2
import numpy as np
from flask import jsonify
from keras.models import model_from_json
import os

# Load the emotion detection model
emotion_dict = {0: "Angry", 1: "Disgusted", 2: "Fearful", 3: "Happy", 4: "Neutral", 5: "Sad", 6: "Surprised"}
json_file = open('models/ferd/fer_model.json', 'r')
loaded_model_json = json_file.read()
json_file.close()
fer_model = model_from_json(loaded_model_json)
fer_model.load_weights("models/ferd/fer_model.h5")
cascade_classifier_path = 'models/ferd/haarcascade_frontalface_default.xml'

# Create a directory to store uploaded videos
if not os.path.exists('uploads'):
    os.makedirs('uploads')


def calculate_emotional_values(video_path):
    # Initialize a dictionary to hold emotion counts
    emotion_count = {emotion: 0 for emotion in emotion_dict.values()}

    cap = cv2.VideoCapture(video_path)
    while True:
        ret, frame = cap.read()
        if not ret:
            break

        frame = cv2.resize(frame, (1280, 720))
        gray_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

        face_detector = cv2.CascadeClassifier(cascade_classifier_path)
        num_faces = face_detector.detectMultiScale(gray_frame, scaleFactor=1.3, minNeighbors=5)

        for (x, y, w, h) in num_faces:
            roi_gray_frame = gray_frame[y:y + h, x:x + w]
            cropped_img = np.expand_dims(np.expand_dims(cv2.resize(roi_gray_frame, (48, 48)), -1), 0)

            emotion_prediction = fer_model.predict(cropped_img)
            maxindex = int(np.argmax(emotion_prediction))
            emotion_label = emotion_dict[maxindex]

            emotion_count[emotion_label] += 1

    cap.release()

    # Calculate percentages
    total_count = sum(emotion_count.values())
    emotion_percentages = {emotion: (count / total_count) * 100 for emotion, count in emotion_count.items()}

    return emotion_percentages


def analyze_emotions(video_path):
    # Initialize a dictionary to hold emotion counts
    emotion_count = {emotion: 0 for emotion in emotion_dict.values()}

    cap = cv2.VideoCapture(video_path)

    while True:
        ret, frame = cap.read()
        if not ret:
            break

        frame = cv2.resize(frame, (640, 360))
        gray_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

        # Detect faces
        face_detector = cv2.CascadeClassifier(cascade_classifier_path)
        num_faces = face_detector.detectMultiScale(gray_frame, scaleFactor=1.3, minNeighbors=5)

        for (x, y, w, h) in num_faces:
            cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 0, 255), 2)

            roi_gray_frame = gray_frame[y:y + h, x:x + w]
            cropped_img = np.expand_dims(np.expand_dims(cv2.resize(roi_gray_frame, (48, 48)), -1), 0)

            emotion_prediction = fer_model.predict(cropped_img)
            maxindex = int(np.argmax(emotion_prediction))
            emotion_label = emotion_dict[maxindex]

            cv2.putText(frame, emotion_label, (x + 5, y - 20), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 0, 255), 2, cv2.LINE_AA)

            _, buffer = cv2.imencode('.jpg', frame)
            frame = buffer.tobytes()

            yield (b'--frame\r\n'
                   b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n')

            emotion_count[emotion_label] += 1

    cap.release()

    # Calculate percentages
    total_count = sum(emotion_count.values())
    emotion_percentages = {emotion: (count / total_count) * 100 for emotion, count in emotion_count.items()}

    # Return the emotion percentages as a Flask jsonify response
    return jsonify(emotion_percentages)
