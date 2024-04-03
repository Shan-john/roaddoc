import 'package:flutter/material.dart';
import 'package:roaddoc/enumfunction/type_of_users.dart';
 import 'package:roaddoc/presentation/auth/registerScreen/registerscreen.dart';
import 'package:roaddoc/presentation/auth/registerScreen/user_select-Screen.dart';
import 'package:roaddoc/presentation/splashScreen/welcomeScreen.dart';
  
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Road Doc',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  WelcomeScreen( ),
    );
  }
}
