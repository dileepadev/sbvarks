import cv2
import numpy as np
from keras.models import model_from_json
import csv
import os

emotion_dict = {0: "Angry", 1: "Disgusted", 2: "Fearful", 3: "Happy", 4: "Neutral", 5: "Sad", 6: "Surprised"}

# load json and create model
json_file = open('model/fer_model.json', 'r')
loaded_model_json = json_file.read()
json_file.close()
fer_model = model_from_json(loaded_model_json)

# load weights into new model
fer_model.load_weights("model/fer_model.h5")
print("Loaded model from disk")

# start the webcam feed
# cap = cv2.VideoCapture(0)

# pass here video path
# cap = "C:\\Users\\dileepadev\\downloads\\1.mp4"
cap = cv2.VideoCapture("/studentprofiler-api/uploads/3.mp4")

# Create a 'charts' folder if it doesn't exist
if not os.path.exists('csv'):
    os.makedirs('csv')

# Initialize a dictionary to hold emotion counts
emotion_count = {emotion: 0 for emotion in emotion_dict.values()}

# Open CSV file for writing emotion statistics
emotion_stats_file = open('csv/emotion_statistics.csv', 'w', newline='')
emotion_stats_writer = csv.writer(emotion_stats_file)
emotion_stats_writer.writerow(['Emotion', 'Timestamp', 'Value'])

while True:
    # Find haar cascade to draw bounding box around face
    ret, frame = cap.read()
    if not ret:
        break

    frame = cv2.resize(frame, (1280, 720))
    # frame = cv2.resize(frame, (500, 720))

    face_detector = cv2.CascadeClassifier('haarcascades/haarcascade_frontalface_default.xml')
    gray_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    # detect faces available on camera
    num_faces = face_detector.detectMultiScale(gray_frame, scaleFactor=1.3, minNeighbors=5)

    # take each face available on the camera and Preprocess it
    for (x, y, w, h) in num_faces:
        # Draw blue-colored bounding box around the detected face
        cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 0, 255), 2)

        roi_gray_frame = gray_frame[y:y + h, x:x + w]
        cropped_img = np.expand_dims(np.expand_dims(cv2.resize(roi_gray_frame, (48, 48)), -1), 0)

        # predict the emotions
        emotion_prediction = fer_model.predict(cropped_img)
        maxindex = int(np.argmax(emotion_prediction))
        emotion_label = emotion_dict[maxindex]

        # Update emotion count
        emotion_count[emotion_label] += 1

        # Draw emotion label on the frame
        cv2.putText(frame, emotion_label, (x + 5, y - 20), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 0, 255), 2, cv2.LINE_AA)

        # Get emotion value
        emotion_value = emotion_prediction[0][maxindex]

        # Write emotion statistics to CSV
        emotion_stats_writer.writerow([emotion_label, cap.get(cv2.CAP_PROP_POS_FRAMES), emotion_value])

        # Print emotion value to console
        print(emotion_dict[maxindex], "Emotion value:", emotion_value)

        # Print frame number to console
        print("Frame number:", cap.get(cv2.CAP_PROP_POS_FRAMES))

    cv2.imshow('SVARKS | Student Profiler | Emotion Detection', frame)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Close the video capture
cap.release()
cv2.destroyAllWindows()

# Close CSV files
emotion_stats_file.close()

# Write emotion counts to a CSV file
with open('csv/emotion_count.csv', 'w', newline='') as csv_file:
    csv_writer = csv.writer(csv_file)
    csv_writer.writerow(['Emotion', 'Count', 'Percentage'])
    for emotion, count in emotion_count.items():
        csv_writer.writerow([emotion, count, str(round(count / sum(emotion_count.values()) * 100, 2)) + '%'])

# Run the display_values.py script to display the emotion statistics
os.system('python display_values.py')
