import 'dart:math';

import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vender/user/screen/login.dart';

class SignupUserScreen extends StatefulWidget {
  const SignupUserScreen({Key? key}) : super(key: key);

  @override
  State<SignupUserScreen> createState() => _SignupUserScreenState();
}

class _SignupUserScreenState extends State<SignupUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final String _name = '';
  //
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  bool isNotValidate_ = false;

  Future<bool> registerUser() async {
    print('registerUser');
    // final url = Uri.parse('http://192.168.1.70:41744/registration');
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var regBody = {
        "email": emailController.text,
        "password": passwordController.text,
        "name": nameController.text,
        "phoneNumber": phoneNumberController.text,
      };
      var body = jsonEncode(regBody);
      print(body);
      var response = await http.post(
          Uri.parse("http://190.190.2.226:3000/User/registration"),
          headers: {"Content-Type": "application/json"},
          body: body);
      print("hellloo");
      print(response.body);
      print(response.statusCode);

      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);

      if (jsonResponse['status']) {
        print("success");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginUserScreen(),
          ),
        );
        return true;
      } else {
        print("something went wrong");
        return false;
      }
    } else {
      setState(() {
        // isNotValidate_ = true;
      });
    }
    return false;
  }

  // Future<void> signUp(BuildContext context) async {
  //   try {
  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: emailController.text,
  //       password: passwordController.text,
  //     );

  //     // User registration successful
  //     // You can navigate to another screen here
  //     print('User registered: ${userCredential.user?.email}');
  //     if (userCredential.user != null) {
  //       await userCredential.user!.updateDisplayName(_name);
  //       print("user exits");
  //       sendDataToServer();
  //       print("send data to server ${sendDataToServer()}");
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const LoginScreen(),
  //         ),
  //       );
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //     }
  //     // Handle other exceptions here
  //   }
  // }

  // //////////// send data to backend ////////////

  // sendDataToServer() async {
  //   // Create a NameEmailModel instance with the entered data
  //   UserAuthData data = UserAuthData(
  //       name: nameController.text,
  //       email: emailController.text,
  //       address: '',
  //       id: "${FirebaseAuth.instance.currentUser?.uid}",
  //       password: passwordController.text,
  //       phoneNumber: phoneNumberController.text,
  //       type: '');

  //   // Convert the data to JSON
  //   String jsonData = jsonEncode(data);

  //   // Specify the endpoint where you want to send the data
  //   String endpoint = '/signup'; // Replace with your actual endpoint

  //   // Send a POST request with the JSON data to the localhost

  //   String response = await NetworkHandler.post(jsonData, endpoint);

  //   print('Response: $response');
  // }

  //////////// end of function //////////

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
                      "Register your new account!",
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
                            controller: nameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Name',
                              hintText: 'Enter your full name',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            // onChanged: (value) {
                            //   setState(() {
                            //     nameController.text = value;
                            //   });
                            // },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
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
                            // onChanged: (value) {
                            //   setState(() {
                            //     emailController.text = value;
                            //   });
                            // },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                                prefixIcon: IconButton(
                                    icon: const Icon(Icons.password),
                                    onPressed: () {
                                      String passGen = generatePassword();
                                      passwordController.text = passGen;
                                      print(passGen);
                                      setState(() {
                                        //
                                      });
                                    })),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            // onChanged: (value) {
                            //   setState(() {
                            //     // _name = value;
                            //     passwordController.text = value;
                            //   });
                            // },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: phoneNumberController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Phone Number',
                              hintText: 'Enter your Phone Number',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                            // onChanged: (value) {
                            //   setState(() {
                            //     // _name = value;
                            //     phoneNumberController.text = value;
                            //   });
                            // },
                          ),
                          const SizedBox(
                            height: 10,
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
                                  // registerUser();
                                  await registerUser();
                                  // signUp(context);
                                }
                              },
                              child: const Text('Continue'),
                            ),
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
      ),
    );
  }

  String generatePassword() {
    String upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    String lower = 'abcdefghijklmnopqrstuvwxyz';
    String numbers = '1234567890';
    String symbols = '!@#\$%^&*()<>,./';
    String password = '';
    int passLength = 20;
    String seed = upper + lower + numbers + symbols;
    List<String> list = seed.split('').toList();
    Random rand = Random();
    for (int i = 0; i < passLength; i++) {
      int index = rand.nextInt(list.length);
      password += list[index];
    }
    return password;
  }
}
