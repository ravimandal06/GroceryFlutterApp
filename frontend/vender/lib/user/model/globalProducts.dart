// To parse this JSON data, do
//
//     final getProduct = getProductFromJson(jsonString);

import 'dart:convert';

GetProduct getProductFromJson(String str) =>
    GetProduct.fromJson(json.decode(str));

String getProductToJson(GetProduct data) => json.encode(data.toJson());

class GetProduct {
  final String productType;
  final String productName;
  final String productPrice;
  final int productStock;
  final String productImage;
  final int productQuantity;
  final int productOfferPrice;

  GetProduct({
    required this.productType,
    required this.productName,
    required this.productPrice,
    required this.productStock,
    required this.productImage,
    required this.productQuantity,
    required this.productOfferPrice,
  });

  factory GetProduct.fromJson(Map<String, dynamic> json) => GetProduct(
        productType:
            json["productType"] ?? "", // Default to an empty string if null
        productName: json["productName"] ?? "",
        productPrice: json["productPrice"] ?? 0,
        productStock: json["productStock"] ?? 0, // Default to 0 if null
        productImage: json["productImage"] ?? "",
        productQuantity: json["productQuantity"] ?? 0,
        productOfferPrice: json["productOfferPrice"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "productType": productType,
        "productName": productName,
        "productPrice": productPrice,
        "productStock": productStock,
        "productImage": productImage,
        "productQuantity": productQuantity,
        "productOfferPrice": productOfferPrice,
      };
}
