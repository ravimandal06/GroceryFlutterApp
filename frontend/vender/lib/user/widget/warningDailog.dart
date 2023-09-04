import 'package:flutter/material.dart';

class WarningDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirm;

  const WarningDialog(
      {super.key, required this.title, required this.message, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context); // Close the dialog after confirming
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
