import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/core/routes.dart';
import 'package:roaddoc/core/verificationfunc.dart';

import 'package:roaddoc/function/type_of_users.dart';
import 'package:roaddoc/home.dart';
import 'package:roaddoc/presentation/Driver/diver_home_screen.dart';
import 'package:roaddoc/presentation/auth/registerScreen/widgets/passwordtextfield.dart';
import 'package:roaddoc/presentation/auth/registerScreen/widgets/textfeildeditor.dart';
import 'package:roaddoc/presentation/mechanic/mechanic_home_screen.dart';
import 'package:roaddoc/presentation/splashScreen/splashScreen.dart';
import 'package:roaddoc/service/firebase/firebase_auth.dart';
import 'package:roaddoc/service/provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  final usertype type;
  RegisterScreen({super.key, required this.type});
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController phoneNumberTextEditingController =
      TextEditingController();
  TextEditingController mailIdTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleText("Register", 40),
              Gap(10),
              textfieldeditor(
                  controller: nameTextEditingController, hintlable: "Name"),
              Gap(10),
              textfieldeditor(
                  controller: mailIdTextEditingController,
                  hintlable: "Mail id"),
              Gap(10),
              PasswordTextField(
                  passwordcontroller: passwordTextEditingController),
              Gap(10),
              textfieldeditor(
                  keyboardType: TextInputType.number,
                  controller: phoneNumberTextEditingController,
                  hintlable: "Phone number"),
              Gap(10),
              Primarybutton(
                  onpressed: () async {
                    bool isvalidated = Registorvalidation(
                      Phonenumber: phoneNumberTextEditingController.text,
                      email: mailIdTextEditingController.text,
                      name: nameTextEditingController.text,
                      password: passwordTextEditingController.text,
                    );
                    print(" done");
                    if (isvalidated) {
                      print(" done");
                      bool isregistered =
                          await FireBaseAuthHelper.instance.signup(
                        nameTextEditingController.text,
                        mailIdTextEditingController.text,
                        phoneNumberTextEditingController.text.toString(),
                        context,
                        type,
                      );
                      if (isregistered) {
                        print("done");
                        if (type == usertype.DRIVER) {
                          Routes.instance.pushandRemoveUntil(
                              widget: SplashScreen(), context: context);
                        } else {
                          Routes.instance.pushandRemoveUntil(
                              widget: SplashScreen(), context: context);
                        }
                      } else {}
                    }
                  },
                  height: 55,
                  size: double.infinity,
                  colors: Colors.black,
                  label: "NEXT",
                  fontsize: 18,
                  Textcolor: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
