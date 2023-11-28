import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Privacy Policy',
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
            child: PrivacyPolicyContent(),
          ),
        ),
      ),
    );
  }
}

class PrivacyPolicyContent extends StatelessWidget {
  const PrivacyPolicyContent({Key? key}) : super(key: key);

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
          'Privacy Policy',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Last Updated: September 1, 2023',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 20),
        Text(
          '1. Introduction',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application.',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 20),
        Text(
          '2. Data Collection',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'We may collect various types of information from you when you use our app, including but not limited to personal information (e.g., name, email address) and location information (if you enable location services).',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 20),
        Text(
          '3. Data Usage',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'We use the information collected to provide and improve our services and to personalize your experience.',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 20),
        Text(
          '4. Data Disclosure',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'We may disclose your information to third parties with your consent or to comply with legal obligations.',
          style: TextStyle(fontSize: 16),
        ),
        // Add more content as needed.
        SizedBox(height: 20),
        Text(
          '5. Security',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'We take security measures to protect your information, but no method of transmission over the internet or electronic storage is 100% secure. We cannot guarantee the absolute security of your data.',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
