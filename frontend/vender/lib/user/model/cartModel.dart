// To parse this JSON data, do
//
//     final cartDetailModel = cartDetailModelFromJson(jsonString);

import 'dart:convert';

CartDetailModel cartDetailModelFromJson(String str) =>
    CartDetailModel.fromJson(json.decode(str));

String cartDetailModelToJson(CartDetailModel data) =>
    json.encode(data.toJson());

class CartDetailModel {
  String productName;
  String productType;
  String productPrice;
  String productQuantity;
  String totalPrice;

  CartDetailModel({
    required this.productName,
    required this.productType,
    required this.productPrice,
    required this.productQuantity,
    required this.totalPrice,
  });

  factory CartDetailModel.fromJson(Map<String, dynamic> json) =>
      CartDetailModel(
        productName: json["productName"],
        productType: json["productType"],
        productPrice: json["productPrice"],
        productQuantity: json["productQuantity"],
        totalPrice: json["totalPrice"],
      );

  Map<String, dynamic> toJson() => {
        "productName": productName,
        "productType": productType,
        "productPrice": productPrice,
        "productQuantity": productQuantity,
        "totalPrice": totalPrice,
      };
}
