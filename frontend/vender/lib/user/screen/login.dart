import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:vender/user/screen/homePage.dart';
import 'package:vender/user/screen/signup.dart';

class LoginUserScreen extends StatefulWidget {
  const LoginUserScreen({Key? key}) : super(key: key);

  @override
  State<LoginUserScreen> createState() => _LoginUserScreenState();
}

//
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class _LoginUserScreenState extends State<LoginUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final String _name = '';
  bool isNotValidate_ = false;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  bool? isUserLogged;

  Future<bool> loginUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var regBody = {
        "email": emailController.text,
        "password": passwordController.text,
      };
      var response = await http.post(
          Uri.parse("http://localhost:3000/User/login"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        var myToken = jsonResponse['token'];
        print("Login successfull");
        print(myToken);
        print(jsonResponse['email']);
        //print the user details
        print(jsonResponse['name']);
        setState(() {
          isUserLogged = true;
          GetStorage().write('isUserLogged', isUserLogged);
          print("isUserLogged ---> ${GetStorage().read('isUserLogged')}");
        });

        //
        prefs.setString('token', myToken);

        GetStorage().write('token', myToken);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const UserDashboard(),
          ),
        );
        return true;
      } else {
        print("something went wrong");
        print(jsonResponse['message']);
        setState(() {
          isUserLogged = false;
          GetStorage().write('isUserLogged', isUserLogged);
          print("isUserLogged ---> ${GetStorage().read('isUserLogged')}");
        });
        return false;
      }
    } else {
      setState(() {
        isNotValidate_ = true;
      });
    }
    return false;
  }

  // Future<void> signIn(BuildContext context) async {
  //   try {
  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: emailController.text,
  //       password: passwordController.text,
  //     );
  //     print("object");

  //     // User sign-in successful
  //     // You can navigate to another screen here
  //     print('User signed in: ${userCredential.user?.email}');

  //     // Perform additional actions or navigate to another screen
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const UserDashboard(),
  //       ),
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     print("object1 : $e");
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided for that user.');
  //     }
  //     // Handle other exceptions here
  //   }
  // }

//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              //
              const Padding(
                padding: EdgeInsets.only(top: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Let's get you login",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Enter your information below",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                              hintText: 'Enter your email',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                // _name = value;
                              });
                            },
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: passwordController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                              hintText: 'Enter your password',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                // _name = value;
                              });
                            },
                          ),
                          const SizedBox(height: 16.0),
                          const Padding(
                            padding: EdgeInsets.only(left: 170),
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          SizedBox(
                            width: 600,
                            height: 45,
                            child: FilledButton.tonal(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // Form is valid, process the data
                                  // For example, save it to a database
                                  print('Name: $_name');
                                  await loginUser();
                                  // signIn(context);
                                }
                              },
                              child: const Text('Login'),
                            ),
                          ),
                          const SizedBox(height: 26.0),
                          const Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.grey,
                                  height: 1,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "Or Login With",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Colors.grey,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 26.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 45),
                            child: Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                  child: const Center(
                                    child: Row(
                                      children: [
                                        // Image.asset(
                                        //   'assets/images/google.png',
                                        //   width: 30,
                                        //   height: 30,
                                        // ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Google",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                  child: const Center(
                                    child: Row(
                                      children: [
                                        // Image.asset(
                                        //   'assets/images/google.png',
                                        //   width: 30,
                                        //   height: 30,
                                        // ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Facebook",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 26.0),
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FilledButton.tonal(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SignupUserScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
