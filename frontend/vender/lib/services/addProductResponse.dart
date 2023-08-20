class AddProductResponse {
  final bool status;
  final String message;

  AddProductResponse({required this.status, required this.message});

  factory AddProductResponse.fromJson(Map<String, dynamic> json) {
    return AddProductResponse(
      status: json['status'],
      message: json['message'],
    );
  }
}
