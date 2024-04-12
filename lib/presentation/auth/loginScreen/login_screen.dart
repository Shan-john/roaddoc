import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:roaddoc/Widgets/loadingindication.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/core/routes.dart';
import 'package:roaddoc/core/verificationfunc.dart';
import 'package:roaddoc/function/type_of_users.dart';
import 'package:roaddoc/models/user_model/user_model.dart';
import 'package:roaddoc/presentation/Driver/diver_home_screen.dart';
import 'package:roaddoc/presentation/auth/registerScreen/widgets/passwordtextfield.dart';
import 'package:roaddoc/presentation/auth/registerScreen/widgets/textfeildeditor.dart';
import 'package:roaddoc/presentation/mechanic/mechanic_home_screen.dart';
import 'package:roaddoc/presentation/splashScreen/splashScreen.dart';
import 'package:roaddoc/service/firebase/firebase_auth.dart';
import 'package:roaddoc/service/provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController passwordTextEditingController = TextEditingController();

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
              titleText("Log in", 40),
              Gap(10),
              textfieldeditor(
                  controller: mailIdTextEditingController,
                  hintlable: "Mail id"),
              Gap(10),
              PasswordTextField(
                  passwordcontroller: passwordTextEditingController),
              Gap(10),
              Primarybutton(
                  onpressed: () async {
                    loaderIndicator(context);
                    bool isvalidated = loginvalidation(
                      mailIdTextEditingController.text,
                      passwordTextEditingController.text,
                    );

                    if (isvalidated) {
                      bool isregistered = await FireBaseAuthHelper.instance
                          .login(mailIdTextEditingController.text,
                              passwordTextEditingController.text, context);

                      if (isregistered) {
                        Routes.instance.pop(context);

                        Routes.instance.pushandRemoveUntil(
                            widget: SplashScreen(), context: context);
                      }
                    }

                    // }
                  },
                  height: 55,
                  size: double.infinity,
                  colors: Colors.black,
                  label: "LOG IN",
                  fontsize: 18,
                  Textcolor: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
