import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studentprofiler/pages/login_page.dart';
import 'package:studentprofiler/pages/privacy_policy_page.dart';
import 'package:studentprofiler/theme/app_theme.dart';

import '../services/firebase_error_service.dart';
import 'about_project_page.dart';
import 'account_details_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isLoading = false;
  bool signupSuccess = false;
  String message = '';
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void navigateToLoginPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  Future<void> _firebaseSignOut() async {
    setState(() {
      isLoading = true;
      signupSuccess = false;
      message = '';
    });
    try {
      await firebaseAuth.signOut();

      log("------------ !!! User SignOut - SUCCESS ------------");
      navigateToLoginPage();

      setState(() {
        isLoading = false;
        signupSuccess = true;
        message = '';
      });
    } on FirebaseAuthException catch (error) {
      setState(() {
        isLoading = false;
        signupSuccess = false;
        message = FirebaseErrorService().findFirebaseAuthErrorType(error);
        log(message);
      });
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

  Card settings(
      {required String title,
      required String subtitle,
      required Function() onTap}) {
    return Card(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 16,
            color: AppThemeData.textGreyDark,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
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
                    title: 'Settings',
                    subtitle: 'Change your preferences',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  settings(
                    title: 'Account Details',
                    subtitle: 'Change your account details',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AccountDetailsPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  settings(
                    title: 'About Project',
                    subtitle: 'See the project details',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutProjectPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  settings(
                    title: 'Privacy Policy',
                    subtitle: 'View our privacy policy',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PrivacyPolicyPage()),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  settings(
                    title: 'Logout',
                    subtitle: 'Logout from the app',
                    onTap: () {
                      _firebaseSignOut();
                    },
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
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
