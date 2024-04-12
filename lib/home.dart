import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:roaddoc/function/type_of_users.dart';
import 'package:roaddoc/models/user_model/user_model.dart';
import 'package:roaddoc/presentation/Driver/diver_home_screen.dart';
import 'package:roaddoc/presentation/mechanic/mechanic_home_screen.dart';
import 'package:roaddoc/presentation/profileScreen/profileScreen.dart';
import 'package:roaddoc/service/provider/provider.dart';

class Mainscreen extends StatefulWidget {
  final UserModel userModel;
  const Mainscreen({
    super.key,
    required this.userModel,
  });

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  bool isloading = false;

  int currentindex = 0;
  List<Widget> Driverscreen = [DriverHomeScreen(), ProfileScreen()];
  List<Widget> Mechscreen = [MechanicHomeScreen(), ProfileScreen()];
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      isloading = true;
      setState(() {});
    });
    super.initState();
  }

// @override
// void dispose() {
//     // TODO: implement dispose

//     super.dispose();
//   }
  @override
  Widget build(BuildContext context) {
    Provider.of<AppProvider>(context, listen: true);
    return Scaffold(
        bottomNavigationBar: isloading == true
            ? CurvedNavigationBar(
                animationCurve: Curves.easeInOutSine,
                height: 50,
                color: Color.fromARGB(255, 46, 46, 46),
                backgroundColor: Colors.white,

                // buttonBackgroundColor: Colors.white,
                onTap: (index) {
                  setState(() {
                    currentindex = index;
                  });
                },
                items: const [
                  Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.person_outline_sharp,
                    color: Colors.white,
                  ),
                ],
              )
            : null,
        body: widget.userModel.type.toString() == usertype.DRIVER.toString()
            ? Driverscreen[currentindex]
            : Mechscreen[currentindex]);
  }
}

Widget Padtext(
    {required String title, required Color colors, String subtitle = ""}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          title,
          style: TextStyle(
            color: colors,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Text(
        subtitle,
        style:
            TextStyle(color: Color.fromARGB(171, 121, 120, 120), fontSize: 18),
      ),
    ],
  );
}

Widget customtext({required String title}) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Text(
      title,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
