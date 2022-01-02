// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, unused_import

import 'package:expense_tracker/screens/addname.dart';
import 'package:expense_tracker/screens/homepage.dart';
import 'package:expense_tracker/screens/splash.dart';
import 'package:expense_tracker/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('money');
  runApp(
    GetMaterialApp(
      theme: ThemeData(
        primaryColor: primaryColor,
        textTheme: TextTheme(
            bodyText1: GoogleFonts.roboto(),
            bodyText2: GoogleFonts.mate(),
            subtitle1: GoogleFonts.eagleLake(),
            subtitle2: GoogleFonts.eagleLake()),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
  );
}
