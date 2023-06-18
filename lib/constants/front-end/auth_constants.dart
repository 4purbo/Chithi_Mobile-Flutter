import 'package:chithi/theme/custom_theme.dart';
import 'package:flutter/material.dart';

import 'package:chithi/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreenPersonalConstants {
  static const SizedBox verticalGap = SizedBox(
    height: 30,
  );
}

class AuthInput extends ConsumerStatefulWidget {
  const AuthInput({
    super.key,
    required this.controller,
    required this.hint,
    required this.isPassword,
    required this.label,
    this.onChanged,
    this.maxCharacters,
  });
  final TextEditingController controller;
  final String hint, label;
  final bool isPassword;
  final void Function(String newText)? onChanged;
  final int? maxCharacters;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthInputState();
}

class _AuthInputState extends ConsumerState<AuthInput> {
  bool? obscure;

  @override
  void initState() {
    super.initState();
    obscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    CustomTheme currentTheme = ref.watch(currentThemeProvider);
    bool isDarkMode = currentTheme == CustomTheme.dark;

    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      maxLength: widget.maxCharacters,
      obscureText: obscure!,
      cursorColor: isDarkMode ? darkTextFieldCursorColor : textFieldCursorColor,
      decoration: InputDecoration(
        suffix: widget.isPassword
            ? GestureDetector(
                onTap: () => setState(() {
                  obscure = !obscure!;
                }),
                child: Icon(
                  obscure! ? Icons.visibility_off : Icons.visibility,
                ),
              )
            : null,
        hintText: widget.hint,
        labelText: widget.label,
      ),
    );
  }
}
