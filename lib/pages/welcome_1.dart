import 'package:cafe_lp/pages/toggle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Welcome1 extends StatelessWidget {
  const Welcome1({super.key});

  // Method to add a delay before navigation
  void _navigateToToggle(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Toggle(), // Navigate to the Toggle page
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Trigger the navigation after a delay
    _navigateToToggle(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/pictures/welcome.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Dark overlay
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0x4D834D1E), // Overlay color
              ),
            ),
          ),
          // Text content (title and description)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Main title (Co/Choc)
                Text(
                  'Co/Choc',
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.w700,
                    fontSize: 40,
                    letterSpacing: 10,
                    color: const Color(0xFF020202),
                  ),
                ),
                const SizedBox(
                    height: 10), // Add some spacing between title and subtitle
                // Subtitle (description)
                Text(
                  'A way to enjoy bitter and sweet of life',
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    letterSpacing: 1,
                    color: const Color(0xFF000000),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
