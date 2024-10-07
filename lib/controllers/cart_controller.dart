import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartController extends StateNotifier<List<Map<String, dynamic>>> {
  CartController() : super([]);

  void addToCart(Map<String, dynamic> product) {
    state = [...state, product];
  }

  void removeFromCart(Map<String, dynamic> product) {
    state = state.where((item) => item['name'] != product['name']).toList();
  }

  bool isInCart(String name) {
    return state.any((item) => item['name'] == name);
  }
}

// Provider for the cart controller
final cartProvider = StateNotifierProvider<CartController, List<Map<String, dynamic>>>((ref) {
  return CartController();
});
