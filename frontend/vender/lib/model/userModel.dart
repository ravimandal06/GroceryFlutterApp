// To parse this JSON data, do
//
//     final AdminAuthData = AdminAuthDataFromJson(jsonString);

import 'dart:convert';

AdminAuthData adminAuthDataFromJson(String str) =>
    AdminAuthData.fromJson(json.decode(str));

String adminAuthDataToJson(AdminAuthData data) => json.encode(data.toJson());

class AdminAuthData {
  String type;
  String id;
  String name;
  String email;
  String password;
  String address;
  String phoneNumber;
  String shopName;
  String shopno;
  String landmark;
  String city;
  String state;
  String pincode;

  AdminAuthData({
    required this.type,
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.phoneNumber,
    required this.shopName,
    required this.shopno,
    required this.landmark,
    required this.city,
    required this.state,
    required this.pincode,
  });

  factory AdminAuthData.fromJson(Map<String, dynamic> json) => AdminAuthData(
        type: json["type"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        shopName: json["shopName"],
        shopno: json["shopno"],
        landmark: json["landmark"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "address": address,
        "phoneNumber": phoneNumber,
        "shopName": shopName,
        "shopno": shopno,
        "landmark": landmark,
        "city": city,
        "state": state,
        "pincode": pincode,
      };
}
