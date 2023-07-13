// To parse this JSON data, do
//
//     final userAuthData = userAuthDataFromJson(jsonString);

import 'dart:convert';

UserAuthData userAuthDataFromJson(String str) =>
    UserAuthData.fromJson(json.decode(str));

String userAuthDataToJson(UserAuthData data) => json.encode(data.toJson());

class UserAuthData {
  String type;
  String id;
  String name;
  String email;
  String password;
  String address;
  String phoneNumber;

  UserAuthData({
    required this.type,
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.phoneNumber,
  });

  factory UserAuthData.fromJson(Map<String, dynamic> json) => UserAuthData(
        type: json["type"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "address": address,
        "phoneNumber": phoneNumber,
      };
}
