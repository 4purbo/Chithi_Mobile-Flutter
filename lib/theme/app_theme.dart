import 'package:chithi/theme/theme.dart';

import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
      splashColor: Colors.transparent,
      brightness: Brightness.light,
      primarySwatch: Colors.blueGrey,
      scaffoldBackgroundColor: screenBgColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: appBarClr,
        centerTitle: true,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: textFieldLabelColor),
        contentPadding: EdgeInsets.only(left: 8, right: 16),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)), gapPadding: 2),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)), gapPadding: 2),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)), gapPadding: 2),
      ));

  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blueGrey,
    brightness: Brightness.dark,
    splashColor: Colors.transparent,

    // scaffold dflt color
    scaffoldBackgroundColor: darkScreenBgColor,

    // app bar deco
    appBarTheme: const AppBarTheme(
      backgroundColor: appBarClr,
      centerTitle: true,
    ),

    // textField decorations
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[900],
      labelStyle: const TextStyle(color: darkTextFieldLabelColor),
      contentPadding: const EdgeInsets.only(left: 8, right: 16),
      enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)), gapPadding: 2),
      focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)), gapPadding: 2),
    ),
  );
}
