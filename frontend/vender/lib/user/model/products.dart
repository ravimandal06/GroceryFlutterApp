// To parse this JSON data, do
//
//     final getProductRequest = getProductRequestFromJson(jsonString);

import 'dart:convert';

GetProductRequest getProductRequestFromJson(String str) =>
    GetProductRequest.fromJson(json.decode(str));

String getProductRequestToJson(GetProductRequest data) =>
    json.encode(data.toJson());

class GetProductRequest {
  String userId;
  String productName;
  String productType;
  double productPrice;
  int productQuantity;
  double productOfferPrice;
  int productStock;
  String productImage;
  bool isSelectedToCart;

  GetProductRequest({
    required this.userId,
    required this.productName,
    required this.productType,
    required this.productPrice,
    required this.productQuantity,
    required this.productOfferPrice,
    required this.productStock,
    required this.productImage,
    required this.isSelectedToCart,
  });

  factory GetProductRequest.fromJson(Map<String, dynamic> json) =>
      GetProductRequest(
        userId: json["userId"],
        productName: json["product_name"],
        productType: json["product_type"],
        productPrice: json["product_price"]?.toDouble(),
        productQuantity: json["product_quantity"],
        productOfferPrice: json["product_offerPrice"]?.toDouble(),
        productStock: json["product_stock"],
        productImage: json["product_image"],
        isSelectedToCart: json["isSelectedToCart"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "product_name": productName,
        "product_type": productType,
        "product_price": productPrice,
        "product_quantity": productQuantity,
        "product_offerPrice": productOfferPrice,
        "product_stock": productStock,
        "product_image": productImage,
        "isSelectedToCart": isSelectedToCart,
      };
}
