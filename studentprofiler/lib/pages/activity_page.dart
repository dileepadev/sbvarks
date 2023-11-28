import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

import '../theme/app_theme.dart';

class ActivityPage extends StatefulWidget {
  final String studentID;
  final String activityType;

  const ActivityPage(
      {super.key, required this.studentID, required this.activityType});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  Widget activityCard({required String text}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppThemeData.textWhite,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          text,
          style: const TextStyle(
            color: AppThemeData.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

// Function to fetch and display activities
  Widget learningActivities() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('teachers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('students')
          .doc(widget.studentID)
          .collection('subjects')
          .doc('Mathematics')
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return activityCard(text: 'No activities found');
        }
        if (snapshot.hasData) {
          final data = snapshot.data!.data() as Map<String, dynamic>;
          log("Data: $data");
          if (data.isEmpty) {
            return activityCard(text: 'No activities found');
          }
          if (data.isNotEmpty) {
            if (widget.activityType == 'Visual') {
              return Column(
                children: [
                  activityCard(text: data['generatedplanV1'] ?? ''),
                  const SizedBox(
                    height: 20,
                  ),
                  activityCard(text: data['generatedplanV2'] ?? ''),
                  const SizedBox(
                    height: 20,
                  ),
                  activityCard(text: data['generatedplanV3'] ?? ''),
                  const SizedBox(
                    height: 20,
                  ),
                  activityCard(text: data['generatedplanV4'] ?? ''),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            } else if (widget.activityType == 'Auditory') {
              return Column(
                children: [
                  activityCard(text: data['generatedplanA1'] ?? ''),
                  const SizedBox(
                    height: 20,
                  ),
                  activityCard(text: data['generatedplanA2'] ?? ''),
                  const SizedBox(
                    height: 20,
                  ),
                  activityCard(text: data['generatedplanA3'] ?? ''),
                  const SizedBox(
                    height: 20,
                  ),
                  activityCard(text: data['generatedplanA4'] ?? ''),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            } else if (widget.activityType == 'Reading/Writing') {
              return Column(
                children: [
                  activityCard(text: data['generatedplanR1'] ?? ''),
                  const SizedBox(
                    height: 20,
                  ),
                  activityCard(text: data['generatedplanR2'] ?? ''),
                  const SizedBox(
                    height: 20,
                  ),
                  activityCard(text: data['generatedplanR3'] ?? ''),
                  const SizedBox(
                    height: 20,
                  ),
                  activityCard(text: data['generatedplanR4'] ?? ''),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            } else if (widget.activityType == 'Kinesthetic') {
              return Column(
                children: [
                  activityCard(text: data['generatedplanK1'] ?? ''),
                  const SizedBox(
                    height: 20,
                  ),
                  activityCard(text: data['generatedplanK2'] ?? ''),
                  const SizedBox(
                    height: 20,
                  ),
                  activityCard(text: data['generatedplanK3'] ?? ''),
                  const SizedBox(
                    height: 20,
                  ),
                  activityCard(text: data['generatedplanK4'] ?? ''),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            }
          }
        }
        return activityCard(text: 'No activities found');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Visual Activities',
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Mathematics',
                  style: TextStyle(
                    color: AppThemeData.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'For young visual learners, incorporating images, diagrams, and visual aids is essential',
                  style: TextStyle(
                    color: AppThemeData.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Learning Activities',
                  style: TextStyle(
                    color: AppThemeData.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                learningActivities(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
