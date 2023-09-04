import 'dart:convert';

import 'package:flutter/material.dart';

import '../controller/order_controller.dart';
import 'package:http/http.dart' as http;

import '../services/addProductResponse.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> middleNavList = [
    'Ordered',
    'Packed',
    'Delivered',
    'Completed',
    'More'
  ];

  int selectedIndex = 0;

  final double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 46,
                    width: 360,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Welcome Back'),
                            Text(
                              "Sam Sepual",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            )
                          ],
                        ),
                        Icon(Icons.notifications)
                      ],
                    ),
                  ),

                  //

                  const SizedBox(
                    height: 16,
                  ),

                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 360,
                    height: 200,
                    child: ListView.builder(
                      clipBehavior: Clip.none,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            width: 240,
                            height: 170,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.black12.withOpacity(0.03)),
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0xff0C1A30)
                                          .withOpacity(0.04),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: const Offset(0, 7))
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Current Balance',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff0C1A30)),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          '\$1.000.000',
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                        RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                              text: '+ 1,502,00',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.green[400])),
                                          const TextSpan(
                                              text: ' Than Last Month',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black26)),
                                        ])),
                                      ],
                                    ),
                                    Container(
                                      width: 70,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.green[400]),
                                      child: const Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '+0.98%',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                            Icon(
                                              Icons.arrow_upward,
                                              color: Colors.white,
                                              size: 12,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: 5,
                    ),
                  ),

                  //
                  const SizedBox(
                    height: 16,
                  ),
                  //
                  Container(
                    width: MediaQuery.sizeOf(context).width * 360,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white.withOpacity(0.03)),
                      boxShadow: [
                        BoxShadow(
                            color: const Color.fromARGB(255, 180, 182, 184)
                                .withOpacity(0.04),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: const Offset(0, 7))
                      ],
                    ),
                    child: ListView.builder(
                      itemCount: middleNavList.length,
                      clipBehavior: Clip.none,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(4),
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  child: SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: CircleAvatar(
                                      backgroundColor: index == selectedIndex
                                          ? const Color(0xff0C1A30)
                                          : Colors.white,
                                      child: Icon(
                                        Icons.wallet_giftcard_rounded,
                                        color: index == selectedIndex
                                            ? Colors.white
                                            : const Color(0xff0C1A30),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                middleNavList[index],
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  //
                  const SizedBox(
                    height: 16,
                  ),
                  //

                  if (selectedIndex == 0) ...{
                    const Ordered(),
                  } else if (selectedIndex == 1) ...{
                    Packed(),
                  } else if (selectedIndex == 2) ...{
                    Delivered(),
                  } else if (selectedIndex == 3) ...{
                    Completed(),
                  } else if (selectedIndex == 4) ...{
                    const Dialog()
                  }
                  //
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Ordered extends StatefulWidget {
  const Ordered({
    super.key,
  });

  @override
  State<Ordered> createState() => _OrderedState();
}

class _OrderedState extends State<Ordered> {
  final List<Order> orders = [
    Order(productName: "Product A", status: "Ordered", progress: "100%"),
    Order(productName: "Product B", status: "Ordered", progress: "50%"),
    Order(productName: "Product C", status: "Ordered", progress: "20%"),
  ];
  late String userId = '64b13fe5a6c641af69dad074';
  List? items;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      var response = await http.get(
        Uri.parse("http://192.168.1.65:3000/admin/getProducts"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        List<dynamic> productData = jsonResponse['products'];

        List<AddProductResponse> products = productData
            .map((productJson) => AddProductResponse.fromJson(productJson))
            .toList();

        // Now you have the list of products, you can use it to populate your UI
        // For example, you can store the products in a state variable and display them in a ListView
        // setState(() {
        //   productList = products;
        // });
        print(response.body);
        print(jsonResponse);
      } else {
        print('Request failed with s: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recent Orders",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),

        //
        const SizedBox(
          height: 16,
        ),
        //
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 360,
          child: ListView.builder(
            itemCount: orders.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  width: 330,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black.withOpacity(0.03)),
                    boxShadow: [
                      BoxShadow(
                          color: const Color.fromARGB(255, 180, 182, 184)
                              .withOpacity(0.04),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: const Offset(0, 7))
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 70,
                        height: 70,
                        child: Icon(
                          Icons.wallet_giftcard_rounded,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        height: 80,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.productName,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      Icons.person_pin_circle_rounded,
                                      color: Colors.black,
                                    ),
                                    Text(
                                      order.status,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(
                                              255, 235, 201, 99)),
                                    ),
                                    Text(
                                      order.progress,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );

              //
            },
          ),
        ),
      ],
    );
  }
}

//
class Packed extends StatelessWidget {
  Packed({
    super.key,
  });

  final List<Order> orders = [
    Order(productName: "Product A", status: "Packed", progress: "100%"),
    Order(productName: "Product B", status: "Packed", progress: "50%"),
    Order(productName: "Product C", status: "Packed", progress: "20%"),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recent Orders",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),

        //
        const SizedBox(
          height: 16,
        ),
        //
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 360,
          child: ListView.builder(
            itemCount: orders.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  width: 330,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black.withOpacity(0.03)),
                    boxShadow: [
                      BoxShadow(
                          color: const Color.fromARGB(255, 180, 182, 184)
                              .withOpacity(0.04),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: const Offset(0, 7))
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 70,
                        height: 70,
                        child: Icon(
                          Icons.wallet_giftcard_rounded,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        height: 80,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.productName,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      Icons.person_pin_circle_rounded,
                                      color: Colors.black,
                                    ),
                                    Text(
                                      order.status,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue[400],
                                      ),
                                    ),
                                    Text(
                                      order.progress,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );

              //
            },
          ),
        ),
      ],
    );
  }
}

//
class Delivered extends StatelessWidget {
  Delivered({
    super.key,
  });

  final List<Order> orders = [
    Order(productName: "Product A", status: "Delivered", progress: "100%"),
    Order(productName: "Product B", status: "Delivered", progress: "50%"),
    Order(productName: "Product C", status: "Delivered", progress: "20%"),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recent Orders",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),

        //
        const SizedBox(
          height: 16,
        ),
        //
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 360,
          child: ListView.builder(
            itemCount: orders.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  width: 330,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black.withOpacity(0.03)),
                    boxShadow: [
                      BoxShadow(
                          color: const Color.fromARGB(255, 180, 182, 184)
                              .withOpacity(0.04),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: const Offset(0, 7))
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 70,
                        height: 70,
                        child: Icon(
                          Icons.wallet_giftcard_rounded,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        height: 80,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.productName,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      Icons.person_pin_circle_rounded,
                                      color: Colors.black,
                                    ),
                                    Text(
                                      order.status,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.green[400]),
                                    ),
                                    Text(
                                      order.progress,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );

              //
            },
          ),
        ),
      ],
    );
  }
}

//
class Completed extends StatelessWidget {
  Completed({
    super.key,
  });

  final List<Order> orders = [
    Order(productName: "Product A", status: "Completed", progress: "100%"),
    Order(productName: "Product B", status: "Completed", progress: "50%"),
    Order(productName: "Product C", status: "Completed", progress: "20%"),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recent Orders",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),

        //
        const SizedBox(
          height: 16,
        ),
        //
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 360,
          child: ListView.builder(
            itemCount: orders.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  width: 330,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black.withOpacity(0.03)),
                    boxShadow: [
                      BoxShadow(
                          color: const Color.fromARGB(255, 180, 182, 184)
                              .withOpacity(0.04),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: const Offset(0, 7))
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 70,
                        height: 70,
                        child: Icon(
                          Icons.wallet_giftcard_rounded,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        height: 80,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.productName,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      Icons.person_pin_circle_rounded,
                                      color: Colors.black,
                                    ),
                                    Text(
                                      order.status,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.purple[400]),
                                    ),
                                    Text(
                                      order.progress,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );

              //
            },
          ),
        ),
      ],
    );
  }
}

//