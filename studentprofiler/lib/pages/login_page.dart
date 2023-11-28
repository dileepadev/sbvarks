import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studentprofiler/pages/signup_page.dart';
import '../services/firebase_error_service.dart';
import '../theme/bottom_nav_bar.dart';
import '../theme/c_textbutton.dart';
import '../theme/c_textfield.dart';

import '../theme/app_theme.dart';
import '../theme/c_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  bool signupSuccess = false;
  String message = '';
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Navigate to bottom nav bar
  void navigateToBottomNavBar() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomNavBar(),
      ),
    );
  }

  // --------------------------- SignIn ---------------------------
  Future<void> _firebaseSignIn() async {
    setState(() {
      isLoading = true;
      signupSuccess = false;
      message = '';
    });

    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      log("------------ !!! User SignIn - SUCCESS ------------");
      // navigate to home page
      navigateToBottomNavBar();

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
                Image.asset(
                  'assets/images/2-tr.png',
                  height: 200,
                  fit: BoxFit.fitHeight,
                ),
                const Center(
                  child: Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Text(
                      'Hello Teacher! Welcome to Student Profiler. This student behaviour and VARK system app will help you to monitor your students and their learning styles. Please login to continue.',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                    labelText: "Password",
                    hintText: "Enter your password",
                    isPassword: true,
                    textEditingController: _passwordController,
                    keyboardType: TextInputType.text,
                    isMaxLength: false,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CTextButton(
                    onPressed: () {},
                    text: "Forgot Password? Click here",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: CButton(
                      onPressed: () {
                        _firebaseSignIn();
                      },
                      text: "Login",
                    ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CTextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
                    },
                    text: "Don't have an account? Click here",
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
