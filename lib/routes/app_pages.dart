import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../controllers/product_controller.dart';
import '../view/pages/cart_page.dart';
import '../view/pages/product_detail_page.dart';
import '../view/pages/product_page.dart';
import 'app_routes.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(() => ProductController());
    // CartController didaftarkan di sini agar tersedia di seluruh app
    Get.lazyPut<CartController>(() => CartController(), fenix: true);
  }
}

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(() => CartController(), fenix: true);
  }
}

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.products,
      page: () => ProductPage(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: AppRoutes.detail,
      page: () => ProductDetailPage(),
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => CartPage(),
      binding: CartBinding(),
    ),
  ];
}
