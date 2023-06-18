import 'dart:io';

import 'package:chithi/constants/front-end/auth_constants.dart';
import 'package:chithi/constants/front-end/frontend_constants.dart';
import 'package:chithi/theme/theme.dart';
import 'package:chithi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class AdditionalSetup extends ConsumerStatefulWidget {
  AdditionalSetup({
    super.key,
    required TextEditingController usernameController,
    required TextEditingController displayNameController,
    required bool isEmpty,
    required this.fileImagePath,
    required this.isPicEmpty,
    required this.changeProfilePic,
    required this.usernameExists,
  })  : _usernameController = usernameController,
        _displayNameController = displayNameController,
        _empty = isEmpty;

  // widget variables
  final TextEditingController _usernameController;

  final TextEditingController _displayNameController;

  final bool isPicEmpty;
  final File? fileImagePath;

  final bool usernameExists;

  final void Function() changeProfilePic;

  bool _empty;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => AdditionalSetupState();
}

class AdditionalSetupState extends ConsumerState<AdditionalSetup> {
  // variables
  String displayName = "";
  String username = "";

  // funcs

  @override
  void initState() {
    super.initState();
    displayName = widget._displayNameController.text;
    username = widget._usernameController.text;
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: StopScrolling(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // displayName

              AuthInput(
                maxCharacters: 15,
                controller: widget._displayNameController,
                hint: "e.g. Chithi User",
                isPassword: false,
                label: "Display Name",
                onChanged: (newText) {
                  if (newText.isEmpty) {
                    setState(() {
                      widget._empty = true;
                    });
                  } else {
                    setState(() {
                      displayName = newText;
                    });
                  }
                },
              ),
              if (widget._empty)
                const Text(
                  "* required",
                  style: TextStyle(color: Colors.red),
                ),
              AuthScreenPersonalConstants.verticalGap,
              // username
              AuthInput(
                controller: widget._usernameController,
                maxCharacters: 10,
                hint: "e.g. chithi_user",
                isPassword: false,
                label: "Username",
                onChanged: (newText) {
                  if (newText.isEmpty) {
                    setState(() {
                      widget._empty = true;
                    });
                  } else {
                    setState(() {
                      username = newText;
                    });
                  }
                },
              ),
              if (widget._empty)
                const Text(
                  "* required",
                  style: TextStyle(color: Colors.red),
                ),

              if (widget.usernameExists)
                const Text(
                  "* username already in use",
                  style: TextStyle(color: Colors.red),
                ),

              // photo review
              AuthScreenPersonalConstants.verticalGap,
              Center(
                child: widget.isPicEmpty
                    ? const CircleAvatar(
                        radius: 55,
                        backgroundImage: AssetImage(Assets.defaultProfilePic),
                      )
                    : CircleAvatar(
                        radius: 55,
                        backgroundImage: FileImage(widget.fileImagePath!),
                      ),
              ),
              AuthScreenPersonalConstants.verticalGap,
              Center(
                child: GestureDetector(
                  onTap: () => widget.changeProfilePic(),
                  child: const Text(
                    "Change profile pic",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // preview of the whole account
              const Text(
                "Your id will look like this:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              AuthScreenPersonalConstants.verticalGap,
              ListTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                tileColor: postBgClr,
                leading: widget.isPicEmpty
                    ? const CircleAvatar(
                        // radius: 55,
                        backgroundImage: AssetImage(Assets.defaultProfilePic),
                      )
                    : CircleAvatar(
                        // radius: 55,
                        backgroundImage: FileImage(widget.fileImagePath!),
                      ),
                title: Text(
                  displayName,
                  style: const TextStyle(color: white),
                ),
                subtitle: Text(
                  "@${widget._usernameController.text}",
                  style: const TextStyle(color: white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
