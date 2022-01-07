// ignore_for_file: prefer_const_constructors

import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChartPage extends StatefulWidget {
  @override
  _PieChartPageState createState() => _PieChartPageState();
}

class _PieChartPageState extends State<PieChartPage> {
  late List<BalanceData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  late Box box;
  DateTime today = DateTime.now();
  double totalExpense = 0;
  double totalIncome = 0;
  double totalBalance = 0;

  @override
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

  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<TransactionModel>>(
        future: fetch(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Unexpected Error",
                style: TextStyle(fontSize: 32),
              ),
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Text("No Values Found"),
              );
            }
            getTotalBalance(snapshot.data!);
            return SafeArea(
              child: SfCircularChart(
                title: ChartTitle(
                  text: 'Pie Chart for Income vs Expense',
                  textStyle: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    wordSpacing: 2,
                    letterSpacing: 2,
                  ),
                ),
                legend: Legend(
                    isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
                tooltipBehavior: _tooltipBehavior,
                series: <CircularSeries>[
                  RadialBarSeries<BalanceData, String>(
                    dataSource: _chartData,
                    xValueMapper: (BalanceData data, _) => data.type,
                    yValueMapper: (BalanceData data, _) => data.amount,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    enableTooltip: true,
                    maximumValue: totalBalance,
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                "Unexpected Error",
                style: TextStyle(fontSize: 32, wordSpacing: 3),
              ),
            );
          }
        },
      ),
    );
  }

  List<BalanceData> getChartData() {
    final List<BalanceData> chartData = [
      BalanceData('Income', totalIncome),
      BalanceData('Expense', totalExpense),
    ];
    return chartData;
  }
}

class BalanceData {
  BalanceData(this.type, this.amount);

  final String type;
  final double amount;
}
