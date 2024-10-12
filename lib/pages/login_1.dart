import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cafe_lp/pages/sign_up_1.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login1 extends StatefulWidget {
  const Login1({super.key});

 @override
  _Login1State createState() => _Login1State();
}

class _Login1State extends State<Login1> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false; // Track loading state
  String? _errorMessage; // Track error message

  // Method to handle login
  Future<void> _login() async {
    setState(() {
      _isLoading = true; // Show loading indicator
      _errorMessage = null; // Reset error message
    });

    try {
      // Input validation
      if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
        setState(() {
          _errorMessage = 'Email and password cannot be empty';
        });
        return;
      }

      // Firebase login
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Navigate to home or dashboard page on successful login
      Navigator.pushReplacementNamed(context, '/home'); // Replace with your home route
    } on FirebaseAuthException catch (e) {
      // Specific Firebase authentication errors
      setState(() {
        switch (e.code) {
          case 'invalid-email':
            _errorMessage = 'The email address is not valid.';
            break;
          case 'user-disabled':
            _errorMessage = 'This user has been disabled.';
            break;
          case 'user-not-found':
            _errorMessage = 'No user found for this email.';
            break;
          case 'wrong-password':
            _errorMessage = 'Incorrect password.';
            break;
          default:
            _errorMessage = 'Login failed. Please try again.';
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred.';
      });
    } finally {
      setState(() {
        _isLoading = false; // Stop loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine screen size for responsive design
    final Size screenSize = MediaQuery.of(context).size;
    final double containerWidth = screenSize.width * 0.85; // 85% of screen width
    final double containerHeight = screenSize.height * 0.6; // 60% of screen height

    return Scaffold(
      backgroundColor: const Color(0xFFF8E3B6),
      body: Center(
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
                    'Login',
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
                  // Show error message if present
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  // Loading indicator and login button
                  _isLoading
                      ? const CircularProgressIndicator() // Show loading
                      : ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF834D1E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: const Size(double.infinity, 50), // Make button full width
                          ),
                          child: Text(
                            'Login',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: const Color(0xFFFCF2D9),
                            ),
                          ),
                        ),
                  const SizedBox(height: 20),
                  // Sign up navigation
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUp1(),
                        ),
                      );
                    },
                    child: Text(
                      "Don't have an account? Sign up!",
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
    );
  }
}