import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kings_connect/constants/colors.dart';
import 'package:kings_connect/constants/font_sizes.dart';
import 'package:kings_connect/controllers/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _controller = LoginController();
  bool _isLoading = false; // To handle loading state

  @override
  void initState() {
    super.initState();
    // Optional: Add listeners if you need to update UI on text field changes
    _controller.emailController.addListener(_validateForm);
    _controller.passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {}); // Refresh UI based on changes
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });
    String? result = await _controller.login();
    setState(() {
      _isLoading = false;
    });
    if (result == "Login Successful") {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result!)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Image
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Image.asset(
                  'assets/images/login_image.jpeg',
                  height: 150,
                ),
              ),
            ),
            const SizedBox(height: 25),
            // Welcome Back and Login Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: FontSizes.headline1,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Login!',
                    style: TextStyle(
                      fontSize: FontSizes.headline2,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Email TextField
                  TextField(
                    controller: _controller.emailController,
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
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: AppColors.primary,
                    cursorHeight: 15,
                    style: const TextStyle(
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Password TextField
                  TextField(
                    controller: _controller.passwordController,
                    obscureText: _controller.isObscure,
                    decoration: InputDecoration(
                      labelText: 'Password',
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
                      hintText: 'Create your Password',
                      hintStyle: const TextStyle(
                        color: AppColors.primary,
                        letterSpacing: -1,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _controller.isObscure
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.primary,
                        ),
                        onPressed: () {
                          setState(() {
                            _controller.togglePasswordVisibility();
                          });
                        },
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    cursorColor: AppColors.primary,
                    cursorHeight: 15,
                    style: const TextStyle(
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/forgotPassword");
                    },
                    child: const Text(
                      "Forgot Password",
                      style: TextStyle(
                        fontSize: FontSizes.headline6,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        letterSpacing: -1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _controller.areFieldsFilled()
                            ? AppColors.primary
                            : AppColors.primary.withOpacity(0.5),
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: _controller.areFieldsFilled() && !_isLoading
                              ? () async {
                                  await _login();
                                }
                              : null,
                              child: _isLoading
                            ? const CupertinoActivityIndicator(
                              color: AppColors.white,
                            ) 
                            : const Text(
                            "Login",
                            style: TextStyle(
                                letterSpacing: -1,
                                color: AppColors.white,
                                fontSize: FontSizes.headline4,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                  const SizedBox(height: 30),
                  // Divider with "or login using"
                  const Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Divider(),
                        ),
                      ),
                      Text(
                        "or login using",
                        style: TextStyle(
                          letterSpacing: -1,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Divider(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  // Facebook Login Button
                  ElevatedButton(
                    onPressed: () {
                      // Handle Facebook login here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800], // Facebook blue
                      minimumSize: const Size(double.infinity, 50), // Full width
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/facebook.svg"),
                        const SizedBox(width: 10),
                        const Text(
                          "Login with Facebook",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSizes.headline5,
                            letterSpacing: -1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Google Login Button
                  OutlinedButton(
                    onPressed: () {
                      // Handle Google login here
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.white, // Google red
                      minimumSize: const Size(double.infinity, 50), // Full width
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/google.svg"),
                        const SizedBox(width: 10),
                        const Text(
                          "Login with Google",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: FontSizes.headline5,
                            letterSpacing: -1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        "New to King's Connect?",
                        style: TextStyle(
                            letterSpacing: -1,
                            fontWeight: FontSizes.regular,
                            fontSize: FontSizes.headline6),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/register');
                          },
                          child: const Text(
                            "Register Here",
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontSizes.bold,
                                letterSpacing: -1,
                                fontSize: FontSizes.headline6),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

