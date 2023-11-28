import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studentprofiler/models/teacher_model.dart';
import '../services/date_time_checker.dart';
import '../theme/c_textfield.dart';
import '../services/firebase_error_service.dart';

import '../theme/app_theme.dart';
import '../theme/c_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  bool signupSuccess = false;
  String message = '';
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String dropdownValue = 'Mr.';

  // --------------------------- SignUp ---------------------------
  Future<void> _firebaseSignUp(TeacherModel teacherModel) async {
    setState(() {
      isLoading = true;
      signupSuccess = false;
      message = '';
    });

    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      log("------------ !!! User SignUp - SUCCESS ------------");
      log("------------ ... Start Add User to Firebase ------------");

      try {
        await FirebaseFirestore.instance
            .collection('teachers')
            .doc(firebaseAuth.currentUser?.uid.toString())
            .set({
          "uuid": firebaseAuth.currentUser?.uid.toString(),
          "title": teacherModel.title,
          "firstName": teacherModel.firstName,
          "lastName": teacherModel.lastName,
          "email": teacherModel.email,
          "contactNumber": teacherModel.contactNumber,
          'password': teacherModel.password,
          'lastAppeared': teacherModel.lastAppeared,
          'accountCreated': teacherModel.accountCreated,
        }).then((value) {
          setState(() {
            isLoading = false;
            signupSuccess = true;
            message = 'Signup successful!';
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
    } on FirebaseAuthException catch (error) {
      setState(() {
        isLoading = false;
        signupSuccess = false;
        message = FirebaseErrorService().findFirebaseAuthErrorType(error);
        log(message);
      });
    }
  }

  Widget _titleSelect() {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        const Text(
          'Title',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Row(
          children: [
            Row(
              children: <Widget>[
                Radio<String>(
                  value: 'Mr.',
                  groupValue: dropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      log(dropdownValue);
                    });
                  },
                ),
                const Text(
                  'Mr.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Radio<String>(
                  value: 'Mrs.',
                  groupValue: dropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      log(dropdownValue);
                    });
                  },
                ),
                const Text(
                  'Mrs.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Radio<String>(
                  value: 'Miss',
                  groupValue: dropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      log(dropdownValue);
                    });
                  },
                ),
                const Text(
                  'Miss',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
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
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: AppThemeData.scaffoldLight,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _titleSelect(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CTextField(
                    labelText: "First Name",
                    hintText: "Enter your first name",
                    isPassword: false,
                    textEditingController: _firstNameController,
                    keyboardType: TextInputType.text,
                    isMaxLength: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CTextField(
                    labelText: "Last Name",
                    hintText: "Enter your last name",
                    isPassword: false,
                    textEditingController: _lastNameController,
                    keyboardType: TextInputType.text,
                    isMaxLength: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CTextField(
                    labelText: "Email",
                    hintText: "Enter your email",
                    isPassword: false,
                    textEditingController: _emailController,
                    keyboardType: TextInputType.text,
                    isMaxLength: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CTextField(
                    labelText: "Contact Number",
                    hintText: "Enter your contact number",
                    isPassword: false,
                    textEditingController: _contactNumberController,
                    keyboardType: TextInputType.text,
                    isMaxLength: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CTextField(
                    labelText: "Password",
                    hintText: "Enter your password",
                    isPassword: true,
                    textEditingController: _passwordController,
                    keyboardType: TextInputType.text,
                    isMaxLength: false,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: CButton(
                        onPressed: () {
                          TeacherModel teacherModel = TeacherModel(
                            uuid: '',
                            title: dropdownValue,
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            email: _emailController.text,
                            contactNumber: _contactNumberController.text,
                            password: _passwordController.text,
                            lastAppeared: DateTimeChecker().dateTimeNow,
                            accountCreated: DateTimeChecker().dateTimeNow,
                          );
                          _firebaseSignUp(teacherModel);
                        },
                        text: "Create Account"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (message.isNotEmpty)
                  Text(
                    message,
                    style: TextStyle(
                      color: signupSuccess ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
