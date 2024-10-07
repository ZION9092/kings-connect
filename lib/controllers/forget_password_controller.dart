import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPasswordController {
  final TextEditingController emailController = TextEditingController();
  bool isEmailEntered = false;

  ForgetPasswordController() {
    emailController.addListener(_checkEmailEntered);
  }

  void _checkEmailEntered() {
    isEmailEntered = emailController.text.isNotEmpty;
  }

  Future<void> sendPasswordResetEmail() async {
    try {
      String email = emailController.text;
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow; // Forward the error to be handled in the UI
    }
  }

  void dispose() {
    emailController.dispose();
  }
}


