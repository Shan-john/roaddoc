import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/core/routes.dart';
import 'package:roaddoc/core/themes.dart';
import 'package:roaddoc/function/ShowMessage.dart';
import 'package:roaddoc/function/getlocation.dart';
import 'package:roaddoc/models/user_model/user_model.dart';
import 'package:roaddoc/presentation/Driver/diver_home_screen.dart';
import 'package:roaddoc/presentation/HistoryScreen/UserdetailsSceen.dart';
import 'package:roaddoc/presentation/HistoryScreen/historyScreen.dart';

import 'package:roaddoc/presentation/mechanic/driverRequestScreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:roaddoc/presentation/splashScreen/welcomeScreen.dart';
import 'package:roaddoc/service/firebase/firebase_auth.dart';
import 'package:roaddoc/service/firebase/firebase_firestorehelper.dart';

import 'package:roaddoc/service/provider/provider.dart';

class MechanicHomeScreen extends StatefulWidget {
  MechanicHomeScreen({
    super.key,
  });

  @override
  State<MechanicHomeScreen> createState() => _MechanicHomeScreenState();
}

class _MechanicHomeScreenState extends State<MechanicHomeScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: true);
    appProvider.getDriversRequestList();
    appProvider.getHistoryList(appProvider.getuserInfromation);
    List<UserModel> requestdriverlist = appProvider.getDriverRequestlist;
    appProvider.getCurrenAcceptedDriverDetails(
        mechUser: appProvider.getuserInfromation);
    appProvider.getUserloaction();

    Position position = appProvider.getUserlocation;
    print(position.latitude);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                FireBaseAuthHelper.instance.logOut();
                Routes.instance.pushandRemoveUntil(
                    widget: WelcomeScreen(), context: context);
              },
              icon: Icon(Icons.menu_sharp)),
          actions: [
            IconButton(
                tooltip: "Confirmed Drivers Credentials",
                onPressed: () {
                  appProvider.currenAcceptedDriverDetails.id != null
                      ? Routes.instance.push(
                          widget: UserDetailScreen(
                              userModel:
                                  appProvider.currenAcceptedDriverDetails),
                          context: context)
                      : null;
                },
                icon: Icon(
                  Icons.inventory_rounded,
                  color: appProvider.currenAcceptedDriverDetails.id != null
                      ? Color.fromARGB(255, 29, 97, 9)
                      : Color.fromARGB(255, 161, 0, 0),
                )),
            IconButton(
                tooltip: "History",
                onPressed: () {
                  Routes.instance.push(
                      widget:
                          HistoryScreen(UserHistory: appProvider.listofHistory),
                      context: context);
                },
                icon: Icon(
                  Icons.history,
                  size: 30,
                ))
          ],
        ),
        drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            )
          ]),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) {
              final DriverUser = requestdriverlist[index];
              return InkWell(
                onTap: () async {
                  //Position position = await getlocation();

                  Routes.instance.push(
                      widget: DriverRequesDetailsScreen(
                        data: DriverUser,
                      ),
                      context: context);
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Color.fromARGB(255, 252, 252, 252),
                    boxShadow: listoBoxshadow,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 37,
                      child: TextConfortaa("${index + 1}", 20),
                    ),
                    title: TextConfortaa(DriverUser.name.toString(), 20),
                    subtitle:
                        TextConfortaa("+91 ${DriverUser.phoneNumber}", 18),
                    trailing: SizedBox(
                        width: 100,
                        child: CircularButton(
                          color: Colors.green,
                          onpress: () {
                            if (position.altitude == 0 &&
                                position.longitude == 0) {
                              showMessage(
                                  "Hold on, setting things up...");
                            } else {
                              if (appProvider.currenAcceptedDriverDetails.id ==
                                  null) {
                                appProvider.removeRequest(DriverUser);
                                FirebasefirestoreHelper.instance
                                    .removeRequest(id: DriverUser.id);
                                FirebasefirestoreHelper.instance
                                    .uploadCurrenAcceptedDriverDetails(
                                        driverUser: DriverUser,
                                        MechUser:
                                            appProvider.getuserInfromation);

                                UserModel UpdatedMech =
                                    appProvider.getuserInfromation.copyWith(
                                        latitude: position.latitude,
                                        longitude: position.longitude);

                                appProvider.updateuserinfo(UpdatedMech);
                                FirebasefirestoreHelper.instance
                                    .uploadCurrenAcceptedDriverDetails(
                                        driverUser: DriverUser,
                                        MechUser:
                                            appProvider.getuserInfromation);
                                FirebasefirestoreHelper.instance
                                    .uploadCurrentAccptedMech(
                                        MechUser:
                                            appProvider.getuserInfromation,
                                        driverUser: DriverUser);
                              } else {
                                showMessage(
                                    "Already Accepted a request ,Check the details screen");
                              }
                            }
                          },
                          radius: 40,
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Gap(10);
            },
            itemCount: requestdriverlist.length));
  }
}

class CircularButton extends StatelessWidget {
  final Function() onpress;
  final double radius;
  final Color color;
  final Widget child;
  const CircularButton({
    super.key,
    required this.onpress,
    required this.radius,
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        height: radius,
        width: radius,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: child,
      ),
    );
  }
}
