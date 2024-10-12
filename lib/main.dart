import 'package:cafe_lp/pages/homescreen.dart';
import 'package:cafe_lp/pages/splashscreen.dart';
import 'package:flutter/material.dart';

// Importing all the pages
//import 'package:cafe_lp/pages/login.dart';
//import 'package:cafe_lp/pages/login_1.dart';
//import 'package:cafe_lp/pages/sign_up.dart';
//import 'package:cafe_lp/pages/sign_up_1.dart';
//import 'package:cafe_lp/pages/welcome.dart';
import 'package:cafe_lp/pages/welcome_1.dart';
import 'package:cafe_lp/pages/toggle.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cafe_lp/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Define the named routes
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cafe LP',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: AuthWrapper(), // Use AuthWrapper to determine initial screen
      routes: {
        '/welcome': (context) => const Welcome1(),
        '/toggle': (context) => const Toggle(),
        '/splash': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  final Auth auth = Auth();

  AuthWrapper({super.key}); // Create an instance of Auth class

  @override
  Widget build(BuildContext context) {
    // Use a StreamBuilder to listen to auth state changes
    return StreamBuilder<User?>(
      stream: auth.authStateChanges, // Listen for auth state changes
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          // If the snapshot has data, the user is logged in
          User? user = snapshot.data;
          if (user == null) {
            // User is not logged in, show Welcome1
            return const Welcome1();
          } else {
            // User is logged in, show SplashScreen
            return const SplashScreen();
          }
        } else {
          // While checking auth state, show a loading spinner
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}