import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/models/user_model/user_model.dart';
import 'package:roaddoc/presentation/auth/registerScreen/widgets/textfeildeditor.dart';
import 'package:roaddoc/service/firebase/firebase_firestorehelper.dart';
import 'package:roaddoc/service/provider/provider.dart';

class FeedbackScreenDriver extends StatelessWidget {
  final UserModel MechUser;
  FeedbackScreenDriver({
    super.key,
    required this.MechUser,
  });
  TextEditingController inspectionCatogoryController = TextEditingController();
  TextEditingController inspectionMessageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of(listen: false, context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            titleText("Inspection report", 40),
            Gap(30),
            textfieldeditor(
              controller: inspectionCatogoryController,
              hintlable: "Problem Category",
            ),
            Gap(30),
            textfieldeditor(
                controller: inspectionMessageController,
                hintlable: "Message",
                maxline: 8),
            Gap(30),
            Primarybutton(
              size: 390,
              colors: Colors.white,
              label: "Payment",
              onpressed: () {
                UserModel UpdatedMechUser = MechUser.copyWith(
                  inspectionCategory: inspectionCatogoryController.text,
                  inspectionmessage: inspectionMessageController.text,
                );
                UserModel UpdatedDriverUser =
                    appProvider.getuserInfromation.copyWith(
                  inspectionCategory: inspectionCatogoryController.text,
                  inspectionmessage: inspectionMessageController.text,
                );

                FirebasefirestoreHelper.instance.uploadhistory(
                    updatedDriverUser: UpdatedDriverUser,
                    updatedMechUser: UpdatedMechUser);
                appProvider.removecurrentavailableMech(
                    driverUser: UpdatedDriverUser);
                appProvider.removeCurrenAcceptedDriverDetails(
                    mechUser: MechUser);
              },
              fontsize: 18,
              Textcolor: Colors.black,
              bordercolor: Colors.black,
              borderwidth: 2,
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
