import cv2
import numpy as np
import glob

# Load the video
# video_path = "C:\\Users\\dileepadev\\downloads\\1.mp4"
video_path = "/sbvarks-bpd/videos/group/1.mp4"
video_capture = cv2.VideoCapture(video_path)

# Load the teacher images
teacher_images = []
teacher_images_folder = "Pictures/Teacher/"
for img_path in sorted(glob.glob(teacher_images_folder + "*.png")):
    img = cv2.imread(img_path)
    teacher_images.append(cv2.cvtColor(img, cv2.COLOR_BGR2GRAY))

# Get the screen resolution
screen_width = 1080  # Replace with screen width
screen_height = 720  # Replace with screen height

while True:
    # Capture each frame of the video
    ret, frame = video_capture.read()

    if not ret:
        break

    # Convert frame to grayscale for template matching
    gray_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    best_match_idx = None
    best_match_score = -1

    for idx, teacher_image in enumerate(teacher_images):
        # Perform template matching
        result = cv2.matchTemplate(gray_frame, teacher_image, cv2.TM_CCOEFF_NORMED)
        min_val, max_val, min_loc, max_loc = cv2.minMaxLoc(result)

        if max_val > best_match_score:
            best_match_score = max_val
            best_match_idx = idx

    if best_match_idx is not None:
        teacher_image = teacher_images[best_match_idx]
        overlay_height, overlay_width = teacher_image.shape

        result = cv2.matchTemplate(gray_frame, teacher_image, cv2.TM_CCOEFF_NORMED)
        threshold = 0.8  # Adjust the threshold as needed
        locations = np.where(result >= threshold)

        for pt in zip(*locations[::-1]):
            # Draw a rectangle around the matched region
            cv2.rectangle(frame, pt, (pt[0] + overlay_width, pt[1] + overlay_height), (0, 255, 0), 2)
            cv2.putText(frame, f"Teachers {best_match_idx + 1}", (pt[0], pt[1] - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.6, (0, 255, 0), 2)

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

    # Display the resulting frame
    cv2.imshow('Video', resized_frame)

    # Press 'q' to exit
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Release the video capture and close the window
video_capture.release()
cv2.destroyAllWindows()
