import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/models/user_model/user_model.dart';
import 'package:roaddoc/service/provider/provider.dart';

class StatusScreen extends StatefulWidget {
  StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  bool isMechanicAccepted = false;
  bool isMechanicReachedButtonisUsed = false;
  bool isInspected = false;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of(listen: true, context);
    appProvider.getCurrentAcceptedMech(
        driverUser: appProvider.getuserInfromation);
    UserModel MechUser = appProvider.currentAvailableMechUser;
    MechUser.id == null
        ? isMechanicAccepted = false
        : isMechanicAccepted = true;
    print(MechUser.name);
    print(isMechanicAccepted);
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleText("Status", 40),
            Gap(10),
            Primarybutton(
              size: 390,
              colors: isMechanicAccepted == false
                  ? Colors.white
                  : Color.fromARGB(255, 0, 255, 157),
              label: "Is Mechanic accept your request",
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
              onpressed: () {
                appProvider.removecurrentavailableMech(
                    driverUser: appProvider.getuserInfromation);
                setState(() {});
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
              label: "Payment",
              fontsize: 18,
              Textcolor: Colors.black,
              bordercolor: Colors.black,
              borderwidth: 2,
              height: 100,
            ),
            isMechanicAccepted
                ? ListTile(
                    title: TextConfortaa(MechUser.name ?? "", 20),
                    subtitle:
                        TextConfortaa("+91 ${MechUser.phoneNumber ?? ""} ", 18),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
