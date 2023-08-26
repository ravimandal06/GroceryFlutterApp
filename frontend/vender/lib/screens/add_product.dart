import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../model/addProductRequest.dart';
import '../services/addProductResponse.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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

  // void addProductList() async {
  //   try {
  //     if (productNameController.text.isNotEmpty &&
  //         categoriesController.text.isNotEmpty &&
  //         stockController.text.isNotEmpty &&
  //         productPriceController.text.isNotEmpty) {
  //       var regBody = {
  //         'userId': "64b13fe5a6c641af69dad074",
  //         // 'productImage': '',
  //         'productType': categoriesController.text,
  //         'productName': productNameController.text,
  //         'productPrice': productPriceController.text,
  //         'productStock': stockController.text,
  //         'productImage': 'empty',

  //         'productOfferPrice': offerPriceController.text,
  //       };
  //       print(addProduct);
  //       print(regBody);

  //       var response = await http.post(
  //         Uri.parse("http://192.168.1.65:3000/admin/addProduct"),
  //         headers: {"Content-Type": "application/json"},
  //         body: jsonEncode(regBody),
  //       );
  //       print(response);
  //       var jsonResponse = jsonDecode(response.body);
  //       print(jsonResponse['status']);
  //       if (jsonResponse['status']) {
  //         print(jsonResponse['message']);
  //         productNameController.clear();
  //         categoriesController.clear();
  //         stockController.clear();
  //         productPriceController.clear();
  //         offerPriceController.clear();

  //         print('traveliiing route');

  //         Get.offAll(() => const HomeNav());
  //       }
  //     }
  //   } catch (e) {
  //     print('error $e');
  //   }
  // }

//
  File? _image;
  String? uploadedImageUrl;

  Future<void> _showImagePickerDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Image Source"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text("Camera"),
                onTap: () {
                  _getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text("Gallery"),
                onTap: () {
                  _getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _uploadImage() async {
    try {
      if (_image == null) return;

      final storage = firebase_storage.FirebaseStorage.instance;
      final imageRef =
          storage.ref().child('productImage/${DateTime.now()}.jpg');

      await imageRef.putFile(_image!);

      final imageUrl = await imageRef.getDownloadURL();
      setState(() {
        uploadedImageUrl = imageUrl;
        print("Image Store : $uploadedImageUrl");
      });

      // Now you have the imageUrl which you can store or use as needed.
      print('Image URL: $imageUrl');
    } catch (e) {
      print("error caught : $e");
    }
  }

  Future _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void addProductList() async {
    try {
      if (productNameController.text.isNotEmpty &&
          categoriesController.text.isNotEmpty &&
          stockController.text.isNotEmpty &&
          productPriceController.text.isNotEmpty) {
        var regBody = AddProductRequest(
          userId: "64b13fe5a6c641af69dad074",
          productType: categoriesController.text,
          productName: productNameController.text,
          productPrice: productPriceController.text,
          productStock: stockController.text,
          productImage: uploadedImageUrl ?? 'empty',
          productOfferPrice: offerPriceController.text,
        );

        var response = await http.post(
          Uri.parse("http://190.190.2.226:3000/admin/addProduct/"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody.toJson()),
        );

        var jsonResponse = jsonDecode(response.body);
        var addProductResponse = AddProductResponse.fromJson(jsonResponse);

        if (addProductResponse.status) {
          print(addProductResponse.message);
          productNameController.clear();
          categoriesController.clear();
          stockController.clear();
          productPriceController.clear();
          offerPriceController.clear();

          print('traveling route');

          Get.back();
        }
        print(addProductResponse.message);
      }
    } catch (e) {
      print('error $e');
    }
  }

//
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
                      child: Center(
                        child: _image == null
                            ? const Text('No image selected.')
                            : Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          //
                          _showImagePickerDialog();
                        });
                      },
                      child: Container(
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
                        if (_formKey.currentState!.validate()) {
                          // Form is valid, process the data
                          // For example, save it to a database
                          // print('Name: ');

                          _uploadImage();
                        }
                      });
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
