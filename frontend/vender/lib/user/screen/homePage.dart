import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:vender/constant.dart';
import 'package:vender/user/model/globalProducts.dart';
import 'package:vender/user/screen/cart.dart';
import 'package:http/http.dart' as http;
import 'productDetailPage.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
//
  Future<List<GetProduct>>? _products;

  String userName = '';
  String userCity = '';

  Future<void> loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('name') ?? '';
      userCity = prefs.getString('city') ?? '';
      print("userName : $userName");
      print("userCity : $userCity");
      _products = _getProducts(userCity);
    });
  }

  @override
  void initState() {
    super.initState();
    loadUserName();
    // Navigator.restorablePushReplacementNamed(context, '/home');
  }

  Future<List<GetProduct>> _getProducts(String city) async {
    final response = await http
        .get(Uri.parse('http://10.10.27.75:3000/admin/getProduct/$city'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print("response status : ${response.statusCode}");
      return List<GetProduct>.from(
          json['products'].map((e) => GetProduct.fromJson(e)));
    } else {
      throw Exception('Failed to get products');
    }
  }

  int selectedCategory = 0;
  List<String> categoryTab_ = [
    'All',
    'Fruits & Vegetables',
    'Dairy Products',
    'Meat & Seafood',
    'Pantry Staples',
    'Snacks & Beverages',
    'Bakery & Bread',
    'Personal Care & Household',
  ];
  //

  bool productsButtonPressed = false;
  bool storesButtonPressed = false;

  void toggleButtons(String button) {
    setState(() {
      if (button == "products") {
        productsButtonPressed = true;
        storesButtonPressed = false;
      } else if (button == "stores") {
        productsButtonPressed = false;
        storesButtonPressed = true;
      }
    });
  }

  bool isFavorite = false;
  List<GetProduct> favProducts_ = [];
  void toggleFavorite(GetProduct favProduct_) {
    final isFavorite = !favProduct_.isFavorite;
    setState(() {
      favProduct_.isFavorite = isFavorite;
    });
    if (favProduct_.isFavorite) {
      // Add the product to the favorite list
      // You can store favorites in a separate list or database
      if (favoriteProducts.contains(favProduct_)) {
        print("already added");
      } else {
        favoriteProducts.add(favProduct_);
      }
    } else {
      // Remove the product from the favorite list
      favoriteProducts.remove(favProduct_);
    }
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
          child: Column(
            children: [
              SizedBox(
                width: width_,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // const Icon(
                    //   Icons.menu,
                    //   color: Colors.black,
                    // ),
                    Text("Hi, ${userName.firstLetterUpperCase()}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                    InkWell(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CartPage(),
                              // products: selectedItems
                            ),
                          );
                        });
                      },
                      child: const Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Container(
              //   width: width_,
              //   height: 170,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20),
              //     color: const Color(0xff843667),
              //   ),
              //   child: const Padding(
              //     padding: EdgeInsets.only(left: 26.0),
              //     child: Row(
              //       children: [
              //         SizedBox(
              //           height: 130,
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //             children: [
              //               Text(
              //                 "D Mart",
              //                 style: TextStyle(
              //                   fontSize: 22,
              //                   color: Color(0xffeeeeee),
              //                   fontWeight: FontWeight.w500,
              //                 ),
              //               ),
              //               Text(
              //                 "Find your daily needs\nhere to your door step",
              //                 style: TextStyle(
              //                   fontSize: 16,
              //                   color: Color(0xffeeeeee),
              //                   fontWeight: FontWeight.w400,
              //                 ),
              //               ),
              //               Text(
              //                 "Shop new arrivals",
              //                 style: TextStyle(
              //                   fontSize: 16,
              //                   color: Color(0xffffdcbc),
              //                   fontWeight: FontWeight.w300,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),

              //
              SizedBox(
                  width: 275,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FilledButton.tonalIcon(
                        icon: const Icon(Icons.shopping_bag_outlined),
                        label: const Text(
                          "Products",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            productsButtonPressed
                                ? Colors.black
                                : const Color(0xffeeeeee),
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(
                            productsButtonPressed ? Colors.white : Colors.black,
                          ),
                        ),
                        onPressed: () {
                          toggleButtons("products");
                        },
                      ),
                      FilledButton.tonalIcon(
                        icon: const Icon(Icons.storefront_outlined),
                        label: const Text(
                          "Stores",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            storesButtonPressed
                                ? Colors.black
                                : const Color(0xffeeeeee),
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(
                            storesButtonPressed ? Colors.white : Colors.black,
                          ),
                        ),
                        onPressed: () {
                          toggleButtons("stores");
                        },
                      ),
                    ],
                  )),
              const SizedBox(height: 16),
              //

              SizedBox(
                width: MediaQuery.sizeOf(context).width * 360,
                height: 150,
                child: ListView.builder(
                    clipBehavior: Clip.none,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryTab_.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        width: 160,
                        height: 150,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          border: Border.fromBorderSide(
                            BorderSide(
                              width: 2,
                              color: Color(0xff0C1A30),
                            ),
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: const Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "30%",
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Discount",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              const SizedBox(height: 16),

              //
              SizedBox(
                width: 340,
                height: 220,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 130,
                      height: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: const Color.fromARGB(255, 237, 237, 237),
                      ),
                      child: Image.asset("assets/n13.png"),
                    ),
                    SizedBox(
                      width: 190,
                      height: 220,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 210,
                            height: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: const Color.fromARGB(255, 246, 241, 241),
                            ),
                            child: Image.asset("assets/d12.png"),
                          ),
                          Container(
                            width: 210,
                            height: 75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: const Color.fromARGB(255, 242, 234, 234),
                            ),
                            child: Image.asset("assets/l13.png"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // SizedBox(
              //   width: MediaQuery.sizeOf(context).width * 360,
              //   height: 50,
              //   child: ListView.builder(
              //       clipBehavior: Clip.none,
              //       shrinkWrap: true,
              //       physics: const ClampingScrollPhysics(),
              //       scrollDirection: Axis.horizontal,
              //       itemCount: categoryTab_.length,
              //       itemBuilder: (context, index) {
              //         return GestureDetector(
              //           onTap: () {
              //             setState(() {
              //               selectedCategory = index;
              //             });
              //           },
              //           child: Padding(
              //             padding: const EdgeInsets.all(4.0),
              //             child: Container(
              //               padding: const EdgeInsets.all(11),
              //               // height: 70,
              //               decoration: BoxDecoration(
              //                 color: index == selectedCategory
              //                     ? const Color(0xff0C1A30)
              //                     : const Color(0xffeeeeee),
              //                 borderRadius: BorderRadius.circular(20),
              //                 border: Border.all(
              //                   color: Colors.black.withOpacity(0.1),
              //                 ),
              //               ),
              //               child: Center(
              //                 child: Text(
              //                   categoryTab_[index],
              //                   style: TextStyle(
              //                     fontSize: 14,
              //                     fontWeight: FontWeight.w400,
              //                     color: index == selectedCategory
              //                         ? const Color(0xffeeeeee)
              //                         : const Color(0xff0C1A30),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         );
              //       }),
              // ),
              // const SizedBox(
              //   height: 16.0,
              // ),

              const SizedBox(
                height: 50,
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "New Arrival",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff0C1A30),
                      ),
                    ),
                    // TextButton(
                    //     onPressed: () {},
                    //     child: Text(
                    //       "See all",
                    //       style: TextStyle(
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w400,
                    //           color: Colors.blue[400]),
                    //     ))
                  ],
                ),
              ),
              // const SizedBox(
              //   height: 16,
              // ),
              FutureBuilder<List<GetProduct>>(
                future: _products,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    return SizedBox(
                      width: MediaQuery.sizeOf(context).width * 360,
                      height: 265,
                      child:
                          // ListView.builder(
                          //   itemCount: snapshot.data!.length,
                          //   itemBuilder: (context, index) {
                          //     return
                          // ListTile(
                          //   title: Text(snapshot.data![index].productName),
                          //   subtitle: Text(snapshot.data![index].productPrice),
                          //   leading:
                          //       Image.network(snapshot.data![index].productImage),
                          // );
                          ListView.builder(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          // final productLists_ = productList_[index];
                          // GetProductRequest productSelective_ =
                          //     productList_[index];
                          // productSelective_.isSelectedToCart = true;
                          // final isFavorite = favoriteProductIds
                          //     .contains(snapshot.data![index].productId);

                          return Padding(
                            padding: const EdgeInsets.only(right: 9),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  // selectedItemsList(index);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailsPage(
                                        product: snapshot.data![index],
                                      ),
                                    ),
                                  );
                                  print('tapped $index product');
                                });
                              },
                              child: Container(
                                width: 170,
                                height: 205,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12.withOpacity(0.1),
                                        spreadRadius: 0,
                                        blurRadius: 10,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ]),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(4.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black12
                                                      .withOpacity(0.1),
                                                  spreadRadius: 0,
                                                  blurRadius: 10,
                                                  offset: const Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ]),
                                          width: 158,
                                          height: 159,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              snapshot
                                                  .data![index].productImage,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: 135,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        snapshot.data![index]
                                                            .productName
                                                            .firstLetterUpperCase(),
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          decorationStyle:
                                                              TextDecorationStyle
                                                                  .double,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              Color(0xff0C1A30),
                                                        ),
                                                      ),
                                                      const Text(
                                                        "1L",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              Color(0xff0C1A30),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    // Text(
                                                    //   snapshot.data![index]
                                                    //       .productName,
                                                    //   style: const TextStyle(
                                                    //     fontSize: 14,
                                                    //     fontWeight:
                                                    //         FontWeight.w400,
                                                    //     color: Color(0xff0C1A30),
                                                    //   ),
                                                    // ),
                                                    Text(
                                                      snapshot.data![index]
                                                          .shopName,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xff0C1A30),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        height: 30,
                                                        width: 115,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            // Text(
                                                            //   "\$${snapshot.data![index].productPrice}",
                                                            //   style: TextStyle(
                                                            //     decoration:
                                                            //         TextDecoration
                                                            //             .lineThrough,
                                                            //     fontSize: 16,
                                                            //     fontWeight:
                                                            //         FontWeight
                                                            //             .w500,
                                                            //     color: Color
                                                            //         .fromARGB(
                                                            //             179,
                                                            //             12,
                                                            //             26,
                                                            //             48),
                                                            //   ),
                                                            // ),
                                                            Text(
                                                              "\$${snapshot.data![index].productOfferPrice}",
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Color(
                                                                    0xff0C1A30),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      // SizedBox(width: 10,),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),

                                    //
                                    // icons
                                    Padding(
                                      padding: const EdgeInsets.only(left: 135),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            // if (isFavorite) {
                                            //   favoriteProductIds.remove(snapshot
                                            //       .data![index].productId);
                                            // } else {
                                            //   favoriteProductIds.add(snapshot
                                            //       .data![index].productId);
                                            // }
                                            toggleFavorite(
                                                snapshot.data![index]);
                                          });
                                        },
                                        child: Icon(
                                          snapshot.data![index].isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_border_outlined,
                                          color:
                                              snapshot.data![index].isFavorite
                                                  ? const Color.fromARGB(
                                                      184, 254, 109, 76)
                                                  : null,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        )),
      ),
    );
  }
}
