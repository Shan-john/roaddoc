import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:roaddoc/models/locationModel/location_model/location_model.dart';
import 'package:roaddoc/service/https/api.dart';
 
Future<LocationModel> getLocationDetails(String pincode) async {
  final response = await http.get(Uri.parse("${API}${pincode}"));
  final jsonbody = jsonDecode(response.body) as List<dynamic>;
  final data = LocationModel.fromJson(jsonbody[0]);
  return data;
}
