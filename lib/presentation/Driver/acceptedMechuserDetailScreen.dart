import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/core/images.dart';
import 'package:roaddoc/core/routes.dart';
import 'package:roaddoc/core/themes.dart';
import 'package:roaddoc/function/urlLauncher.dart';
import 'package:roaddoc/models/user_model/user_model.dart';
import 'package:roaddoc/presentation/profileScreen/profileScreen.dart';

class AcceptedMechUserDetailsScreen extends StatelessWidget {
  final UserModel mechUser;
  const AcceptedMechUserDetailsScreen({super.key, required this.mechUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Routes.instance.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.black,
              radius: 70,
              backgroundImage: mechUser.image != ""
                  ? NetworkImage(mechUser.image!)
                  : NetworkImage(personAvatar),
            ),
            Center(
              child: Container(
                height: 400,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: listoBoxshadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextConfortaa(text: "Mechanic Details", size: 30),
                    RowMaptile(
                      icon: Icons.person_3_outlined,
                      value: mechUser.name!,
                      size: 25,
                    ), RowMaptile(
                      icon: Icons.vpn_key_outlined,
                      value: mechUser.id.toString(),
                      size: 25,
                    ),
                    RowMaptile(
                      icon: Icons.mail_outlined,
                      value: mechUser.mailid!,
                      size: 25,
                    ),
                    detailstile(
                        "${mechUser.phoneNumber}", Icons.call_outlined, () {
                      makePhoneCall(
                        mechUser.phoneNumber.toString(),
                      );
                    }, true, false),
                   
                     detailstile(
                        "${mechUser.address}", Icons.location_on_outlined, () {
                          launchGoogleMap(
                          latitude: mechUser.latitude!,
                          longitude: mechUser.longitude!);
                      
                    }, true, false),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class RowMaptile extends StatelessWidget {
  final IconData icon;
  final String value;
  final double size;
  const RowMaptile(
      {required this.icon, required this.value, required this.size});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon),
            Gap(5),
            TextConfortaa(text: value, size: 18),
          ],
        ),
        Gap(15)
      ],
    );
  }
}
