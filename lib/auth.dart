import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Getter for the current user
  User? get currentUser => _firebaseAuth.currentUser;

  // Stream to listen to authentication state changes
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Sign in with email and password
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password, required String pass,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Create a user with email, password, and name, and store user info in Firestore
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name, required String pass,
  }) async {
    // Create user in Firebase Authentication
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Store additional user info (name, email) in Firestore
    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'name': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(), // Timestamp for record creation
    });
  }

  /// Sign out the current user
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
