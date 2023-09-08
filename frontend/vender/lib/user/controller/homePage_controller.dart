import 'dart:convert';

import 'package:get/get.dart';
import 'package:vender/user/model/globalProducts.dart';

import 'package:http/http.dart' as http;

class HomeProductController extends GetxController {
  final _products = <GetProduct>[].obs;
  final _favorites = <GetProduct>[].obs;

  List<GetProduct> get products => _products;
  List<GetProduct> get favorites => _favorites;

  Future<List<GetProduct>> fetchProducts(String city) async {
    final response = await http
        .get(Uri.parse('http://10.10.27.75:3000/admin/getProduct/$city'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print("response status : ${response.statusCode}");
      final fetchedProducts = await fetchProducts(city);
      _products.assignAll(fetchedProducts);
      return List<GetProduct>.from(
          json['products'].map((e) => GetProduct.fromJson(e)));
    } else {
      throw Exception('Failed to get products');
    }
  }

  void toggleFavorite(GetProduct product) {
    final isFavorite = !product.isFavorite;
    product.isFavorite = isFavorite;
    if (isFavorite) {
      if (!_favorites.contains(product)) {
        _favorites.add(product);
      }
    } else {
      _favorites.remove(product);
    }
  }
}
