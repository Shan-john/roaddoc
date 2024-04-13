import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/core/images.dart';
import 'package:roaddoc/core/routes.dart';
import 'package:roaddoc/core/themes.dart';
import 'package:roaddoc/function/urlLauncher.dart';
import 'package:roaddoc/models/user_model/user_model.dart';

class AcceptedDriverUserScreen extends StatelessWidget {
  final UserModel driverUser;
  const AcceptedDriverUserScreen({super.key, required this.driverUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Routes.instance.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              backgroundColor: Colors.black,
              radius: 70,
              backgroundImage: driverUser.image == ""
                  ? NetworkImage(driverUser.image!)
                  : NetworkImage(personAvatar),
            ),
            Center(
              child: Container(
                height: 500,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: listoBoxshadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextConfortaa(text: "Driver Details", size: 30),
                    RowMaptile(
                      icon: Icons.person_3_outlined,
                      value: driverUser.name!,
                      size: 25,
                    ),
                    RowMaptile(
                      icon: Icons.mail_outlined,
                      value: driverUser.mailid!,
                      size: 25,
                    ),
                    InkWell(
                      onTap: () {
                        makePhoneCall(driverUser.phoneNumber.toString());
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RowMaptile(
                            icon: Icons.call_outlined,
                            value: driverUser.phoneNumber.toString(),
                            size: 25,
                          ),
                          Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                    RowMaptile(
                      icon: Icons.code,
                      value: driverUser.id.toString(),
                      size: 25,
                    ),
                    Primarybutton(
                      size: 390,
                      colors: Colors.white,
                      label: "Navigate",
                      onpressed: () {
                        launchGoogleMap(
                            latitude: driverUser.latitude ?? 0,
                            longitude: driverUser.longitude ?? 0);
                      },
                      fontsize: 18,
                      Textcolor: Colors.red,
                      bordercolor: Colors.black,
                      borderwidth: 2,
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class RowMaptile extends StatelessWidget {
  final IconData icon;
  final String value;
  final double size;
  const RowMaptile(
      {required this.icon, required this.value, required this.size});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon),
            Gap(5),
            TextConfortaa(text: value, size: 18),
          ],
        ),
        Gap(15)
      ],
    );
  }
}
