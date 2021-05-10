import 'package:covid_app/login_signup_page.dart';
import 'package:flutter/material.dart';

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
