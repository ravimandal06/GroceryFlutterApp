class GetProductRequest {
  // final RxString userId;
  final String productType;
  final String productName;
  final double productPrice;
  final double productStock;
  int quantity = 1;
  final String productImage;
  final double productOfferPrice;
  bool isSelectedToCart = false;

  GetProductRequest({
    //  this.userId,
    required this.productType,
    required this.productName,
    required this.productPrice,
    required this.productStock,
    required this.productImage,
    required this.quantity,
    required this.productOfferPrice,
    required this.isSelectedToCart,
  });

  // Map<String, dynamic> toJson() {
  //   return {
  //     // 'userId': userId,
  //     'productType': productType,
  //     'productName': productName,
  //     'productPrice': productPrice,
  //     'productStock': productStock,
  //     'productImage': productImage,

  //     'productOfferPrice': productOfferPrice,
  //     'isSelectedToCart': isSelectedToCart,
  //   }.obs;
  // }
}
