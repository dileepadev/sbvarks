import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AboutProjectPage extends StatefulWidget {
  const AboutProjectPage({Key? key}) : super(key: key);

  @override
  State<AboutProjectPage> createState() => _AboutProjectPageState();
}

class _AboutProjectPageState extends State<AboutProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Project',
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
      body: const SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: AboutProjectContent(),
          ),
        ),
      ),
    );
  }
}

class AboutProjectContent extends StatelessWidget {
  const AboutProjectContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Student Profiler',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Developer: Dileepa Bandara',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'App Name: Student Profiler',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Version: 1.0.0',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Contact Email: contact@dileepabandara.dev',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Description:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Student Profiler is a mobile application designed to help teachers and students manage their profiles and academic information efficiently. This app simplifies the process of organizing and accessing important student-related data.',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        // Add more details as needed.
      ],
    );
  }
}
