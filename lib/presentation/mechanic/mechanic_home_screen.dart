import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/core/routes.dart';
import 'package:roaddoc/function/getlocation.dart';
import 'package:roaddoc/models/user_model/user_model.dart';
import 'package:roaddoc/presentation/Driver/diver_home_screen.dart';

import 'package:roaddoc/presentation/mechanic/driverRequestScreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:roaddoc/presentation/splashScreen/welcomeScreen.dart';
import 'package:roaddoc/service/firebase/firebase_auth.dart';
import 'package:roaddoc/service/firebase/firebase_firestorehelper.dart';
import 'package:roaddoc/service/firebase/firebaserealtime.dart';
import 'package:roaddoc/service/provider/provider.dart';

class MechanicHomeScreen extends StatefulWidget {
  MechanicHomeScreen({
    super.key,
  });

  @override
  State<MechanicHomeScreen> createState() => _MechanicHomeScreenState();
}

class _MechanicHomeScreenState extends State<MechanicHomeScreen> {
  bool isloading = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isloading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: true);
    appProvider.getDriversRequestList();
    List<UserModel> requestdriverlist = appProvider.getDriverRequestlist;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                FireBaseAuthHelper.instance.logOut();
                Routes.instance.pushandRemoveUntil(
                    widget: WelcomeScreen(), context: context);
              },
              icon: Icon(Icons.menu_sharp)),
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
              final data = requestdriverlist[index];
              return InkWell(
                onTap: () async {
                  //Position position = await getlocation();

                  Routes.instance.push(
                      widget: DriverRequesDetailsScreen(
                        data: data,
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
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(101, 58, 58, 58),
                            blurRadius: 5,
                            spreadRadius: 0,
                            offset: Offset(3, 5)),
                        BoxShadow(
                            color: Color.fromARGB(48, 1, 111, 255),
                            blurRadius: 5,
                            spreadRadius: 0,
                            offset: Offset(-5, -3))
                      ]),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 37,
                      child: TextConfortaa("${index + 1}", 20),
                    ),
                    title: TextConfortaa(data.name.toString(), 20),
                    subtitle: TextConfortaa("+91 ${data.phoneNumber}", 18),
                    trailing: SizedBox(
                        width: 100,
                        child: CircularButton(
                          color: Colors.green,
                          onpress: () {
                            appProvider.removeRequest(data);
                            firebaseRealtimeStorageHelper.instance
                                .requeststatuschager(value: true, id: data.id);
                            FirebasefirestoreHelper.instance
                                .removeRequest(id: data.id);
                            FirebasefirestoreHelper.instance
                                .uploadCurrentAccptedMech(
                                    MechUser: appProvider.getuserInfromation,
                                    driverUser: data);
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
