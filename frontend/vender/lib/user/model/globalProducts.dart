// To parse this JSON data, do
//
//     final getProduct = getProductFromJson(jsonString);

import 'dart:convert';

GetProduct getProductFromJson(String str) =>
    GetProduct.fromJson(json.decode(str));

String getProductToJson(GetProduct data) => json.encode(data.toJson());

class GetProduct {
  String productType;
  String productName;
  String productPrice;
  int productStock;
  String productImage;
  int productOfferPrice;

  GetProduct({
    required this.productType,
    required this.productName,
    required this.productPrice,
    required this.productStock,
    required this.productImage,
    required this.productOfferPrice,
  });

  factory GetProduct.fromJson(Map<String, dynamic> json) => GetProduct(
        productType: json["productType"],
        productName: json["productName"],
        productPrice: json["productPrice"],
        productStock: json["productStock"],
        productImage: json["productImage"],
        productOfferPrice: json["productOfferPrice"],
      );

  Map<String, dynamic> toJson() => {
        "productType": productType,
        "productName": productName,
        "productPrice": productPrice,
        "productStock": productStock,
        "productImage": productImage,
        "productOfferPrice": productOfferPrice,
      };
}
