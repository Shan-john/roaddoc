import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roaddoc/function/ShowMessage.dart';
import 'package:roaddoc/models/user_model/user_model.dart';
import 'package:roaddoc/service/provider.dart';

class FirebasefirestoreHelper {
  static FirebasefirestoreHelper instance = FirebasefirestoreHelper();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<UserModel> getUserinformation() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> QuerySnapshot =
          await firebaseFirestore
              .collection("Users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get();
      return UserModel.fromJson(QuerySnapshot.data()!);
    } catch (e) {
      return UserModel();
    }
  }

  Future<bool> uploadRequest(BuildContext context,String ? id) async {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    try {
      await firebaseFirestore
          .collection("RequestList")
          .doc(id)
          .set(appProvider.getuserInfromation.toJson());
      return true;
    } catch (e) {
      showMessage("error");
      return false;
    }
  }

  Future<List<UserModel>> getRequestList() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firebaseFirestore.collection("RequestList").get();
      List<UserModel> listofUsermodel =
          querySnapshot.docs.map((e) => UserModel.fromJson(e.data())).toList();

      return listofUsermodel;
    } catch (e) {
      showMessage("error");
      return [];
    }
  }

Future<bool> removeRequest({required String? id}) async {
  try {
   
    await FirebaseFirestore.instance.collection("RequestList").doc(id).delete();
    
    
    showMessage("Request accepted successfully");
    
    
    return true;
  } catch (e) {
 
    showMessage("Failed to accept request: $e");
    return false;
  }
}

}
