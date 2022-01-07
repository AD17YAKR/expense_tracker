// ignore_for_file: prefer_const_constructors

import 'package:expense_tracker/screens/incomePage.dart';
import 'package:expense_tracker/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'customanimatedbottombar.dart';

List<String> months = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec"
];

Widget cardIncome(String income) {
  // |Income
  // 1200
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.all(6.0),
        child: const Icon(
          Icons.arrow_upward,
          color: Colors.white,
        ),
      ),
      const SizedBox(
        width: 8.5,
      ),
      Column(
        children: [
          const Text(
            "Income",
            style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w600,
                letterSpacing: 2),
          ),
          Text(
            income,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          )
        ],
      )
    ],
  );
}

Widget cardExpense(String expense) {
  // | Expense
  // | 1200
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.all(6.0),
        child: const Icon(
          Icons.arrow_downward,
          color: Colors.redAccent,
        ),
      ),
      const SizedBox(
        width: 8.5,
      ),
      Column(
        children: [
          const Text(
            "Expense",
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
          Text(
            expense,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      )
    ],
  );
}

Widget IncomeTile(
    BuildContext context, int value, String note, String date, int index) {
  if (note == "Expense") note = "Income";
  return Container(
    margin: const EdgeInsets.all(
      8.0,
    ),
    padding: const EdgeInsets.all(
      18.0,
    ),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.greenAccent,
          Colors.greenAccent.shade100,
          cardcolor,
        ],
      ),
      boxShadow: [bshadow],
      borderRadius: BorderRadius.circular(
        8.0,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.arrow_circle_up_outlined,
                  size: 28.0,
                  color: Colors.green[700],
                ),
                SizedBox(
                  width: 4.0,
                ),
                Text(
                  "Income",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              date,
              style: GoogleFonts.poppins(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.1,
              ),
            ),
          ],
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "+ $value",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                ),
              ),
              Text(
                note,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget ExpenseTile(
    BuildContext context, int value, String note, String date, int index) {
  return Container(
    margin: const EdgeInsets.all(
      8.0,
    ),
    padding: const EdgeInsets.all(
      18.0,
    ),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          cardcolor,
          Colors.redAccent.shade100,
          Colors.redAccent,
        ],
      ),
      boxShadow: [bshadow],
      borderRadius: BorderRadius.circular(
        8.0,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.arrow_circle_down_outlined,
                  size: 28.0,
                  color: Colors.red[700],
                ),
                const SizedBox(
                  width: 4.0,
                ),
                const Text(
                  "Expense",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              date,
              style: GoogleFonts.poppins(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.1,
              ),
            ),
          ],
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "- $value",
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                ),
              ),
              Text(
                note,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

showConfirmDialog(BuildContext context, String title, String content) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.redAccent.shade700,
            ),
          ),
          child: Text(
            "YES",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(
            "No",
          ),
          style: ElevatedButton.styleFrom(primary: primaryColor),
        ),
      ],
    ),
  );
}
