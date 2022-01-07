// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_final_fields, unused_field

import 'package:expense_tracker/controllers/dbhelper.dart';
import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/screens/expensePage.dart';
import 'package:expense_tracker/screens/incomePage.dart';
import 'package:expense_tracker/utils/gradientText.dart';
import 'package:expense_tracker/utils/theme.dart';
import 'package:expense_tracker/utils/widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box box;
  late SharedPreferences preferences;
  DbHelper dbHelper = DbHelper();
  Map? data;
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;
  List<FlSpot> dataSet = [];
  List<FlSpot> dataSetIncome = [];
  DateTime today = DateTime.now();
  DateTime now = DateTime.now();
  int index = 1;
  int selectedIndex = 0;
  DateTime selectedDate = DateTime.now();

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
  late int mot = 0;

  //
  //
  //
  //
  List<ChoiceChip> month = [];

  @override
  void initState() {
    super.initState();
    getPreference();
    box = Hive.box('money');
  }

  //
  //
  //
  //

  getPreference() async {
    preferences = await SharedPreferences.getInstance();
  }

//
//
//
//

  Future<List<TransactionModel>> fetch() async {
    if (box.values.isEmpty) {
      return Future.value([]);
    } else {
      List<TransactionModel> items = [];
      box.toMap().values.forEach((element) {
        items.add(
          TransactionModel(element['amount'] as int,
              element['date'] as DateTime, element['note'], element['type']),
        );
      });
      return items;
    }
  }

  //
  //
  //
  //

  getTotalBalance(List<TransactionModel> entireData) {
    totalExpense = 0;
    totalIncome = 0;
    totalBalance = 0;

    for (TransactionModel data in entireData) {
      if (data.date.month == today.month) {
        if (data.type == "Income") {
          totalBalance += data.amount;
          totalIncome += data.amount;
        } else {
          totalBalance -= data.amount;
          totalExpense += data.amount;
        }
      }
    }
  }

//
//
//
//

//
//
//
//

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        backgroundColor: primaryColor,
      ),
//
//
//
//
      body: FutureBuilder<List<TransactionModel>>(
        future: fetch(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Unexpected Error"),
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Text("No Values Found"),
              );
            }
            getTotalBalance(snapshot.data!);

            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
              child: ListView(
                children: [
                  Center(
                    child: GradientText(
                      "Welcome ${preferences.getString("name")} ",
                      style: GoogleFonts.mate(
                        fontWeight: FontWeight.w500,
                        fontSize: 32,
                        letterSpacing: 2,
                      ),
                      gradient: LinearGradient(colors: [
                        primaryColor,
                        Colors.indigoAccent,
                        Colors.greenAccent.shade700,
                        Colors.redAccent
                      ]),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  // Wrap(
                  //   children: dateChips(),
                  // ),

                  Container(
                    width: width / 1.05,
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          primaryColor,
                          Colors.indigoAccent,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Column(
                      children: [
                        Text(
                          "Total Balance ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "₹ $totalBalance",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            letterSpacing: 2,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              child: cardIncome(totalIncome.toString()),
                              onTap: () => Get.to(IncomePage()),
                            ),
                            GestureDetector(
                              child: cardExpense(totalExpense.toString()),
                              onTap: () => Get.to(
                                ExpensePage(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: GradientText(
                      "Transactions",
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                      gradient: textGrad,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      TransactionModel dataAtIndex = snapshot.data![index];
                      try {
                        dataAtIndex = snapshot.data![index];
                      } catch (e) {
                        return Container();
                      }
                      if (dataAtIndex.type == "Income") {
                        DateTime date = dataAtIndex.date;
                        String currentDate =
                            "${date.day} ,${months[date.month - 1]},${date.year}";
                        return GestureDetector(
                          onLongPress: () async {
                            bool? answer = await showConfirmDialog(
                              context,
                              "WARNING",
                              "This will delete this record. This action is irreversible. Do you want to continue ?",
                            );
                            if (answer != null && answer) {
                              dbHelper.deleteData(index);
                              setState(() {});
                            }
                          },
                          child: IncomeTile(context, dataAtIndex.amount,
                              dataAtIndex.note, currentDate, index),
                        );
                      } else {
                        DateTime date = dataAtIndex.date;
                        String currentDate =
                            "${date.day},${months[date.month - 1]},${date.year}";
                        return GestureDetector(
                          onLongPress: () async {
                            bool? answer = await showConfirmDialog(
                              context,
                              "WARNING",
                              "This will delete this record. This action is irreversible. Do you want to continue ?",
                            );
                            if (answer != null && answer) {
                              dbHelper.deleteData(index);
                              setState(() {});
                            }
                          },
                          child: ExpenseTile(context, dataAtIndex.amount,
                              dataAtIndex.note, currentDate, index),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: Text("Unexpected Error"),
            );
          }
        },
      ),
    );
  }
}

class Months {
  String label;
  Color color;

  Months(this.label, this.color);
}
