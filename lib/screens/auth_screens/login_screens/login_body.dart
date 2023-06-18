import 'package:chithi/constants/front-end/auth_constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:chithi/api/apis.dart';

import 'login_btn.dart';

class LogInBody extends StatelessWidget {
  const LogInBody({
    super.key,
    required TextEditingController emailController,
    required TextEditingController passController,
  })  : _emailController = emailController,
        _passController = passController;

  // variables
  final TextEditingController _emailController;
  final TextEditingController _passController;

  // funcs
  void onLogin(BuildContext context) async {
    final Connectivity connectivity = Connectivity();

    ConnectivityResult result = await connectivity.checkConnectivity();

    if (result == ConnectivityResult.none) {
      SnackBar snackBar = const SnackBar(
        content: Text("No connection available !!"),
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      if (context.mounted) {
        await AuthAPI.logInWithEmail(
          email: _emailController.text,
          pass: _passController.text,
          context: context,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // email
        AuthInput(
          controller: _emailController,
          hint: "e.g. example@gmail.com",
          isPassword: false,
          label: "Email",
        ),
        AuthScreenPersonalConstants.verticalGap,
        // password
        AuthInput(
          controller: _passController,
          hint: "e.g. 123456",
          isPassword: true,
          label: "Password",
        ),
        const SizedBox(
          height: 10,
        ),
        // chnge pass ..
        const Text(
          "Forgot password?",
          // style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(
          height: AuthScreenPersonalConstants.verticalGap.height! + 10,
        ),
        // login function
        Center(
            child: LogInButton(
          onLogin: () => onLogin(context),
        )),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
