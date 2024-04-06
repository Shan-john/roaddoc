import 'package:cloud_firestore/cloud_firestore.dart';
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

  void updateuserinfo(UserModel userModel) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(userModel.id)
        .set(userModel.toJson());
    getUserInformationFirebase();
    notifyListeners();
  }

  UserModel _currentAvailableMechUser = UserModel();
  void getCurrentAcceptedMech({required UserModel driverUser}) async {
    _currentAvailableMechUser = await FirebasefirestoreHelper.instance
        .getCurrentAccepetedMech(driverUser: driverUser);
    notifyListeners();
  }

  UserModel get currentAvailableMechUser => _currentAvailableMechUser;

  void removecurrentavailableMech({required UserModel driverUser}) {
    FirebasefirestoreHelper.instance
        .deleteCurrentAccepetedMech(driverUser: driverUser);
    notifyListeners();
  }
}
