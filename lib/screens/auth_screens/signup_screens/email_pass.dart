import 'package:chithi/constants/front-end/auth_constants.dart';
import 'package:chithi/theme/custom_theme.dart';
import 'package:chithi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class EmailPassScreen extends ConsumerWidget {
  EmailPassScreen({
    super.key,
    required TextEditingController emailController,
    required TextEditingController passController,
    required this.emailValid,
    required this.passValid,
    required this.empty,
  })  : _emailController = emailController,
        _passController = passController;
  // final void Function() _goToNextScreen;

  final TextEditingController _emailController;
  final TextEditingController _passController;
  bool emailValid = true;
  bool passValid = true;
  bool empty = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CustomTheme currentTheme = ref.watch(currentThemeProvider);
    bool isDark = currentTheme == CustomTheme.dark;

    return Center(
      child: ScrollConfiguration(
        behavior: StopScrolling(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome,",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text.rich(
                  TextSpan(style: TextStyle(fontSize: 15), children: [
                    TextSpan(
                        text: "it's always nice to have someone like you.. "),
                    TextSpan(text: "<3", style: TextStyle(color: Colors.red))
                  ]),
                ),

                const SizedBox(
                  height: 80,
                ),

                // email

                AuthInput(
                  controller: _emailController,
                  hint: "e.g. example@gmail.com",
                  isPassword: false,
                  label: "Email",
                ),
                if (empty)
                  const Text(
                    "* required",
                    style: TextStyle(color: Colors.red),
                  ),
                AuthScreenPersonalConstants.verticalGap,
                // pass
                AuthInput(
                  controller: _passController,
                  hint: "e.g. 123456",
                  isPassword: true,
                  label: "Password",
                ),
                if (empty)
                  const Text(
                    "* required",
                    style: TextStyle(color: Colors.red),
                  ),
                AuthScreenPersonalConstants.verticalGap,
                Divider(
                  height: 60,
                  thickness: 0.5,
                  color: isDark ? Colors.grey : Colors.black,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
