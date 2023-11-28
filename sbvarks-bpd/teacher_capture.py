import os
import cv2

# Get the directory of the script
script_directory = os.path.dirname(__file__)

# Load the video
# video_path = "C:\\Users\\dileepadev\\downloads\\1.mp4"
video_path = "/sbvarks-bpd/videos/group/1.mp4"
video_capture = cv2.VideoCapture(video_path)

# Desired resolution for the displayed frame
display_width = 1280
display_height = 720

# Horizontal position after which to capture images (right of the red line)
capture_position = display_width // 2 + 450

# Counter for captured images
image_counter = 0

# Folder path to save captured images (in the project directory)
save_folder = os.path.join(script_directory, "Pictures/TeacherCap")

# Create the save folder if it doesn't exist
os.makedirs(save_folder, exist_ok=True)

while True:
    # Read a frame from the video
    ret, frame = video_capture.read()

    if not ret:
        break

    # Get the dimensions of the frame
    height, width, _ = frame.shape

    # Calculate the coordinates of the vertical line's endpoints (center x - 100)
    vertical_line_start = (capture_position, 0)
    vertical_line_end = (capture_position, height)

    # Resize the frame to the desired display resolution
    resized_frame = cv2.resize(frame, (display_width, display_height))

    # Draw the vertical line on the resized frame
    line_color = (0, 0, 255)  # Red color in BGR format
    line_thickness = 2
    cv2.line(resized_frame, vertical_line_start, vertical_line_end, line_color, line_thickness)

    # Display the resized frame
    cv2.imshow('Video Frame', resized_frame)

    # Capture frames after passing the specified position
    if vertical_line_start[0] >= capture_position:
        # Extract the region to the right of the red line
        roi = frame[:, capture_position:]

        image_counter += 1
        image_filename = os.path.join(save_folder, f"{image_counter}.jpg")
        cv2.imwrite(image_filename, roi)
        print(f"Captured {image_filename}")
    else:
        print(f"Did not capture: width={width}, capture_position={capture_position}")

    # Break the loop when 'q' key is pressed
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Release the video capture and close the window
video_capture.release()
cv2.destroyAllWindows()
