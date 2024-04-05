import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roaddoc/firebase_options.dart';
import 'package:roaddoc/presentation/Driver/diver_home_screen.dart';
import 'package:roaddoc/presentation/auth/loginScreen/login_screen.dart';

import 'package:roaddoc/presentation/auth/registerScreen/registerscreen.dart';
import 'package:roaddoc/presentation/auth/registerScreen/user_select-Screen.dart';
import 'package:roaddoc/presentation/mechanic/driverRequestScreen.dart';
import 'package:roaddoc/presentation/mechanic/mechanic_home_screen.dart';
import 'package:roaddoc/presentation/splashScreen/splashScreen.dart';
import 'package:roaddoc/presentation/splashScreen/welcomeScreen.dart';
import 'package:roaddoc/service/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> AppProvider(),
  child: MaterialApp(
      title: 'Road Doc',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    ) ,
    );
  }
}
