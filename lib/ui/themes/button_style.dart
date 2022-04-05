import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: avoid_classes_with_only_static_members
abstract class AppButtonStyle {
  static final ButtonStyle filledButton = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(const Color(0xFF01B4E4)),
    foregroundColor: MaterialStateProperty.all(Colors.white),
    textStyle: MaterialStateProperty.all(
      GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700),
    ),
    padding: MaterialStateProperty.all(
      const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 8,
      ),
    ),
  );
}
