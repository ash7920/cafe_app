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

  bool _obscureLoginPassword = true;
  bool _obscureSignupPassword = true;
  bool _obscureSignupConfirmPassword = true;

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
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in all fields.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        pass: _passwordController.text.trim(),
      );
      // No manual navigation; AuthWrapper will handle it
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'An error occurred during login.';
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

  // Method to handle sign up
  Future<void> _signup() async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in all fields.';
      });
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _errorMessage = 'Passwords do not match!';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        pass: _passwordController.text.trim(),
      );
      // No manual navigation; AuthWrapper will handle it
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'An error occurred during signup.';
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

  // Reusable TextField widget with optional password toggle
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    bool obscureText = false,
    VoidCallback? toggleVisibility,
    IconData? prefixIcon,
    IconData? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: const Color(0xFF57280A),
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF834D1E).withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            hintText: hintText,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            suffixIcon: suffixIcon != null
                ? IconButton(
                    icon: Icon(suffixIcon),
                    onPressed: toggleVisibility,
                  )
                : null,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8E3B6),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
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
            // Overlay
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0x4D834D1E),
                ),
              ),
            ),
            // Main content
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF834D1E)),
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xFFFCF2D9).withOpacity(0.9),
                      ),
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
                          TabBarView(
                            controller: _tabController,
                            children: [
                              // Login Tab
                              _buildLoginTab(),
                              // Sign Up Tab
                              _buildSignupTab(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (_isLoading) const CircularProgressIndicator(),
                    if (_errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          _errorMessage,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
            prefixIcon: Icons.email,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _passwordController,
            label: 'Password',
            hintText: 'Enter your password',
            obscureText: _obscureLoginPassword,
            prefixIcon: Icons.lock,
            suffixIcon: _obscureLoginPassword ? Icons.visibility : Icons.visibility_off,
            toggleVisibility: () {
              setState(() {
                _obscureLoginPassword = !_obscureLoginPassword;
              });
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _login, // Call login method
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF834D1E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              minimumSize: const Size(double.infinity, 50), // Full width
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
            prefixIcon: Icons.email,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _passwordController,
            label: 'Password',
            hintText: 'Enter your password',
            obscureText: _obscureSignupPassword,
            prefixIcon: Icons.lock,
            suffixIcon: _obscureSignupPassword ? Icons.visibility : Icons.visibility_off,
            toggleVisibility: () {
              setState(() {
                _obscureSignupPassword = !_obscureSignupPassword;
              });
            },
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _confirmPasswordController,
            label: 'Confirm Password',
            hintText: 'Confirm your password',
            obscureText: _obscureSignupConfirmPassword,
            prefixIcon: Icons.lock,
            suffixIcon: _obscureSignupConfirmPassword ? Icons.visibility : Icons.visibility_off,
            toggleVisibility: () {
              setState(() {
                _obscureSignupConfirmPassword = !_obscureSignupConfirmPassword;
              });
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _signup, // Call signup method
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF834D1E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              minimumSize: const Size(double.infinity, 50), // Full width
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
        ],
      ),
    );
  }
}