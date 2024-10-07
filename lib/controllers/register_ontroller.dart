import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kings_connect/Firebase/firebase_helper.dart'; // Import FirebaseHelper
import 'package:kings_connect/models/user_model.dart'; // Import UserModel

class RegisterController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController createPasswordController = TextEditingController();

  bool isObscure = true;
  bool isFormValid = false;
  bool _isLoading = false; // field to manage loading state

  bool get isLoading => _isLoading; // loading state getter

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    createPasswordController.dispose();
  }

  void togglePasswordVisibility() {
    isObscure = !isObscure;
  }

  void updateFormValidation() {
    // final firstName = firstNameController.text.trim();
    // final lastName = lastNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = createPasswordController.text.trim();

    if (_isValidEmail(email) &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        password == confirmPassword) {
      isFormValid = true;
    } else {
      isFormValid = false;
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    return emailRegex.hasMatch(email);
  }

  Future<String?> registerNewUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (!_isValidEmail(email)) {
      return "Invalid email address.";
    }

    if (password.length < 6) {
      return "Password must be at least 6 characters.";
    }

    if (password != createPasswordController.text.trim()) {
      return "Passwords do not match.";
    }

    _isLoading = true; // loading state set to true
    try {
      // Register user with firebase
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create a UserModel instance
      UserModel user = UserModel(
        fullName: '${firstNameController.text.trim()} ${lastNameController.text.trim()}',
        email: email,
        profileImageUrl: '', // Add a default or empty URL
      );

      // Save user data in Firestore
      await FirebaseHelper().saveUserData(user, userCredential.user!.uid);

      return "Registration Successful";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return 'An unexpected error occurred.';
      }
    } catch (e) {
      return 'An error occurred';
    } finally {
      _isLoading = false; // loading state set to false
    }
  }
}

