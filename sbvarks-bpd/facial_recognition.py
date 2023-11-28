import cv2
import face_recognition
import numpy as np

# Load the video
# video_path = "C:\\Users\\dileepadev\\downloads\\1.mp4"
video_path = "/sbvarks-bpd/videos/group/1.mp4"
video_capture = cv2.VideoCapture(video_path)

# Load the sample images for comparison
students = {
    "Kevin": "pictures/1.png",
    "Abby": "pictures/2.png",
    "Mike": "pictures/3.png",
    "Ruby": "pictures/4.png",
    "Sasha": "pictures/5.png"
}

student_face_encodings = {}
for name, image_path in students.items():
    student_image = face_recognition.load_image_file(image_path)
    student_face_encoding = face_recognition.face_encodings(student_image)[0]
    student_face_encodings[name] = student_face_encoding

# Get the screen resolution
screen_width = 1080  # Replace with screen width
screen_height = 720  # Replace with screen height

while True:
    # Capture each frame of the video
    ret, frame = video_capture.read()

    if not ret:
        break

    # Resize the frame to fit the screen while maintaining aspect ratio
    frame_aspect_ratio = frame.shape[1] / frame.shape[0]
    screen_aspect_ratio = screen_width / screen_height

    if frame_aspect_ratio > screen_aspect_ratio:
        new_width = screen_width
        new_height = int(new_width / frame_aspect_ratio)
    else:
        new_height = screen_height
        new_width = int(new_height * frame_aspect_ratio)

    resized_frame = cv2.resize(frame, (new_width, new_height))

    # Find all face locations and encodings in the resized frame
    face_locations = face_recognition.face_locations(resized_frame)
    face_encodings = face_recognition.face_encodings(resized_frame, face_locations)

    for (top, right, bottom, left), face_encoding in zip(face_locations, face_encodings):
        matched_students = []
        for student_name, student_face_encoding in student_face_encodings.items():
            match = face_recognition.compare_faces([student_face_encoding], face_encoding)
            if match[0]:
                matched_students.append(student_name)

        if len(matched_students) == 1:
            name = matched_students[0]
        elif len(matched_students) > 1:
            name = "?"
        else:
            name = "Unknown"

        # Draw green square around the face
        cv2.rectangle(resized_frame, (left, top), (right, bottom), (0, 255, 0), 2)

        # Draw black background with white text for student's name
        label_width = cv2.getTextSize(name, cv2.FONT_HERSHEY_SIMPLEX, 0.6, 2)[0][0]
        cv2.rectangle(resized_frame, (left, top - 30), (left + label_width + 10, top), (0, 0, 0), -1)
        cv2.putText(resized_frame, name, (left + 5, top - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.6, (255, 255, 255), 2)

    # Calculate position to center the frame on the screen
    x_offset = (screen_width - new_width) // 2
    y_offset = (screen_height - new_height) // 2

    # Create a canvas of the screen size and paste the resized frame onto it
    canvas = 255 * np.ones((screen_height, screen_width, 3), dtype=np.uint8)
    canvas[y_offset:y_offset+new_height, x_offset:x_offset+new_width] = resized_frame

    # Display the resulting frame
    cv2.imshow('Video', canvas)

    # Press 'q' to exit
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Release the video capture and close the window
video_capture.release()
cv2.destroyAllWindows()
