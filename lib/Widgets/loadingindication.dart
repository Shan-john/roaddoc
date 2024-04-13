import 'package:flutter/material.dart';

 
void loaderIndicator(BuildContext context) {
  showDialog( 
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.transparent,
      content: SizedBox(
        width: 50.0,
        height: 50.0,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Color.fromARGB(255, 10, 207, 131),
            ),
          ),
        ),
      ),
    ),
  );
}