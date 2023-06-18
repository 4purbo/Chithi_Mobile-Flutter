import 'package:chithi/theme/custom_theme.dart';
import 'package:flutter/material.dart';

import 'package:chithi/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogInButton extends ConsumerWidget {
  const LogInButton({super.key, required void Function() onLogin})
      : _onLogin = onLogin;

  final void Function() _onLogin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CustomTheme currentTheme = ref.watch(currentThemeProvider);
    bool isDark = currentTheme == CustomTheme.dark;

    return ElevatedButton(
      onPressed: _onLogin,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDark ? darkLogInBtnClr : logInBtnClr,
      ),
      child: const Text("Login"),
    );
  }
}
