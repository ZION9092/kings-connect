// providers/laptop_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/laptop_model.dart';

// Define a provider that manages a list of laptops
final laptopProvider = Provider<List<Laptop>>((ref) {
  // Simulated list of laptops
  return List.generate(15, (index) {
    return Laptop(
      name: 'Laptop $index',
      imagePath: "assets/images/lenovo.jpeg",
      description: 'This is a description for Laptop $index.',
      price: "1000",
      //products: '', 
    );
  });
});