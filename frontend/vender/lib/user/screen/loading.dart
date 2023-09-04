import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vender/payment/esewa_function.dart';
import 'package:vender/user/screen/success.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

void initEsewaPayment() async {
  // await Esewa().verify(EsewaPaymentSuccessResult(
  //   productId: "1d71jd81",
  //   productName: "Product One",
  //   totalAmount: "1000",
  //   environment: "test",
  //   code: "Success",
  //   merchantName: "Esewa",
  //   message: "Success",
  //   date: "2021-10-12",
  //   status: "Success",
  //   refId: "1234567890",
  // ));
  await Esewa().pay();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    // Start a 3-second timer to delay navigation to the next page
    Future.delayed(const Duration(seconds: 3), () {
      // Navigate to the next page after 3 seconds
      initEsewaPayment();
      setState(() {
        Future.delayed(const Duration(seconds: 3), () {
          // Navigate to the next page after 3 seconds
          Get.to(() => const SuccessPage());
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 16.0),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }
}
