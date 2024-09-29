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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cafe LP',
      home: AuthWrapper(), // Use AuthWrapper to determine whether to show Welcome1 or the main content
      // home: Welcome1()
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
            // User is logged in, show the main content
            return const PageSequence(); // The main content of your app
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

class PageSequence extends StatefulWidget {
  const PageSequence({super.key});

  @override
  _PageSequenceState createState() => _PageSequenceState();
}

class _PageSequenceState extends State<PageSequence> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cafe LP'),
      ),
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: const <Widget>[
          Toggle(), // After login, toggle between login and signup
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}