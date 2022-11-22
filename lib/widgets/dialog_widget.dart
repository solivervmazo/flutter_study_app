import 'package:flutter/material.dart';

class DialogWidget {
  static final DialogWidget _singleTon = DialogWidget._internal();

  DialogWidget._internal();

  factory DialogWidget() {
    return _singleTon;
  }

  static Widget questionStartDialog({required VoidCallback onTap}) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Hi",
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
          Text("Please login before you start")
        ],
      ),
      actions: [
        TextButton(
          onPressed: onTap,
          child: const Text("Proceed"),
        ),
      ],
    );
  }
}
