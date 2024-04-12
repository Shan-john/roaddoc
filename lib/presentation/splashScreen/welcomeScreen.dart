import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:roaddoc/Widgets/logo.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/core/routes.dart';
import 'package:roaddoc/presentation/auth/loginScreen/login_screen.dart';

import 'package:roaddoc/presentation/auth/registerScreen/user_select-Screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Gap(50),
            logoSection(),
            Gap(50),
            _loginAndRegister(),
          ],
        ),
      ),
    );
  }
}

class _loginAndRegister extends StatelessWidget {
  const _loginAndRegister({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Primarybutton(
          Textcolor: Colors.black,
          height: 60,
          size: 180,
          colors: Colors.white,
          label: "LOGIN",
          onpressed: () {
            Routes.instance.push(widget: LoginScreen(), context: context);
          },
          bordercolor: Colors.black,
          borderwidth: 3,
          fontsize: 18,
          widget: null,
        ),
        Primarybutton(
            fontsize: 18,
            Textcolor: Colors.white,
            height: 60,
            size: 180,
            colors: Colors.black,
            label: "REGISTER",
            onpressed: () {
              Routes.instance
                  .push(widget: UserTypeSelectionScreen(), context: context);
            })
      ],
    );
  }
}
