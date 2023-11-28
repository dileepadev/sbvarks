import os

from flask import Flask, render_template, request, jsonify, redirect, Response
import firebase_admin
from firebase_admin import credentials, firestore

from model import analyze_emotions, calculate_emotional_values
from model_sad import perform_sentiment_analysis
from display_model_predictions import display_sad_predictions
from plan_generator import get_plan

cred = credentials.Certificate("firebase/serviceAccountKey.json")
firebase_admin.initialize_app(cred)

app = Flask(__name__)

# Get a reference to the Firestore database
db = firestore.client()
vp = "uploads/a.mp4"


@app.route('/', methods=['GET', 'POST'])
def teacher_profiler():
    name = None

    if request.method == 'POST':
        name = request.form.get('name')

    return render_template('index.html', name=name)


@app.route('/teachers', methods=['GET'])
def get_teachers():
    # Retrieve teacher details from Firestore
    teachers_collection = db.collection('teachers')
    teachers_snapshot = teachers_collection.get()

    teachers = []
    for teacher_doc in teachers_snapshot:
        teacher_data = teacher_doc.to_dict()
        teachers.append(teacher_data)

    return jsonify(teachers)


@app.route('/teachers/<teacher_uuid>/students', methods=['GET'])
def get_students_for_teacher(teacher_uuid):
    # Retrieve student details for the selected teacher from Firestore
    students_collection = db.collection('teachers').document(teacher_uuid).collection('students')
    students_snapshot = students_collection.get()

    students = []
    for student_doc in students_snapshot:
        student_data = student_doc.to_dict()
        students.append(student_data)

    return jsonify(students)


@app.route('/teachers/<teacher_uuid>/students/<student_uuid>', methods=['GET'])
def get_student_for_teacher(teacher_uuid, student_uuid):
    # Retrieve student details for the selected teacher from Firestore
    student_doc = db.collection('teachers').document(teacher_uuid).collection('students').document(student_uuid).get()
    student_data = student_doc.to_dict()

    return jsonify(student_data)


@app.route('/subjects', methods=['GET'])
def get_subjects():
    # Retrieve subject details from Firestore
    subjects_collection = db.collection('subjects')
    subjects_snapshot = subjects_collection.get()

    subjects = []
    for subject_doc in subjects_snapshot:
        subject_data = subject_doc.to_dict()
        subjects.append(subject_data)

    return jsonify(subjects)


@app.route('/behavior', methods=['POST'])
def add_behaviour():
    if request.method == 'POST':
        request_data = request.get_json()
        # Extract form data using request.form
        teacher_feedback_v = request_data['teacherFeedbackV']
        student_feedback_v = request_data['studentFeedbackV']
        teacher_feedback_a = request_data['teacherFeedbackA']
        student_feedback_a = request_data['studentFeedbackA']
        teacher_feedback_r = request_data['teacherFeedbackR']
        student_feedback_r = request_data['studentFeedbackR']
        teacher_feedback_k = request_data['teacherFeedbackK']
        student_feedback_k = request_data['studentFeedbackK']

        # Combine feedback texts for sentiment analysis
        feedback_texts = [
            teacher_feedback_v, student_feedback_v,
            teacher_feedback_a, student_feedback_a,
            teacher_feedback_r, student_feedback_r,
            teacher_feedback_k, student_feedback_k
        ]

        # Perform sentiment analysis
        sentiments = perform_sentiment_analysis(feedback_texts)

        # Print the predicted sentiments to the console
        print("Sentiment Analysis Results:")
        display_sad_predictions(sentiments, feedback_texts)

        # Now 'sentiments' contains the sentiment predictions for each feedback
        # Can use these sentiments as needed, for example, save them to database

        # Redirect or render a response as needed
        # For example, redirect to a success page or render a response in JSON format

        return jsonify({
            'message': 'Behavior added successfully!',
            'teacherSentimentV': sentiments[0],
            'studentSentimentV': sentiments[1],
            'teacherSentimentA': sentiments[2],
            'studentSentimentA': sentiments[3],
            'teacherSentimentR': sentiments[4],
            'studentSentimentR': sentiments[5],
            'teacherSentimentK': sentiments[6],
            'studentSentimentK': sentiments[7]
        })

    return jsonify({'error': 'Invalid request'})


@app.route('/upload_video', methods=['GET', 'POST'])
def upload():
    if request.method == 'POST':
        print("Received a POST request to /upload_video")
        if 'video' not in request.files:
            return redirect(request.url)

        video_file = request.files['video']
        if video_file.filename == '':
            return redirect(request.url)

        # Save the uploaded video to the "uploads" directory
        video_path = os.path.join('uploads', video_file.filename)
        video_file.save(video_path)

        print("Saved uploaded video to " + video_path)

        # return video_path as a json response
        return jsonify(video_path)


@app.route('/video_feed', methods=['GET', 'POST'])
def video_feed():
    if request.method == 'GET':
        print("Received a GET request to /video_feed")
        print("videoPath = " + request.args.get('videoPath'))
        received_video = analyze_emotions(request.args.get('videoPath'))
        mime_type = 'multipart/x-mixed-replace; boundary=frame'
        if received_video is None:
            print("Received video is None")
            return Response(analyze_emotions("uploads/a.mp4"), mimetype=mime_type)
        else:
            print("Received video is not None")
            return Response(received_video, mimetype=mime_type)


@app.route('/emotional_values', methods=['GET'])
def emotional_values():
    # Calculate and gather emotional values here
    emotion_percentages = calculate_emotional_values(request.args.get('videoPath'))

    return jsonify(emotion_percentages)


@app.route('/plan', methods=['POST'])
def plan():
    if request.method == 'POST':
        request_data = request.get_json()
        learning_style = request_data['learningStyle']
        set_number = request_data['setNumber']
        result = get_plan(learning_style, set_number)

        return jsonify(result)


@app.route('/saveplan', methods=['POST'])
def save_to_firestore():
    try:
        data = request.get_json()

        # Extract data from the request
        selectedTeacherID = data['selectedTeacherID']
        selectedStudentID = data['selectedStudentID']
        selectedSubjectID = data['selectedSubjectID']
        teacherSentimentV = data['teacherSentimentV']
        studentSentimentV = data['studentSentimentV']
        teacherSentimentA = data['teacherSentimentA']
        studentSentimentA = data['studentSentimentA']
        teacherSentimentR = data['teacherSentimentR']
        studentSentimentR = data['studentSentimentR']
        teacherSentimentK = data['teacherSentimentK']
        studentSentimentK = data['studentSentimentK']
        highestEmotionV = data['highestEmotionV']
        highestEmotionA = data['highestEmotionA']
        highestEmotionR = data['highestEmotionR']
        highestEmotionK = data['highestEmotionK']
        emotionPercentageV = data['emotionPercentageV']
        emotionPercentageA = data['emotionPercentageA']
        emotionPercentageR = data['emotionPercentageR']
        emotionPercentageK = data['emotionPercentageK']
        happinessValueV = data['happinessValueV']
        happinessValueA = data['happinessValueA']
        happinessValueR = data['happinessValueR']
        happinessValueK = data['happinessValueK']
        ldVarkValueV = data['ldVarkValueV']
        ldVarkValueA = data['ldVarkValueA']
        ldVarkValueR = data['ldVarkValueR']
        ldVarkValueK = data['ldVarkValueK']
        generatedplanV1 = data['generatedplanV1']
        generatedplanV2 = data['generatedplanV2']
        generatedplanV3 = data['generatedplanV3']
        generatedplanV4 = data['generatedplanV4']
        generatedplanA1 = data['generatedplanA1']
        generatedplanA2 = data['generatedplanA2']
        generatedplanA3 = data['generatedplanA3']
        generatedplanA4 = data['generatedplanA4']
        generatedplanR1 = data['generatedplanR1']
        generatedplanR2 = data['generatedplanR2']
        generatedplanR3 = data['generatedplanR3']
        generatedplanR4 = data['generatedplanR4']
        generatedplanK1 = data['generatedplanK1']
        generatedplanK2 = data['generatedplanK2']
        generatedplanK3 = data['generatedplanK3']
        generatedplanK4 = data['generatedplanK4']

        # Define the Firestore collection path
        collection_path_stu = db.collection('teachers').document(data['selectedTeacherID']).collection(
            'students').document(
            data['selectedStudentID'])
        collection_path_sub = db.collection('teachers').document(data['selectedTeacherID']).collection(
            'students').document(data['selectedStudentID']).collection('subjects').document(data['selectedSubjectID'])

        # Calculate the maximum value
        max_value = max(ldVarkValueV, ldVarkValueA, ldVarkValueR, ldVarkValueK)

        # Determine the corresponding letter
        varkType_letter = ''
        if max_value == ldVarkValueV:
            varkType_letter = 'Visual'
        elif max_value == ldVarkValueA:
            varkType_letter = 'Auditory'
        elif max_value == ldVarkValueR:
            varkType_letter = 'Reading/Writing'
        elif max_value == ldVarkValueK:
            varkType_letter = 'Kinesthetic'

        doc_ref_stu = collection_path_stu.update(
            {
                'valueA': ldVarkValueV,
                'valueR': ldVarkValueA,
                'valueK': ldVarkValueR,
                'valueV': ldVarkValueK,
                'varkType': varkType_letter
            }
        )

        doc_ref_sub = collection_path_sub.set(
            {
                'selectedTeacherID': selectedTeacherID,
                'selectedStudentID': selectedStudentID,
                'selectedSubjectID': selectedSubjectID,
                'teacherSentimentV': teacherSentimentV,
                'studentSentimentV': studentSentimentV,
                'teacherSentimentA': teacherSentimentA,
                'studentSentimentA': studentSentimentA,
                'teacherSentimentR': teacherSentimentR,
                'studentSentimentR': studentSentimentR,
                'teacherSentimentK': teacherSentimentK,
                'studentSentimentK': studentSentimentK,
                'highestEmotionV': highestEmotionV,
                'highestEmotionA': highestEmotionA,
                'highestEmotionR': highestEmotionR,
                'highestEmotionK': highestEmotionK,
                'emotionPercentageV': emotionPercentageV,
                'emotionPercentageA': emotionPercentageA,
                'emotionPercentageR': emotionPercentageR,
                'emotionPercentageK': emotionPercentageK,
                'happinessValueV': happinessValueV,
                'happinessValueA': happinessValueA,
                'happinessValueR': happinessValueR,
                'happinessValueK': happinessValueK,
                'ldVarkValueV': ldVarkValueV,
                'ldVarkValueA': ldVarkValueA,
                'ldVarkValueR': ldVarkValueR,
                'ldVarkValueK': ldVarkValueK,
                'generatedplanV1': generatedplanV1,
                'generatedplanV2': generatedplanV2,
                'generatedplanV3': generatedplanV3,
                'generatedplanV4': generatedplanV4,
                'generatedplanA1': generatedplanA1,
                'generatedplanA2': generatedplanA2,
                'generatedplanA3': generatedplanA3,
                'generatedplanA4': generatedplanA4,
                'generatedplanR1': generatedplanR1,
                'generatedplanR2': generatedplanR2,
                'generatedplanR3': generatedplanR3,
                'generatedplanR4': generatedplanR4,
                'generatedplanK1': generatedplanK1,
                'generatedplanK2': generatedplanK2,
                'generatedplanK3': generatedplanK3,
                'generatedplanK4': generatedplanK4
            }
        )

        print("Student data updated successfully: " + str(doc_ref_stu))
        print("Subject data added successfully:" + str(doc_ref_sub))

        return jsonify(
            {'message': 'Data updated successfully!'}
        )

    except Exception as e:
        # Log the error and return a 500 Internal Server Error response
        print(str(e))
        return jsonify({'error': 'Internal Server Error'}), 500


if __name__ == '__main__':
    app.run(debug=True)
