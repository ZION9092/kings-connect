import 'package:flutter/material.dart';
import 'package:kings_connect/controllers/favorites_controllers.dart';
import 'package:kings_connect/models/laptop_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; 
import 'package:kings_connect/constants/colors.dart';

class ProductCard extends ConsumerWidget {
  final Laptop product;

  const ProductCard({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access your favorite controller or state using Riverpod
    final favoritesController = ref.watch(favoritesProvider.notifier); 
    final isFavorite = ref.watch(favoritesProvider).contains(product);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product-detail',
          arguments: product,
        );
      },
      child: Card(
        color: AppColors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  product.imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${product.price}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 8,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  if (isFavorite) {
                    favoritesController.removeFromFavorites(product);
                  } else {
                    favoritesController.addToFavorites(product);
                  }
                },
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

