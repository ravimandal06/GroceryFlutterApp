class Product {
  final String productId;
  final String productName;
  final String productType;
  final double productPrice;
  final int productStock;
  final String productImage;
  final double productOfferPrice;

  Product({
    required this.productId,
    required this.productName,
    required this.productType,
    required this.productPrice,
    required this.productStock,
    required this.productImage,
    required this.productOfferPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['_id'],
      productName: json['productName'],
      productType: json['productType'],
      productPrice: json['productPrice'],
      productStock: json['productStock'],
      productImage: json['productImage'],
      productOfferPrice: json['productOfferPrice'],
    );
  }
}
