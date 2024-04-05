import 'package:flutter/material.dart';

class Primarybutton extends StatelessWidget {
  final double size;
  final double fontsize;
  final Widget? icon;
  final Color colors;
  final double? height;
  final String label;
  final Color Textcolor;
  final void Function()? onpressed;
  final Color? bordercolor;
  final double? borderwidth;
  const Primarybutton({
    super.key,
    this.height = 45,
    this.onpressed,
    required this.size,
    this.icon,
    required this.colors,
    required this.label,
    required this.fontsize,
    required this.Textcolor,
    this.bordercolor,
    this.borderwidth,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: size,
          height: height,
          decoration: BoxDecoration(
            border: Border.all(
              color: bordercolor ?? Colors.transparent,
              width: borderwidth ?? 0.0,
            ),
            borderRadius: BorderRadius.circular(5),
            color: colors,
          ),
          child: MaterialButton(
            onPressed: onpressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon ?? const SizedBox(),
                Text(
                  label,
                  style: TextStyle(
                    color: Textcolor,
                    fontSize: fontsize,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

/// custom
titleText(String lable, double fontsize) {
  return Text(
    lable,
    style: TextStyle(fontSize: fontsize, fontFamily: "Comfortaa"),
  );
}

Text TextConfortaa(String text, double size) {
  return Text(
    text,
    style: TextStyle(
        fontSize: size, fontWeight: FontWeight.w400, fontFamily: "Confortaa"),
  );
}
