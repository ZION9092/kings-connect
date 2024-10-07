import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kings_connect/constants/colors.dart';
import 'package:kings_connect/constants/font_sizes.dart';
import 'package:kings_connect/controllers/cart_controller.dart';
import 'package:kings_connect/models/cart_model.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the cart provider to get the list of cart items
    final cartItems = ref.watch(cartProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.white,
            )),
        backgroundColor: AppColors.primary,
        title: const Text(
          'Your Cart',
          style: TextStyle(
            fontSize: FontSizes.headline3,
            fontWeight: FontSizes.bold,
            color: AppColors.white,
            letterSpacing: -1,
          ),
        ),
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(
                  fontSize: FontSizes.headline4,
                  color: AppColors.textColor,
                  letterSpacing: -1,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return CartItemCard(
                    image: item['image'],
                    name: item['name'],
                    price: item['price'],
                    quantity: item['quantity'],
                  );
                },
              ),
            ),
      bottomNavigationBar: cartItems.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the checkout screen or handle checkout
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: const Text(
                  'Proceed to Checkout',
                  style: TextStyle(
                    fontSize: FontSizes.headline5,
                    color: AppColors.white,
                    letterSpacing: -1,
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
