import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'screens/login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

      // User sign-out successful
      // Navigate to the sign-in screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FilledButton(
              onPressed: () async {
                await signOut(context);
              },
              child: const Text("Sign Out"),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Align(
                alignment: const Alignment(0.0, 1.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: BottomNavigationBar(
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Colors.grey,
                    showSelectedLabels: true,
                    showUnselectedLabels: false,
                    backgroundColor: Colors.black,
                    onTap: (int index) {},
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), label: "Home"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.search), label: "Search"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.add), label: "Add"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.favorite), label: "Favorite"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.person), label: "Profile"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
