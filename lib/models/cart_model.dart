import 'package:flutter/material.dart';
import 'package:kings_connect/constants/colors.dart';
import 'package:kings_connect/constants/font_sizes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kings_connect/controllers/cart_controller.dart';

class CartItemCard extends ConsumerWidget {
  final String image;
  final String name;
  final String price;
  final int quantity;

  const CartItemCard({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        boxShadow:[ BoxShadow(
          color: Colors.grey.withOpacity(0),
          spreadRadius: 2,
              blurRadius: 5,
        ),
       ]
      ),
      child: Card(
        color: AppColors.white,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: 70,
                width: 90,
                fit: BoxFit.fill,
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: FontSizes.headline5,
                        fontWeight: FontSizes.bold,
                        color: AppColors.primary,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      // ignore: unnecessary_string_interpolations
                      '$price',
                      style: const TextStyle(
                        fontSize: FontSizes.headline6,
                        color: AppColors.textColor,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Quantity: $quantity',
                      style: const TextStyle(
                        fontSize: FontSizes.bodyText1,
                        color: AppColors.textColor,
                        letterSpacing: -1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // Use ref.read to access and remove the item from the cart
                  ref.read(cartProvider.notifier).removeFromCart({
                    'name': name,
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

