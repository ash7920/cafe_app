import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cafe_lp/auth.dart'; // Import the Auth class
import 'package:firebase_auth/firebase_auth.dart'; // For Firebase-specific errors

class Toggle extends StatefulWidget {
  const Toggle({super.key});

  @override
  _ToggleState createState() => _ToggleState();
}

class _ToggleState extends State<Toggle> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isLoading = false; // To show a loading state
  String _errorMessage = ''; // To display error messages

  final Auth _auth = Auth(); // Create an instance of the Auth class

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Method to handle login
  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        pass: _passwordController.text.trim(),
      );
      // Handle successful login (e.g., navigate to home page)
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'An error occurred during login.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Method to handle sign up
  Future<void> _signup() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _errorMessage = 'Passwords do not match!';
        _isLoading = false;
      });
      return;
    }

    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        pass: _passwordController.text.trim(),
      );
      // Handle successful signup (e.g., navigate to home page)
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'An error occurred during signup.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8E3B6),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/unsplashd_9_vs_o_3166_ui.jpeg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0x4D834D1E),
              ),
            ),
          ),
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
                          TabBar(
                            controller: _tabController,
                            tabs: const [
                              Tab(text: 'Login'),
                              Tab(text: 'Sign Up'),
                            ],
                            labelColor: const Color(0xFF834D1E),
                            unselectedLabelColor: Colors.grey,
                            indicatorColor: const Color(0xFF834D1E),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 300, // Adjust as needed
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                // Login Tab
                                _buildLoginTab(),
                                // Sign Up Tab
                                _buildSignupTab(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_isLoading) const CircularProgressIndicator(),
                  if (_errorMessage.isNotEmpty)
                    Text(
                      _errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget for Login Tab
  Widget _buildLoginTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          _buildTextField(
            controller: _emailController,
            label: 'Email',
            hintText: 'Enter your email',
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _passwordController,
            label: 'Password',
            hintText: 'Enter your password',
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _login, // Call login method
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
        ],
      ),
    );
  }

  // Widget for Sign Up Tab
  Widget _buildSignupTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          _buildTextField(
            controller: _emailController,
            label: 'Email',
            hintText: 'Enter your email',
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _passwordController,
            label: 'Password',
            hintText: 'Enter your password',
            obscureText: true,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _confirmPasswordController,
            label: 'Confirm Password',
            hintText: 'Confirm your password',
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _signup, // Call signup method
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF834D1E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              'Sign Up',
              style: GoogleFonts.getFont(
                'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: const Color(0xFFFCF2D9),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable TextField widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.getFont(
            'Inter',
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: const Color(0xFF57280A),
          ),
        ),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF834D1E),
            border: const OutlineInputBorder(),
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}