import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roaddoc/core/url.dart';
import 'package:roaddoc/function/ShowMessage.dart';
import 'package:url_launcher/url_launcher.dart';

void launchGoogleMap(
    {required double latitude, required double longitude}) async {
  final String _http = googleMapUrl(
      latitude: latitude.toString(), longitude: longitude.toString());
  final Uri _url = Uri.parse(_http);

  try {
    await launchUrl(
      _url,
    );
  } on PlatformException catch (e) {
    showMessage(e.code.toString());
  }
}

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}

void launchUPIApp({
  required String upi_id,
  required String name,
  required String code,
  required String transactionid,
  required String transaction_reference,
  required String transaction_amount,
}) async {
  // String upiUrl =
  //     "upi://pay?pa=${upi_id}&pn=${name}&mc=${code}&tid=${transactionid}&tr=${transaction_reference}&tn=Service&am=${transaction_amount}&cu=INR";
  String upiUrl = "upi://pay?pa=${upi_id}&pn=${name}&cu=INR";
  final uri = Uri.parse(upiUrl);
  if (await launchUrl(uri)) {
    await launchUrl(uri);
  } else {
    // Handle if the UPI app cannot be launched
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: Text("Error"),
    //       content: Text("Could not launch UPI app."),
    //       actions: [
    //         TextButton(
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //           child: Text("OK"),
    //         ),
    //       ],
    //     );
    //   },
    //   );
  }
}
