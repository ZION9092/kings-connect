import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Import Cupertino package for loading indicator
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kings_connect/constants/colors.dart';
import 'package:kings_connect/constants/font_sizes.dart';
import 'package:kings_connect/controllers/register_ontroller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController _controller = RegisterController();
  bool _isLoading = false; // Add a loading state variable

  @override
  void initState() {
    super.initState();
    _controller.firstNameController.addListener(_validateForm);
    _controller.lastNameController.addListener(_validateForm);
    _controller.emailController.addListener(_validateForm);
    _controller.passwordController.addListener(_validateForm);
    _controller.createPasswordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _controller.updateFormValidation();
    });
  }

  Future<void> _register() async {
    setState(() {
      _isLoading = true; // Set loading state to true
    });

    final result = await _controller.registerNewUser();
    if (result == "Registration Successful") {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result ?? 'Unknown error')),
      );
    }

    setState(() {
      _isLoading = false; // Set loading state to false
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: Stack(children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Image
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Center(
                    child: Image.asset(
                      'assets/images/register_image.jpeg',
                      height: 150,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Welcome to King's Connect",
                        style: TextStyle(
                          fontSize: FontSizes.headline1,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -1,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'SignUp!',
                        style: TextStyle(
                          fontSize: FontSizes.headline2,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -1,
                        ),
                      ),
                      const SizedBox(height: 30),
                      //firstName Textfield
                      TextField(
                        controller: _controller.firstNameController,
                        decoration: InputDecoration(
                          labelText: 'First Name',
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
                          hintText: 'Enter your first name',
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
                      //lastName Textfield
                      TextField(
                        controller: _controller.lastNameController,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
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
                          hintText: 'Enter your last name',
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

                      const SizedBox(height: 20),
                      // Confirm Password TextField
                      TextField(
                        controller: _controller.createPasswordController,
                        obscureText: _controller.isObscure,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
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
                          hintText: 'Confirm Password',
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
                      const SizedBox(height: 25),
                      // Signup Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _controller.isFormValid
                              ? AppColors.primary
                              : AppColors.primary.withOpacity(0.5),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: _controller.isFormValid
                            ? () async {
                                if (!_isLoading) {
                                  // Prevent multiple taps
                                  await _register();
                                }
                              }
                            : null,
                        child: _isLoading
                            ? const CupertinoActivityIndicator(
                                color: AppColors.white,
                              ) // Show loading indicator
                            : const Text(
                                "SignUp",
                                style: TextStyle(
                                    letterSpacing: -1,
                                    color: AppColors.white,
                                    fontSize: FontSizes.headline4,
                                    fontWeight: FontWeight.w700),
                              ),
                      ),
                      const SizedBox(height: 30),
                      const Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Divider(),
                            ),
                          ),
                          Text(
                            "or signup using",
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
                      // Facebook Signup Button
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[800], // Facebook blue
                          minimumSize:
                              const Size(double.infinity, 50), // Full width
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
                              "Signup with Facebook",
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
                      // Google Signup Button
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.white, // Google red
                          minimumSize:
                              const Size(double.infinity, 50), // Full width
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
                              "Signup with Google",
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
                            "Already have an account?",
                            style: TextStyle(
                                letterSpacing: -1,
                                fontWeight: FontSizes.regular,
                                fontSize: FontSizes.headline6),
                          ),
                          //const SizedBox(width:1),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/login');
                              },
                              child: const Text(
                                "Login Here",
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
        ]));
  }
}
