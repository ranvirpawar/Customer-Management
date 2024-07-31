import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldTheme {
  TextFormFieldTheme._();
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 10,
    ),
    hintStyle: GoogleFonts.montserrat(
        fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
    labelStyle: GoogleFonts.montserrat(
      fontSize: 14,
      color: Colors.black,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(1.0),
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(1.0),
      borderSide: BorderSide(
        color: Colors.blue,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(1.0),
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(1.0),
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
  );
}
