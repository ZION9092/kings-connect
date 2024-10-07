import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:kings_connect/Main%20app/Auth%20pages/forgot_password.dart';
// import 'package:kings_connect/Main%20app/Auth%20pages/login_screen.dart';
// import 'package:kings_connect/Main%20app/Profile%20Pages/edit_profile_screen.dart';
// import 'package:kings_connect/Main%20app/Profile%20Pages/profile_page.dart';
// import 'package:kings_connect/Main%20app/cart_page.dart';
 import 'package:kings_connect/Main%20app/main_page.dart';
// import 'package:kings_connect/Main%20app/Auth%20pages/register_screen.dart';
// import 'package:kings_connect/Main%20app/product_details_screen.dart';
// import 'package:kings_connect/models/laptop_model.dart';
// import 'package:kings_connect/onboarding/onboarding_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "King's Connect",
          theme: ThemeData(
            primarySwatch: Colors.green,
            fontFamily: 'InriaSans',
          ),
          home: const MainPage(),
         // initialRoute: '/onboarding',
          // routes: {
          //   '/onboarding': (context) => const OnboardingPage(),
          //   '/login': (context) => const LoginScreen(),
          //   '/register': (context) => const RegisterScreen(),
          //   '/forgotPassword': (context) => const ForgotPassword(),
          //   '/home': (context) => const MainPage(),
          //   '/profile': (context) => const ProfilePage(),
          //   '/edit-profile': (context) => const EditProfileScreen(),
          //   '/cart': (context) => const CartScreen(),
          //   '/product-detail': (context) {
          //      final product = ModalRoute.of(context)!.settings.arguments as Laptop;  // Expecting a Laptop object
          //      return ProductDetailScreen(product: product);
          //    },
             
          //   },
        ),
    );
  }
}
