import 'package:customer_management/utils/widget%20theme/elevated_button_theme.dart';
import 'package:customer_management/utils/widget%20theme/textformfield_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class AppTheme{
AppTheme._();
static ThemeData lightTheme = ThemeData(
  textTheme:  GoogleFonts.montserratTextTheme(),
  inputDecorationTheme: TextFormFieldTheme.lightInputDecorationTheme,
  elevatedButtonTheme: AppElevatedTheme.lightElevatedButtonTheme,
);
}