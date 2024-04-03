import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:roaddoc/Widgets/logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //@override
  //  void initState() {
  // get User infromation;
  //   super.initState();
  //   // Delay navigation to home screen
  //   Future.delayed(const Duration(seconds: 2), () {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => StreamBuilder(
  //           stream: FirebaseAuthHelper.instance.getAuthChange,
  //           builder: (context, snapshot) {
  //             if (snapshot.hasData) {

  //               return if the user is driver goto drivermain page() other wize mechanic homepage;
  //             } else {
  //               return const Welcome();
  //             }
  //           },
  //         ),
  //       ),
  //     );
  //   });
  // }
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