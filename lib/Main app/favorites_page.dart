import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kings_connect/constants/colors.dart';
import 'package:kings_connect/constants/font_sizes.dart';
import 'package:kings_connect/controllers/favorites_controllers.dart';


class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteProducts = ref.watch(favoritesProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Favorites',
        style: TextStyle(
           fontSize: FontSizes.headline1,
           fontWeight: FontSizes.bold,
           letterSpacing: -1,
           color: AppColors.white,
          ),

        
        ),
      ),
      body: favoriteProducts.isEmpty
          ? const Center(
              child: Text('No favorites yet!'),
            )
          : ListView.builder(
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts.elementAt(index);

                return ListTile(
                  title: Text(product.name), // Display product details
                  subtitle: Text(product.description),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      // Remove product from favorites if clicked
                      ref.read(favoritesProvider.notifier).toggleFavorite(product);
                    },
                  ),
                );
              },
            ),
    );
  }
}
