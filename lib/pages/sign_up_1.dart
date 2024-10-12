import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp1 extends StatefulWidget {
  const SignUp1({super.key});

  @override
  _SignUp1State createState() => _SignUp1State();
}

class _SignUp1State extends State<SignUp1> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  String? _errorMessage;

  // Method to handle signup
  Future<void> _signUp() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Input validation
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'All fields are required.';
        _isLoading = false;
      });
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _errorMessage = 'Passwords do not match';
        _isLoading = false;
      });
      return;
    }

    try {
      // Firebase signup
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Navigate to the home or login page after successful signup
      Navigator.pushReplacementNamed(context, '/home'); // Replace with your desired route
    } on FirebaseAuthException catch (e) {
      // Specific Firebase authentication errors
      setState(() {
        switch (e.code) {
          case 'email-already-in-use':
            _errorMessage = 'This email is already in use.';
            break;
          case 'invalid-email':
            _errorMessage = 'The email address is not valid.';
            break;
          case 'operation-not-allowed':
            _errorMessage = 'Operation not allowed. Please contact support.';
            break;
          case 'weak-password':
            _errorMessage = 'The password is too weak.';
            break;
          default:
            _errorMessage = 'Sign up failed. Please try again.';
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine screen size for responsive design
    final Size screenSize = MediaQuery.of(context).size;
    final double containerWidth = screenSize.width * 0.85; // 85% of screen width
    final double containerHeight = screenSize.height * 0.7; // 70% of screen height

    return Scaffold(
      backgroundColor: const Color(0xFFF8E3B6),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/unsplashd_9_vs_o_3166_ui.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Overlay
          Positioned.fill(
            child: Container(
              color: const Color(0x4D834D1E),
            ),
          ),
          Center(
            child: SizedBox(
              width: containerWidth,
              height: containerHeight,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF834D1E)),
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xFFFCF2D9),
                ),
                padding: const EdgeInsets.all(25),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Sign Up',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: const Color(0xFF834D1E),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Email input field
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: const Color(0xFF57280A),
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color(0xFF834D1E),
                                border: OutlineInputBorder(),
                                hintText: 'Enter your email',
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Password input field
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Password',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: const Color(0xFF57280A),
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color(0xFF834D1E),
                                border: OutlineInputBorder(),
                                hintText: 'Enter your password',
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Confirm Password input field
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Confirm Password',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: const Color(0xFF57280A),
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextField(
                              controller: _confirmPasswordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color(0xFF834D1E),
                                border: OutlineInputBorder(),
                                hintText: 'Confirm your password',
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Show error message if present
                      if (_errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      // Loading indicator and sign-up button
                      _isLoading
                          ? const CircularProgressIndicator() // Show loading spinner
                          : ElevatedButton(
                              onPressed: _signUp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF834D1E),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                minimumSize: const Size(double.infinity, 50), // Make button full width
                              ),
                              child: Text(
                                'Sign Up',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: const Color(0xFFFCF2D9),
                                ),
                              ),
                            ),
                      const SizedBox(height: 20),
                      // Navigate back to login if needed
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Go back to the previous screen
                        },
                        child: Text(
                          "Already have an account? Login!",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: const Color(0xFF834D1E),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}