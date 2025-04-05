import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cafe_lp/theme/colours.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _imageFile;

  Future<Map<String, dynamic>> fetchUserProfile() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        debugPrint("No user is logged in.");
        throw Exception("User not logged in");
      }

      debugPrint("Fetching profile for UID: ${user.uid}");
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      if (!doc.exists) {
        debugPrint("Profile document does not exist for UID: ${user.uid}");
        throw Exception("User profile not found");
      }

      debugPrint("Profile data: ${doc.data()}");
      return doc.data() as Map<String, dynamic>;
    } catch (e) {
      debugPrint("Error fetching profile: $e");
      throw Exception("Failed to load profile information: $e");
    }
  }

  void handleLogout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/welcome');
  }

  void pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void navigateToOrderHistory(BuildContext context) {
    Navigator.pushNamed(context, '/orderHistory'); // Make sure you have this route in your app
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FutureBuilder<Map<String, dynamic>>(
              future: fetchUserProfile(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(color: primaryColor);
                } else if (snapshot.hasError) {
                  return Text(
                    "Error: ${snapshot.error}",
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  );
                } else if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile picture
                      Center(
                        child: GestureDetector(
                          onTap: pickImage,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                _imageFile != null ? FileImage(_imageFile!) : null,
                            backgroundColor: Colors.grey[300],
                            child: _imageFile == null
                                ? const Icon(Icons.add_a_photo, size: 40, color: Colors.white)
                                : null,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // User information
                      Text(
                        "Name: ${data['name'] ?? 'Not available'}",
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Email: ${data['email'] ?? 'Not available'}",
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Text(
                    "No profile data available.",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  );
                }
              },
            ),
            Column(
              children: [
                // Order history button
                GestureDetector(
                  onTap: () => navigateToOrderHistory(context),
                  child: Container(
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history,
                          color: Colors.grey[800],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Order History",
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Logout button
                GestureDetector(
                  onTap: () => handleLogout(context),
                  child: Container(
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.grey[800],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
