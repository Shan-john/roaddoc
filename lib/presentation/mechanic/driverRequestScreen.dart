import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:roaddoc/Widgets/avatarimageProvider.dart';
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
 
  const DriverRequesDetailsScreen({super.key, required this.data, });

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
                      backgroundColor: Colors.black,
                      backgroundImage: avatarImageProvider(model: data)),
                  Gap(20),
                  TextConfortaa(text: data.name.toString(), size: 25),
                  Gap(50),
                  detailstile("${data.address}", Icons.place_outlined, () {
                    launchGoogleMap(
                        latitude: data.latitude!, longitude: data.longitude!);
                  }, true, true),
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
                         Placemark placemark = await getPlaceName(
                                latitude: position.latitude,
                                longitude: position.longitude);

                            LocationModel locationModel =
                                await getLocationDetails(
                                    placemark.postalCode.toString());

                            String Address =
                                "${placemark.locality!}_${locationModel.postOffice?[0].district!}_${locationModel.postOffice?[0].state!}_${placemark.postalCode!}";

                        if (position.altitude == 0 && position.longitude == 0&& Address.isEmpty) {
                          showMessage("Hold on, setting things up...");
                        } else {
                          if (appProvider.currenAcceptedDriverDetails.id ==
                              null) {
                           
                            appProvider.removeRequest(data);
                            FirebasefirestoreHelper.instance
                                .removeRequest(id: data.id);
                            FirebasefirestoreHelper.instance
                                .uploadCurrenAcceptedDriverDetails(
                                    driverUser: data,
                                    MechUser: appProvider.getuserInfromation);

                            UserModel UpdatedMech =
                                appProvider.getuserInfromation.copyWith(
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
      ),
    );
  }
}

 