
import 'package:flutter/material.dart';

Text showText(
    {required String label, required double size, required Color color}) {
  return Text(
    label,
    
    style: TextStyle(
      color: color,
      fontSize: size,
    ),
  );
}