import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';

class DriverRequesDetailsScreen extends StatelessWidget {
  const DriverRequesDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // cro
          children: [
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkUD7iu_VLgdUdXR1fFBuo_letwFWX90p6v7umD9lDKQ&s"),
                  ),
                  TextConfortaa("Shan john", 20),
                  TextConfortaa("TRIVANDRUM, KERALA", 20),
                ],
              ),
            ),
            SizedBox(
              child: Column(
                children: [
                  Primarybutton(
                      size: 300,
                      colors: Colors.green,
                      label: "ACCEPT",
                      fontsize: 20,
                      Textcolor: Colors.white),
                  Gap(20),
                
                  Primarybutton(
                    size: 300,
                    colors: Colors.transparent,
                    label: "#KM distance",
                    fontsize: 20,
                    Textcolor: Colors.black,
                    bordercolor: Colors.black,
                    borderwidth: 3,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
