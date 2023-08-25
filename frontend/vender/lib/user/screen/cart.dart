import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:vender/user/model/cart_model.dart';
import 'package:vender/user/screen/checkout.dart';
import 'package:http/http.dart' as http;
import 'package:vender/user/screen/emptyCart.dart';
import 'package:vender/user/widget/warningDailog.dart';

// import '../model/cartModel.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Future<List<dynamic>> fetchCartProducts() async {
    final response = await http.get(Uri.parse(
        'http://190.190.2.226:3000/Cart/getUserCartList/64afa968935c3ce30d04076f'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      if (jsonResponse != null && jsonResponse['cart_list'] is List<dynamic>) {
        final cartProducts = jsonResponse['cart_list'] as List<dynamic>;
        return cartProducts;
      } else {
        throw Exception("Response is not a valid cart list");
      }
    } else {
      throw Exception("GET request failed with status: ${response.statusCode}");
    }
  }

  // delete-cart-item
  // List<CartItem> cartItems = []; // Your list of cart items

  Future<void> deleteCartItem(String productId) async {
    const userId = '64afa968935c3ce30d04076f'; // Replace with actual user ID
    final response = await http.delete(
      Uri.parse('http://190.190.2.226:3000/Cart/deleteCart/$userId/$productId'),
    );

    if (response.statusCode == 200) {
      // Item deleted successfully
      print('Item deleted successfully');
      // You can update your UI here if needed
    } else {
      // Handle error
      print('Failed to delete item: ${response.statusCode}');
    }
  }

  @override
  initState() {
    super.initState();
    fetchCartProducts();
  }

  @override
  Widget build(BuildContext context) {
    final width_ = MediaQuery.of(context).size.width * 360;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<List<dynamic>>(
              future: fetchCartProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  // Navigate to another screen when data is empty
                  Future.microtask(() {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const EmptyCart(),
                    ));
                  });
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return
                      // ListView.builder(
                      //   itemCount: snapshot.data!.length,
                      //   itemBuilder: (context, index) {
                      //     final product = snapshot.data![index];
                      //     return ListTile(
                      //       title: Text(product['product_name']),
                      //       subtitle: Text('Price: \$${product['product_price']}'),
                      //       leading: Image.asset(
                      //         product['product_image'], // Display the product image
                      //         fit: BoxFit.cover,
                      //       ), // Display the product image

                      //       // Add other fields as needed
                      //     );
                      //   },
                      // );

                      Column(
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
                              itemCount: snapshot.data!.length,
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                final product = snapshot.data![index];
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.asset(
                                            product['product_image'],
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
                                              product['product_name'],
                                              style: const TextStyle(
                                                  fontSize: 21,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              product['product_type'],
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
                                                  // '\$ ${value.cartItems[index].productPrice}',
                                                  '\$${product['product_price']}',
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
                                                          value
                                                              .decreaseQuantity(
                                                                  index);
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            border: Border.all(
                                                              color:
                                                                  Colors.black,
                                                              width: 1,
                                                            ),
                                                          ),
                                                          width: 25,
                                                          height: 25,
                                                          child: const Center(
                                                            child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      // value.cartItems[index].productQuantity
                                                      Text(
                                                        "${product['product_quantity']}",
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          value
                                                              .increaseQuantity(
                                                                  index);
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            border: Border.all(
                                                              color:
                                                                  Colors.black,
                                                              width: 1,
                                                            ),
                                                          ),
                                                          width: 25,
                                                          height: 25,
                                                          child: const Center(
                                                            child: Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.black,
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
                                            // value.removeItemFromCart(index);
                                            deleteCartItem(
                                                product['_id'].toString());
                                            // Get.to(() => const CartPage());

                                            //
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return WarningDialog(
                                                  title: 'Delete Item',
                                                  message:
                                                      'Are you sure you want to delete this item?',
                                                  onConfirm: () {
                                                    // Implement your delete logic here
                                                    print('Item deleted!');
                                                    setState(() {
                                                      deleteCartItem(
                                                              product['_id']
                                                                  .toString())
                                                          .then((value) =>
                                                              RefreshCallback);
                                                      // .then((value) =>
                                                      //     Get.to(() =>
                                                      //         const CartPage()));
                                                    });
                                                  },
                                                );
                                              },
                                            );
                                            //
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
                              Consumer<CartModel>(
                                  builder: (context, value, child) {
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
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
