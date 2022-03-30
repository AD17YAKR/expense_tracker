// not just splash , will ask use for their name here

// ignore_for_file: prefer__ructors

import 'package:expense_tracker/controllers/dbhelper.dart';
import 'package:expense_tracker/screens/addname.dart';
import 'package:expense_tracker/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'navbar.dart';

class SplashScreen extends StatefulWidget {
   SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //
  DbHelper dbHelper = DbHelper();

  Future getSettings() async {
    String? name = await dbHelper.getName();
    if (name != null) {
      Get.offAll(MyHomePage());
    } else {
      Get.offAll(AddNameScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    getSettings();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      //
      backgroundColor: Colors.white,
      //
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              12.0,
            ),
          ),
          padding: EdgeInsets.all(
            16.0,
          ),
          child: Image.asset(
            "assets/Appicon.png",
            width: 164.0,
            height: 164.0,
          ),
        ),
      ),
    );
  }
}
