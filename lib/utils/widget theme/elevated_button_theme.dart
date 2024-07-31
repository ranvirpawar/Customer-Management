import 'package:customer_management/constants/colors.dart';
import 'package:flutter/material.dart';

class AppElevatedTheme {
  AppElevatedTheme._();
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    foregroundColor: appWhiteColor,
    backgroundColor: appBlackColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(1),
    ),
  ));
}
