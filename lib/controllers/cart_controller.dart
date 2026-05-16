import 'package:get/get.dart';
import '../models/product.dart';

class CartController extends GetxController {
  final RxList<Product> _cartItems = <Product>[].obs;

  List<Product> get cartItems => _cartItems;
  int get itemCount => _cartItems.length;

  double get totalPrice =>
      _cartItems.fold(0.0, (sum, item) => sum + item.price);

  void addToCart(Product product) {
    _cartItems.add(product);
    Get.snackbar(
      'Keranjang',
      '${product.title} ditambahkan ke keranjang',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void removeFromCart(int index) {
    final name = _cartItems[index].title;
    _cartItems.removeAt(index);
    Get.snackbar(
      'Keranjang',
      '$name dihapus dari keranjang',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  bool isInCart(Product product) =>
      _cartItems.any((item) => item.id == product.id);
}
