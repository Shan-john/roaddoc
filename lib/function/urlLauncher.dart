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
