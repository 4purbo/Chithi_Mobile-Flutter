import 'dart:io';

import 'package:chithi/api/apis.dart';
import 'package:chithi/constants/back-end/firebase_constants.dart';
import 'package:chithi/model/models.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthAPI {
  static Future<void> logInWithEmail({
    required String email,
    required String pass,
    required BuildContext context,
  }) async {
    try {
      await fireAuth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
    } on FirebaseException catch (e) {
      SnackBar snackBar = SnackBar(
        content: Text(e.message.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  static Future<void> signupWithEmail({
    required String email,
    required String pass,
    required String displayName,
    required String username,
    required bool isProfileEmpty,
    required File? picFile,
    required BuildContext context,
  }) async {
    try {
      await fireAuth.createUserWithEmailAndPassword(
          email: email, password: pass);

      UserModel usrModel;

      if (isProfileEmpty) {
        usrModel = UserModel(
          displayName: displayName,
          email: email,
          isActive: true,
          profilePhoto: null,
          id: Usr().crntUsr!.uid,
          fans: [],
          idols: [],
          bannerPic: null,
          bio: null,
          userName: username,
        );
      } else {
        String profileLink = await StoreAPI.uploadProfilePic(
          uid: Usr().crntUsr!.uid,
          picFile: picFile!,
        );

        usrModel = UserModel(
          displayName: displayName,
          email: email,
          isActive: true,
          profilePhoto: profileLink,
          id: Usr().crntUsr!.uid,
          fans: [],
          idols: [],
          bannerPic: null,
          bio: null,
          userName: username,
        );
      }

      await fireUsersCollec.doc(Usr().crntUsr!.uid).set(usrModel.toMap());
    } on FirebaseException catch (e) {
      SnackBar snackBar = SnackBar(
        content: Text(e.message.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
