import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vender/user/screen/success.dart';

import '../user/screen/cart.dart';
import 'esewa_const.dart';

class Esewa {
  // pay() {
  //   try {
  //     EsewaFlutterSdk.initPayment(
  //         esewaConfig: EsewaConfig(
  //             clientId: kEsewaClientId,
  //             secretId: kEsewaSecretKey,
  //             environment: Environment.test),
  //         esewaPayment: EsewaPayment(
  //             productId: "1d71jd81",
  //             productName: "Product One",
  //             productPrice: "20"),
  //         onPaymentSuccess: (EsewaPaymentSuccessResult result) {
  //           debugPrint('Success');
  //         },
  //         onPaymentFailure: () {
  //           debugPrint("Failure");
  //         },
  //         onPaymentCancellation: () {
  //           debugPrint("Cancel");
  //         });
  //   } catch (e) {
  //     debugPrint("Exception");
  //   }
  // }

  ///
  ///
  ///

  Future<void> pay() async {
    try {
      final cartProducts = await fetchCartProducts();
      final prefs = await SharedPreferences.getInstance();
      final totalAmount = prefs.getString('totalAmount').toString();

      // Define a function to initiate payments recursively
      Future<void> initiatePaymentForProduct(int index) async {
        if (index < cartProducts.length) {
          final product = cartProducts[index];
          final esewaPayment = EsewaPayment(
            productId: product['_id'],
            productName: product['product_name'],
            productPrice: totalAmount,
          );

          await EsewaFlutterSdk.initPayment(
            esewaConfig: EsewaConfig(
              clientId: kEsewaClientId,
              secretId: kEsewaSecretKey,
              environment: Environment.test,
            ),
            esewaPayment: esewaPayment,
            onPaymentSuccess: (EsewaPaymentSuccessResult data) {
              debugPrint(":::SUCCESS::: => $data");
              verify(data);
            },
            onPaymentFailure: () {
              debugPrint('Failure for product: ${product['product_name']}');
              // Handle failure for this product

              // Initiate payment for the next product in the cart
              initiatePaymentForProduct(index + 1);
            },
            onPaymentCancellation: () {
              debugPrint('Cancel for product: ${product['product_name']}');
              // Handle cancellation for this product

              // Initiate payment for the next product in the cart
              initiatePaymentForProduct(index + 1);
            },
          );
        }
      }

      // Start the recursive payment process with the first product
      await initiatePaymentForProduct(0);
    } catch (e) {
      debugPrint('Exception: $e');
      // Handle exceptions as needed
    }
  }

  ///
  ///
  ///

  void verify(EsewaPaymentSuccessResult result) async {
    try {
      Dio dio = Dio();
      String basic =
          'Basic ${base64.encode(utf8.encode('JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R:BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ=='))}';
      Response response = await dio.get(
        'https://esewa.com.np/mobile/transaction',
        queryParameters: {
          'txnRefId': result.refId,
        },
        options: Options(
          headers: {
            'Authorization': basic,
          },
        ),
      );
      print("this is the payment response ----> ${response.data}");
    } catch (e) {
      print("error here caught : $e");
    }
  }
}
