import 'package:covid_app/local_user.dart';
import 'package:covid_app/login_signup_page.dart';
import 'package:covid_app/tabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}


final FirebaseAuth _auth = FirebaseAuth.instance;


class RootPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  LocalUser localUser;

  @override
  void initState()  {
    super.initState();
    final user = _auth.currentUser;
    if (user!=null)
      setState(() {
        authStatus = user.uid.isEmpty
            ? AuthStatus.NOT_LOGGED_IN
            : AuthStatus.LOGGED_IN;
      });
    else
      setState(() {
        authStatus = AuthStatus.NOT_LOGGED_IN;
      });
  }

  void loginCallback(LocalUser localUser) {
    setState(() {
      this.localUser = localUser;
      this.authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void logoutCallback() {
    setState(() {
      _auth.signOut();
      authStatus = AuthStatus.NOT_LOGGED_IN;
    });
  }


  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return new LoginSignUpPage(
          loginCallback: loginCallback,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_auth.currentUser != null && _auth.currentUser.uid.isNotEmpty) {
          return new TabPage(user: localUser, logoutCallback: logoutCallback);
        } else
          return buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
    }
  }
}