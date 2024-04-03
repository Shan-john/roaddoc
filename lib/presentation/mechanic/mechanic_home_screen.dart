import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MechanicHomeScreen extends StatefulWidget {
  const MechanicHomeScreen({super.key});

  @override
  State<MechanicHomeScreen> createState() =>
      _MechanicHomeScreenState();
}

class _MechanicHomeScreenState extends State<MechanicHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///
        body: ListView.separated(
            itemBuilder: (context, index) {
              return Container(height: 50,
              color: Colors.amber, 
              width: 100,);
            },
            separatorBuilder:(context, index) {
              return Gap(10);},
            itemCount: 10));
  }
}
