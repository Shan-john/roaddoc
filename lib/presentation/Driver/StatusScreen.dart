import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gap/gap.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/core/routes.dart';
import 'package:roaddoc/function/ShowMessage.dart';
import 'package:roaddoc/function/calculateDistanceLatitudemandLongitude.dart';
import 'package:roaddoc/models/user_model/user_model.dart';
import 'package:roaddoc/presentation/Driver/acceptedMechuserDetailScreen.dart';
import 'package:roaddoc/presentation/Driver/inspectionfeedbackScreen.dart';
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
    UserModel mechUser = appProvider.currentAvailableMechUser;

    mechUser.id == null
        ? isMechanicAccepted = false
        : isMechanicAccepted = true;
    // print(mechUser.name);
    // print(isMechanicAccepted);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleText("Status", 40),
              Gap(10),
              Primarybutton(
                size: 390,
                colors: isMechanicAccepted == false
                    ? Colors.white
                    : Color.fromARGB(255, 0, 255, 157),
                label: "Request accepted?",
                onpressed: () {
                  isMechanicAccepted
                      ? Routes.instance.push(
                          widget: AcceptedMechUserDetailsScreen(
                            mechUser: mechUser,
                          ),
                          context: context)
                      : showMessage("Pending acceptance..");
                },
                fontsize: 18,
                Textcolor: Colors.black,
                bordercolor: Colors.black,
                borderwidth: 2,
                height: 100,
              ),
              Gap(10),
              isMechanicAccepted
                  ? Container(
                      height: MediaQuery.of(context).size.height / 2.2,
                      width: double.infinity,
                      child: FlutterMap(
                          options: MapOptions(
                            minZoom: 10,
                            initialZoom: 17,
                            initialCenter: LatLng(mechUser.latitude ?? 0.0,
                                mechUser.longitude ?? 0.0),
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
                                  height: 50,
                                  point: LatLng(mechUser.latitude ?? 0.0,
                                      mechUser.longitude ?? 0.0),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                    ],
                                  )),
                              Marker(
                                point: LatLng(
                                    appProvider.getUserlocation.latitude,
                                    appProvider.getUserlocation.latitude),
                                child: Icon(
                                  Icons.location_on,
                                  color: const Color.fromARGB(255, 54, 57, 244),
                                  size: 30,
                                ),
                              ),
                              Marker(
                                  point: LatLng(
                                      appProvider.getUserlocation.latitude,
                                      appProvider.getUserlocation.latitude),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 30,
                                  ))
                            ]),
                          ]))
                  : SizedBox(),
              Gap(20),
              Primarybutton(
                size: 390,
                colors: Colors.white,
                label: "Payment",
                onpressed: () {
                  if (isMechanicAccepted) {
                    Routes.instance.push(
                        widget: FeedbackScreenDriver(
                          MechUser: mechUser,
                        ),
                        context: context);
                  } else {
                    showMessage("Pending acceptance..");
                  }

                  // appProvider.removecurrentavailableMech(
                  //     driverUser: appProvider.getuserInfromation);
                  // setState(() {});
                },
                fontsize: 18,
                Textcolor: Colors.black,
                bordercolor: Colors.black,
                borderwidth: 2,
                height: 100,
              ),
              Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
