import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color.fromARGB(255, 37, 37, 37),
      textColor: Colors.white,
      fontSize: 16.0);
}
