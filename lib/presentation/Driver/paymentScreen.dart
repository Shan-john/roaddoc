import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_upi_pay/Src/payment.dart';

import 'package:gap/gap.dart';

import 'package:provider/provider.dart';

import 'package:roaddoc/Widgets/primaryButton.dart';
import 'package:roaddoc/core/routes.dart';
import 'package:roaddoc/function/ShowMessage.dart';
import 'package:roaddoc/function/urlLauncher.dart';
import 'package:roaddoc/home.dart';
import 'package:roaddoc/models/user_model/user_model.dart';
import 'package:roaddoc/presentation/Driver/paymentmethod.dart';
import 'package:roaddoc/presentation/auth/registerScreen/widgets/textfeildeditor.dart';
import 'package:roaddoc/service/provider/provider.dart';
import 'package:upi_chooser/upi_apps.dart';

import '../../service/firebase/firebase_firestorehelper.dart';

class PaymentScreen extends StatelessWidget {
  final String inceptioncategory;
  final String inspectionMessage;

  PaymentScreen(
      {super.key,
      required this.inceptioncategory,
      required this.inspectionMessage});
      
  TextEditingController paymentcontroller = TextEditingController();
 
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(10),
             
            TextConfortaa(text: "PAYMENT DETAIL", size: 40),
            Gap(10),
            TextRoboto(text: "INVOICE", size: 20),
            Divider(),
            Gap(10),
            _invoicedetailRow(
                key: "ITEM DESCRIPTION :",
                value: "AMOUNT (₹)",
                color: Colors.black54),
            Gap(10),
            _invoicedetailRow(
                key: "Service Charges :",
                value: "${400}",
                color: Colors.black,
                textfieldaccess: true),
            Gap(20),
            Primarybutton(
                onpressed: () {
                  if (paymentcontroller.text.isEmpty) {

                    showMessage("Enter the amount");
                  } else {
                    Routes.instance.push(
                        widget: PaymentMethodScreen(
                          amount: paymentcontroller.text,
                          inceptioncategory: inceptioncategory,
                          inspectionMessage: inspectionMessage,
                        ),
                        context: context);
                  }
                },
                size: 110,
                colors: Colors.green,
                label: "Proceed",
                fontsize: 20,
                Textcolor: Colors.white)
          ],
        ),
      ),
    );
  }

  Row _invoicedetailRow(
      {required String value,
      required String key,
      required Color color,
      bool? textfieldaccess = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextRoboto(text: key, size: 18, color: color),
        Gap(20),
        textfieldaccess == false
            ? TextRoboto(text: value, size: 18, color: color)
            : Container(
                margin: EdgeInsets.only(left: 100),
                width: 100,
                child: textfieldeditor(
                  keyboardType: TextInputType.number,
                    maxline: 1,
                    controller: paymentcontroller,
                    hintlable: "₹",
                    border: true),
              ),
        Gap(10),
      ],
    );
  }
}
