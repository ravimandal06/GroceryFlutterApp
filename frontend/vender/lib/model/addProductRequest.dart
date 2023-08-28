class AddProductRequest {
  final String userId;
  final String productType;
  final String productName;
  final String productPrice;
  final int productStock;
  final String productImage;
  final int productOfferPrice;
  final String shopLocation;

  AddProductRequest({
    required this.userId,
    required this.productType,
    required this.productName,
    required this.productPrice,
    required this.productStock,
    required this.productImage,
    required this.productOfferPrice,
    required this.shopLocation,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'productType': productType,
      'productName': productName,
      'productPrice': productPrice,
      'productStock': productStock,
      'productImage': productImage,
      'productOfferPrice': productOfferPrice,
      'shopLocation': shopLocation,
    };
  }
}
