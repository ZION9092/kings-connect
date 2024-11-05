import 'package:flutter/material.dart';
import 'package:kings_connect/constants/colors.dart';
import 'package:kings_connect/constants/font_sizes.dart';


class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Image.asset("assets/images/onboarding image.jpg",
            height: 500,
            ),

            const SizedBox(height: 30),
            const Text(
              "Welcome to King's Connect",
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: FontSizes.headline2,
                fontWeight: FontSizes.bold,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 60), 
            
            ElevatedButton(
             style: ButtonStyle(
             backgroundColor: WidgetStateProperty.all(Colors.green),
             minimumSize:WidgetStateProperty.all(const Size(500, 50)),
             shape: WidgetStateProperty.all(
             const RoundedRectangleBorder(
             borderRadius: BorderRadius.all(
              Radius.circular(10)
               ),
              )
            ),
          ),
          onPressed: (){
           Navigator.pushReplacementNamed(context, '/home');
          },
              child: const Text(
                'Get Started',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: FontSizes.bodyText1,
                  fontWeight: FontSizes.bold,
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}