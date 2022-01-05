// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:expense_tracker/controllers/dbhelper.dart';
import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/screens/add_transaction.dart';
import 'package:expense_tracker/screens/expensePage.dart';
import 'package:expense_tracker/screens/incomePage.dart';
import 'package:expense_tracker/screens/settings.dart';
import 'package:expense_tracker/utils/theme.dart';
import 'package:expense_tracker/utils/widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({Key? key}) : super(key: key);

  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
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

  //
  //
  //
  //

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

  List<FlSpot> getPlotPointsExpense(List<TransactionModel> entireData) {
    dataSet = [];
    dataSet = [];
    List tempdataSet = [];

    for (TransactionModel item in entireData) {
      if (item.date.month == today.month && item.type == "Expense") {
        tempdataSet.add(item);
      }
    }
    //
    // Sorting the list as per the date
    tempdataSet.sort((a, b) => a.date.day.compareTo(b.date.day));
    //
    for (var i = 0; i < tempdataSet.length; i++) {
      dataSet.add(
        FlSpot(
          tempdataSet[i].date.day.toDouble(),
          tempdataSet[i].amount.toDouble(),
        ),
      );
    }
    return dataSet;
  }

//
//
//
//

  List<FlSpot> getPlotPointsIncome(List<TransactionModel> entireData) {
    dataSetIncome = [];
    List tempdataSet = [];

    for (TransactionModel item in entireData) {
      if (item.date.month == today.month && item.type == "Income") {
        tempdataSet.add(item);
      }
    }
    //
    // Sorting the list as per the date
    tempdataSet.sort((a, b) => a.date.day.compareTo(b.date.day));
    //
    for (var i = 0; i < tempdataSet.length; i++) {
      dataSetIncome.add(
        FlSpot(
          tempdataSet[i].date.day.toDouble(),
          tempdataSet[i].amount.toDouble(),
        ),
      );
    }
    return dataSetIncome;
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
            getPlotPointsExpense(snapshot.data!);
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
              child: ListView(
                children: [
                  Center(
                    child: Text(
                      "Expenses Data ",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15, top: 6),
                      child: Text(
                        " Expense Chart",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  if (dataSet.length <= 2)
                    Card(
                      elevation: 5,
                      clipBehavior: Clip.hardEdge,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        height: 65,
                        child: Center(
                          child: Text(
                            " Insufficient data to render a chart",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.1,
                              fontSize: 17.5,
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 5,
                            blurRadius: 6,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 1.0,
                        vertical: 28.0,
                      ),
                      margin: EdgeInsets.all(
                        7.0,
                      ),
                      height: 500.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3.0, right: 35),
                        child: LineChart(
                          LineChartData(
                            titlesData: FlTitlesData(
                              show: true,
                              rightTitles: SideTitles(),
                              topTitles: SideTitles(),
                            ),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                spots: getPlotPointsExpense(snapshot.data!),
                                isCurved: false,
                                barWidth: 2.71,
                                colors: [Colors.black],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Transactions",
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
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
                      if (dataAtIndex.type == "Expense") {
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
                          child: ExpenseTile(context, dataAtIndex.amount,
                              dataAtIndex.note, currentDate, index),
                        );
                      } else
                        return Container();
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
