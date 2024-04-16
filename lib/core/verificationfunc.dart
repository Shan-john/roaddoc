import 'package:roaddoc/function/ShowMessage.dart';

// login vadidation checker
bool loginvalidation(
  String email,
  String password,
) {
  if (email.isEmpty && password.isEmpty) {
    showMessage("Email is empty");
     
    return false;
  } else if (email.isEmpty) {
    showMessage("Email is empty");
    return false;
  } else if (password.isEmpty) {
    showMessage("Email is empty");
    return false;
  } else {
    return true;
  }
}
//Sign Up validation checker

bool Registorvalidation({
  required String Phonenumber,
  required String email,
  required String password,
  required String name,
}) {
  if (email.isEmpty &&
      password.isEmpty &&
      name.isEmpty &&
      Phonenumber.isEmpty) {
    showMessage("Email,Password,Name and phone number is not found");
    return false;
  } else if (email.isEmpty) {
    showMessage("Email is  not found");
    return false;
  } else if (password.isEmpty) {
    showMessage("password is  not found");
    return false;
  } else if (name.isEmpty) {
    showMessage("Name is not found");
    return false;
  } else if (Phonenumber.isEmpty) {
    return false;
  } else {
    return true;
  }
}
