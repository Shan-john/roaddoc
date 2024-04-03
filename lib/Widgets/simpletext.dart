import 'package:flutter/material.dart';

class SimpleText extends StatelessWidget {
  final String lable;
  const SimpleText({super.key, required this.lable});

  @override
  Widget build(BuildContext context) {
    return Text(
      lable,
      style: const TextStyle(fontSize: 20, fontFamily: "Roboto",fontWeight: FontWeight.w600  ),
    );
    
  }
}
