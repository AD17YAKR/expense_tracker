// not just splash , will ask use for their name here

import 'package:expense_tracker/controllers/dbhelper.dart';
import 'package:expense_tracker/screens/homepage.dart';
import 'package:expense_tracker/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNameScreen extends StatefulWidget {
  const AddNameScreen({Key? key}) : super(key: key);

  @override
  _AddNameScreenState createState() => _AddNameScreenState();
}

class _AddNameScreenState extends State<AddNameScreen> {
  DbHelper dbHelper = DbHelper();
  String name = "";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      //
      backgroundColor: Colors.white,
      //
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
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
                width: 124.0,
                height: 124.0,
              ),
            ),
          ),
          Text(
            "What Your Name?",
            style: GoogleFonts.redHatDisplay(
              fontWeight: FontWeight.w400,
              fontSize: 20,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor,
                      blurRadius: 2.2,
                    ),
                  ],
                  color: Colors.white),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "  Your Name",
                  hintStyle:
                      GoogleFonts.poppins(letterSpacing: 1.2, fontSize: 18),
                ),
                onChanged: (val) {
                  name = val;
                },
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (name.isNotEmpty) {
                  dbHelper.addName(name);
                  Get.to(HomePage());
                } else {
                  Get.snackbar(
                    "Oops!",
                    "",
                    messageText: Text(
                      "I am Sure you got a Name!\nEnter it Please ",
                      style: GoogleFonts.poppins(fontSize: 15),
                    ),
                    duration: Duration(milliseconds: 1350),
                  );
                }
              },
              child: Text(
                "Next",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  letterSpacing: 7.5,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: primaryColor,
                minimumSize: Size(width / 1.05, 50),
              ),
            ),
          )
        ],
      ),
    );
  }
}
