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
  final String shopName;

  final String city;
  final String state;
  final String landmark;
  final String pincode;

  GetProduct({
    required this.productType,
    required this.productName,
    required this.productPrice,
    required this.productStock,
    required this.productImage,
    required this.productQuantity,
    required this.productOfferPrice,
    required this.shopName,
    required this.city,
    required this.state,
    required this.landmark,
    required this.pincode,
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
        shopName: json["shopName"] ?? "",
        city: json["city"] ?? "",
        state: json["state"] ?? "",
        landmark: json["landmark"] ?? "",
        pincode: json["pincode"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "productType": productType,
        "productName": productName,
        "productPrice": productPrice,
        "productStock": productStock,
        "productImage": productImage,
        "productQuantity": productQuantity,
        "productOfferPrice": productOfferPrice,
        "shopName": shopName,
        "city": city,
        "state": state,
        "landmark": landmark,
        "pincode": pincode,
      };
}
