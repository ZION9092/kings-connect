// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kings_connect/constants/colors.dart';
import 'package:kings_connect/constants/font_sizes.dart';
import 'package:kings_connect/controllers/forget_password_controller.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late ForgetPasswordController _forgetPasswordController;

  @override
  void initState() {
    super.initState();
    _forgetPasswordController = ForgetPasswordController();
    _forgetPasswordController.emailController.addListener(() {
      setState(() {}); // To update elevated button when email is entered or not
    });
  }

  @override
  void dispose() {
    _forgetPasswordController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (_forgetPasswordController.isEmailEntered) {
      try {
        await _forgetPasswordController.sendPasswordResetEmail();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset email sent. Check your inbox.'),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send password reset email: $e'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email address.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/login');
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.primary,
          ),
        ),
        backgroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/password.jpg",
                height: 200,
                alignment: Alignment.center,
              ),
              const SizedBox(height: 15),
              const Text(
                "Forgot Password",
                style: TextStyle(
                    fontWeight: FontSizes.bold,
                    fontSize: FontSizes.headline1,
                    letterSpacing: -1,
                    color: AppColors.primary),
              ),
              const SizedBox(height: 10),
              const Text(
                "Please enter your email to reset the password",
                style: TextStyle(
                  fontSize: FontSizes.headline6,
                  color: AppColors.cardColor,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _forgetPasswordController.emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: const TextStyle(
                    color: AppColors.primary,
                    letterSpacing: -1,
                  ),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  hintText: 'Enter your email',
                  hintStyle: const TextStyle(
                    color: AppColors.primary,
                    letterSpacing: -1,
                  ),
                ),
                style: const TextStyle(letterSpacing: -1),
                keyboardType: TextInputType.emailAddress,
                cursorColor: AppColors.primary,
                cursorHeight: 15,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _forgetPasswordController.isEmailEntered
                      ? AppColors.primary
                      : AppColors.primary.withOpacity(0.5),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _resetPassword,
                child: const Text(
                  "Reset Password",
                  style: TextStyle(
                      letterSpacing: -1,
                      color: AppColors.white,
                      fontSize: FontSizes.headline4,
                      fontWeight: FontSizes.regular),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.white,
    );
  }
}


