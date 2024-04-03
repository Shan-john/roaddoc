import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/enumfunction/type_of_users.dart';
import 'package:roaddoc/presentation/auth/registerScreen/widgets/passwordtextfield.dart';
import 'package:roaddoc/presentation/auth/registerScreen/widgets/textfeildeditor.dart';

class RegisterScreen extends StatelessWidget {
  final UserType type;
  RegisterScreen({super.key, required this.type});
  TextEditingController usernameTextEditingController = TextEditingController();
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
              titleText("Register"),
              Gap(10),
              textfieldeditor(
                  controller: usernameTextEditingController,
                  hintlable: "username"),
              Gap(10),
              textfieldeditor(
                  controller: mailIdTextEditingController, hintlable: "Mail id"),
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
