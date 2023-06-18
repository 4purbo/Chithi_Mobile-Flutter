import 'package:chithi/constants/back-end/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:chithi/model/models.dart';

class UserAPI {
  static Future<UserModel> getUserData(String userUid) async {
    DocumentSnapshot<Map<String, dynamic>> newUserDoc =
        await fireUsersCollec.doc(userUid).get();

    Map<String, dynamic> newUserData = newUserDoc.data()!;

    return UserModel.fromMap(newUserData);
  }
}
