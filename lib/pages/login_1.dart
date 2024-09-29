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
  bool _isLoading = false;  // Track loading state
  String? _errorMessage;    // Track error message

  // Method to handle login
  Future<void> _login() async {
    setState(() {
      _isLoading = true;    // Show loading indicator
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
        email: _emailController.text,
        password: _passwordController.text,
      );
      
      // Navigate to home or dashboard page on successful login
      Navigator.pushReplacementNamed(context, '/home'); // Replace with your home route

    } catch (e) {
      setState(() {
        _errorMessage = 'Login failed. Please check your credentials.'; // Display error
      });
    } finally {
      setState(() {
        _isLoading = false; // Stop loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8E3B6),
      body: Stack(
        children: [
          // Center content
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF834D1E)),
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xFFFCF2D9),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        children: [
                          Text(
                            'Login',
                            style: GoogleFonts.getFont(
                              'Inter',
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
                                  style: GoogleFonts.getFont(
                                    'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: const Color(0xFF57280A),
                                  ),
                                ),
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
                                  style: GoogleFonts.getFont(
                                    'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: const Color(0xFF57280A),
                                  ),
                                ),
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
                                  ),
                                  child: Text(
                                    'Login',
                                    style: GoogleFonts.getFont(
                                      'Inter',
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
                              style: GoogleFonts.getFont(
                                'Inter',
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}