import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/presentation/auth/registerScreen/widgets/passwordtextfield.dart';
import 'package:roaddoc/presentation/auth/registerScreen/widgets/textfeildeditor.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
 
  TextEditingController passwordTextEditingController = TextEditingController();
  
  TextEditingController mailIdTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
              titleText("Log in"),
              Gap(10),
             
              textfieldeditor(
                  controller: mailIdTextEditingController, hintlable: "Mail id"),
              Gap(10),
              PasswordTextField(
                  passwordcontroller: passwordTextEditingController),
              Gap(10),
             
              Primarybutton(
                onpressed: (){},
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