import 'package:get/get.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductController extends GetxController {
  final ProductService _productService = ProductService();

  final RxList<Product> _products = <Product>[].obs;
  final RxBool _isLoading = false.obs;

  List<Product> get products => _products;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    _retrieveData();
    super.onInit();
  }

  Future<void> _retrieveData() async {
    try {
      _isLoading.value = true;
      final data = await _productService.fetchProducts();
      _products.assignAll(data);
      _isLoading.value = false;
    } catch (e) {
      _isLoading.value = false;
      throw Exception(e.toString());
    }
  }
}
