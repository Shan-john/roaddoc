import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:roaddoc/Widgets/logo.dart';
import 'package:roaddoc/function/ShowMessage.dart';
import 'package:roaddoc/function/getlocation.dart';
import 'package:roaddoc/function/type_of_users.dart';
import 'package:roaddoc/models/user_model/user_model.dart';
import 'package:roaddoc/presentation/Driver/diver_home_screen.dart';
import 'package:roaddoc/home.dart';
import 'package:roaddoc/presentation/mechanic/mechanic_home_screen.dart';
import 'package:roaddoc/presentation/splashScreen/welcomeScreen.dart';
import 'package:roaddoc/service/firebase/firebase_auth.dart';
import 'package:roaddoc/service/firebase/firebase_firestorehelper.dart';
import 'package:roaddoc/service/provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    //get User infromation;
    super.initState();
    // Delay navigation to home screen
    // AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    // appProvider.getUserInformationFirebase();
        AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
                     appProvider.getUserInformationFirebase();
                     appProvider.getUserloaction();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => StreamBuilder(
              stream: FireBaseAuthHelper.instance.getAuthChange,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  
                   
                                      return Mainscreen(
                      
                    );
                  // if (appProvider.getuserInfromation.type ==
                  //     usertype.DRIVER.toString()) {
                  //   showMessage(appProvider.getuserInfromation.type.toString());
                  //   print("driver screen");
                  //   return Mainscreen(
                  //     userModel: appProvider.getuserInfromation,
                  //   );
                  // } else if (appProvider.getuserInfromation.type ==
                  //     usertype.MECHANIC.toString()) {
                  //   showMessage(appProvider.getuserInfromation.type.toString());
                  //   return Mainscreen(
                  //     userModel: appProvider.getuserInfromation,
                  //   );
                  // } else {
                  //   showMessage("NetWork Issue");
                  //   return SplashScreen();
                  // }
                } //  return if the user is driver goto drivermain page() other wize mechanic homepage;
                else {
                  return const WelcomeScreen();
                }
              },
            ),
          ));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: logoSection(),
      ),
    );
  }
}

// MaterialPageRoute(
//           builder: (context) => StreamBuilder(
//             stream: FirebaseAuthHelper.instance.getAuthChange,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {

//                 return const Mainscreen();
//               } else {
//                 return const Welcome();
//               }
//             },
//           ),
//         ),
