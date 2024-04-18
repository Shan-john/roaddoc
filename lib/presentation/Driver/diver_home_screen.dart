import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:roaddoc/Widgets/loadingindication.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/Widgets/simpletext.dart';
import 'package:roaddoc/core/routes.dart';
import 'package:roaddoc/function/ShowMessage.dart';
import 'package:roaddoc/function/getlocation.dart';
import 'package:roaddoc/models/locationModel/location_model/location_model.dart';
import 'package:roaddoc/models/user_model/user_model.dart';
import 'package:roaddoc/presentation/Driver/StatusScreen.dart';
import 'package:roaddoc/service/firebase/firebase_firestorehelper.dart';
import 'package:roaddoc/service/https/httpsCall.dart';
import 'package:roaddoc/service/provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';

class DriverHomeScreen extends StatelessWidget {
  DriverHomeScreen({super.key});

  String titlelable = "Locate";

  bool isloading = true;

  List<UserModel> listofrequest = [];

// @override
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of(listen: true, context);
    appProvider.getCurrentAcceptedMech(
        driverUser: appProvider.getuserInfromation);
    appProvider.getHistoryList(appProvider.getuserInfromation);
    Position position = appProvider.getUserlocation;

    position.latitude == 0.0 ? isloading = true : isloading = false;
    DateTime now = DateTime.now();

    String hour = (now.hour % 12).toString().padLeft(2, '0');
    String minute = now.minute.toString().padLeft(2, '0');

    String period = now.hour >= 12 ? 'PM' : 'AM';
    String currentTime = '$hour:$minute:$period';
  
    final size = MediaQuery.of(context).size;
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
        Routes.instance.pop(context);
        Routes.instance.push(widget: StatusScreen(), context: context);
      }
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              toolbarHeight: 37,
              title: TextConfortaa(text: "ROAD DOC", size: 20),
            ),
            TextConfortaa(text: titlelable, size: 40),
            const SimpleText(lable: "Available Mechanics Around"),
            Gap(size.height / 16),
            Container(
              height: MediaQuery.of(context).size.height / 1.8,
              width: double.infinity,
              child: isloading == false
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
                      appProvider.getUserloaction();

                      if (position.altitude == 0 && position.longitude == 0) {
                        showMessage("Hold on, setting things up...");
                      } else {
                        loaderIndicator(context);
                        Placemark placemark = await getPlaceName(
                            latitude: position.latitude,
                            longitude: position.longitude);

                        LocationModel locationModel = await getLocationDetails(
                            placemark.postalCode.toString());

                        String address =
                            "${placemark.locality ?? ""}_${locationModel.postOffice?[0].district ?? ""}_${locationModel.postOffice?[0].state ?? ""}_${placemark.postalCode ?? ""}";

                        appProvider.getCurrentAcceptedMech(
                            driverUser: appProvider.getuserInfromation);
                        listofrequest = appProvider.getDriverRequestlist;

                        UserModel userModel = appProvider.getuserInfromation
                            .copyWith(
                                time: currentTime,
                                address: address,
                                latitude: position.latitude,
                                longitude: position.longitude);

                        appProvider.updateuserinfo(userModel, null);

                        if (appProvider.currentAvailableMechUser.id == null) {
                          requestbuttom(appProvider.getuserInfromation.id);
                        } else {
                          Routes.instance.pop(context);

                          showMessage("Mechanic has accepted your request.");
                          Routes.instance
                              .push(widget: StatusScreen(), context: context);
                        }
                      }
                    },
                    bordercolor: Colors.black,
                    borderwidth: 3,
                    fontsize: 18),
                Primarybutton(
                    fontsize: 18,
                    Textcolor: Colors.white,
                    height: 60,
                    size: 189,
                    colors: Colors.black,
                    label: "CANCEL REQUEST",
                    onpressed: () {
                      loaderIndicator(context);
                      if (appProvider.currentAvailableMechUser.id == null) {
                        FirebasefirestoreHelper.instance.removeRequest(
                            id: appProvider.getuserInfromation.id);
                        showMessage("Your request has been cancelled.");
                      } else {
                        showMessage("Mechanic has accepted your request.");
                      }

                      Routes.instance.pop(context);
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
