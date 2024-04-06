import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/function/calculateDistanceLatitudemandLongitude.dart';
import 'package:roaddoc/models/user_model/user_model.dart';
import 'package:roaddoc/service/firebase/firebase_firestorehelper.dart';
import 'package:roaddoc/service/firebase/firebaserealtime.dart';
import 'package:roaddoc/service/provider/provider.dart';

class DriverRequesDetailsScreen extends StatelessWidget {
  final UserModel data;
  const DriverRequesDetailsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    double distance = calculateDistance(point1, point2);
    print(distance); 
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // cro
          children: [
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkUD7iu_VLgdUdXR1fFBuo_letwFWX90p6v7umD9lDKQ&s"),
                  ),
                  TextConfortaa("Shan john", 20),
                  TextConfortaa("TRIVANDRUM, KERALA", 20),
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
                      onpressed: () {
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
                      fontsize: 20,
                      Textcolor: Colors.white),
                  Gap(20),
                  Primarybutton(
                    size: 300,
                    colors: Colors.transparent,
                    label: distance.toString(),
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

// my 9.357348, 76.866933// map
// chenganuur 9.318288, 76.611102
final LatLng point1 = LatLng(9.357348, 76.866933); // New York City
final LatLng point2 = LatLng(9.318288, 76.611102);  // Los Angeles
   