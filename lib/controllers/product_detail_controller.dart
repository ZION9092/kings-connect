import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailController extends StateNotifier<int> {
  ProductDetailController() : super(1);

  void incrementQuantity() {
    state++;
  }

  void decrementQuantity() {
    if (state > 0) {
      state--;
    }
  }
}

// Provider for the product detail controller
final productDetailProvider = StateNotifierProvider<ProductDetailController, int>((ref) {
  return ProductDetailController();
});
