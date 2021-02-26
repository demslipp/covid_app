/*
 * QR.Flutter
 * Copyright (c) 2019 the QR.Flutter authors.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:covid_app/Constructor_page.dart';

void main() => runApp(ExampleApp());

/// The example application class
class ExampleApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'QR.Flutter',
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: ExampleApp(),
    );
  }
}