import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roaddoc/core/routes.dart';

import 'package:roaddoc/function/ShowMessage.dart';

import 'package:roaddoc/models/user_model/user_model.dart';

import '../../function/type_of_users.dart';

class FireBaseAuthHelper {
  static FireBaseAuthHelper instance = FireBaseAuthHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get getAuthChange => _auth.authStateChanges();

  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      showMessage("logining..");

      await _auth.signInWithEmailAndPassword(email: email, password: password);
      showMessage("Login successfully completed ..");

      return true;
    } on FirebaseAuthException catch (ex) {
      // Routes.instance.pop(context);
      showMessage(ex.code.toString());
      return false;
    }
  }

  Future<bool> signup(String name, String email, String phonenumber,
      BuildContext context, usertype type) async {
    try {
      UserCredential? userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: phonenumber);
      showMessage("Signuped successfully completed ..");

      UserModel dirverUser = UserModel(
        mailid: email,
        id: userCredential.user!.uid,
        name: name,
        phoneNumber: int.parse(phonenumber),
        type: type.toString(),
      );
      _firestore
          .collection("Users")
          .doc(dirverUser.id)
          .set(dirverUser.toJson());
      return true;
    } on FirebaseAuthException catch (ex) {
      showMessage(ex.code.toString());
     Routes.instance.pop(context);
      return false;
    }
  }

  Future<bool> logOut() async {
    try {
      showMessage("LoginIng out");
      await _auth.signOut();
      return true;
    } catch (e) {
      showMessage("failed");
      return false;
    }
  }
}
