import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:vender/screens/show_product.dart';

import '../config.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key, this.token})
      : super(
          key: key,
        );
  final token;

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController categoriesController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController offerPriceController = TextEditingController();
  late String userId;
  List? items;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    // userId = jwtDecodedToken['userId'];
    // print(userId);
  }

  void addProductList() async {
    try {
      if (productNameController.text.isNotEmpty &&
          categoriesController.text.isNotEmpty &&
          stockController.text.isNotEmpty &&
          productPriceController.text.isNotEmpty) {
        var regBody = {
          'userId': "64b13fe5a6c641af69dad074",
          // 'productImage': '',
          'productType': categoriesController.text,
          'productName': productNameController.text,
          'productPrice': productPriceController.text,
          'productStock': stockController.text,
          'productImage': 'empty',

          'productOfferPrice': offerPriceController.text,
        };
        print(addProduct);
        print(regBody);

        var response = await http.post(
          Uri.parse("http://192.168.29.60:3000/admin/addProduct"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody),
        );
        print(response);
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse['status']);
        if (jsonResponse['status']) {
          print(jsonResponse['message']);
          productNameController.clear();
          categoriesController.clear();
          stockController.clear();
          productPriceController.clear();
          offerPriceController.clear();

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ShowProduct(
                        // token: jsonResponse['token'],
                      )));
        }
      }
    } catch (e) {
      print('error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios_new_rounded),
        title: const Text(
          'Add Product',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.search_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Upload Product Image',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ]),
                      child: const Center(child: Text("data")),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ]),
                      child: const Center(
                        child: Icon(
                          Icons.add_a_photo_rounded,
                          size: 50,
                        ),
                      ),
                    ),
                  ],
                ),

                //
                const SizedBox(
                  height: 15,
                ),
                //
                const Text(
                  'Categories',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),

                TextFormField(
                  controller: categoriesController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    labelText: 'Type of product',
                    hintText: 'Enter your product type',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter type of product';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      // _name = value;
                    });
                  },
                ),

                //
                const SizedBox(
                  height: 15,
                ),
                //
                const Text(
                  'Product Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),

                TextFormField(
                  controller: productNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    labelText: 'Product Name',
                    hintText: 'Enter your product name',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter product name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      // _name = value;
                    });
                  },
                ),
                //
                const SizedBox(
                  height: 15,
                ),
                //
                const Text(
                  'Stock',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),

                TextFormField(
                  controller: stockController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    labelText: 'Stock',
                    hintText: 'Enter your product stock(eg. 10kg)',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter product stock(eg. 10kg)';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      // _name = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                //
                const Text(
                  'Product Price',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),

                TextFormField(
                  controller: productPriceController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    labelText: 'Product Price',
                    hintText: 'Enter your product price',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter product price';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      // _name = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                //
                const Text(
                  'Offer Price',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),

                TextFormField(
                  controller: offerPriceController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    labelText: 'Offer Price',
                    hintText: 'Enter your product offer price',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      // _name = value;
                    });
                  },
                ),

                const SizedBox(height: 50.0),
                SizedBox(
                  width: 600,
                  height: 45,
                  child: FilledButton.tonal(
                    onPressed: () {
                      setState(() {
                        addProductList();
                      });
                      if (_formKey.currentState!.validate()) {
                        // Form is valid, process the data
                        // For example, save it to a database
                        // print('Name: ');
                      }
                    },
                    child: const Text('Upload Product'),
                  ),
                ),
                const SizedBox(height: 60.0),
              ],
              //
            ),
          ),
        ),
      ),
    );
  }
}
