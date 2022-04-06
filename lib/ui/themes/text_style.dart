import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: avoid_classes_with_only_static_members
abstract class AppTextStyle {
  static final inputLabelStyle = GoogleFonts.roboto(fontSize: 18, color: const Color(0xFF212529));

  static final boldTextStyle =
      GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF212529));

  static final profileInfoStyle = GoogleFonts.roboto(fontSize: 16, color: const Color(0xFF212529));

  static final profileOptionsStyle =
      GoogleFonts.roboto(fontSize: 20, color: const Color(0xFF212529));

  static final titleStyle =
      GoogleFonts.roboto(fontSize: 26, fontWeight: FontWeight.w700, color: const Color(0xFF212529));

  static const inputDecoration = InputDecoration(
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    isCollapsed: true,
  );
}
