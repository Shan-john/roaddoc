import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/core/images.dart';
import 'package:roaddoc/core/routes.dart';
import 'package:roaddoc/function/urlLauncher.dart';
import 'package:roaddoc/models/user_model/user_model.dart';
import 'package:roaddoc/presentation/Driver/acceptedMechuserDetailScreen.dart';
import 'package:roaddoc/presentation/HistoryScreen/historyscreen.dart';
import 'package:roaddoc/presentation/profileScreen/profileEditScreen.dart';
import 'package:roaddoc/presentation/splashScreen/welcomeScreen.dart';
import 'package:roaddoc/service/firebase/firebase_auth.dart';
import 'package:roaddoc/service/provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of(listen: false, context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          //  crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 340,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 46, 46, 46),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                        radius: 70,
                        backgroundImage:
                            appProvider.getuserInfromation.image != null
                                ? NetworkImage(
                                    appProvider.getuserInfromation.image!)
                                : NetworkImage(personAvatar)),
                    Gap(30),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextConfortaa(
                            text: appProvider.getuserInfromation.name!,
                            size: 25,
                            color: Colors.white),
                        Gap(10),
                        TextRoboto(
                            text: appProvider.getuserInfromation.mailid!,
                            size: 20,
                            color: Color.fromARGB(255, 228, 228, 228)),
                        Gap(10),
                        Primarybutton(
                            height: 40,
                            size: 145,
                            colors: Colors.white,
                            label: "EDIT PROFILE",
                            onpressed: () => Routes.instance.push(
                                widget: ProfileEditScreen(), context: context),
                            fontsize: 17,
                            Textcolor: Colors.black)
                      ],
                    )
                  ],
                )),
            Gap(30),
            SizedBox(
              height: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  detailstile(
                      appProvider.getuserInfromation.phoneNumber.toString(),
                      Icons.phone,
                      () {},
                      false,true),
                  detailstile(appProvider.getuserInfromation.id!, Icons.code,
                      () {}, false,true),
                  detailstile("HISTORY", Icons.history, () {
                    Routes.instance.push(
                        widget: HistoryScreen(
                            UserHistory: appProvider.listofHistory),
                        context: context);
                  }, true,true),
                  Primarybutton(
                    size: 100,
                    colors: Colors.red,
                    label: "LOGOUT",
                    fontsize: 15,
                    Textcolor: Colors.white,
                    onpressed: () {
                      FireBaseAuthHelper.instance.logOut();
                      appProvider.removeUserdatafromprovide();
                      Routes.instance.pushandRemoveUntil(
                          widget: WelcomeScreen(), context: context);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

detailstile(
     String value, IconData icons, Function() ontap, bool directionicons, bool Divider  ) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: InkWell(
      onTap: ontap,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowMaptile(icon: icons, value: value, size: 15),
              directionicons == true
                  ? Icon(Icons.arrow_forward_ios_rounded)
                  : SizedBox()
            ],
          ),
        Divider ==true?  customDivider():SizedBox()
        ],
      ),
    ),
  );
}

class customDivider extends StatelessWidget {
  const customDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1.4,
      color: Color.fromARGB(255, 148, 148, 148),
    );
  }
}
