import 'dart:io';

import 'package:chithi/api/apis.dart';
import 'package:chithi/constants/back-end/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import 'additional_setup.dart';
import 'package:chithi/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'email_pass.dart';

class SignUp extends ConsumerStatefulWidget {
  SignUp({
    super.key,
    required TextEditingController emailController,
    required TextEditingController passController,
  })  : _emailController = emailController,
        _passController = passController;
  final TextEditingController _emailController;
  final TextEditingController _passController;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  // instamces
  final ImagePicker _imagePicker = ImagePicker();

  // variables
  bool emailValid = true;
  bool passValid = true;
  bool empty = false;
  bool usernameExists = false;
  int _currentIndex = 0;
  bool isPicEmpty = true;
  File? fileImagePath;

  final PageController pageController = PageController(initialPage: 0);

  // make sure everything is fine before signup...
  Future<void> makeSure() async {
    if (widget._emailController.text.isNotEmpty &&
        widget._passController.text.isNotEmpty) {
      // proceed to check for display & username
      if (widget._displayNameController.text.isNotEmpty &&
          widget._usernameController.text.isNotEmpty) {
        // check if the username already exist or not..

        QuerySnapshot<Map<String, dynamic>> users = await fireUsersCollec
            .where("userName", isEqualTo: widget._usernameController.text)
            .get();

        List<QueryDocumentSnapshot<Map<String, dynamic>>> listOfFoundedUsers =
            users.docs;

        if (listOfFoundedUsers.isEmpty) {
          signup();
        } else {
          setState(() {
            empty = false;
            usernameExists = true;
          });
        }
      } else {
        giveError(1);
      }
    }

    // show error for email & pass
    else {
      giveError(0);
    }
  }

  void giveError(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutBack,
    );
    setState(() {
      empty = true;
    });
    SnackBar snackBar = const SnackBar(
      content: Text("Please fill all the fields with required tag."),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> signup() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    await AuthAPI.signupWithEmail(
      email: widget._emailController.text.trim(),
      pass: widget._passController.text,
      displayName: widget._displayNameController.text,
      username: widget._usernameController.text,
      isProfileEmpty: isPicEmpty,
      picFile: fileImagePath,
      context: context,
    );

    if (context.mounted) {
      Navigator.popUntil(context, (route) => route.isFirst);
    }
  }

  // ui funcs
  AppBar? _appBar() {
    // for main screen
    if (_currentIndex == 0) {
      return AppBar(
        actions: [
          IconButton(
            onPressed: () => pageController.animateToPage(
              _currentIndex + 1,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutBack,
            ),
            icon: const Icon(Icons.arrow_forward_ios_rounded),
          )
        ],
      );
    }

    // for usernameDisplay screen
    if (_currentIndex == 1) {
      return AppBar(
        leading: IconButton(
          onPressed: () => pageController.animateToPage(
            _currentIndex - 1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutBack,
          ),
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
        actions: [
          TextButton(
            onPressed: () async => await makeSure(),
            child: const Text(
              "FINISH",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      EmailPassScreen(
        emailValid: emailValid,
        passValid: passValid,
        emailController: widget._emailController,
        passController: widget._passController,
        empty: empty,
      ),
      AdditionalSetup(
        usernameExists: usernameExists,
        usernameController: widget._usernameController,
        displayNameController: widget._displayNameController,
        isEmpty: empty,
        isPicEmpty: isPicEmpty,
        fileImagePath: fileImagePath,
        changeProfilePic: () async {
          XFile? xFile =
              await _imagePicker.pickImage(source: ImageSource.gallery);
          if (xFile != null) {
            setState(() {
              isPicEmpty = false;
              fileImagePath = File(xFile.path);
            });
          }
        },
      ),
    ];

    return Scaffold(
      appBar: _appBar(),
      body: Stack(
        children: [
          ScrollConfiguration(
            behavior: StopScrolling(),
            child: PageView(
              controller: pageController,
              onPageChanged: (int newIndex) => setState(() {
                _currentIndex = newIndex;
              }),
              children: screens,
            ),
          ),

          // indicator

          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Indicator(
                length: screens.length,
                activeIndex: _currentIndex,
                onClicked: (int newIndex) {
                  pageController.jumpToPage(newIndex);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
