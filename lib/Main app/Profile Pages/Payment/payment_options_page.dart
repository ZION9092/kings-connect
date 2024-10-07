import 'package:flutter/material.dart';
import 'package:kings_connect/Main%20app/Profile%20Pages/Payment/credit_card_input_form.dart';
import 'package:kings_connect/constants/colors.dart';
import 'package:kings_connect/constants/font_sizes.dart';

class PaymentOptionsPage extends StatelessWidget {
  const PaymentOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white
      ,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Payment Methods', style: TextStyle(color: AppColors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: const [
            PaymentMethodTile(
              imagePath: 'assets/images/visa.png',
              name: 'Visa',
            ),
            SizedBox(height: 30),
            PaymentMethodTile(
              imagePath: 'assets/images/mastercard.png',
              name: 'MasterCard',
            ),
            SizedBox(height: 30),
            PaymentMethodTile(
              imagePath: 'assets/images/paypal.png',
              name: 'PayPal',
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodTile extends StatelessWidget {
  final String imagePath;
  final String name;

  const PaymentMethodTile({
    super.key,
    required this.imagePath,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.white, width: 0.5)),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(
            imagePath,  // Use the image here
            width: 40,
            height: 40,
          ),
        ),
        title: Text(name, style: const TextStyle(letterSpacing: -1,fontSize: FontSizes.headline4)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {
           Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreditCardInputForm()),
          );
        },
      ),
    );
  }
}
