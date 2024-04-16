import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:roaddoc/function/getlocation.dart';
import 'package:roaddoc/models/user_model/user_model.dart';
import 'package:roaddoc/service/firebase/firebaseStorage.dart';
import 'package:roaddoc/service/firebase/firebase_firestorehelper.dart';

class AppProvider with ChangeNotifier {
  UserModel _userModel = UserModel();

  void getUserInformationFirebase() async {
    _userModel = await FirebasefirestoreHelper.instance.getUserinformation();
    notifyListeners();
  }

  void removeUserdatafromprovide() async {
    _userModel.type = _userModel.type = "";
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

  void updateuserinfo(UserModel userModel, File? file) async {
    if (file == null) {
      
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userModel.id)
          .set(userModel.toJson());
      getUserInformationFirebase();
      notifyListeners();
    } else {
      String imageURl =
          await FireBaseStoragehelper.instance.uploadUserImage(file);
      _userModel = userModel.copyWith(image: imageURl);
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(_userModel.id)
          .set(_userModel.toJson());

      notifyListeners();
    }
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

  Position _position = Position(
    longitude: 0.0,
    latitude: 0.0,
    timestamp: DateTime.now(),
    accuracy: 0.0,
    altitude: 0.0,
    altitudeAccuracy: 0.0,
    heading: 0.0,
    headingAccuracy: 0.0,
    speed: 0.0,
    speedAccuracy: 0.0,
  );

  void getUserloaction() async {
    _position = await getlocation();
    notifyListeners();
  }

  Position get getUserlocation => _position;

  List<UserModel> _historylist = [];
  void getHistoryList(UserModel userModel) async {
    _historylist =
        await FirebasefirestoreHelper.instance.getHistoryOfUser(userModel);
    notifyListeners();
  }

  List<UserModel> get listofHistory => _historylist;

  UserModel _currenAcceptedDriverDetails = UserModel();
  void getCurrenAcceptedDriverDetails({required UserModel mechUser}) async {
    _currenAcceptedDriverDetails = await FirebasefirestoreHelper.instance
        .getCurrenAcceptedDriverDetails(MechUser: mechUser);
    notifyListeners();
  }

  UserModel get currenAcceptedDriverDetails => _currenAcceptedDriverDetails;

  void removeCurrenAcceptedDriverDetails({required UserModel mechUser}) {
    FirebasefirestoreHelper.instance
        .deleteCurrenAcceptedDriverDetails(mechUser: mechUser);
    notifyListeners();
  }
}
