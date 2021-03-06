import 'dart:ui';

import 'package:covid_app/local_user.dart';
import 'package:covid_app/login_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum _DoubleConstants {
  textFieldContainerHeight,
  textFieldContainerWidth,
  textFieldDecorationBorderWidth
}

final FirebaseAuth _auth = FirebaseAuth.instance;

extension _DoubleConstantsExtension on _DoubleConstants {
  double get value {
    switch (this) {
      case _DoubleConstants.textFieldContainerHeight:
        return 50.0;
      case _DoubleConstants.textFieldContainerWidth:
        return 80.0;
      case _DoubleConstants.textFieldDecorationBorderWidth:
        return 0.6;
      default:
        return null;
    }
  }
}

class LoginSignUpPage extends StatefulWidget {
  LoginSignUpPage({this.loginCallback});

  final Function(LocalUser) loginCallback;

  @override
  State<StatefulWidget> createState() => _LoginSignUpPageState();
}

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  final _formKey = new GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  String _errorMessage;

  bool _isLoginForm;
  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      String userId = "";
      try {
        if (_isLoginForm) {
          final User user = (await _auth.signInWithEmailAndPassword(
            email: _email.value.text,
            password: _password.value.text,
          ))
              .user;
          userId = await user.getIdToken();
          print('Signed in: $userId');

          widget.loginCallback(LocalUser.randomLocalUser());

          setState(() {
            _isLoading = false;
          });
        } else {
          await _auth
              .createUserWithEmailAndPassword(
            email: _email.value.text,
            password: _password.value.text,
          )
              .then((user) {
            //If a user is successfully created with an appropriate email
            if (user.user != null) {
              user.user.sendEmailVerification();
            }
          });
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoginInfo(signUpCallback: signUp)),
          );
          //widget.auth.sendEmailVerification();
          //_showVerifyEmailSentDialog();
        }
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.toString();
          _formKey.currentState.reset();
        });
      }
    }
  }

  void signUp(LocalUser localUser) {
    print("Sign up success");
    print(localUser.firstname);
    widget.loginCallback(localUser);
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
    print("Login switch to" + _isLoginForm.toString());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("???????????????? ??????????????????????"),
      ),
      body: Stack(
        children: <Widget>[
          _showForm(),
          _showCircularProgress(),
        ],
      ),
    );
  }

  Widget _showForm() {
    return new SafeArea(
        child: Container(
            padding: EdgeInsets.all(10.0),
            child: new Form(
              key: _formKey,
              child: new ListView(
                shrinkWrap: true,
                children: <Widget>[
                  //showLogo(),
                  showMainHint(),
                  showEmailInput(),
                  showPasswordInput(),
                  showPrimaryButton(),
                  showSecondaryButton(),
                  showErrorMessage(),
                ],
              ),
            )));
  }

  Widget showMainHint() {
    return new Container(
      height: 140,
      width: 200,
      child: Center(
        child: Text(
          _isLoginForm ? "?????????????? ????????????????????????" : "??????????????????????",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget showEmailInput() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 20, 0.0, 0.4),
      child: new TextField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: true,
        controller: _email,
        maxLength: 30,
        decoration:
            InputDecoration(border: InputBorder.none, hintText: 'Email'),
        showCursor: true,
        autocorrect: false,
      ),
    );
  }

  Widget showPasswordInput() {
    return new Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: new TextField(
        maxLines: 1,
        obscureText: true,
        autofocus: true,
        autocorrect: false,
        keyboardType: TextInputType.visiblePassword,
        controller: _password,
        decoration:
            InputDecoration(border: InputBorder.none, hintText: '????????????'),
      ),
    );
  }

  Widget showPrimaryButton() {
    return GestureDetector(
      onTap: () {
        validateAndSubmit();
      },
      child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 40, 0.0, 0.0),
          child: SizedBox(
            height: 50.0,
            child: new MaterialButton(
              disabledColor: Colors.red,
              child: new Text(_isLoginForm ? '??????????' : '?????????????? ??????????????',
                  style: new TextStyle(fontSize: 18.0, color: Colors.white)),
              onPressed: null,
            ),
          )),
    );
  }

  Widget showSecondaryButton() {
    return Padding(
        padding: EdgeInsets.only(top: 10),
        child: MaterialButton(
            child: new Text(
                _isLoginForm ? 'C???????????? ??????????????' : '?????? ???????? ??????????????? ??????????????',
                style:
                    new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
            onPressed: toggleFormMode));
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new AlertDialog(
          content: Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.blue,
            height: 1.0,
            fontWeight: FontWeight.bold),
      ));
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Opacity(
          opacity: 0.3,
          child: Container(
              color: Colors.blueGrey,
              child: Center(child: CircularProgressIndicator())));
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }
}
