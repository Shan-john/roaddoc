import 'package:flutter/material.dart';
import 'package:roaddoc/models/user_model/user_model.dart';
import 'package:roaddoc/service/firebase/firebase_firestorehelper.dart';

class AppProvider with ChangeNotifier {
  UserModel _userModel = UserModel();

  void getUserInformationFirebase() async {
    _userModel = await FirebasefirestoreHelper.instance.getUserinformation();
    notifyListeners();
  }

  //passing userModel using "get" keyword
  UserModel get getuserInfromation => _userModel;

  List<UserModel> _listofRequest = [];

  void getDriversRequestList() async {
    _listofRequest = await FirebasefirestoreHelper.instance.getRequestList();
    notifyListeners();
  }

  List<UserModel> get getDriverRequestlist => _listofRequest;

  void removeRequest(UserModel userModel) {
    _listofRequest.remove(userModel);
    notifyListeners();
  }
}
