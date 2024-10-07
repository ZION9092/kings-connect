import 'package:flutter/material.dart';
import 'package:kings_connect/Main%20app/Profile%20Pages/Payment/payment_options_page.dart';
import 'package:kings_connect/constants/colors.dart';
import 'package:kings_connect/constants/font_sizes.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Select Payment Method',
          style:TextStyle(
            color:AppColors.white,
            letterSpacing:-1,
            fontSize: FontSizes.headline2,
            fontWeight: FontSizes.bold,
          )
         ),
          backgroundColor: AppColors.primary,
          leading: GestureDetector(
            onTap: (){Navigator.pop(context);},
            child: const Icon(Icons.arrow_back_ios, color: AppColors.white,)
            ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextButton(onPressed: (){
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PaymentOptionsPage()),
                  );
                  }, 
                   style: ButtonStyle(
                    overlayColor: WidgetStateProperty.resolveWith<Color?>(
                     (Set<WidgetState> states) {
                      if (states.contains(WidgetState.pressed)) {
                       return AppColors.primary.withOpacity(0.5); // Lemon-green shade when clicked
                   }
                   return null; // Default overlay color if not clicked
                  },
                ),
               ),
                  child: const Text("Add Payment Methods",
                  style: TextStyle(
                    color:AppColors.primary,
                    letterSpacing: -1,
                    fontSize: FontSizes.headline3,
                    fontWeight: FontSizes.regular,
                  ),
                 ),
                )
              ]
            )
           ),
            backgroundColor: AppColors.white,
        );
      }
     }
