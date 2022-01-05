// ignore_for_file: prefer_const_constructors

import 'package:expense_tracker/controllers/dbhelper.dart';
import 'package:expense_tracker/utils/theme.dart';
import 'package:expense_tracker/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  //
  DbHelper dbHelper = DbHelper();
  String darktext = "Wanna Turn it Dark";

  //
  //
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(
          10.0,
        ),
        children: [
          const SizedBox(
            height: 15.0,
          ),
          Center(
            child: Text(
              "Settings",
              style: GoogleFonts.mate(
                  fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Card(
            elevation: 6,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: ListTile(
              onTap: () async {
                bool answer = await showConfirmDialog(
                  context,
                  "Warning",
                  "This is irreversible. Your entire data will be Lost",
                );
                if (answer) {
                  await dbHelper.cleanData();
                }
              },
              tileColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 20.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  8.0,
                ),
              ),
              title: const Text(
                "Clean Data",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              subtitle: const Text(
                "This is irreversible",
              ),
              trailing: const Icon(
                Icons.delete_forever,
                size: 32.0,
                color: Colors.black87,
              ),
            ),
          ),
          //
          Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              onTap: () async {
                String nameEditing = "";
                String? name = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.grey[300],
                    title: Text(
                      "Enter new name",
                      style: GoogleFonts.poppins(letterSpacing: 2),
                    ),
                    content: Container(
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(
                          12.0,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Your Name",
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                        maxLength: 12,
                        onChanged: (val) {
                          nameEditing = val;
                        },
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(nameEditing);
                        },
                        child: const Text(
                          "OK",
                        ),
                        style: ElevatedButton.styleFrom(primary: primaryColor),
                      ),
                    ],
                  ),
                );
                //
                if (name != null && name.isNotEmpty) {
                  DbHelper dbHelper = DbHelper();
                  await dbHelper.addName(name);
                }
              },
              tileColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 20.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  8.0,
                ),
              ),
              title: const Text(
                "Change Name",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              trailing: const Icon(
                Icons.change_circle,
                size: 32.0,
                color: Colors.black87,
              ),
            ),
          ),
          //
          //
          Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "   " + darktext,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Switch(
                      value: isDarkModeEnabled,
                      onChanged: (bool state) {
                        setState(() {
                          isDarkModeEnabled = state;
                        });
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
