import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/product_controller.dart';
import '../../routes/app_routes.dart';
import '../widgets/product_card.dart';

class ProductPage extends StatelessWidget {
  ProductPage({super.key});

  final ProductController controller = Get.find<ProductController>();
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Home Page'),
        actions: [
          Obx(() => Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () => Get.toNamed(AppRoutes.cart),
                  ),
                  if (cartController.itemCount > 0)
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${cartController.itemCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Obx(() {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blueGrey),
            );
          }
          return GridView.builder(
            itemCount: controller.products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              return ProductCard(
                product: controller.products[index],
                onTap: () {
                  Get.toNamed(
                    AppRoutes.detail,
                    arguments: controller.products[index],
                  );
                },
              );
            },
          );
        }),
      ),
    );
  }
}
