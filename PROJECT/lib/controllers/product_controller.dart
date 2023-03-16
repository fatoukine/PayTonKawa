import 'package:flutter/cupertino.dart';
import 'package:paytonkawa/models/product_model.dart';
import 'package:paytonkawa/services/api_service.dart';

class ProductController extends ChangeNotifier {
  bool isLoading = false;
  List<Product> products = [];
  ProductController() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();
    products = await RemoteServices.fetchProducts();
    isLoading = false;
    notifyListeners();
  }
}