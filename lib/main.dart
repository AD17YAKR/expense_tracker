// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, unused_import, unnecessary_import

import 'package:expense_tracker/screens/splash.dart';
import 'package:expense_tracker/utils/theme.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('money');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: light,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
