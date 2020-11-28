import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackathon/ColorGenerator.dart';

import 'Consts.dart';
import 'Pages/ComplaintPage.dart';
import 'Pages/InitiativePage.dart';
import 'Pages/LoginPage.dart';
import 'Pages/MainPage.dart';
import 'Pages/VotePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Consts.updateStatusBar();

    return MaterialApp(
      title: 'IQ',
      theme: ThemeData(

        fontFamily: "NotoSans",

        primarySwatch: ColorGenerator.generateMaterialColor(Color(0xFF0075CD)),
        primaryColor: ColorGenerator.generateMaterialColor(Color(0xFF0075CD)),
        brightness: Brightness.light,


        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/FirstPage",
      routes: {
        "/FirstPage":(BuildContext context) => LoginPage(),
        "/MainPage":(BuildContext context) => MainPage(),
        "/ComplaintPage":(BuildContext context) => ComplaintPage(),
        "/VotePage":(BuildContext context) => VotePage(),
        "/InitiativePage":(BuildContext context) => InitiativePage(),
      },
    );
  }
}
