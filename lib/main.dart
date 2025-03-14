import 'package:flutter/material.dart';
import 'package:tarvel_mate/pages/design_tm.dart';
import 'package:tarvel_mate/pages/home.dart';
import 'package:tarvel_mate/pages/login.dart';
import 'package:tarvel_mate/pages/map.dart';
import 'package:tarvel_mate/pages/profile.dart';
import 'package:tarvel_mate/pages/signup.dart';
import 'package:tarvel_mate/pages/test.dart';
import 'package:tarvel_mate/pages/time_schedule.dart';
import 'package:tarvel_mate/pages/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/welcome',
      routes: {
        '/home': (context) => Home(),
        '/login': (context) => Login(),
        '/signup': (context) => Signup(),
        '/map': (context) => MapLoca(),
        '/nav': (context) => NavBottom(),
        '/welcome': (context) => Welcome(),
        '/timeschedule': (context) => TimeSchedule(),
        '/t': (context) => TransportApp(),
        '/stuprofile': (context) => StuProfile(),
      },
    );
  }
}
