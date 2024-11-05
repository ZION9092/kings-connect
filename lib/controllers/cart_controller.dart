import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartController extends StateNotifier<List<Map<String, dynamic>>> {
  CartController() : super([]);

 void addToCart(Map<String, dynamic> product) {
  if (product['name'] != null && product['quantity'] != null && product['price'] != null) {
    state = [...state, product];
  } else {
    // Optionally handle the case where product data is incomplete
    print('Attempted to add a product with missing fields: $product');
  }
}



  void removeFromCart(Map<String, dynamic> product) {
    // Remove product completely from cart
    state = state.where((item) => item['name'] != product['name']).toList();
  }

  bool isInCart(String name) {
    return state.any((item) => item['name'] == name);
  }

 double get totalPrice {
    return state.fold(0.0, (total, item) {
      final price = double.tryParse(item['price'].toString()) ?? 0.0;
      final quantity = int.tryParse(item['quantity'].toString()) ?? 0;
      return total + (price * quantity);
    });
  }

  int getItemQuantity(String name) {
    final item = state.firstWhere((item) => item['name'] == name, orElse: () => {});
    return item.isNotEmpty ? item['quantity'] : 0; // Return the quantity or 0 if not found
  }
}

// Provider for the cart controller
final cartProvider = StateNotifierProvider<CartController, List<Map<String, dynamic>>>((ref) {
  return CartController();
});
