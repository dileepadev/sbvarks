import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:studentprofiler/theme/app_theme.dart';
import 'package:studentprofiler/pages/student_details_page.dart';

import '../models/student_model.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<StudentModel> students = [];

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    try {
      String uid = _firebaseAuth.currentUser?.uid ?? '';
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('teachers')
          .doc(uid)
          .collection('students')
          .get();

      List<StudentModel> fetchedStudents = [];
      for (var document in querySnapshot.docs) {
        fetchedStudents.add(StudentModel.fromMap(document.data()));
      }

      setState(() {
        students = fetchedStudents;
      });
    } catch (e) {
      log("Error fetching students: $e");
    }
  }

  Future<void> _deleteStudent(StudentModel studentModel) async {
    try {
      String uid = _firebaseAuth.currentUser?.uid ?? '';
      await _firestore
          .collection('teachers')
          .doc(uid)
          .collection('students')
          .doc(studentModel.index)
          .delete();
      fetchStudents();
    } catch (e) {
      log("Error deleting student: $e");
    }
  }

  Widget header({required String title, required String subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 20,
            color: AppThemeData.textGreyDark,
          ),
        ),
      ],
    );
  }

  Widget studentCard({
    required String image,
    required String title,
    required String subtitle,
    required StudentModel studentModel,
  }) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StudentDetailsPage(studentModel: studentModel),
        ),
      ),
      child: Card(
        elevation: 1,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: AppThemeData.textGreyDark,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                child: const Icon(
                  Icons.more_vert_rounded,
                  size: 30,
                ),
                onTap: () {
                  // Delete student ask from alert dialog
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Delete Student'),
                          content: const Text(
                              'Are you sure you want to delete this student?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel')),
                            TextButton(
                              onPressed: () {
                                _deleteStudent(studentModel);
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeData.scaffoldLight,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                header(
                  title: 'Students',
                  subtitle: 'Manage your students',
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'You have ${students.length} students',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppThemeData.textPrimary,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Display fetched students
                Column(
                  children: students.map((student) {
                    return studentCard(
                      image: student.picture,
                      title: '${student.firstName} ${student.lastName}',
                      subtitle: student.index,
                      studentModel: student,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
