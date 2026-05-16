import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
        backgroundColor: Colors.white,
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_outlined,
                    size: 80, color: Colors.blueGrey),
                SizedBox(height: 16),
                Text(
                  'Keranjang masih kosong',
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final product = cartController.cartItems[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          product.images[0],
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image),
                        ),
                      ),
                      title: Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.blueGrey[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // Tombol hapus dari keranjang
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => cartController.removeFromCart(index),
                      ),
                    ),
                  );
                },
              ),
            ),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Harga',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Obx(() => Text(
                            '\$${cartController.totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.snackbar(
                          'Checkout',
                          'Fitur checkout belum tersedia',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey[700],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Obx(() => Text(
                            'Checkout (${cartController.itemCount} item)',
                            style: const TextStyle(fontSize: 15),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
