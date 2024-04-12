import 'package:flutter/material.dart';

Widget textfieldeditor(
    {required TextEditingController controller,
    required String hintlable,
    TextInputType? keyboardType,
    int? maxline,
    bool? border = false,
    String? labelText}) {
  return Container(
    decoration: BoxDecoration(
        border:
            border == false ? Border.all(color: Colors.black, width: 4) : null,
        borderRadius: BorderRadius.all(Radius.circular(5))),

    // margin: const EdgeInsets.symmetric(horizontal: 15),
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: TextFormField(
      maxLines: maxline,
      keyboardType: keyboardType,
      style: const TextStyle(color: Color.fromARGB(255, 10, 10, 10)),
      controller: controller,
      decoration: InputDecoration(
        border: border == false ? InputBorder.none : null,
        // ink well to switch the visiblity to true and false
        labelText: labelText,
        hintText: hintlable,
        hintStyle: const TextStyle(
            color: Color.fromARGB(151, 43, 43, 43), fontSize: 20),
      ),
    ),
  );
}
