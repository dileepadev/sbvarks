import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studentprofiler/models/teacher_model.dart';
import 'package:studentprofiler/theme/app_theme.dart';
import 'package:flutter/scheduler.dart';

import 'add_new_student_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late Ticker _ticker;

  String formattedTime = "";

  @override
  void initState() {
    super.initState();

    _ticker = createTicker((Duration elapsed) {
      formattedTime = currentTime();
      setState(() {});
    });

    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  // Current Date in format 14th September 2021
  String currentDate() {
    DateTime now = DateTime.now();
    String month = "January";
    if (now.month == 1) {
      month = "January";
    } else if (now.month == 2) {
      month = "February";
    } else if (now.month == 3) {
      month = "March";
    } else if (now.month == 4) {
      month = "April";
    } else if (now.month == 5) {
      month = "May";
    } else if (now.month == 6) {
      month = "June";
    } else if (now.month == 7) {
      month = "July";
    } else if (now.month == 8) {
      month = "August";
    } else if (now.month == 9) {
      month = "September";
    } else if (now.month == 10) {
      month = "October";
    } else if (now.month == 11) {
      month = "November";
    } else if (now.month == 12) {
      month = "December";
    }
    String formattedDate = "${now.day} $month ${now.year}";
    return formattedDate;
  }

  // Current Time in format 01:03 PM 12 hour clock
  String currentTime() {
    DateTime now = DateTime.now();
    int hour = now.hour;
    String period = "AM";

    if (hour >= 12) {
      period = "PM";
      if (hour > 12) {
        hour -= 12;
      }
    }

    String formattedTime =
        "${hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} $period";

    return formattedTime;
  }

  // Greetings
  String greeting() {
    DateTime now = DateTime.now();
    int hour = now.hour;
    String greeting = "Good Morning";

    if (hour >= 12) {
      greeting = "Good Afternoon";
      if (hour > 17) {
        greeting = "Good Evening";
      }
    }

    return greeting;
  }

  Widget _buildHeader() {
    log(FirebaseAuth.instance.currentUser!.uid);
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('teachers')
            .where('uuid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   log("Issue: ${snapshot.connectionState}");
          //   return header(name: "Loading...");
          // }
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isNotEmpty) {
              TeacherModel teacherModel =
                  TeacherModel.fromJsom(snapshot.data!.docs[0]);
              return header(
                  title: teacherModel.title,
                  name: "${teacherModel.firstName} ${teacherModel.lastName}");
            }
          }
          return header(title: '', name: 'User');
        });
  }

  Row header({required String title, required String name}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                text: "Hello! $title",
                style: const TextStyle(
                  color: AppThemeData.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: name,
                    style: const TextStyle(
                      color: AppThemeData.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              greeting(),
              style: const TextStyle(
                color: AppThemeData.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              currentDate(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              formattedTime,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_rounded, size: 30),
        ),
      ],
    );
  }

  Widget _buildHomeCard() {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference teacherCollection =
        FirebaseFirestore.instance.collection('teachers');

    return StreamBuilder(
      stream: teacherCollection
          .doc(currentUserId)
          .collection('students')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return const CircularProgressIndicator(); // Show a loading indicator here
        // }
        int totalStudentCount = snapshot.data?.docs.length ?? 0;

        return homeCard(
          title: "Total Students",
          subtitle: "Added student count",
          value: totalStudentCount.toString(),
          onTap: () {},
          isNavigation: false,
        );
      },
    );
  }

  GestureDetector homeCard({
    required String title,
    required String subtitle,
    required String value,
    required Function() onTap,
    required bool isNavigation,
  }) {
    return GestureDetector(
      onTap: onTap,
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
            children: [
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
              isNavigation
                  ? const Icon(Icons.arrow_forward_ios)
                  : Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
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
              children: [
                const SizedBox(
                  height: 20,
                ),
                _buildHeader(),
                Image.asset(
                  'assets/images/1-tr.png',
                  height: 250,
                  fit: BoxFit.fitHeight,
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildHomeCard(),
                const SizedBox(
                  height: 20,
                ),
                homeCard(
                  title: "Add New Student",
                  subtitle: "Add a new student to the list",
                  value: ">",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddNewStudentPage(),
                    ),
                  ),
                  isNavigation: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
