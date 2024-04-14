import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roaddoc/function/type_of_users.dart';
import 'package:roaddoc/presentation/Driver/diver_home_screen.dart';
import 'package:roaddoc/presentation/mechanic/mechanic_home_screen.dart';
import 'package:roaddoc/presentation/profileScreen/profileScreen.dart';
import 'package:roaddoc/service/provider/provider.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({
    super.key,
  });

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  bool isloading = true;

  int currentindex = 0;
  List<Widget> driverscreen = [DriverHomeScreen(), const ProfileScreen()];
  List<Widget> mechscreen = [MechanicHomeScreen(), const ProfileScreen()];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: true);

    isloading = false;
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          animationCurve: Curves.easeInOutSine,
          height: 50,
          color: const Color.fromARGB(255, 46, 46, 46),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
        ),
        body: appProvider.getuserInfromation.type == usertype.DRIVER.toString()
            ? driverscreen[currentindex]
            : appProvider.getuserInfromation.type ==
                    usertype.MECHANIC.toString()
                ? mechscreen[currentindex]
                : const SizedBox());
  }
}

Widget padtext(
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
        style: const TextStyle(
            color: Color.fromARGB(171, 121, 120, 120), fontSize: 18),
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
