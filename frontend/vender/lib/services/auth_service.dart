// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import '../model/userModel.dart';
// import '../screens/signup.dart';

// String uri = 'http://localhost:3000';

// class AuthService {
//   //sign up user with email and password
//   void signUpUser({
//     required BuildContext context,
//     required String email,
//     required String password,
//     required String name,
//   }) async {
//     try {
//       UserAuthData data = UserAuthData(
//           name: nameController.text,
//           email: emailController.text,
//           address: '',
//           id: "${FirebaseAuth.instance.currentUser?.uid}",
//           password: passwordController.text,
//           phoneNumber: phoneNumberController.text,
//           type: '');

//       http.Response res =
//           await http.post(Uri.parse('$uri/api/signup'), //post request
//               body: UserAuthData.fromJson,
//               headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-8',
//           });
//       print(res.body);
//       print(res.statusCode);
//     } catch (e) {
//       print(e);
//     }
//   }

//   //
// }
