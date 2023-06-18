import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StoreAPI {
  static Future<String> uploadProfilePic({
    required String uid,
    required File picFile,
  }) async {
    Reference storageRef = FirebaseStorage.instance.ref();

    Reference profilePicParentRef = storageRef.child("profilePics");

    final Reference profilePicRef = profilePicParentRef.child(uid);

    await profilePicRef.putFile(picFile);

    final String url = await profilePicRef.getDownloadURL();
    log(url);

    return url;
  }
}
