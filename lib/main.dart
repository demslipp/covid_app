import 'package:covid_app/news/news_homepage.dart';
import 'package:covid_app/login_signup_page.dart';
import 'package:covid_app/quiz_page.dart';
import 'package:flutter/material.dart';
import 'package:covid_app/home_screen.dart';

import 'login_info.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid_app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginSignUpPage(),
    );
  }
}