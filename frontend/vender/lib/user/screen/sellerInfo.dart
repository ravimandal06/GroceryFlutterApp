import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vender/constant.dart';
import 'package:vender/user/model/globalProducts.dart';
import 'package:vender/user/model/products.dart';
import 'package:http/http.dart' as http;
import 'package:vender/user/screen/productDetailPage.dart';

class SellerInfoPage extends StatefulWidget {
  const SellerInfoPage({Key? key}) : super(key: key);

  @override
  State<SellerInfoPage> createState() => _SellerInfoPageState();
}

class _SellerInfoPageState extends State<SellerInfoPage> {
//

  late Future<List<GetProduct>> _products;

  @override
  void initState() {
    super.initState();
    _products = _getProducts();
  }

  Future<List<GetProduct>> _getProducts() async {
    final response =
        await http.get(Uri.parse('http://192.168.137.1:3000/admin/getProduct'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return List<GetProduct>.from(
          json['products'].map((e) => GetProduct.fromJson(e)));
    } else {
      throw Exception('Failed to get products');
    }
  }

//
  bool isProductAddedCart_ = false;

  // void toggleSelection(int index) {
  //   setState(() {
  //     productList_[index].isSelectedToCart =
  //         !productList_[index].isSelectedToCart;
  //     print(productList_[index].isSelectedToCart);
  //   });
  // }

  void addToCart(GetProductRequest product) {
    setState(() {
      selectedItems.add(product);
      print(selectedItems.length);
    });
  }

  // void selectedItemsList(int index) {
  //   setState(() {
  //     print(productList_[index].productName);
  //     String productName = productList_[index].productName;
  //     double productPrice = productList_[index].productPrice;
  //     String productType = productList_[index].productType;
  //     String productImage = productList_[index].productImage;
  //     int productQuantity = productList_[index].productQuantity;
  //     bool isSelectedToCart = productList_[index].isSelectedToCart;
  //     double productOfferPrice = productList_[index].productOfferPrice;

  //     // Use Navigator to push a new page with the selected product name.
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => ProductDetailsPage(
  //           productName: productName,
  //           productPrice: "$productPrice",
  //           productType: productType,
  //           productImage: productImage,
  //           productQuantity: productQuantity,
  //           isSelectedToCart: isSelectedToCart,
  //           productOfferPrice: productOfferPrice,
  //         ),
  //       ),
  //     );
  //   });
  // }
//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const PageScrollPhysics(),
        child: SafeArea(
            child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  //
                  // 1. Seller Info

                  SizedBox(
                    height: 55,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child:
                                const Icon(Icons.arrow_back_ios_new_rounded)),
                        const Text(
                          "Info Seller",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          child: Row(
                            children: [
                              Icon(Icons.search_rounded),
                              SizedBox(width: 10),
                              Icon(
                                Icons.shopping_bag_outlined,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    // height: 45,
                    width: 325,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //
                        // Container(
                        //   height: 50,
                        //   width: 50,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(100),
                        //     color: const Color(0xffFECC4C),
                        //   ),
                        // )

                        Row(
                          children: [
                            CircleAvatar(),
                            SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Orange Juice",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Fresh Orange Juice",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    // Transform.scale(
                                    //     scale: 0.3,
                                    //     child: Image.asset("assets/shield.png"))

                                    Icon(
                                      Icons.shield_outlined,
                                      color: Color(0xffFECC4C),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Color(0xffFECC4C),
                              ),
                              Text(
                                "4.6",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  const SizedBox(
                    width: 290,
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Jawa Barat, Bandung (Jam Buka 08:00-21:00)",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 50,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //
                        SizedBox(
                          child: Column(
                            children: [
                              Text(
                                "Followers",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(
                                      0xff838589,
                                    )),
                              ),
                              Text(
                                "1.2K",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Column(
                            children: [
                              Text(
                                "Product",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(
                                      0xff838589,
                                    )),
                              ),
                              Text(
                                "150 Items",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Column(
                            children: [
                              Text(
                                "Joined on",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(
                                      0xff838589,
                                    )),
                              ),
                              Text(
                                "20 Jun 2023",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Divider(
                    color: Colors.grey[350],
                    thickness: 0.5,
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Shipping Support",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(
                              0xff0c1a30,
                            )),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 28,
                  ),

                  //

                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 360,
                    height: 265,
                    child: FutureBuilder<List<GetProduct>>(
                      future: _products,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            // clipBehavior: Clip.none,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 9),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailsPage(
                                            product: snapshot.data![index],
                                          ),
                                        ),
                                      );
                                      print('tapped $index product');
                                    });
                                  },
                                  child: Container(
                                    width: 166,
                                    height: 263,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black12.withOpacity(0.1),
                                            spreadRadius: 0,
                                            blurRadius: 10,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ]),
                                    child: SizedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(4.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
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
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    snapshot.data![index]
                                                        .productType,
                                                    style: const TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff0C1A30),
                                                    ),
                                                  ),
                                                  Text(
                                                    snapshot.data![index]
                                                        .productName,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xff0C1A30),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 130,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "\$ ${snapshot.data![index].productPrice}",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                                0xff0C1A30),
                                                          ),
                                                        ),
                                                        // SizedBox(width: 10,),
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              //
                                                            });
                                                          },
                                                          child: Container(
                                                              width: 40,
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100),
                                                                  color: const Color(
                                                                      0xff0C1A30)),
                                                              child: const Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .white,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
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
                            },
                          );
                        }
                      },
                    ),
                  ),

                  const SizedBox(
                    height: 110,
                  ),

                  //
                ],
              ),
            ),

            // Bottom Navigation Bar
            Positioned(
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.25,
                ),
                child: SizedBox(
                  height: 50,
                  width: 180,
                  child:
                      // ElevatedButton(
                      //   onPressed: () {
                      //     //
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     foregroundColor: Colors.black,
                      //     backgroundColor: const Color(0xffFECC4C), // Text color

                      // shape: RoundedRectangleBorder(
                      //   borderRadius:
                      //       BorderRadius.circular(15), // Button border radius
                      // ),
                      //   ),
                      //   child: const Text(
                      //     "Follow",
                      //     style: TextStyle(
                      // fontSize: 17,
                      // fontWeight: FontWeight.w500,
                      //         color: Colors.black),
                      //   ),
                      // ),
                      FollowButton(
                    isFollowing: false,
                    onFollowChanged: (isFollowing) {
                      print('following: $isFollowing');
                    },
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class FollowButton extends StatefulWidget {
  final bool isFollowing;
  final Function(bool isFollowing) onFollowChanged;

  const FollowButton(
      {super.key, required this.isFollowing, required this.onFollowChanged});

  @override
  _FollowButtonState createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool _isFollowing = false;

  @override
  void initState() {
    super.initState();
    _isFollowing = widget.isFollowing;
  }

  void _toggleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;
      widget.onFollowChanged(_isFollowing);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _toggleFollow,
      style: ElevatedButton.styleFrom(
        backgroundColor: _isFollowing ? Colors.grey : const Color(0xffFECC4C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Button border radius
        ),
      ),
      child: Text(
        _isFollowing ? 'Unfollow' : 'Follow',
        style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: _isFollowing ? Colors.white : Colors.black),
      ),
    );
  }
}
