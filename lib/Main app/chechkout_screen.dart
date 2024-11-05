import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kings_connect/controllers/cart_controller.dart';

// Assuming CartItem and cartProvider are defined elsewhere

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) { // Change here
    final cartItems = ref.watch(cartProvider); // Use watch to listen to cartProvider
    final totalPrice = ref.read(cartProvider.notifier).totalPrice; // Read the notifier for total price

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
           Expanded(
  child: ListView.builder(
    itemCount: cartItems.length,
    itemBuilder: (context, index) {
      final item = cartItems[index]; // This is a Map<String, dynamic>
      final price = double.tryParse(item['price'].toString()) ?? 0.0; // Convert to double
      final quantity = int.tryParse(item['quantity'].toString()) ?? 0; // Convert to int
      
      return ListTile(
        title: Text(item['name']),
        subtitle: Text("Quantity: $quantity"),
        trailing: Text("\$${(price * quantity).toStringAsFixed(2)}"), // Safe multiplication
      );
    },
  ),
),


            const Divider(),
            // Total Price Display
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "\$${totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Checkout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Proceed with payment logic
                },
                child: const Text("Proceed to Payment"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



