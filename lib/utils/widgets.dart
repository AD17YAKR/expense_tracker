import 'package:expense_tracker/utils/theme.dart';
import 'package:flutter/material.dart';

Widget cardIncome(String income) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(18),
        ),
        padding: EdgeInsets.all(6.0),
        child: Icon(
          Icons.arrow_downward,
          color: Colors.greenAccent,
        ),
      ),
      SizedBox(
        width: 8.5,
      ),
      Column(
        children: [
          Text(
            "Income",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            income,
            style: TextStyle(
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

Widget cardExpense(String expense) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(18),
        ),
        padding: EdgeInsets.all(6.0),
        child: Icon(
          Icons.arrow_upward,
          color: Colors.redAccent,
        ),
      ),
      SizedBox(
        width: 8.5,
      ),
      Column(
        children: [
          Text(
            "Expense",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            expense,
            style: TextStyle(
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

Widget IncomeTile(int value, String Note) {
  return Container(
    margin: EdgeInsets.all(
      8.0,
    ),
    padding: EdgeInsets.all(
      18.0,
    ),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.greenAccent,
          Colors.grey.shade100,
        ],
      ),
      borderRadius: BorderRadius.circular(
        8.0,
      ),
    ),
    child: Row(
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
              ),
            ),
          ],
        ),
        Text(
          "+ $value",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

Widget ExpenseTile(int value, String Note) {
  return Container(
    margin: EdgeInsets.all(
      8.0,
    ),
    padding: EdgeInsets.all(
      18.0,
    ),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.grey.shade100,
          Colors.redAccent,
        ],
      ),
      borderRadius: BorderRadius.circular(
        8.0,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.arrow_circle_down_outlined,
              size: 28.0,
              color: Colors.red[700],
            ),
            SizedBox(
              width: 4.0,
            ),
            Text(
              "Expense",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
        Text(
          "- $value",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}
