import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vender/user/screen/emptyCart.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  Future<List<dynamic>> fetchCartProducts() async {
    final response = await http.get(Uri.parse(
        'http://190.190.2.226:3000/Cart/getUserCartList/64afa968935c3ce30d04076f'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      if (jsonResponse != null && jsonResponse['cart_list'] is List<dynamic>) {
        final cartProducts = jsonResponse['cart_list'] as List<dynamic>;
        return cartProducts;
      } else {
        throw Exception("Response is not a valid cart list");
      }
    } else {
      throw Exception("GET request failed with status: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchCartProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Navigate to another screen when data is empty
            Future.microtask(() {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const EmptyCart(),
              ));
            });
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return ListTile(
                  title: Text(product['product_name']),
                  subtitle: Text('Price: \$${product['_id']}'),
                  leading: Image.asset(
                    product['product_image'], // Display the product image
                    fit: BoxFit.cover,
                  ), // Display the product image

                  // Add other fields as needed
                );
              },
            );
          }
        },
      ),
    );
  }
}

class NoProductsScreen extends StatelessWidget {
  const NoProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("No Products"),
      ),
      body: const Center(
        child: Text("No products available."),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: CartPage()));
}
