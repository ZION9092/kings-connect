import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isObscure = true; // managing visibility of the password field
  bool _isLoading = false; // managing loading state

  bool get isObscure => _isObscure;
  bool get isLoading => _isLoading;

  final FirebaseAuth _auth = FirebaseAuth.instance; // FirebaseAuth instance

  // Method to toggle password visibility
  void togglePasswordVisibility() {
    _isObscure = !_isObscure;
  }

  // Method to clear the controllers and dispose when done
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  // Firebase login logic with loading state management
  Future<String?> login() async {
    if (!areFieldsFilled()) {
      return 'Please fill in all fields.';
    }

    _isLoading = true; // Start loading
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      return userCredential.user != null ? "Login Successful" : "Login Failed";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided.';
      } else {
        return 'Error: ${e.message}';
      }
    } finally {
      _isLoading = false; // End loading
    }
  }

  // Check if email and password fields are filled
  bool areFieldsFilled() {
    return emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
  }
}

