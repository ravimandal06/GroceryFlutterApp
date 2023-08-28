// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:vender/user/model/globalProducts.dart';

// class ProductListPage extends StatefulWidget {
//   const ProductListPage({Key? key}) : super(key: key);

//   @override
//   State<ProductListPage> createState() => _ProductListPageState();
// }

// class _ProductListPageState extends State<ProductListPage> {
//   late Future<List<GetProduct>> _products;

//   @override
//   void initState() {
//     super.initState();
//     _products = _getProducts();
//   }

//   Future<List<GetProduct>> _getProducts() async {
//     final response =
//         await http.get(Uri.parse('http://190.190.2.226:3000/admin/getProduct'));
//     if (response.statusCode == 200) {
//       final json = jsonDecode(response.body);
//       return List<GetProduct>.from(
//           json['products'].map((e) => GetProduct.fromJson(e)));
//     } else {
//       throw Exception('Failed to get products');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Product List'),
//       ),
//       body: FutureBuilder<List<GetProduct>>(
//         future: _products,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text(snapshot.error.toString()));
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(snapshot.data![index].productName),
//                   subtitle: Text(snapshot.data![index].productPrice),
//                   leading: Image.network(snapshot.data![index].productImage),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
