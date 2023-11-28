import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import '../models/student_model.dart';
import '../theme/c_button.dart';
import '../theme/c_textbutton.dart';
import '../theme/c_textfield.dart';

import '../theme/app_theme.dart';

class AddNewStudentPage extends StatefulWidget {
  const AddNewStudentPage({super.key});

  @override
  State<AddNewStudentPage> createState() => _AddNewStudentPageState();
}

class _AddNewStudentPageState extends State<AddNewStudentPage> {
  final firstNameEditingController = TextEditingController();
  final lastNameEditingController = TextEditingController();
  final indexEditingController = TextEditingController();
  String selectedGrade = "Grade 1";
  File? _selectedImage;
  bool isLoading = false;
  bool signupSuccess = false;
  String message = '';
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Upload image to Firebase Storage
  Future<String> _uploadImage(File imageFile, String imageName) async {
    try {
      final storageRef = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('student_images')
          .child(firebaseAuth.currentUser!.uid.toString())
          .child(imageName);

      final task = storageRef.putFile(imageFile);

      final snapshot = await task.whenComplete(() {});
      final downloadURL = await snapshot.ref.getDownloadURL();

      return downloadURL;
    } catch (e) {
      log("Error uploading image: $e");
      return "";
    }
  }

  // Add student to Firebase Firestore
  Future<void> _firebaseAddStudent(StudentModel studentModel) async {
    setState(() {
      isLoading = true;
      signupSuccess = false;
      message = '';
    });

    bool indexExists = await _checkIndexExists(studentModel.index);
    if (indexExists) {
      setState(() {
        isLoading = false;
        signupSuccess = false;
        message = 'Student with the same index already exists.';
        _showErrorDialog(message);
      });
      return;
    }
    if (_selectedImage != null) {
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      String imageUrl = await _uploadImage(_selectedImage!, imageName);
      if (imageUrl.isNotEmpty) {
        studentModel.picture = imageUrl;
      }
    }

    // Student details
    final studentDetails = {
      "firstName": studentModel.firstName,
      "lastName": studentModel.lastName,
      "picture": studentModel.picture,
      "index": studentModel.index,
      "grade": studentModel.grade,
      "teacherID": studentModel.teacherID,
      "varkType": studentModel.varkType,
      "valueV": studentModel.valueV,
      "valueA": studentModel.valueA,
      "valueR": studentModel.valueR,
      "valueK": studentModel.valueK,
    };

    // Add to Teachers collection
    try {
      await FirebaseFirestore.instance
          .collection('teachers')
          .doc(firebaseAuth.currentUser?.uid.toString())
          .collection('students')
          .doc(studentModel.index)
          .set(studentDetails)
          .then((value) async {
        // Add to Students collection
        try {
          await FirebaseFirestore.instance
              .collection('students')
              .doc(studentModel.index)
              .set(studentDetails)
              .then((value) {
            log("------------ !!! Student Add - SUCCESS ------------");
            setState(() {
              isLoading = false;
              signupSuccess = true;
              message = 'Student add successful!';
              _showSuccessDialog();
            });
          });
        } on FirebaseException catch (firestoreError) {
          setState(() {
            isLoading = false;
            signupSuccess = false;
            message = firestoreError.toString();
            log(message);
          });
        }
      });
    } on FirebaseException catch (firestoreError) {
      setState(() {
        isLoading = false;
        signupSuccess = false;
        message = firestoreError.toString();
        log(message);
      });
    }
  }

  // Check if student index already exists
  Future<bool> _checkIndexExists(String index) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('teachers')
          .doc(firebaseAuth.currentUser?.uid.toString())
          .collection('students')
          .doc(index)
          .get();

      return snapshot.exists;
    } catch (e) {
      log("Error checking index: $e");
      return false;
    }
  }

  // Show error dialog
  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Show success dialog
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success"),
          content: const Text("Student added successfully!"),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  Row uploadImageSection() {
    return Row(
      children: [
        //circle Image.asset
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: _selectedImage != null
                  ? FileImage(_selectedImage!) as ImageProvider<Object>
                  : const AssetImage("assets/images/avatar.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        CTextButton(
          onPressed: _pickImage,
          text: "Click to upload image",
        ),
      ],
    );
  }

  Widget studentGradeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Student Grade",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedGrade,
              isExpanded: true,
              items: <String>[
                'Grade 1',
                'Grade 2',
                'Grade 3',
                'Grade 4',
                'Grade 5'
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                // Update the selected value
                setState(() {
                  selectedGrade = newValue!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: AppThemeData.scaffoldLight,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                "Adding student...",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
            title: const Text(
              'Add New Student',
              style: TextStyle(color: AppThemeData.textPrimary),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppThemeData.iconSecondary,
              ),
            ),
            elevation: 0,
            backgroundColor: AppThemeData.appBarLight),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CTextField(
                    labelText: "First Name",
                    hintText: "Enter student's first name",
                    isPassword: false,
                    textEditingController: firstNameEditingController,
                    keyboardType: TextInputType.name,
                    isMaxLength: true,
                  ),
                  CTextField(
                    labelText: "Last Name",
                    hintText: "Enter student's last name",
                    isPassword: false,
                    textEditingController: lastNameEditingController,
                    keyboardType: TextInputType.name,
                    isMaxLength: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Student Picture",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  uploadImageSection(),
                  const SizedBox(
                    height: 20,
                  ),
                  CTextField(
                    labelText: "Student Index",
                    hintText: "Enter student's index",
                    isPassword: false,
                    textEditingController: indexEditingController,
                    keyboardType: TextInputType.name,
                    isMaxLength: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  studentGradeSection(),
                  const SizedBox(
                    height: 40,
                  ),
                  CButton(
                    onPressed: () async {
                      StudentModel studentModel = StudentModel(
                        firstName: firstNameEditingController.text,
                        lastName: lastNameEditingController.text,
                        picture: _selectedImage != null
                            ? _selectedImage!.path
                            : "assets/images/avatar.png",
                        index: indexEditingController.text,
                        grade: selectedGrade,
                        teacherID: firebaseAuth.currentUser!.uid.toString(),
                        varkType: "Not Set",
                        valueV: "0%",
                        valueA: "0%",
                        valueR: "0%",
                        valueK: "0%",
                      );
                      _firebaseAddStudent(studentModel);
                    },
                    text: "Add New Student",
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
