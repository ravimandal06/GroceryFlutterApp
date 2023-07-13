import 'package:flutter/material.dart';

class OptionScreen extends StatefulWidget {
  const OptionScreen({super.key});

  @override
  _OptionScreenState createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  bool firstOptionSelected = false;
  bool secondOptionSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select an Option'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          firstOptionSelected = true;
                          secondOptionSelected = false;
                        });
                      },
                      child: Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          color:
                              firstOptionSelected ? Colors.blue : Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Seller',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          firstOptionSelected = false;
                          secondOptionSelected = true;
                        });
                      },
                      child: Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          color:
                              secondOptionSelected ? Colors.blue : Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Delivery Boy',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 350,
            ),
            SizedBox(
              width: 600,
              height: 45,
              child: FilledButton.tonal(
                onPressed: () {
                  // if (_formKey.currentState!.validate()) {
                  //   // Form is valid, process the data
                  //   // For example, save it to a database
                  //   print('Name: $_name');
                  // }
                  //  Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => const AddProduct(),
                  //     ),
                  //   );
                },
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: OptionScreen(),
  ));
}
