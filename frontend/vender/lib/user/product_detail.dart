// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  String productType;
  String productName;
  double productPrice;
  double productStock;
  double quantity = 1.0;
  String productImage;
  double productOfferPrice;
  bool isSelectedToCart = false;

  ProductDetailScreen(
      this.productType,
      this.productName,
      this.productPrice,
      this.productStock,
      this.productImage,
      this.quantity,
      this.productOfferPrice,
      this.isSelectedToCart,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product detail"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(productImage),
            const SizedBox(height: 20),
            Text(
              productName,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: const [
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
