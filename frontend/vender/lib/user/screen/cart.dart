import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:vender/user/model/cart_model.dart';
import 'package:vender/user/screen/checkout.dart';
import 'package:vender/user/screen/homePage.dart';
import 'package:http/http.dart' as http;
import '../model/cartModel.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  // List<String> cartItems = [
  //   GetStorage().read('productName'),
  //   GetStorage().read('productType'),
  //   GetStorage().read('productPrice'),
  //   GetStorage().read('productQuantity'),
  //   GetStorage().read('totalPrice'),
  // ];

  continueCart() async {
    try {
      if (CartModel().cartItems.isNotEmpty) {
        var regBody = CartDetailModel(
            productName: CartModel().cartItems.productName,
            productType: CartModel().cartItems.productType,
            productPrice: CartModel().cartItems.productPrice,
            productQuantity: CartModel().cartItems.productQuantity,
            totalPrice: CartModel().cartItems.totalPrice);

        var response = await http.post(
          Uri.parse('http://190.190.1.106:3000/user/getCartProducts'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(regBody.toJson()),
        );

        var jsonResponse = jsonDecode(response.body);
        var cartProductResponse = CartDetailModel.fromJson(jsonResponse);

        print(cartProductResponse);
      }
    } catch (e) {
      print('error in cart.dart $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width_ = MediaQuery.of(context).size.width * 360;

    if (GetStorage().read('cartItems') != null) {
      return Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width_,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.black,
                          ),
                        ),
                        const Text("Cart",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500)),
                        const Icon(
                          Icons.notifications_none_rounded,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    child: Consumer<CartModel>(
                      builder: (context, value, child) {
                        return ListView.builder(
                          itemCount: value.cartItems.length,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Container(
                                padding: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey[300]!,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                width: 320,
                                height: 105,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        value.cartItems[index].productImage,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          value.cartItems[index].productName,
                                          style: const TextStyle(
                                              fontSize: 21,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          value.cartItems[index].productType,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black38),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '\$ ${value.cartItems[index].productPrice}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 50,
                                            ),
                                            SizedBox(
                                              width: 70,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      value.decreaseQuantity(
                                                          index);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        border: Border.all(
                                                          color: Colors.black,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      width: 25,
                                                      height: 25,
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${value.cartItems[index].quantity}",
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      value.increaseQuantity(
                                                          index);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        border: Border.all(
                                                          color: Colors.black,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      width: 25,
                                                      height: 25,
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons.add,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        value.removeItemFromCart(index);
                                      },
                                      child: Icon(
                                        Icons.close_rounded,
                                        color: Colors.red[300],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: GetStorage().read('cartItems') != null,
                    child: SizedBox(
                      child: Column(
                        children: [
                          const Divider(
                            height: 10,
                            endIndent: 10,
                            color: Colors.black38,
                            thickness: 1,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            'Have a coupon code? enter here',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Coupon Code',
                              hintText: 'Coupon code here xxxxxx',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Coupon code here xxxxxx';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              // Handle coupon code change
                            },
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          SizedBox(
                            width: width_,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Subtotal:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Consumer<CartModel>(
                                      builder: (context, value, child) {
                                        double subTotal = double.parse(
                                            value.calculateSubTotalPrice());
                                        return Text(
                                          '\$ $subTotal',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Delivery Fee:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      '\$ 5',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Discount:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      '25%',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Consumer<CartModel>(
                            builder: (context, value, child) {
                              double totalAmount =
                                  double.parse(value.calculateTotal());
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total:',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    '\$ $totalAmount',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Consumer<CartModel>(builder: (context, value, child) {
                            double totalAmount =
                                double.parse(value.calculateTotal());
                            return SizedBox(
                              width: width_,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle checkout button press

                                  // continueCart().then((value) {
                                  //   if (value) {
                                  //     Get.to(() => const CheckOut());
                                  //   }
                                  // });

                                  //

                                  Get.to(() => const CheckOut());

                                  // var regBody = CartDetailModel(
                                  //     productName:
                                  //         CartModel().cartItems.productName,
                                  //     productType:
                                  //         CartModel().cartItems.productType,
                                  //     productPrice:
                                  //         CartModel().cartItems.productPrice,
                                  //     productQuantity:
                                  //         CartModel().cartItems.productQuantity,
                                  //     totalPrice:
                                  //         CartModel().cartItems.totalPrice);

                                  // print(regBody.toJson());

                                  // var response = http.post(
                                  //   Uri.parse(
                                  //       'http://190.190.15.106:3000/user/getCartProducts'),
                                  //   headers: <String, String>{
                                  //     'Content-Type':
                                  //         'application/json; charset=UTF-8',
                                  //   },
                                  //   body: jsonEncode(regBody.toJson()),
                                  // );
                                  // print('response $response');

                                  // ],

                                  //
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'Continue to Checkout \$$totalAmount',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: width_,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.black,
                          ),
                        ),
                        const Text("Cart",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500)),
                        const Icon(
                          Icons.notifications_none_rounded,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                      width: width_,
                      height: 260,
                      child: Image.asset(
                        'assets/empty_cart.png',
                        fit: BoxFit.cover,
                      )),
                  const SizedBox(
                    height: 50.0,
                  ),
                  SizedBox(
                    width: width_,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle checkout button press
                        Get.to(() => const UserDashboard());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Continue Shopping',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Text(
                    'Recommended for you',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
