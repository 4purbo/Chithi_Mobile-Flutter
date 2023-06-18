import 'package:chithi/theme/custom_theme.dart';
import 'package:chithi/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:chithi/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'login_screens/login_body.dart';
import 'signup_screens/signup.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  // controllers
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passController = TextEditingController();

  // ui funcs
  Widget _body({required bool isDark, required BuildContext context}) {
    return Stack(
      children: [
        Center(
          child: ScrollConfiguration(
            behavior: StopScrolling(),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Welcome back,",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text.rich(
                      TextSpan(style: TextStyle(fontSize: 15), children: [
                        TextSpan(text: "we missed you a lot.. "),
                        TextSpan(
                            text: "<3", style: TextStyle(color: Colors.red))
                      ]),
                    ),

                    const SizedBox(
                      height: 100,
                    ),

                    LogInBody(
                        emailController: emailController,
                        passController: passController),

                    // navigate screens

                    Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color,
                              ),
                            ),
                            TextSpan(
                                text: "Sign up",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignUp(
                                            emailController: emailController,
                                            passController: passController,
                                          ),
                                        ),
                                      ),
                                style: const TextStyle(
                                  color: blue,
                                  decoration: TextDecoration.underline,
                                ))
                          ],
                        ),
                      ),
                    ),

                    // divide other logins
                    Divider(
                      height: 60,
                      thickness: 0.5,
                      color: isDark ? Colors.grey : Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
            top: MediaQuery.of(context).padding.top,
            right: 15,
            child: ChangeThemeButton(
              icon: Icon(
                isDark
                    ? Icons.brightness_6_outlined
                    : Icons.brightness_6_rounded,
                color: isDark ? Colors.white : Colors.black,
              ),
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    CustomTheme currentTheme = ref.watch(currentThemeProvider);
    bool isDark = currentTheme == CustomTheme.dark;

    return Scaffold(
      body: _body(
        context: context,
        isDark: isDark,
      ),
    );
  }
}