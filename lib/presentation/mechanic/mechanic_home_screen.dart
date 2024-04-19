import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';

import 'package:provider/provider.dart';
import 'package:roaddoc/Widgets/avatarimageProvider.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';

import 'package:roaddoc/core/routes.dart';
import 'package:roaddoc/core/themes.dart';
import 'package:roaddoc/function/getlocation.dart';
import 'package:roaddoc/models/locationModel/location_model/location_model.dart';

import 'package:roaddoc/models/user_model/user_model.dart';
import 'package:roaddoc/presentation/mechanic/acceptedDriverrUserDetailScreen.dart';

import 'package:roaddoc/presentation/mechanic/driverRequestScreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:roaddoc/presentation/splashScreen/welcomeScreen.dart';
import 'package:roaddoc/service/firebase/firebase_auth.dart';
import 'package:roaddoc/service/firebase/firebase_firestorehelper.dart';
import 'package:roaddoc/service/https/httpsCall.dart';

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
     




    return Scaffold(
        appBar: AppBar(
          title: TextConfortaa(text: "ROAD DOC", size: 20),
          actions: [
            IconButton(
                tooltip: "Confirmed Drivers Credentials",
                onPressed: () {
                  appProvider.currenAcceptedDriverDetails.id != null
                      ? Routes.instance.push(
                          widget: AcceptedDriverUserScreen(
                              driverUser:
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
          ],
        ),
        body: ListView.separated(
            itemBuilder: (context, index) {
              final DriverUser = requestdriverlist[index];
              return InkWell(
                onTap: () async {
                  appProvider.getUserloaction();

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
                    color: const Color.fromARGB(255, 252, 252, 252),
                    boxShadow: listoBoxshadow,
                  ),
                  child: ListTile(
                    leading:   CircleAvatar(
                      radius: 20,
                      backgroundImage: avatarImageProvider(model:DriverUser)
                    ),
                    title: TextConfortaa(
                        text: DriverUser.name.toString(), size: 20),
                    subtitle: TextConfortaa(
                        text: "+91 ${DriverUser.phoneNumber}", size: 18),
                    trailing: TextConfortaa(text: DriverUser.time??"", size: 18),),
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


