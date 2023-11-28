import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/teacher_model.dart';
import '../theme/app_theme.dart';

class AccountDetailsPage extends StatefulWidget {
  const AccountDetailsPage({Key? key}) : super(key: key);

  @override
  State<AccountDetailsPage> createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
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
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Text('No data found');
          }
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isNotEmpty) {
              TeacherModel teacherModel =
                  TeacherModel.fromJsom(snapshot.data!.docs[0]);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailItem('UUID', teacherModel.uuid),
                  _buildDetailItem('Title', teacherModel.title),
                  _buildDetailItem('First Name', teacherModel.firstName),
                  _buildDetailItem('Last Name', teacherModel.lastName),
                  _buildDetailItem('Email', teacherModel.email),
                  _buildDetailItem(
                      'Contact Number', teacherModel.contactNumber),
                  _buildDetailItem('Last Appeared', teacherModel.lastAppeared),
                  _buildDetailItem(
                      'Account Created', teacherModel.accountCreated),
                  // Add more fields as needed
                ],
              );
            }
          }
          return _buildDetailItem('Error', 'No data found');
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Account Details',
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
        backgroundColor: AppThemeData.appBarLight,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: _buildHeader()),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, dynamic value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
