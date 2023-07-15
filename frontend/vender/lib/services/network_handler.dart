// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class NetworkHandler {
  static final client = http.Client();
  static const storage = FlutterSecureStorage();
  static Future<String> post(var body, String endpoint) async {
    print(buildUrl(endpoint));
    print(body);
    var response = await client.post(buildUrl(endpoint),
        body: body, headers: {"Content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 500) {
      print("Error $response");
    }
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return "Error";
  }

  static var response;

  static Future<dynamic> get(String endpoint) async {
    try {
      var response = await client.get(buildUrl(endpoint));
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(jsonDecode(response.body));
        return response.body;
      } else {
        print('statuscode ${response.statusCode}');
        print("error in making request");
        return "Error";
      }
    } catch (e) {
      print(e);
    }
    return response.body;
  }

  static Future<String> delete(
    String endpoint,
  ) async {
    try {
      var response = await client.delete(
        buildUrl(endpoint),
      );
      return response.body;
    } catch (e) {
      print("Error occured in deleting grocery item");
      print(e);
    }
    return response;
  }

  static buildUrl(String endpoint) {
    // String host = "http://192.168.10.38:8000/we/";
    String host = "http://192.168.1.67:3000/";
    final apiPath = host + endpoint;
    print(apiPath);
    return Uri.parse(apiPath);
  }

  static Future<void> storeToken(String token) async {
    await storage.write(key: "token", value: token);
  }

  static Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  static Future<void> storeUserId(String userId) async {
    await storage.write(key: "userId", value: userId);
  }

  static Future<String?> getuserId() async {
    return await storage.read(key: "userId");
  }
}
