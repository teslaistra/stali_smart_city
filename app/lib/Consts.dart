import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class Consts {
  static final TextStyle titleTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 36, height: 1.4);
  static final TextStyle subtitleText = TextStyle(fontWeight: FontWeight.normal, fontSize: 14);
  static final TextStyle graySubtitleText = TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: grayText);
  static final TextStyle graySubtitle2Text = TextStyle(fontWeight: FontWeight.normal, fontSize: 20, color: grayText);
  static final TextStyle graySubtitle3Text = TextStyle(fontWeight: FontWeight.normal, fontSize: 20, color: grayText);
  static final TextStyle graySubtitle4Text = TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: grayText);
  static final TextStyle grayButtonText = TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: grayText);
  static final TextStyle title2TextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 25);
  static final TextStyle title3TextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
  static final TextStyle buttonText = TextStyle(fontWeight: FontWeight.bold, fontSize: 20,);
  static final TextStyle normalButtonText = TextStyle(fontWeight: FontWeight.normal, fontSize: 20,);

  static final Color blueShadow = Color(0xFFCEEEFF);
  static final Color grayText = Color(0xFF8E92A2);
  static final Color subButtonColor = Color(0xFFDDEFFE);

  static void updateStatusBar(){
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
  }

  static void updateStatusBarDark(){
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
  }
}