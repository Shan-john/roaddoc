import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/Widgets/simpletext.dart';
import 'package:roaddoc/core/routes.dart';
import 'package:roaddoc/function/ShowMessage.dart';
import 'package:roaddoc/function/getlocation.dart';
import 'package:roaddoc/models/user_model/user_model.dart';
import 'package:roaddoc/presentation/Driver/StatusScreen.dart';
import 'package:roaddoc/presentation/splashScreen/welcomeScreen.dart';
import 'package:roaddoc/service/firebase/firebase_auth.dart';
import 'package:roaddoc/service/firebase/firebase_firestorehelper.dart';
import 'package:roaddoc/service/firebase/firebaserealtime.dart';
import 'package:roaddoc/service/provider/provider.dart';

class DriverHomeScreen extends StatefulWidget {
  DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  String titlelable = "Locate";
  Position? position;
  List<UserModel> listofrequest = [];
  @override
  void initState() {
    super.initState();
    _get_lat_long();
  }

  _get_lat_long() async {
    position = await getlocation();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of(listen: true, context);
    appProvider.getDriversRequestList();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 28,
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
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleText(titlelable, 40),
            const SimpleText(lable: "Available Mechanics Around"),
            Gap(20),
            Container(
              height: MediaQuery.of(context).size.height / 1.6,
              width: double.infinity,
              color: Colors.amber,
              child: Image.network(
                  fit: BoxFit.cover,
                  "https://www.google.com/maps/d/u/0/thumbnail?mid=1uD9FtjLONCK4Hazcf36xDQ7Xa8Y&hl=en"),
            ),
            Gap(10),
            Primarybutton(
                bordercolor: Colors.black,
                borderwidth: 2,
                size: 390,
                colors: Colors.white,
                label: "REQUEST MECHANIC",
                onpressed: () async {
                  loaderIndicator(context);

                  listofrequest = appProvider.getDriverRequestlist;
                  print(" altitude : ${position!.latitude}");
                  UserModel userModel = appProvider.getuserInfromation.copyWith(
                      inspectionmessage: "ho bro",
                      latitude: position!.latitude,
                      longitude: position!.longitude);
                  appProvider.getCurrentAcceptedMech(
                      driverUser: appProvider.getuserInfromation);
                  appProvider.updateuserinfo(userModel);

                  requestbuttom(appProvider.getuserInfromation.id);
                },
                fontsize: 18,
                Textcolor: Colors.black),
            Gap(5),
            Primarybutton(
                bordercolor: Colors.black,
                borderwidth: 2,
                size: 390,
                colors: Colors.white,
                label: " CANNCEL REQUEST",
                onpressed: () async {
                  loaderIndicator(context);
                  appProvider.currentAvailableMechUser.id == ""
                      ? FirebasefirestoreHelper.instance
                          .removeRequest(id: appProvider.getuserInfromation.id)
                      : showMessage("your Request is already accepted");
                  Routes.instance.pop(context);
                },
                fontsize: 18,
                Textcolor: Colors.black)
          ],
        ),
      ),
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
      firebaseRealtimeStorageHelper.instance
          .requeststatuschager(id: id, value: false);

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
