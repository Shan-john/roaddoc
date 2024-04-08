import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/Widgets/simpletext.dart';
import 'package:roaddoc/core/routes.dart';
import 'package:roaddoc/function/ShowMessage.dart';
import 'package:roaddoc/function/getlocation.dart';

import 'package:roaddoc/models/user_model/user_model.dart';
import 'package:roaddoc/presentation/Driver/StatusScreen.dart';
import 'package:roaddoc/presentation/HistoryScreen/historyScreen.dart';
import 'package:roaddoc/presentation/splashScreen/welcomeScreen.dart';
import 'package:roaddoc/service/firebase/firebase_auth.dart';
import 'package:roaddoc/service/firebase/firebase_firestorehelper.dart';

import 'package:roaddoc/service/provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';

class DriverHomeScreen extends StatefulWidget {
  DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  String titlelable = "Locate";
  bool isloading = true;

  List<UserModel> listofrequest = [];
  @override
  void initState() {
    super.initState();
  }

  // _get_lat_long() async {
  //   position = await getlocation();
  // }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of(listen: true, context);
    appProvider.getCurrentAcceptedMech(
        driverUser: appProvider.getuserInfromation);
    appProvider.getHistoryList(appProvider.getuserInfromation);
    Position position = appProvider.getUserlocation;
    position.latitude == 0.0 ? isloading = true : isloading = false;

    print(position.longitude);
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 37,
          leading: IconButton(
              onPressed: () {
                FireBaseAuthHelper.instance.logOut();
                Routes.instance.pushandRemoveUntil(
                    widget: WelcomeScreen(), context: context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          actions: [
            IconButton(
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
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleText(titlelable, 40),

              const SimpleText(lable: "Available Mechanics Around"),
              Gap(size.height / 16),
              Container(
                height: MediaQuery.of(context).size.height / 1.7,
                width: double.infinity,
                child: !isloading
                    ? FlutterMap(
                        options: MapOptions(
                          minZoom: 10,
                           initialZoom: 17,
                          initialCenter:
                              LatLng(position.latitude, position.longitude),
                        ),
                        children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              subdomains: ['a', 'b', 'c'],
                            ),
                            MarkerLayer(markers: [
                              Marker(
                                  //  point: LatLng(9.357359, 76.866928),
                                  point: LatLng(
                                      position.latitude, position.longitude),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 30,
                                  ))
                            ])
                          ])
                    : Center(
                        child: SizedBox(
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ),
              Gap(size.height / 23),
              // Primarybutton(
              //     bordercolor: Colors.black,
              //     borderwidth: 2,
              //     size: 390,
              //     colors: Colors.white,
              //     label: "REQUEST MECHANIC",
              //     onpressed: () async {
              //       loaderIndicator(context);

              //       listofrequest = appProvider.getDriverRequestlist;
              //       print(" altitude : ${position.latitude}");
              //       UserModel userModel = appProvider.getuserInfromation
              //           .copyWith(
              //               inspectionmessage: "ho bro",
              //               latitude: position.latitude,
              //               longitude: position.longitude);
              //       appProvider.getCurrentAcceptedMech(
              //           driverUser: appProvider.getuserInfromation);
              //       appProvider.updateuserinfo(userModel);

              //       if (appProvider.currentAvailableMechUser.id == null) {
              //         requestbuttom(appProvider.getuserInfromation.id);
              //       } else {
              //         Routes.instance.pop(context);
              //         Routes.instance
              //             .push(widget: StatusScreen(), context: context);
              //         showMessage("Mechanic already accepted your request");
              //       }
              //     },
              //     fontsize: 18,
              //     Textcolor: Colors.black),
              // Gap(5),
              // Primarybutton(
              //     bordercolor: Colors.black,
              //     borderwidth: 2,
              //     size: 390,
              //     colors: Colors.white,
              //     label: " CANNCEL REQUEST",
              //     onpressed: () async {
              //       loaderIndicator(context);
              //       appProvider.currentAvailableMechUser.id == ""
              //           ? FirebasefirestoreHelper.instance.removeRequest(
              //               id: appProvider.getuserInfromation.id)
              //           : showMessage("your Request is already accepted");
              //       Routes.instance.pop(context);
              //     },
              //     fontsize: 18,
              //     Textcolor: Colors.black)

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Primarybutton(
                      Textcolor: Colors.black,
                      height: 60,
                      size: 189,
                      colors: Colors.white,
                      label: "REQUEST MECHANIC",
                      onpressed: () async {
                        if (position.altitude == 0 && position.longitude == 0) {
                          showMessage("Hold on, setting things up...");
                        } else { loaderIndicator(context);
                        appProvider.getCurrentAcceptedMech(
                            driverUser: appProvider.getuserInfromation);
                        listofrequest = appProvider.getDriverRequestlist;
                        print(" altitude : ${position.latitude}");
                        UserModel userModel = appProvider.getuserInfromation
                            .copyWith(
                                latitude: position.latitude,
                                longitude: position.longitude);

                        appProvider.updateuserinfo(userModel);

                        if (appProvider.currentAvailableMechUser.id == null) {
                          requestbuttom(appProvider.getuserInfromation.id);
                        } else {
                          Routes.instance.pop(context);
                          Routes.instance
                              .push(widget: StatusScreen(), context: context);
                          showMessage("Mechanic already accepted your request");
                        }}

                       
                      },
                      bordercolor: Colors.black,
                      borderwidth: 3,
                      fontsize: 15),
                  Primarybutton(
                      fontsize: 18,
                      Textcolor: Colors.white,
                      height: 60,
                      size: 189,
                      colors: Colors.black,
                      label: "CANCEL REQUEST",
                      onpressed: () {
                        loaderIndicator(context);
                        appProvider.currentAvailableMechUser.id == ""
                            ? FirebasefirestoreHelper.instance.removeRequest(
                                id: appProvider.getuserInfromation.id)
                            : showMessage("your Request is already accepted");
                        Routes.instance.pop(context);
                      })
                ],
              )
            ],
          ),
        )
        //
        );
  }

  void requestbuttom(String? id) async {
    UserModel userModel = UserModel(id: "");
    if (listofrequest.isNotEmpty) {
      userModel =
          listofrequest.firstWhere((element) => element.id == id, orElse: () {
        listofrequest.add(UserModel(id: ""));
        return UserModel();
      });
    }

    Routes.instance.pop(context);

    if (userModel.id == "") {
      bool uploaded =
          await FirebasefirestoreHelper.instance.uploadRequest(context, id);
      uploaded == true
          ? Routes.instance.push(widget: StatusScreen(), context: context)
          : null;
    } else {
      showMessage("Already requested routing to the status page.");

      Routes.instance.push(widget: StatusScreen(), context: context);
    }
  }
}

loaderIndicator(BuildContext context) {
  AlertDialog alert = AlertDialog(
    backgroundColor: const Color.fromARGB(0, 0, 0, 0),
    content: SizedBox(
      width:
          10.0, // Set the width and height to the same value to make it square
      height: 50.0,
      child: Builder(
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 10, 207, 131),
            ),
          );
        },
      ),
    ),
  );
  showDialog(
    context: context,
    builder: (context) {
      return alert;
    },
  );
}
