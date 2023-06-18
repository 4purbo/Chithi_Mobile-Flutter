import 'package:chithi/constants/back-end/firebase_constants.dart';
import 'package:flutter/material.dart';

import 'package:chithi/model/models.dart';

import './dashboard.dart';

class Profile extends StatelessWidget {
  final UserModel crntUserModel;
  const Profile({super.key, required this.crntUserModel});

  Widget logOutBtn() {
    return ElevatedButton.icon(
      onPressed: () async {
        await fireAuth.signOut();
      },
      icon: const Icon(Icons.logout_rounded),
      label: const Text("SignOut"),
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, elevation: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(crntUserModel.displayName),
        centerTitle: false,
        actions: [
          logOutBtn(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // physics: const PageScrollPhysics(),
          children: [
            Dashboard(
              userModel: crntUserModel,
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
