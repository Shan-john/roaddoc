import 'package:flutter/material.dart';
import 'package:roaddoc/presentation/Driver/diver_home_screen.dart';
import 'package:roaddoc/presentation/auth/loginScreen/login_screen.dart';
 
 import 'package:roaddoc/presentation/auth/registerScreen/registerscreen.dart';
import 'package:roaddoc/presentation/auth/registerScreen/user_select-Screen.dart';
import 'package:roaddoc/presentation/mechanic/mechanic_home_screen.dart';
import 'package:roaddoc/presentation/splashScreen/splashScreen.dart';
import 'package:roaddoc/presentation/splashScreen/welcomeScreen.dart';
  
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Road Doc',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:    MechanicHomeScreen( ), 
    );
  }
}

