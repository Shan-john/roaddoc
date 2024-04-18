import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/core/routes.dart';
import 'package:roaddoc/function/urlLauncher.dart';
import 'package:roaddoc/home.dart';
import 'package:roaddoc/models/user_model/user_model.dart';
import 'package:roaddoc/service/firebase/firebase_firestorehelper.dart';
import 'package:roaddoc/service/provider/provider.dart';
import 'package:intl/intl.dart';

class PaymentMethodScreen extends StatelessWidget {
  final String inceptioncategory;
  final String inspectionMessage;
  final String amount;
  
  PaymentMethodScreen(
      {super.key,
      required this.inceptioncategory,
      required this.inspectionMessage,
      required this.amount});
  @override
  
  Widget build(BuildContext context) {
    
    AppProvider appProvider = Provider.of(listen: false, context);
    UserModel mechUser = appProvider.currentAvailableMechUser;
    DateTime now = DateTime.now();
      String formattedDate;
    formattedDate = DateFormat('dd/MM/yyyy').format(now);

    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextConfortaa(text: "Payment", size: 40),
                Gap(10),
                Center(
                  child: Primarybutton(
                    size: 390,
                    colors: Color.fromARGB(255, 0, 255, 179),
                    label: "Direct Payment",
                    onpressed: () {
                      DateTime now = DateTime.now();
                      String formattedDate =
                          DateFormat('dd/MM/yyyy').format(now);

                      UserModel UpdatedMechUser = mechUser.copyWith(
                          inspectionCategory: inceptioncategory,
                          inspectionmessage: inspectionMessage,
                          paymentmethod: "Direct Payment",
                          date: formattedDate,
                          amount: amount);
                      UserModel UpdatedDriverUser =
                          appProvider.getuserInfromation.copyWith(
                              inspectionCategory: inceptioncategory,
                              inspectionmessage: inspectionMessage,
                              paymentmethod: "Direct Payment",
                              date: formattedDate,
                              amount: amount);

                      FirebasefirestoreHelper.instance.uploadhistory(
                          updatedDriverUser: UpdatedDriverUser,
                          updatedMechUser: UpdatedMechUser);
                      appProvider.removecurrentavailableMech(
                          driverUser: UpdatedDriverUser);
                      appProvider.removeCurrenAcceptedDriverDetails(
                          mechUser: mechUser);
                      Routes.instance.pushandRemoveUntil(
                          widget: Mainscreen(), context: context);
                    },
                    fontsize: 18,
                    Textcolor: Colors.black,
                    bordercolor: Colors.black,
                    borderwidth: 2,
                    height: 100,
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
 