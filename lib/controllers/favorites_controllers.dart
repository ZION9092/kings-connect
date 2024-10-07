import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kings_connect/models/laptop_model.dart';

// State notifier to handle favorites
class FavoritesController extends StateNotifier<List<Laptop>> {
  FavoritesController() : super([]);

  // Method to toggle favorite status
  void toggleFavorite(Laptop product) {
    if (isFavorite(product)) {
      removeFromFavorites(product);
    } else {
      addToFavorites(product);
    }
  }

  // Method to add a product to favorites
  void addToFavorites(Laptop product) {
    if (!state.contains(product)) {
      state = [...state, product];
    }
  }

  // Method to remove a product from favorites
  void removeFromFavorites(Laptop product) {
    state = state.where((item) => item != product).toList();
  }

  // Check if a product is already favorited
  bool isFavorite(Laptop product) {
    return state.contains(product);
  }
}

// Provider for the favorites controller
final favoritesProvider = StateNotifierProvider<FavoritesController, List<Laptop>>((ref) {
  return FavoritesController();
});


