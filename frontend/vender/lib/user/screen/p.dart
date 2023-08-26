import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vender/user/model/globalProducts.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<GetProduct> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http
          .get(Uri.parse('http://190.190.2.226:3000/admin/getProduct'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        print(response.statusCode);

        List<GetProduct> productList =
            jsonResponse.map((data) => GetProduct.fromJson(data)).toList();

        setState(() {
          products = productList;
        });
      } else {
        throw Exception(
            "GET request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].productName),
            subtitle: Text(products[index].productPrice),
            // You can add more widgets to display other product details
          );
        },
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ProductListScreen(),
  ));
}
