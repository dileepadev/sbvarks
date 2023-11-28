const teacherDropdown = document.getElementById('teacher-dropdown');
const studentDropdown = document.getElementById('student-dropdown');
const subjectDropdown = document.getElementById('subject-dropdown');

const studentName = document.getElementById('student-name');
const studentGrade = document.getElementById('student-grade');
const studentPicture = document.getElementById('img-avatar');

const btnAddBehaviour = document.getElementById('btn-add-behaviour');

const teacherFeedbackV = document.getElementById('teacher-feedback-v');
const studentFeedbackV = document.getElementById('student-feedback-v');
const teacherFeedbackA = document.getElementById('teacher-feedback-a');
const studentFeedbackA = document.getElementById('student-feedback-a');
const teacherFeedbackR = document.getElementById('teacher-feedback-r');
const studentFeedbackR = document.getElementById('student-feedback-r');
const teacherFeedbackK = document.getElementById('teacher-feedback-k');
const studentFeedbackK = document.getElementById('student-feedback-k');

let selectedTeacherID = null;
let selectedStudentID = null;
let selectedSubjectID = null;

const successAlert = document.querySelector('.alert-success');
const errorAlert = document.querySelector('.alert-danger');

// Hide the success and error alerts initially
successAlert.style.display = 'none';
errorAlert.style.display = 'none';

const teacherSentimentV = document.getElementById('teacherSentimentV');
const studentSentimentV = document.getElementById('studentSentimentV');
const teacherSentimentA = document.getElementById('teacherSentimentA');
const studentSentimentA = document.getElementById('studentSentimentA');
const teacherSentimentR = document.getElementById('teacherSentimentR');
const studentSentimentR = document.getElementById('studentSentimentR');
const teacherSentimentK = document.getElementById('teacherSentimentK');
const studentSentimentK = document.getElementById('studentSentimentK');

const ldStudentName = document.getElementById('ldStudentName');
const ldStudentGrade = document.getElementById('ldStudentGrade');
const ldStudentTeacher = document.getElementById('ldStudentTeacher');
const ldStudentSubject = document.getElementById('ldStudentSubject');

const videoInputV = document.querySelector('#videoInput-v');
const videoInputA = document.querySelector('#videoInput-a');
const videoInputR = document.querySelector('#videoInput-r');
const videoInputK = document.querySelector('#videoInput-k');

const videoProcessingLoaderV = document.querySelector('#btn-add-behaviour-spinner-v');
const videoProcessingLoaderA = document.querySelector('#btn-add-behaviour-spinner-a');
const videoProcessingLoaderR = document.querySelector('#btn-add-behaviour-spinner-r');
const videoProcessingLoaderK = document.querySelector('#btn-add-behaviour-spinner-k');

// Hide the video processing loaders initially
videoProcessingLoaderV.classList.add('d-none');
videoProcessingLoaderA.classList.add('d-none');
videoProcessingLoaderR.classList.add('d-none');
videoProcessingLoaderK.classList.add('d-none');

// const textSuccessV = document.querySelector('#text-success-v');
// const textSuccessA = document.querySelector('#text-success-a');
// const textSuccessR = document.querySelector('#text-success-r');
// const textSuccessK = document.querySelector('#text-success-k');

// Hide the text success initially
// textSuccessV.classList.add('d-none');
// textSuccessA.classList.add('d-none');
// textSuccessR.classList.add('d-none');
// textSuccessK.classList.add('d-none');

// Emotional Values
const highestEmotionV = document.getElementById('highestEmotionV');
const highestEmotionA = document.getElementById('highestEmotionA');
const highestEmotionR = document.getElementById('highestEmotionR');
const highestEmotionK = document.getElementById('highestEmotionK');
const emotionPercentageV = document.getElementById('emotionPercentageV');
const emotionPercentageA = document.getElementById('emotionPercentageA');
const emotionPercentageR = document.getElementById('emotionPercentageR');
const emotionPercentageK = document.getElementById('emotionPercentageK');
const happinessValueV = document.getElementById('happinessValueV');
const happinessValueA = document.getElementById('happinessValueA');
const happinessValueR = document.getElementById('happinessValueR');
const happinessValueK = document.getElementById('happinessValueK');

const videoProcessFrameV = document.querySelector('#video-process-frame-v');
const videoProcessFrameA = document.querySelector('#video-process-frame-a');
const videoProcessFrameR = document.querySelector('#video-process-frame-r');
const videoProcessFrameK = document.querySelector('#video-process-frame-k');

const videoUploadSuccessTextV = document.querySelector('#video-upload-success-text-v');
const videoUploadSuccessTextA = document.querySelector('#video-upload-success-text-a');
const videoUploadSuccessTextR = document.querySelector('#video-upload-success-text-r');
const videoUploadSuccessTextK = document.querySelector('#video-upload-success-text-k');

const emotionDetectionSuccessTextV = document.querySelector('#emotion-detection-success-text-v');
const emotionDetectionSuccessTextA = document.querySelector('#emotion-detection-success-text-a');
const emotionDetectionSuccessTextR = document.querySelector('#emotion-detection-success-text-r');
const emotionDetectionSuccessTextK = document.querySelector('#emotion-detection-success-text-k');

const emotionValuesGeneratedTextV = document.querySelector('#emotion-values-generated-text-v');
const emotionValuesGeneratedTextA = document.querySelector('#emotion-values-generated-text-a');
const emotionValuesGeneratedTextR = document.querySelector('#emotion-values-generated-text-r');
const emotionValuesGeneratedTextK = document.querySelector('#emotion-values-generated-text-k');

const ldVarkValueV = document.querySelector('#ldVarkValueV');
const ldVarkValueA = document.querySelector('#ldVarkValueA');
const ldVarkValueR = document.querySelector('#ldVarkValueR');
const ldVarkValueK = document.querySelector('#ldVarkValueK');

const ldVarkValueVL = document.querySelector('#ldVarkValueVL');
const ldVarkValueAL = document.querySelector('#ldVarkValueAL');
const ldVarkValueRL = document.querySelector('#ldVarkValueRL');
const ldVarkValueKL = document.querySelector('#ldVarkValueKL');

const generatedplanV1 = document.querySelector('#generatedplanV1');
const generatedplanV2 = document.querySelector('#generatedplanV2');
const generatedplanV3 = document.querySelector('#generatedplanV3');
const generatedplanV4 = document.querySelector('#generatedplanV4');

const generatedplanA1 = document.querySelector('#generatedplanA1');
const generatedplanA2 = document.querySelector('#generatedplanA2');
const generatedplanA3 = document.querySelector('#generatedplanA3');
const generatedplanA4 = document.querySelector('#generatedplanA4');

const generatedplanR1 = document.querySelector('#generatedplanR1');
const generatedplanR2 = document.querySelector('#generatedplanR2');
const generatedplanR3 = document.querySelector('#generatedplanR3');
const generatedplanR4 = document.querySelector('#generatedplanR4');

const generatedplanK1 = document.querySelector('#generatedplanK1');
const generatedplanK2 = document.querySelector('#generatedplanK2');
const generatedplanK3 = document.querySelector('#generatedplanK3');
const generatedplanK4 = document.querySelector('#generatedplanK4');

const spinnerText = document.querySelector('#spinner-text');

const btnAddGeneratePlan = document.querySelector('#btn-add-generate-plan');
const btnSubmitPlan = document.querySelector('#btn-submit-plan');

const submittingLoader = document.querySelector('#btn-submit-plan-spinner-r');
submittingLoader.classList.add('d-none');

// Hide the success text v
videoUploadSuccessTextV.style.display = 'none';
emotionDetectionSuccessTextV.style.display = 'none';
emotionValuesGeneratedTextV.style.display = 'none';

// Hide the success text a
videoUploadSuccessTextA.style.display = 'none';
emotionDetectionSuccessTextA.style.display = 'none';
emotionValuesGeneratedTextA.style.display = 'none';

// Hide the success text r
videoUploadSuccessTextR.style.display = 'none';
emotionDetectionSuccessTextR.style.display = 'none';
emotionValuesGeneratedTextR.style.display = 'none';

// Hide the success text k
videoUploadSuccessTextK.style.display = 'none';
emotionDetectionSuccessTextK.style.display = 'none';
emotionValuesGeneratedTextK.style.display = 'none';

// Hide the success and error alerts initially
successAlert.style.display = 'none';
errorAlert.style.display = 'none';

// Fetch teacher details from the Flask route
fetch('/teachers')
    .then(response => response.json())
    .then(teachers => {
        teachers.forEach(teacher => {
            const option = document.createElement('option');
            option.value = teacher.uuid;
            option.textContent = `${teacher.title} ${teacher.firstName} ${teacher.lastName} - ${teacher.uuid}`;
            teacherDropdown.appendChild(option);
            console.log('LOG 1: Teacher dropdown changed')
        });
    })
    .catch(error => {
        console.error('Error fetching teacher details:', error);
    });

// Event listener for teacher dropdown change
teacherDropdown.addEventListener('change', () => {
    console.log('LOG 2: Selected teacher: ', teacherDropdown.value);
    selectedTeacherID = teacherDropdown.value;

    // Reset the "Select Student" dropdown
    studentDropdown.innerHTML = '<option value="">Please select the teacher first</option>';

    // Reset the "Select Subject" dropdown
    subjectDropdown.value = '';

    // Reset the student details
    studentName.textContent = `Please select a student`;
    studentGrade.textContent = 'Please select a student';
    studentPicture.src = '/static/images/avatar.png';

    if (selectedTeacherID) {
        console.log('LOG 3: Starting fetchStudentsForTeacher')
        fetchStudentsForTeacher(selectedTeacherID);
        ldStudentTeacher.textContent = teacherDropdown.options[teacherDropdown.selectedIndex].text;
    }
});


// Function to fetch students for a selected teacher
function fetchStudentsForTeacher(teacherUuid) {
    // Fetch student details from the Flask route for the selected teacher
    fetch(`/teachers/${teacherUuid}/students`)
        .then(response => response.json())
        .then(students => {
            console.log('LOG 4: Students fetched')
            populateStudentDropdown(teacherUuid, students);
        })
        .catch(error => {
            console.error('Error fetching student details:', error);
        });
}

// Function to populate student dropdown with options
function populateStudentDropdown(teacherUuid, students) {
    // Clear existing options in student dropdown
    studentDropdown.innerHTML = '';
    const noStudentsOption = document.createElement('option');

    if (students.length === 0) {
        // Display "This teacher has no students" message and disable the dropdown
        noStudentsOption.textContent = 'This teacher has no students';
        selectedStudentID = null;
        studentName.textContent = `Please select a student`;
        studentGrade.textContent = 'Please select a student';
        studentPicture.src = '/static/images/avatar.png';
        studentDropdown.appendChild(noStudentsOption);
        studentDropdown.disabled = true;
    } else {
        students.forEach(student => {
            const option = document.createElement('option');
            option.value = student.index;
            option.textContent = `${student.index} - ${student.firstName} ${student.lastName}`;
            studentDropdown.appendChild(option);
            console.log('LOG 5: Student dropdown updated')
            selectedStudentID = students[0].index;
            studentName.textContent = `${students[0].firstName} ${students[0].lastName}`;
            studentGrade.textContent = students[0].grade;
            studentPicture.src = students[0].picture;
            ldStudentName.textContent = `${students[0].firstName} ${students[0].lastName}`;
            ldStudentGrade.textContent = students[0].grade;
        });
        studentDropdown.disabled = false;
    }
}

// Event listener for student dropdown change
studentDropdown.addEventListener('change', () => {
    console.log('LOG 6: Selected student: ', studentDropdown.value);
    selectedStudentID = studentDropdown.value;
    fetch(`/teachers/${teacherDropdown.value}/students/${studentDropdown.value}`)
        .then(response => response.json())
        .then(student => {
            Student = student;
            studentName.textContent = `${student.firstName} ${student.lastName}`;
            studentGrade.textContent = student.grade;
            studentPicture.src = student.picture;
            ldStudentName.textContent = `${student.firstName} ${student.lastName}`;
            ldStudentGrade.textContent = student.grade;
            console.log('LOG 7: Fetched single student: ', student);
        })
        .catch(error => {
            console.error('Error fetching student details:', error);
        });
});

// Function to fetch subjects for a selected student
fetch('/subjects')
    .then(response => response.json())
    .then(subjects => {
        subjects.forEach(subject => {
            const option = document.createElement('option');
            option.value = subject.name;
            option.textContent = `${subject.name}`;
            subjectDropdown.appendChild(option);
        });
    })
    .catch(error => {
        console.error('Error fetching teacher details:', error);
    });

// Event listener for subject dropdown change
subjectDropdown.addEventListener('change', () => {
    console.log('LOG 8: Selected subject: ', subjectDropdown.value);
    selectedSubjectID = subjectDropdown.value;
    ldStudentSubject.textContent = subjectDropdown.value;
});

// Function to addStudentButton
btnAddBehaviour.addEventListener('click', function (event) {
    // Prevent the default form submission behavior
    event.preventDefault();

    // Check if the form is valid
    const form = document.querySelector('.was-validated');
    if (form.checkValidity()) {
        // Check if the required values have valid selections
        if (selectedTeacherID && selectedStudentID && selectedSubjectID &&
            teacherFeedbackV.value && studentFeedbackV.value && document.getElementById('videoInput-v').files[0] &&
            teacherFeedbackA.value && studentFeedbackA.value && document.getElementById('videoInput-a').files[0] &&
            teacherFeedbackR.value && studentFeedbackR.value && document.getElementById('videoInput-r').files[0] &&
            teacherFeedbackK.value && studentFeedbackK.value && document.getElementById('videoInput-k').files[0]
        ) {
            // Create an object with the form data
            const formData = {
                teacherFeedbackV: teacherFeedbackV.value,
                studentFeedbackV: studentFeedbackV.value,
                teacherFeedbackA: teacherFeedbackA.value,
                studentFeedbackA: studentFeedbackA.value,
                teacherFeedbackR: teacherFeedbackR.value,
                studentFeedbackR: studentFeedbackR.value,
                teacherFeedbackK: teacherFeedbackK.value,
                studentFeedbackK: studentFeedbackK.value,
            };

            // Display the success alert
            // successAlert.style.display = 'block';
            // errorAlert.style.display = 'none';

            console.log("LOG 9: Student Behaviour Added");
            console.log('--- SELECTED STUDENT ---');
            console.log('Teacher ID: ', selectedTeacherID);
            console.log('Student ID: ', selectedStudentID);
            console.log('Subject ID: ', selectedSubjectID);
            console.log('--- STUDENT BEHAVIOUR ---');
            console.log('(V) Teacher Feedback: ', formData.teacherFeedbackV);
            console.log('(V) Student Behaviour: ', formData.studentFeedbackV);
            // console.log('(V) Student Video: ', formData.studentVideoV);
            console.log('(A) Teacher Feedback: ', formData.teacherFeedbackA);
            console.log('(A) Student Behaviour: ', formData.studentFeedbackA);
            // console.log('(A) Student Video: ', formData.studentVideoA);
            console.log('(R) Teacher Feedback: ', formData.teacherFeedbackR);
            console.log('(R) Student Behaviour: ', formData.studentFeedbackR);
            // console.log('(R) Student Video: ', formData.studentVideoR);
            console.log('(K) Teacher Feedback: ', formData.teacherFeedbackK);
            console.log('(K) Student Behaviour: ', formData.studentFeedbackK);
            // console.log('(K) Student Video: ', formData.studentVideoK);
            // Send the form data to the server for processing and sentiment analysis
            fetch('/behavior', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(formData)
            })
                .then(response => response.json())
                .then(data => {
                    SentimentAnalysis = data;
                    // console.log('--- SENTIMENT ANALYSIS ---');
                    console.log('(V) Teacher Sentiment: ', data.teacherSentimentV);
                    console.log('(V) Student Sentiment: ', data.studentSentimentV);
                    console.log('(A) Teacher Sentiment: ', data.teacherSentimentA);
                    console.log('(A) Student Sentiment: ', data.studentSentimentA);
                    console.log('(R) Teacher Sentiment: ', data.teacherSentimentR);
                    console.log('(R) Student Sentiment: ', data.studentSentimentR);
                    console.log('(K) Teacher Sentiment: ', data.teacherSentimentK);
                    console.log('(K) Student Sentiment: ', data.studentSentimentK);
                    // Display result of sentiment analysis
                    teacherSentimentV.textContent = data.teacherSentimentV;
                    studentSentimentV.textContent = data.studentSentimentV;
                    teacherSentimentA.textContent = data.teacherSentimentA;
                    studentSentimentA.textContent = data.studentSentimentA;
                    teacherSentimentR.textContent = data.teacherSentimentR;
                    studentSentimentR.textContent = data.studentSentimentR;
                    teacherSentimentK.textContent = data.teacherSentimentK;
                    studentSentimentK.textContent = data.studentSentimentK;
                    // Visual Video Analysis
                    videoAnalysisV();

                })
                .catch(error => {
                    // Display an error message if there is a server error
                    successAlert.style.display = 'none';
                    errorAlert.style.display = 'block';
                    console.error('Error:', error);
                });
        } else {
            // Display the error alert with the appropriate message
            successAlert.style.display = 'none';
            errorAlert.style.display = 'block';

            if (!selectedTeacherID || !selectedStudentID || !selectedSubjectID) {
                displayErrorAlert('Error', 'Please select all required values in the Step 1 section.');
            } else {
                displayErrorAlert('Error', 'Please provide feedback for both teacher and student.')
            }

            console.log('LOG 10: Error');
            console.log('Please select all required values and provide feedback.');
        }
    } else {
        // Display the error alert for an invalid form
        successAlert.style.display = 'none';
        errorAlert.style.display = 'block';
        displayErrorAlert('Error', 'Please fill out all required fields.')

        console.log('Please fill out all required fields.');
    }
});

// Top emotion finder
function displayTopEmotion(data) {
    let topEmotion = null;
    let topEmotionValue = 0;

    for (const emotion in data) {
        const emotionValue = data[emotion];
        if (emotionValue > topEmotionValue) {
            topEmotionValue = emotionValue;
            topEmotion = emotion;
        }
    }

    if (topEmotion !== null) {
        console.log('Top Emotion:', topEmotion);
        console.log('Top Emotion Value:', topEmotionValue);
        return [topEmotion, topEmotionValue.toFixed(2)];
    } else {
        console.log('No top emotion found.');
    }
}


function getVideoFrame(videoPath, style) {
    spinnerText.textContent = 'Detecting emotions...';
    if (style === "V") {
        videoProcessFrameV.style.display = 'block';
        videoProcessingLoaderV.classList.remove('d-none');
    } else if (style === "A") {
        videoProcessFrameA.style.display = 'block';
        videoProcessingLoaderA.classList.remove('d-none');
    } else if (style === "R") {
        videoProcessFrameR.style.display = 'block';
        videoProcessingLoaderR.classList.remove('d-none');
    } else if (style === "K") {
        videoProcessFrameK.style.display = 'block';
        videoProcessingLoaderK.classList.remove('d-none');
    }

    const xhr = new XMLHttpRequest();
    xhr.open('GET', '/video_feed?videoPath=' + encodeURIComponent(videoPath), true);

    // Event handler for when the AJAX request receives new frames
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 3 && xhr.status === 200) {
            if (style === "V") {
                videoProcessFrameV.src = '/video_feed?videoPath=' + encodeURIComponent(videoPath);
            } else if (style === "A") {
                videoProcessFrameA.src = '/video_feed?videoPath=' + encodeURIComponent(videoPath);
            } else if (style === "R") {
                videoProcessFrameR.src = '/video_feed?videoPath=' + encodeURIComponent(videoPath);
            } else if (style === "K") {
                videoProcessFrameK.src = '/video_feed?videoPath=' + encodeURIComponent(videoPath);
            }
        } else if (xhr.readyState === 4 && xhr.status === 200) {
            try {
                console.log('Video processing complete.');
                if (style === "V") {
                    videoProcessingLoaderV.classList.add('d-none');
                    emotionDetectionSuccessTextV.style.display = 'block';
                } else if (style === "A") {
                    videoProcessingLoaderA.classList.add('d-none');
                    emotionDetectionSuccessTextA.style.display = 'block';
                } else if (style === "R") {
                    videoProcessingLoaderR.classList.add('d-none');
                    emotionDetectionSuccessTextR.style.display = 'block';
                } else if (style === "K") {
                    videoProcessingLoaderK.classList.add('d-none');
                    emotionDetectionSuccessTextK.style.display = 'block';
                }

                // Fetch emotional values after video processing is complete
                fetchEmotionalValues(videoPath, style);
            } catch (error) {
                console.error('Error:', error);
                if (style === "V") {
                    videoProcessingLoaderV.classList.add('d-none');
                    emotionDetectionSuccessTextV.style.display = 'block';
                    emotionDetectionSuccessTextV.textContent = 'Error processing video.';
                } else if (style === "A") {
                    videoProcessingLoaderA.classList.add('d-none');
                    emotionDetectionSuccessTextA.style.display = 'block';
                    emotionDetectionSuccessTextA.textContent = 'Error processing video.';
                } else if (style === "R") {
                    videoProcessingLoaderR.classList.add('d-none');
                    emotionDetectionSuccessTextR.style.display = 'block';
                    emotionDetectionSuccessTextR.textContent = 'Error processing video.';
                } else if (style === "K") {
                    videoProcessingLoaderK.classList.add('d-none');
                    emotionDetectionSuccessTextK.style.display = 'block';
                    emotionDetectionSuccessTextK.textContent = 'Error processing video.';
                }
            }
        }
    };

    xhr.send();
}

function fetchEmotionalValues(videoPath, style) {
    spinnerText.textContent = 'Generating emotional values...';
    if (style === "V") {
        videoProcessingLoaderV.classList.remove('d-none');
    } else if (style === "A") {
        videoProcessingLoaderA.classList.remove('d-none');
    } else if (style === "R") {
        videoProcessingLoaderR.classList.remove('d-none');
    } else if (style === "K") {
        videoProcessingLoaderK.classList.remove('d-none');
    }

    fetch(`/emotional_values?videoPath=${encodeURIComponent(videoPath)}`)
        .then(response => response.json())
        .then(data => {
            console.log('Emotional Values:', data);
            if (style === "V") {
                videoProcessingLoaderV.classList.add('d-none');
                emotionValuesGeneratedTextV.style.display = 'block';
            } else if (style === "A") {
                videoProcessingLoaderA.classList.add('d-none');
                emotionValuesGeneratedTextA.style.display = 'block';
            } else if (style === "R") {
                videoProcessingLoaderR.classList.add('d-none');
                emotionValuesGeneratedTextR.style.display = 'block';
            } else if (style === "K") {
                videoProcessingLoaderK.classList.add('d-none');
                emotionValuesGeneratedTextK.style.display = 'block';
            }
            // Top Emotion
            let topEmotions = displayTopEmotion(data);
            Emotions = data;
            if (style === "V") {
                highestEmotionV.textContent = topEmotions[0];
                emotionPercentageV.textContent = topEmotions[1] + '%';
                happinessValueV.textContent = data.Happy.toFixed(2) + '%';
                videoAnalysisA();
            } else if (style === "A") {
                highestEmotionA.textContent = topEmotions[0];
                emotionPercentageA.textContent = topEmotions[1] + '%';
                happinessValueA.textContent = data.Happy.toFixed(2) + '%';
                videoAnalysisR();
            } else if (style === "R") {
                highestEmotionR.textContent = topEmotions[0];
                emotionPercentageR.textContent = topEmotions[1] + '%';
                happinessValueR.textContent = data.Happy.toFixed(2) + '%';
                videoAnalysisK();
            } else if (style === "K") {
                highestEmotionK.textContent = topEmotions[0];
                emotionPercentageK.textContent = topEmotions[1] + '%';
                happinessValueK.textContent = data.Happy.toFixed(2) + '%';
                console.log('ALL DONE!')
                printDetails();
                // Enable the submit button and hide the loader
                btnAddBehaviour.removeAttribute('disabled');
            }
        })
        .catch(error => {
            console.error('Error fetching emotional values:', error);
            if (style === "V") {
                videoProcessingLoaderV.classList.add('d-none');
                emotionValuesGeneratedTextV.style.display = 'block';
                emotionValuesGeneratedTextV.textContent = 'Error fetching emotional values.';
            } else if (style === "A") {
                videoProcessingLoaderA.classList.add('d-none');
                emotionValuesGeneratedTextA.style.display = 'block';
                emotionValuesGeneratedTextA.textContent = 'Error fetching emotional values.';
            } else if (style === "R") {
                videoProcessingLoaderR.classList.add('d-none');
                emotionValuesGeneratedTextR.style.display = 'block';
                emotionValuesGeneratedTextR.textContent = 'Error fetching emotional values.';
            } else if (style === "K") {
                videoProcessingLoaderK.classList.add('d-none');
                emotionValuesGeneratedTextK.style.display = 'block';
                emotionValuesGeneratedTextK.textContent = 'Error fetching emotional values.';
            }
        });
}

// Visual Video Analysis
function videoAnalysisV() {
    const videoDataV = videoInputV.files[0];

    // Disable the submit button and show the loader
    btnAddBehaviour.setAttribute('disabled', 'true');
    videoProcessingLoaderV.classList.remove('d-none');
    spinnerText.textContent = 'Uploading visual video...';

    // Process each video here (can send them to the server for analysis)
    console.log('Visual Video:', videoDataV);

    // can now send each video file to the server for analysis
    const formData = new FormData();
    formData.append('video', videoDataV);

    fetch('/upload_video', {
        method: 'POST',
        body: formData
    })
        .then(response => response.json())
        .then(data => {
            console.log('---VISUAL---');
            console.log('Video uploaded at:', data);
            // Display the success alert
            // successAlert.style.display = 'block';
            // errorAlert.style.display = 'none';

            videoProcessingLoaderV.classList.add('d-none');
            videoUploadSuccessTextV.style.display = 'block';
            getVideoFrame(data, "V");

            // Audio Video Analysis
            // videoAnalysisA();

            // Enable the submit button and hide the loader
            // btnAddBehaviour.removeAttribute('disabled');
            // videoProcessingLoaderV.classList.add('d-none');
            // textSuccessV.classList.remove('d-none');
        })
        .catch(error => {
            console.error('Error:', error);

            // Enable the submit button and hide the loader in case of an error
            btnAddBehaviour.removeAttribute('disabled');
            videoProcessingLoaderV.classList.add('d-none');
        });
}

// Audio Video Analysis
function videoAnalysisA() {
    const videoDataA = videoInputA.files[0];

    // Disable the submit button and show the loader
    btnAddBehaviour.setAttribute('disabled', 'true');
    videoProcessingLoaderA.classList.remove('d-none');
    spinnerText.textContent = 'Uploading auditory video...';

    // Process each video here (can send them to the server for analysis)
    console.log('Auditory Video:', videoDataA);

    // can now send each video file to the server for analysis
    const formData = new FormData();
    formData.append('video', videoDataA);

    fetch('/upload_video', {
        method: 'POST',
        body: formData
    })
        .then(response => response.json())
        .then(data => {
            console.log('---AUDITORY---');
            console.log('Video uploaded at:', data);
            // Display the success alert
            // successAlert.style.display = 'block';
            // errorAlert.style.display = 'none';

            videoProcessingLoaderA.classList.add('d-none');
            videoUploadSuccessTextA.style.display = 'block';
            getVideoFrame(data, "A");

            // Audio Video Analysis
            // videoAnalysisA();

            // Enable the submit button and hide the loader
            // btnAddBehaviour.removeAttribute('disabled');
            // videoProcessingLoaderV.classList.add('d-none');
            // textSuccessV.classList.remove('d-none');
        })
        .catch(error => {
            console.error('Error:', error);

            // Enable the submit button and hide the loader in case of an error
            btnAddBehaviour.removeAttribute('disabled');
            videoProcessingLoaderA.classList.add('d-none');
        });
}

// ReadWrite Video Analysis
function videoAnalysisR() {
    const videoDataR = videoInputR.files[0];

    // Disable the submit button and show the loader
    btnAddBehaviour.setAttribute('disabled', 'true');
    videoProcessingLoaderR.classList.remove('d-none');
    spinnerText.textContent = 'Uploading reading/writing video...';

    // Process each video here (can send them to the server for analysis)
    console.log('Reading/Writing Video:', videoDataR);

    // can now send each video file to the server for analysis
    const formData = new FormData();
    formData.append('video', videoDataR);

    fetch('/upload_video', {
        method: 'POST',
        body: formData
    })
        .then(response => response.json())
        .then(data => {
            console.log('---READING/WRITING---');
            console.log('Video uploaded at:', data);
            // Display the success alert
            // successAlert.style.display = 'block';
            // errorAlert.style.display = 'none';

            videoProcessingLoaderR.classList.add('d-none');
            videoUploadSuccessTextR.style.display = 'block';
            getVideoFrame(data, "R");

            // Audio Video Analysis
            // videoAnalysisA();

            // Enable the submit button and hide the loader
            // btnAddBehaviour.removeAttribute('disabled');
            // videoProcessingLoaderV.classList.add('d-none');
            // textSuccessV.classList.remove('d-none');
        })
        .catch(error => {
            console.error('Error:', error);

            // Enable the submit button and hide the loader in case of an error
            btnAddBehaviour.removeAttribute('disabled');
            videoProcessingLoaderR.classList.add('d-none');
        });
}

// Kinesthetic Video Analysis
function videoAnalysisK() {
    const videoDataK = videoInputK.files[0];

    // Disable the submit button and show the loader
    btnAddBehaviour.setAttribute('disabled', 'true');
    videoProcessingLoaderK.classList.remove('d-none');
    spinnerText.textContent = 'Uploading kinesthetic video...';

    // Process each video here ( can send them to the server for analysis)
    console.log('Kinesthetic Video:', videoDataK);

    // can now send each video file to the server for analysis
    const formData = new FormData();
    formData.append('video', videoDataK);

    fetch('/upload_video', {
        method: 'POST',
        body: formData
    })
        .then(response => response.json())
        .then(data => {
            console.log('---KINESTHETIC---');
            console.log('Video uploaded at:', data);
            // Display the success alert
            // successAlert.style.display = 'block';
            // errorAlert.style.display = 'none';

            videoProcessingLoaderK.classList.add('d-none');
            videoUploadSuccessTextK.style.display = 'block';
            getVideoFrame(data, "K");

            // Audio Video Analysis
            // videoAnalysisA();

            // Enable the submit button and hide the loader
            // btnAddBehaviour.removeAttribute('disabled');
            // videoProcessingLoaderV.classList.add('d-none');
            // textSuccessV.classList.remove('d-none');
        })
        .catch(error => {
            console.error('Error:', error);

            // Enable the submit button and hide the loader in case of an error
            btnAddBehaviour.removeAttribute('disabled');
            videoProcessingLoaderK.classList.add('d-none');
        });
}

function displayErrorAlert(title, message) {
    const errorAlertHeading = errorAlert.querySelector('.alert-heading');
    const errorAlertMessage = errorAlert.querySelector('p:first-of-type');

    errorAlertHeading.textContent = title;
    errorAlertMessage.textContent = message;

    successAlert.style.display = 'none';
    errorAlert.style.display = 'block';
}

class VARKCal {
    constructor(xteacherSentimentV, xstudentSentimentV, xteacherSentimentA, xstudentSentimentA, xteacherSentimentR, xstudentSentimentR, xteacherSentimentK, xstudentSentimentK, xhighestEmotionV, xhighestemotionPercentageV, xhighestEmotionA, xhighestemotionPercentageA, xhighestEmotionR, xhighestemotionPercentageR, xhighestEmotionK, xhighestemotionPercentageK, xhappyValueV, xhappyValueA, xhappyValueR, xhappyValueK) {
        this.xteacherSentimentV = xteacherSentimentV;
        this.xstudentSentimentV = xstudentSentimentV;
        this.xteacherSentimentA = xteacherSentimentA;
        this.xstudentSentimentA = xstudentSentimentA;
        this.xteacherSentimentR = xteacherSentimentR;
        this.xstudentSentimentR = xstudentSentimentR;
        this.xteacherSentimentK = xteacherSentimentK;
        this.xstudentSentimentK = xstudentSentimentK;
        this.xhighestEmotionV = xhighestEmotionV;
        this.xhighestemotionPercentageV = xhighestemotionPercentageV;
        this.xhighestEmotionA = xhighestEmotionA;
        this.xhighestemotionPercentageA = xhighestemotionPercentageA;
        this.xhighestEmotionR = xhighestEmotionR;
        this.xhighestemotionPercentageR = xhighestemotionPercentageR;
        this.xhighestEmotionK = xhighestEmotionK;
        this.xhighestemotionPercentageK = xhighestemotionPercentageK;
        this.xhappyValueV = xhappyValueV;
        this.xhappyValueA = xhappyValueA;
        this.xhappyValueR = xhappyValueR;
        this.xhappyValueK = xhappyValueK;
    }
}


function printDetails() {
    console.log("--- GENERATE PLAN ---");
    console.log("Teacher ID: ", selectedTeacherID);
    console.log("Student ID: ", selectedStudentID);
    console.log("Subject ID: ", selectedSubjectID);
    console.log("Teacher Sentiment (V): ", teacherSentimentV.textContent);
    console.log("Student Sentiment (V): ", studentSentimentV.textContent);
    console.log("Teacher Sentiment (A): ", teacherSentimentA.textContent);
    console.log("Student Sentiment (A): ", studentSentimentA.textContent);
    console.log("Teacher Sentiment (R): ", teacherSentimentR.textContent);
    console.log("Student Sentiment (R): ", studentSentimentR.textContent);
    console.log("Teacher Sentiment (K): ", teacherSentimentK.textContent);
    console.log("Student Sentiment (K): ", studentSentimentK.textContent);
    console.log("Highest Emotion (V): ", highestEmotionV.textContent);
    console.log("Highest Emotion (A): ", highestEmotionA.textContent);
    console.log("Highest Emotion (R): ", highestEmotionR.textContent);
    console.log("Highest Emotion (K): ", highestEmotionK.textContent);
    console.log("Emotion Percentage (V): ", emotionPercentageV.textContent);
    console.log("Emotion Percentage (A): ", emotionPercentageA.textContent);
    console.log("Emotion Percentage (R): ", emotionPercentageR.textContent);
    console.log("Emotion Percentage (K): ", emotionPercentageK.textContent);
    console.log("Happiness Value (V): ", happinessValueV.textContent);
    console.log("Happiness Value (A): ", happinessValueA.textContent);
    console.log("Happiness Value (R): ", happinessValueR.textContent);
    console.log("Happiness Value (K): ", happinessValueK.textContent);


    // const xteacherSentimentV = "Positive";
    // const xstudentSentimentV = "Neutral";
    // const xteacherSentimentA = "Negative";
    // const xstudentSentimentA = "Positive";
    // const xteacherSentimentR = "Neutral";
    // const xstudentSentimentR = "Positive";
    // const xteacherSentimentK = "Positive";
    // const xstudentSentimentK = "Negative";
    // const xhighestEmotionV = "Happy";
    // const xhighestemotionPercentageV = 80;
    // const xhighestEmotionA = "Sad";
    // const xhighestemotionPercentageA = 60;
    // const xhighestEmotionR = "Neutral";
    // const xhighestemotionPercentageR = 40;
    // const xhighestEmotionK = "Angry";
    // const xhighestemotionPercentageK = 70;
    // const xhappyValueV = 80;
    // const xhappyValueA = 60;
    // const xhappyValueR = 40;
    // const xhappyValueK = 70;

    const xteacherSentimentV = teacherSentimentV.textContent;
    const xstudentSentimentV = studentSentimentV.textContent;
    const xteacherSentimentA = teacherSentimentA.textContent;
    const xstudentSentimentA = studentSentimentA.textContent;
    const xteacherSentimentR = teacherSentimentR.textContent;
    const xstudentSentimentR = studentSentimentR.textContent;
    const xteacherSentimentK = teacherSentimentK.textContent;
    const xstudentSentimentK = studentSentimentK.textContent;
    const xhighestEmotionV = highestEmotionV.textContent;
    const xhighestemotionPercentageV = parseFloat(emotionPercentageV.textContent.replace('%', '')).toFixed(2);
    const xhighestEmotionA = highestEmotionA.textContent;
    const xhighestemotionPercentageA = parseFloat(emotionPercentageA.textContent.replace('%', '')).toFixed(2);
    const xhighestEmotionR = highestEmotionR.textContent;
    const xhighestemotionPercentageR = parseFloat(emotionPercentageR.textContent.replace('%', '')).toFixed(2);
    const xhighestEmotionK = highestEmotionK.textContent;
    const xhighestemotionPercentageK = parseFloat(emotionPercentageK.textContent.replace('%', '')).toFixed(2);
    const xhappyValueV = parseFloat(happinessValueV.textContent.replace('%', '')).toFixed(2);
    const xhappyValueA = parseFloat(happinessValueA.textContent.replace('%', '')).toFixed(2);
    const xhappyValueR = parseFloat(happinessValueR.textContent.replace('%', '')).toFixed(2);
    const xhappyValueK = parseFloat(happinessValueK.textContent.replace('%', '')).toFixed(2);

    const varkCalObj = new VARKCal(
        xteacherSentimentV,
        xstudentSentimentV,
        xteacherSentimentA,
        xstudentSentimentA,
        xteacherSentimentR,
        xstudentSentimentR,
        xteacherSentimentK,
        xstudentSentimentK,
        xhighestEmotionV,
        xhighestemotionPercentageV,
        xhighestEmotionA,
        xhighestemotionPercentageA,
        xhighestEmotionR,
        xhighestemotionPercentageR,
        xhighestEmotionK,
        xhighestemotionPercentageK,
        xhappyValueV,
        xhappyValueA,
        xhappyValueR,
        xhappyValueK
    );
    calculateVARKPercentagesGeneralBased(varkCalObj);
}


function calculateVARKPercentagesGeneralBased(varkCalObj) {
    console.log(varkCalObj);
    // Define a mapping for text values to numerical values
    const valueMapping = {
        "Negative": 0,
        "Neutral": 50,
        "Positive": 100,
        "Angry": 70,
        "Disgusted": 60,
        "Fearful": 75,
        "Happy": 90,
        "Sad": 65,
        "Surprised": 80,
    };

    // Calculate the weighted sum for each category (V, A, R, K)
    const V = (
        (valueMapping[varkCalObj.xteacherSentimentV] + valueMapping[varkCalObj.xstudentSentimentV]) / 2 +
        valueMapping[varkCalObj.xhighestEmotionV] * (varkCalObj.xhighestemotionPercentageV / 100) +
        valueMapping["Happy"] * (varkCalObj.xhappyValueV / 100)
    );

    const A = (
        (valueMapping[varkCalObj.xteacherSentimentA] + valueMapping[varkCalObj.xstudentSentimentA]) / 2 +
        valueMapping[varkCalObj.xhighestEmotionA] * (varkCalObj.xhighestemotionPercentageA / 100) +
        valueMapping["Happy"] * (varkCalObj.xhappyValueA / 100)
    );

    const R = (
        (valueMapping[varkCalObj.xteacherSentimentR] + valueMapping[varkCalObj.xstudentSentimentR]) / 2 +
        valueMapping[varkCalObj.xhighestEmotionR] * (varkCalObj.xhighestemotionPercentageR / 100) +
        valueMapping["Happy"] * (varkCalObj.xhappyValueR / 100)
    );

    const K = (
        (valueMapping[varkCalObj.xteacherSentimentK] + valueMapping[varkCalObj.xstudentSentimentK]) / 2 +
        valueMapping[varkCalObj.xhighestEmotionK] * (varkCalObj.xhighestemotionPercentageK / 100) +
        valueMapping["Happy"] * (varkCalObj.xhappyValueK / 100)
    );

    // Calculate percentages
    const total = V + A + R + K;
    const VPercentage = (V / total) * 100;
    const APercentage = (A / total) * 100;
    const RPercentage = (R / total) * 100;
    const KPercentage = (K / total) * 100;

    console.log("General Based")
    console.log("VARK Behavior Percentage (V): ", VPercentage.toFixed(2) + "%");
    console.log("VARK Behavior Percentage (A): ", APercentage.toFixed(2) + "%");
    console.log("VARK Behavior Percentage (R): ", RPercentage.toFixed(2) + "%");
    console.log("VARK Behavior Percentage (K): ", KPercentage.toFixed(2) + "%");

    ldVarkValueV.textContent = VPercentage.toFixed(2) + "%";
    ldVarkValueA.textContent = APercentage.toFixed(2) + "%";
    ldVarkValueR.textContent = RPercentage.toFixed(2) + "%";
    ldVarkValueK.textContent = KPercentage.toFixed(2) + "%";

    // 0-25 = Level 1
    // 25-50 = Level 2
    // 50-75 = Level 3
    // 75-100 = Level 4

    if (VPercentage >= 0 && VPercentage <= 25) {
        ldVarkValueVL.textContent = "Level 1 (0-25%)";
    } else if (VPercentage > 25 && VPercentage <= 50) {
        ldVarkValueVL.textContent = "Level 2 (25-50%)";
    } else if (VPercentage > 50 && VPercentage <= 75) {
        ldVarkValueVL.textContent = "Level 3 (50-75%)";
    } else if (VPercentage > 75 && VPercentage <= 100) {
        ldVarkValueVL.textContent = "Level 4 (75-100%)";
    }

    if (APercentage >= 0 && APercentage <= 25) {
        ldVarkValueAL.textContent = "Level 1 (0-25%)";
    } else if (APercentage > 25 && APercentage <= 50) {
        ldVarkValueAL.textContent = "Level 2 (25-50%)";
    } else if (APercentage > 50 && APercentage <= 75) {
        ldVarkValueAL.textContent = "Level 3 (50-75%)";
    } else if (APercentage > 75 && APercentage <= 100) {
        ldVarkValueAL.textContent = "Level 4 (75-100%)";
    }

    if (RPercentage >= 0 && RPercentage <= 25) {
        ldVarkValueRL.textContent = "Level 1 (0-25%)";
    } else if (RPercentage > 25 && RPercentage <= 50) {
        ldVarkValueRL.textContent = "Level 2 (25-50%)";
    } else if (RPercentage > 50 && RPercentage <= 75) {
        ldVarkValueRL.textContent = "Level 3 (50-75%)";
    } else if (RPercentage > 75 && RPercentage <= 100) {
        ldVarkValueRL.textContent = "Level 4 (75-100%)";
    }

    if (KPercentage >= 0 && KPercentage <= 25) {
        ldVarkValueKL.textContent = "Level 1 (0-25%)";
    } else if (KPercentage > 25 && KPercentage <= 50) {
        ldVarkValueKL.textContent = "Level 2 (25-50%)";
    } else if (KPercentage > 50 && KPercentage <= 75) {
        ldVarkValueKL.textContent = "Level 3 (50-75%)";
    } else if (KPercentage > 75 && KPercentage <= 100) {
        ldVarkValueKL.textContent = "Level 4 (75-100%)";
    }


    //generateStudyPlan();
}

// function calculateVARKPercentagesHappyBased() {
//     // Define a mapping for text values to numerical values
//     const valueMapping = {
//         "Negative": 0,
//         "Neutral": 50,
//         "Positive": 100,
//     };
//
//     // Calculate the weighted sum for each category (V, A, R, K)
//     const V = (
//         (valueMapping[xteacherSentimentV] + valueMapping[xstudentSentimentV]) / 2 +
//         valueMapping["Positive"] * (xhappyValueV / 100)
//     );
//
//     const A = (
//         (valueMapping[xteacherSentimentA] + valueMapping[xstudentSentimentA]) / 2 +
//         valueMapping["Positive"] * (xhappyValueA / 100)
//     );
//
//     const R = (
//         (valueMapping[xteacherSentimentR] + valueMapping[xstudentSentimentR]) / 2 +
//         valueMapping["Positive"] * (xhappyValueR / 100)
//     );
//
//     const K = (
//         (valueMapping[xteacherSentimentK] + valueMapping[xstudentSentimentK]) / 2 +
//         valueMapping["Positive"] * (xhappyValueK / 100)
//     );
//
//     // Calculate percentages
//     const total = V + A + R + K;
//     const VPercentage = (V / total) * 100;
//     const APercentage = (A / total) * 100;
//     const RPercentage = (R / total) * 100;
//     const KPercentage = (K / total) * 100;
//
//     console.log("Happy Based")
//     console.log("h VARK Behavior Percentage (V): ", VPercentage.toFixed(2) + "%");
//     console.log("h VARK Behavior Percentage (A): ", APercentage.toFixed(2) + "%");
//     console.log("h VARK Behavior Percentage (R): ", RPercentage.toFixed(2) + "%");
//     console.log("h VARK Behavior Percentage (K): ", KPercentage.toFixed(2) + "%");
// }


function generateStudyPlan() {

    const levelNumberV = parseInt(document.getElementById("ldVarkValueVL").textContent.match(/\d+/)[0]);
    const levelNumberA = parseInt(document.getElementById("ldVarkValueAL").textContent.match(/\d+/)[0]);
    const levelNumberR = parseInt(document.getElementById("ldVarkValueRL").textContent.match(/\d+/)[0]);
    const levelNumberK = parseInt(document.getElementById("ldVarkValueKL").textContent.match(/\d+/)[0]);

    console.log("Level Number (V): ", levelNumberV);
    console.log("Level Number (A): ", levelNumberA);
    console.log("Level Number (R): ", levelNumberR);
    console.log("Level Number (K): ", levelNumberK);

    // Define an array of objects specifying learning style and set number
    const requestConfig = [
        {learningStyle: 'V', setNumber: levelNumberV},
        {learningStyle: 'A', setNumber: levelNumberA},
        {learningStyle: 'R', setNumber: levelNumberR},
        {learningStyle: 'K', setNumber: levelNumberK},
    ];

    // Create an array to store the results
    const results = [];

    // Loop through the requestConfig and send requests for each combination
    for (const config of requestConfig) {
        const {learningStyle, setNumber} = config;

        const requestData = {
            learningStyle: learningStyle,
            setNumber: setNumber
        };

        // Send a POST request to the /plan route for each combination
        fetch('/plan', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(requestData)
        })
            .then(response => response.json())
            .then(data => {
                results.push({style: learningStyle, number: setNumber, data});
                if (results.length === requestConfig.length) {
                    // All requests have been completed, handle the results here
                    console.log(results);
                    generatedplanV1.textContent = results[0].data[0];
                    generatedplanV2.textContent = results[0].data[1];
                    generatedplanV3.textContent = results[0].data[2];
                    generatedplanV4.textContent = results[0].data[3];

                    generatedplanA1.textContent = results[1].data[0];
                    generatedplanA2.textContent = results[1].data[1];
                    generatedplanA3.textContent = results[1].data[2];
                    generatedplanA4.textContent = results[1].data[3];

                    generatedplanR1.textContent = results[2].data[0];
                    generatedplanR2.textContent = results[2].data[1];
                    generatedplanR3.textContent = results[2].data[2];
                    generatedplanR4.textContent = results[2].data[3];

                    generatedplanK1.textContent = results[3].data[0];
                    generatedplanK2.textContent = results[3].data[1];
                    generatedplanK3.textContent = results[3].data[2];
                    generatedplanK4.textContent = results[3].data[3];

                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }
}

btnAddGeneratePlan.addEventListener('click', function () {
    if (teacherSentimentK.textContent === "Not Available") {
        const toastLiveExample = document.getElementById('liveToast-error')
        const toastBootstrap = bootstrap.Toast.getOrCreateInstance(toastLiveExample)
        toastBootstrap.show()
    } else {
        generateStudyPlan();
    }
});

function saveToDatabase() {
    // Define the data to be sent in the POST request
    const postData = {
        selectedTeacherID: selectedTeacherID,
        selectedStudentID: selectedStudentID,
        selectedSubjectID: selectedSubjectID,
        teacherSentimentV: teacherSentimentV.textContent,
        studentSentimentV: studentSentimentV.textContent,
        teacherSentimentA: teacherSentimentA.textContent,
        studentSentimentA: studentSentimentA.textContent,
        teacherSentimentR: teacherSentimentR.textContent,
        studentSentimentR: studentSentimentR.textContent,
        teacherSentimentK: teacherSentimentK.textContent,
        studentSentimentK: studentSentimentK.textContent,
        highestEmotionV: highestEmotionV.textContent,
        highestEmotionA: highestEmotionA.textContent,
        highestEmotionR: highestEmotionR.textContent,
        highestEmotionK: highestEmotionK.textContent,
        emotionPercentageV: emotionPercentageV.textContent,
        emotionPercentageA: emotionPercentageA.textContent,
        emotionPercentageR: emotionPercentageR.textContent,
        emotionPercentageK: emotionPercentageK.textContent,
        happinessValueV: happinessValueV.textContent,
        happinessValueA: happinessValueA.textContent,
        happinessValueR: happinessValueR.textContent,
        happinessValueK: happinessValueK.textContent,
        ldVarkValueV: ldVarkValueV.textContent,
        ldVarkValueA: ldVarkValueA.textContent,
        ldVarkValueR: ldVarkValueR.textContent,
        ldVarkValueK: ldVarkValueK.textContent,
        generatedplanV1: generatedplanV1.textContent,
        generatedplanV2: generatedplanV2.textContent,
        generatedplanV3: generatedplanV3.textContent,
        generatedplanV4: generatedplanV4.textContent,
        generatedplanA1: generatedplanA1.textContent,
        generatedplanA2: generatedplanA2.textContent,
        generatedplanA3: generatedplanA3.textContent,
        generatedplanA4: generatedplanA4.textContent,
        generatedplanR1: generatedplanR1.textContent,
        generatedplanR2: generatedplanR2.textContent,
        generatedplanR3: generatedplanR3.textContent,
        generatedplanR4: generatedplanR4.textContent,
        generatedplanK1: generatedplanK1.textContent,
        generatedplanK2: generatedplanK2.textContent,
        generatedplanK3: generatedplanK3.textContent,
        generatedplanK4: generatedplanK4.textContent,
    };

    // Send a POST request to database endpoint
    fetch('/saveplan', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(postData)
    })
        .then(response => response.json())
        .then(data => {
            // Handle the response from the server (e.g., success message or error handling)
            console.log('Data saved to the database:', data);
            submittingLoader.classList.add('d-none');
            const toastLiveExample = document.getElementById('liveToast')
            const toastBootstrap = bootstrap.Toast.getOrCreateInstance(toastLiveExample)
            toastBootstrap.show()
        })
        .catch(error => {
            console.error('Error saving data to the database:', error);
            const toastLiveExample = document.getElementById('liveToast-error')
            const toastBootstrap = bootstrap.Toast.getOrCreateInstance(toastLiveExample)
            toastBootstrap.show()
        });
}

btnSubmitPlan.addEventListener('click', function () {
    submittingLoader.classList.remove('d-none');
    if (generatedplanV1.textContent === "Not Available") {
        const toastLiveExample = document.getElementById('liveToast-error')
        const toastBootstrap = bootstrap.Toast.getOrCreateInstance(toastLiveExample)
        toastBootstrap.show()
    } else {
        saveToDatabase();
    }
});

