//  import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class firebaseRealtimeStorageHelper {
  static firebaseRealtimeStorageHelper instance =
      firebaseRealtimeStorageHelper();
  requeststatuschager({String? id, required bool value}) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Users");

    await ref.child(id!).set({
      "accept": value,
    });
  }
}
