# import cv2
# import numpy as np
# from keras.models import model_from_json
# import csv
# import os
#
# emotion_dict = {0: "Angry", 1: "Disgusted", 2: "Fearful", 3: "Happy", 4: "Neutral", 5: "Sad", 6: "Surprised"}
#
# # load json and create model
# json_file = open('models/ferd/fer_model.json', 'r')
# loaded_model_json = json_file.read()
# json_file.close()
# fer_model = model_from_json(loaded_model_json)
#
# # load weights into new model
# fer_model.load_weights("models/ferd/fer_model.h5")
# print("Loaded model from disk")
#
# # pass here video path
# videoName = "v"
# cap = cv2.VideoCapture("C:\\Users\\dilee\\OneDrive\\Desktop\\SVARKS\\videos\\single\\1sec\\" + videoName + ".mp4")
#
# # Create a 'charts' folder if it doesn't exist
# if not os.path.exists('models/ferd/csv'):
#     os.makedirs('models/ferd/csv')
#
# # Initialize a dictionary to hold emotion counts
# emotion_count = {emotion: 0 for emotion in emotion_dict.values()}
#
# # Open CSV file for writing emotion statistics
# emotion_stats_file = open('models/ferd/csv/emotion_statistics.csv', 'w', newline='')
# emotion_stats_writer = csv.writer(emotion_stats_file)
# emotion_stats_writer.writerow(['Emotion', 'Timestamp', 'Value'])
#
# while True:
#     # Find haar cascade to draw bounding box around face
#     ret, frame = cap.read()
#     if not ret:
#         break
#
#     frame = cv2.resize(frame, (1280, 720))
#     # frame = cv2.resize(frame, (500, 720))
#
#     face_detector = cv2.CascadeClassifier('models/ferd/haarcascade_frontalface_default.xml')
#     gray_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
#
#     # detect faces available on camera
#     num_faces = face_detector.detectMultiScale(gray_frame, scaleFactor=1.3, minNeighbors=5)
#
#     # take each face available on the camera and Preprocess it
#     for (x, y, w, h) in num_faces:
#         # Draw blue-colored bounding box around the detected face
#         cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 0, 255), 2)
#
#         roi_gray_frame = gray_frame[y:y + h, x:x + w]
#         cropped_img = np.expand_dims(np.expand_dims(cv2.resize(roi_gray_frame, (48, 48)), -1), 0)
#
#         # predict the emotions
#         emotion_prediction = fer_model.predict(cropped_img)
#         maxindex = int(np.argmax(emotion_prediction))
#         emotion_label = emotion_dict[maxindex]
#
#         # Update emotion count
#         emotion_count[emotion_label] += 1
#
#         # Draw emotion label on the frame
#         cv2.putText(frame, emotion_label, (x + 5, y - 20), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 0, 255), 2, cv2.LINE_AA)
#
#         # Get emotion value
#         emotion_value = emotion_prediction[0][maxindex]
#
#         # Write emotion statistics to CSV
#         emotion_stats_writer.writerow([emotion_label, cap.get(cv2.CAP_PROP_POS_FRAMES), emotion_value])
#
#         # Print emotion value to console
#         print(emotion_dict[maxindex], "Emotion value:", emotion_value)
#
#         # Print frame number to console
#         print("Frame number:", cap.get(cv2.CAP_PROP_POS_FRAMES))
#
#     cv2.imshow('SVARKS | Student Profiler | Emotion Detection', frame)
#     if cv2.waitKey(1) & 0xFF == ord('q'):
#         break
#
# # Close the video capture
# cap.release()
# cv2.destroyAllWindows()
#
# # Close CSV files
# emotion_stats_file.close()
#
# # Write emotion counts to a CSV file
# with open('models/ferd/csv/emotion_count.csv', 'w', newline='') as csv_file:
#     csv_writer = csv.writer(csv_file)
#     csv_writer.writerow(['Emotion', 'Count', 'Percentage'])
#     for emotion, count in emotion_count.items():
#         csv_writer.writerow([emotion, count, str(round(count / sum(emotion_count.values()) * 100, 2)) + '%'])
#
# # Display top 3 emotions
# # Sort the emotion_count dictionary by values in descending order
# sorted_emotion_count = {k: v for k, v in sorted(emotion_count.items(), key=lambda item: item[1], reverse=True)}
#
# # Get the total count of emotions
# total_emotion_count = sum(emotion_count.values())
#
# # Get the top 3 emotions and their percentages
# top_3_emotions = list(sorted_emotion_count.keys())[:3]
#
# # Print the top 3 emotions with percentages
# print("Top 3 emotions with percentages:")
# for idx, emotion in enumerate(top_3_emotions, start=1):
#     count = sorted_emotion_count[emotion]
#     percentage = (count / total_emotion_count) * 100
#     print(f"{idx}. {emotion}: {count} ({percentage:.2f}%)")
