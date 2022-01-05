import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

Color primaryColor = HexColor("#12012C");
Color secondaryColor = const Color(0x2A003819);
Color bgColor = const Color(0xFF1A1A1A);
Color bgColor2 = const Color(0xFF252525);
BoxShadow bshadow = BoxShadow(blurRadius: 5, color: Colors.grey.shade600);
Color textColor = Colors.blueGrey;
Color cardcolor = Colors.grey.shade200;
bool isDarkModeEnabled = false;

ThemeData light = ThemeData(
  primaryColor: primaryColor,
  backgroundColor: Colors.white,
  textTheme: TextTheme(
      bodyText1: GoogleFonts.roboto(),
      bodyText2: GoogleFonts.mate(),
      subtitle1: GoogleFonts.eagleLake(),
      subtitle2: GoogleFonts.eagleLake()),
);
ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  backgroundColor: Colors.black,
  buttonTheme:
      ButtonThemeData(buttonColor: Colors.amber, disabledColor: Colors.black),
  textTheme: TextTheme(
    bodyText1: GoogleFonts.roboto(color: textColor),
    bodyText2: GoogleFonts.mate(color: textColor),
    subtitle1: GoogleFonts.eagleLake(color: Colors.black),
    subtitle2: GoogleFonts.eagleLake(color: Colors.black),
  ),
);

ThemeData currentTheme = light;
