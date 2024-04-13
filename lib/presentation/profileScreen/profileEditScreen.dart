import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:roaddoc/Widgets/logo.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/core/images.dart';
import 'package:roaddoc/core/routes.dart';
import 'package:roaddoc/function/ShowMessage.dart';
import 'package:roaddoc/models/user_model/user_model.dart';
import 'package:roaddoc/presentation/auth/registerScreen/widgets/textfeildeditor.dart';
import 'package:roaddoc/presentation/profileScreen/profileScreen.dart';
import 'package:roaddoc/service/provider/provider.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  TextEditingController newphonecontroller = TextEditingController();
  TextEditingController upicontroller = TextEditingController();
  TextEditingController newnamecontroller = TextEditingController();

  File? image;

  void pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 10);

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of(listen: false, context);
    newnamecontroller.text = appProvider.getuserInfromation.name!;
    newphonecontroller.text =
        appProvider.getuserInfromation.phoneNumber.toString();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 37,
        leading: IconButton(
            tooltip: "Profile",
            onPressed: () {
              Routes.instance.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: InkWell(
                  onTap: () {
                    pickImageFromGallery();
                  },
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: appProvider.getuserInfromation.image !=
                            null
                        ? NetworkImage(appProvider.getuserInfromation.image!)
                        : NetworkImage(personAvatar),
                  ),
                ),
              ),
              textfieldeditor(
                  labelText: "NAME",
                  controller: newnamecontroller,
                  hintlable: "Name",
                  border: true),
              textfieldeditor(
                  labelText: "PHONENUMBER",
                  controller: newphonecontroller,
                  hintlable: "PhoneNumber",
                  border: true),
              Gap(20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextConfortaa(
                    text: "id: ${appProvider.getuserInfromation.id!}",
                    size: 18),
              ),
              customDivider(),
              Gap(20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextConfortaa(
                    text: "id: ${appProvider.getuserInfromation.mailid!}",
                    size: 18),
              ),
              customDivider(),
              //  textfieldeditor(
              //       controller:  ,
              //       hintlable: "UPi",
              //       border: true),
              Gap(30),
              Primarybutton(
                colors: Colors.black,
                Textcolor: Colors.white,
                fontsize: 18,
                size: 170,
                label: "SAVE",
                onpressed: () async {
                  UserModel userModel = appProvider.getuserInfromation;
                  appProvider.updateuserinfo(userModel, image);

                  if (newnamecontroller.text == "" &&
                      newphonecontroller.text == "") {
                  } else if (newnamecontroller.text == "") {
                    UserModel userModel = appProvider.getuserInfromation
                        .copyWith(
                            phoneNumber: int.parse(newphonecontroller.text));
                    appProvider.updateuserinfo(userModel, image);
                    showMessage("sucessfully Update the profile");
                  } else if (newphonecontroller.text == "") {
                    UserModel userModel =
                        appProvider.getuserInfromation.copyWith(
                      name: newnamecontroller.text,
                    );
                    appProvider.updateuserinfo(userModel, image);
                    showMessage("sucessfully Update the profile");
                  } else {
                    UserModel userModel = appProvider.getuserInfromation
                        .copyWith(
                            name: newnamecontroller.text,
                            phoneNumber: int.parse(newphonecontroller.text));
                    appProvider.updateuserinfo(userModel, image);
                    showMessage("sucessfully Update the profile");
                  }
                  appProvider.getUserInformationFirebase();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
