import 'package:flutter/material.dart';

loaderIndicator(BuildContext context) {
  AlertDialog alert = AlertDialog(
    backgroundColor: const Color.fromARGB(0, 0, 0, 0),
    content: SizedBox(
      width:
          10.0, // Set the width and height to the same value to make it square
      height: 50.0,
      child: Builder(
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 10, 207, 131),
            ),
          );
        },
      ),
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return alert;
    },
  );
}
