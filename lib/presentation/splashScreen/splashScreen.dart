
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:roaddoc/Widgets/logo.dart';
 
import 'package:roaddoc/home.dart';
 
import 'package:roaddoc/presentation/splashScreen/welcomeScreen.dart';
import 'package:roaddoc/service/firebase/firebase_auth.dart';
 
import 'package:roaddoc/service/provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
   
    super.initState();
     
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
                  return const Mainscreen();
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
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: logoSection(),
      ),
    );
  }
}
