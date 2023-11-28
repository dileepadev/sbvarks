import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:studentprofiler/theme/bottom_nav_bar.dart';
import '../pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ifUserLoggedIn() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return const BottomNavBar();
    } else {
      return const LoginPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Profiler',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: ifUserLoggedIn(),
    );
  }
}
