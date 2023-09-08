import 'package:flutter/material.dart';
import 'package:vender/constant.dart';
import 'package:vender/user/model/globalProducts.dart';

class FavoriteListScreen extends StatelessWidget {
  const FavoriteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Products'),
      ),
      body: ListView.builder(
        itemCount: favoriteProducts.length,
        itemBuilder: (context, index) {
          final product = favoriteProducts[index];

          return ListTile(
            title: Text(product.productName),
            // You can add more details or actions here
          );
        },
      ),
    );
  }
}
