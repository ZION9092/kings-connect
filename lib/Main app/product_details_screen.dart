import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kings_connect/constants/colors.dart';
import 'package:kings_connect/constants/font_sizes.dart';
import 'package:kings_connect/controllers/cart_controller.dart';
import 'package:kings_connect/controllers/product_detail_controller.dart';
import 'package:kings_connect/models/laptop_model.dart';

class ProductDetailScreen extends ConsumerWidget {
  final Laptop product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = ref.watch(productDetailProvider);
    final cartController = ref.watch(cartProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios, color: AppColors.white)),
        backgroundColor: AppColors.primary,
        title: const Text(
          'Product Details',
          style: TextStyle(
            fontSize: FontSizes.headline3,
            fontWeight: FontSizes.bold,
            color: AppColors.white,
            letterSpacing: -1,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              product.imagePath,  // Access product's image
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              product.name,  // Access product's name
              style: const TextStyle(
                fontSize: FontSizes.headline4,
                fontWeight: FontSizes.bold,
                color: AppColors.primary,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '\$${product.price}',  // Access product's price
              style: const TextStyle(
                fontSize: FontSizes.headline5,
                fontWeight: FontSizes.bold,
                color: AppColors.primary,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'A fine laptop',
              style: TextStyle(
                fontSize: FontSizes.headline5,
                color: AppColors.textColor,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 50),
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: AppColors.errorColor,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.remove, color: AppColors.white),
                    onPressed: () => ref.read(productDetailProvider.notifier).decrementQuantity(),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '$quantity',
                  style: const TextStyle(
                    fontSize: FontSizes.headline5,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, color: AppColors.white),
                    onPressed: () => ref.read(productDetailProvider.notifier).incrementQuantity(),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    minimumSize: const Size(50, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    final isInCart = cartController.any((item) => item['name'] == product.name);  // Check by product name
                    if (isInCart) {
                      ref.read(cartProvider.notifier).removeFromCart({
                        'image': product.imagePath,
                        'name': product.name,
                        'price': product.price,
                        'quantity': quantity,
                      });
                    } else {
                      ref.read(cartProvider.notifier).addToCart({
                        'image': product.imagePath,
                        'name': product.name,
                        'price': product.price,
                        'quantity': quantity,
                      });
                    }
                  },
                  child: Text(
                    cartController.any((item) => item['name'] == product.name)
                        ? 'Remove from Cart'
                        : 'Add to Cart',
                    style: const TextStyle(
                      letterSpacing: -1,
                      color: AppColors.white,
                      fontSize: FontSizes.headline5,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

