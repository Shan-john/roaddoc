import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';

class StatusScreen extends StatefulWidget {
  StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  bool isMechanicReached = false;
  bool isMechanicReachedButtonisUsed = false;
  bool isInspected = false;
  void StutusCheck() {
    // todo check the status to the mech user to indicate the Status light
    // from history of the current mech user id on the user collection
  }
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
      body: SafeArea(
        minimum: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleText("Status", 40),
            Gap(10),
            Primarybutton(
              size: 390,
              colors: !isMechanicReached
                  ? Colors.white
                  : Color.fromARGB(255, 0, 255, 157),
              label: "Is Mechanic accept your request",
              onpressed: () {
                setState(() {
                  if (!isMechanicReachedButtonisUsed) {
                    isMechanicReached = !isMechanicReached;
                    isMechanicReachedButtonisUsed = true;
                  }
                });
              },
              fontsize: 18,
              Textcolor: Colors.black,
              bordercolor: Colors.black,
              borderwidth: 2,
              height: 100,
            ),
            Gap(20),
            Primarybutton(
              size: 390,
              colors: Colors.white,
              label: "Inspected",
              fontsize: 18,
              Textcolor: Colors.black,
              bordercolor: Colors.black,
              borderwidth: 2,
              height: 100,
            ),
            Gap(20),
            Primarybutton(
              size: 390,
              colors: Colors.white,
              label: "Payment",
              fontsize: 18,
              Textcolor: Colors.black,
              bordercolor: Colors.black,
              borderwidth: 2,
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
