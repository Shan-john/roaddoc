import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:roaddoc/Widgets/logo.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/core/images.dart';
import 'package:roaddoc/core/routes.dart';
import 'package:roaddoc/function/ShowMessage.dart';
import 'package:roaddoc/function/calculateDistanceLatitudemandLongitude.dart';
import 'package:roaddoc/function/getlocation.dart';
import 'package:roaddoc/function/urlLauncher.dart';
import 'package:roaddoc/home.dart';
import 'package:roaddoc/models/locationModel/location_model/location_model.dart';
import 'package:roaddoc/models/user_model/user_model.dart';
import 'package:roaddoc/presentation/Driver/acceptedMechuserDetailScreen.dart';
import 'package:roaddoc/presentation/profileScreen/profileScreen.dart';
import 'package:roaddoc/service/firebase/firebase_firestorehelper.dart';
import 'package:roaddoc/service/https/httpsCall.dart';

import 'package:roaddoc/service/provider/provider.dart';

class DriverRequesDetailsScreen extends StatelessWidget {
  final UserModel data;
  const DriverRequesDetailsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);

    appProvider.getUserloaction();

    Position position = appProvider.getUserlocation;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // cro
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(
                     data.image??personAvatar
                              )
                ),
                Gap(20),
                TextConfortaa(text: data.name.toString(), size: 20),
                Gap(50),
                InkWell(
                        onTap: () {
                          launchGoogleMap(
                              latitude: data.latitude!,
                              longitude: data.longitude!);
                        },
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RowMaptile(
                                icon: Icons.location_on_outlined,
                                value: data.address.toString(),
                                size: 18,
                              ),
                              Icon(Icons.arrow_forward_ios) 
                            ],
                          ),
                        ),
                      ),
                Gap(10),
                detailstile("${data.phoneNumber}", Icons.phone_outlined, () {
                  makePhoneCall(data.phoneNumber.toString());
                }, true, true),
                Gap(10),
                detailstile("${data.mailid}", Icons.code, () {}, false, true),
                Gap(10),
                detailstile(
                    "${data.id}", Icons.mail_outline, () {}, false, true)
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
                    onpressed: () async {
                      appProvider.getUserloaction();
                      if (position.altitude == 0 && position.longitude == 0) {
                        showMessage("Hold on, setting things up...");
                      } else {
                        if (appProvider.currenAcceptedDriverDetails.id ==
                            null) {
                          Placemark placemark = await getPlaceName(
                              latitude: position.latitude,
                              longitude: position.longitude);

                          LocationModel locationModel =
                              await getLocationDetails(
                                  placemark.postalCode.toString());

                          String Address =
                              "${placemark.locality??""}_${locationModel.postOffice?[0].district??""}_${locationModel.postOffice?[0].state??""}_${placemark.postalCode??""}";
                               
                          appProvider.removeRequest(data);
                          FirebasefirestoreHelper.instance
                              .removeRequest(id: data.id);
                          FirebasefirestoreHelper.instance
                              .uploadCurrenAcceptedDriverDetails(

                                  driverUser: data,
                                  MechUser: appProvider.getuserInfromation);

                          UserModel UpdatedMech = appProvider.getuserInfromation
                              .copyWith(
                                  address: Address,
                                  latitude: position.latitude,
                                  longitude: position.longitude);

                          appProvider.updateuserinfo(UpdatedMech, null);
                          FirebasefirestoreHelper.instance
                              .uploadCurrenAcceptedDriverDetails(
                                  driverUser: data,
                                  MechUser: appProvider.getuserInfromation);
                          FirebasefirestoreHelper.instance
                              .uploadCurrentAccptedMech(
                                  MechUser: appProvider.getuserInfromation,
                                  driverUser: data);
                        } else {
                          showMessage(
                              "Already Accepted a request ,Check the details screen");
                        }
                        Routes.instance.pushandRemoveUntil(
                            widget: Mainscreen(), context: context);
                      }
                    },
                    fontsize: 20,
                    Textcolor: Colors.white),
                Gap(20),
                Primarybutton(
                  size: 300,
                  colors: Colors.transparent,
                  label: "Location Navigate",
                  onpressed: () {
                    launchGoogleMap(
                        latitude: data.latitude!, longitude: data.longitude!);
                  },
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
    );
  }
}
// if (position.altitude == 0 &&
//                               position.longitude == 0) {
//                             showMessage("Hold on, setting things up...");
//                           } else {
//                             if (appProvider.currenAcceptedDriverDetails.id ==
//                                 null) {
//                                    Placemark placemark = await getPlaceName(
//                             latitude: position.latitude,
//                             longitude: position.longitude);

//                         LocationModel locationModel =
//                             await getLocationDetails(
//                                 placemark.postalCode.toString());

//                         String Address =
//                             "${placemark.locality}, ${locationModel.postOffice![0].district}, ${locationModel.postOffice![0].state}, ${placemark.postalCode}";

//                               appProvider.removeRequest(DriverUser);
//                               FirebasefirestoreHelper.instance
//                                   .removeRequest(id: DriverUser.id);
//                               FirebasefirestoreHelper.instance
//                                   .uploadCurrenAcceptedDriverDetails(
//                                       driverUser: DriverUser,
//                                       MechUser:
//                                           appProvider.getuserInfromation);

//                               UserModel UpdatedMech =
//                                   appProvider.getuserInfromation.copyWith(
//                                     address: Address,
//                                       latitude: position.latitude,
//                                       longitude: position.longitude);

//                               appProvider.updateuserinfo(UpdatedMech, null);
//                               FirebasefirestoreHelper.instance
//                                   .uploadCurrenAcceptedDriverDetails(
//                                       driverUser: DriverUser,
//                                       MechUser:
//                                           appProvider.getuserInfromation);
//                               FirebasefirestoreHelper.instance
//                                   .uploadCurrentAccptedMech(
//                                       MechUser:
//                                           appProvider.getuserInfromation,
//                                       driverUser: DriverUser);
//                             } else {
//                               showMessage(
//                                   "Already Accepted a request ,Check the details screen");
//                             }
//                           }
