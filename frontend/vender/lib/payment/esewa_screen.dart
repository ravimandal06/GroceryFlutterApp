import 'package:flutter/material.dart';

class EsewaScreen extends StatefulWidget {
  const EsewaScreen({super.key});

  @override
  State<EsewaScreen> createState() => _EsewaScreenState();
}

class _EsewaScreenState extends State<EsewaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Esewa Integration'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          Image.network(
            'https://picsum.photos/id/237/200/300',
            width: 300,
            height: 200,
          ),
          Text(
            'Pariatur occaecat elit esse quis.',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          ElevatedButton(
            child: const Text('Pay with E-Sewa'),
            onPressed: () {
              try {} catch (e) {
                print("error -----> $e");
              }
            },
          ),
        ],
      ),
    );
  }
}
