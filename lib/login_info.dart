import 'dart:ui';
import 'package:covid_app/User.dart';
import 'package:covid_app/quiz_pagee.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LoginInfo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_LoginInfoState();
  }

class _LoginInfoState extends State<LoginInfo>{
  TextEditingController _surname = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _country= TextEditingController();
  TextEditingController _city = TextEditingController();
  DateTime _dateTime;
  bool _isLoading = false;
  final format = DateFormat("yyyy-MM-dd");
  bool islogended = false;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Заполните данные"),
      ),
      body: Stack(
        children: <Widget>[
          _showForm(),
          _showCircularProgress(),
        ],
      ),
    );
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

  Widget _showForm() {
    return new SafeArea(
        child: Container(
            padding: EdgeInsets.all(10.0),
            child: new Form(
              child: new ListView(
                shrinkWrap: true,
                children: <Widget>[
                  //showLogo(),
                  showSurnameInput(),
                  showFirstnameInput(),
                  showCountryInput(),
                  showCityInput(),
                  showDateInput(),
                  stopButton()
                ],
              ),
            )));
  }

  Widget showSurnameInput() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(10.0, 00.0, 0.0, 0.4),
      child: new TextField(
        maxLines: 1,
        keyboardType: TextInputType.name,
        autofocus: true,
        controller: _surname,
        decoration:
        InputDecoration(border: InputBorder.none, hintText: 'Фамилия'),
        showCursor: true,
        autocorrect: false,
      ),
    );
  }

  Widget showFirstnameInput() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(10.0, 00.0, 0.0, 0.4),
      child: new TextField(
        maxLines: 1,
        keyboardType: TextInputType.name,
        autofocus: true,
        controller: _name,
        decoration:
        InputDecoration(border: InputBorder.none, hintText: 'Имя'),
        showCursor: true,
        autocorrect: false,
      ),
    );
  }

  Widget showCountryInput() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(10.0, 00.0, 0.0, 0.4),
      child: new TextField(
        maxLines: 1,
        keyboardType: TextInputType.name,
        autofocus: true,
        controller: _country,
        decoration:
        InputDecoration(border: InputBorder.none, hintText: 'Страна'),
        showCursor: true,
        autocorrect: false,
      ),
    );
  }
  Widget showCityInput() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(10.0, 00.0, 0.0, 0.4),
      child: new TextField(
        maxLines: 1,
        keyboardType: TextInputType.name,
        autofocus: true,
        controller: _city,
        decoration:
        InputDecoration(border: InputBorder.none, hintText: 'Город'),
        showCursor: true,
        autocorrect: false,
      ),
    );
  }

  void shit() {

  }

  Widget showDateInput() {
    return Column(children: <Widget>[
      DateTimeField(
        format: format,
        scrollPadding: EdgeInsets.fromLTRB(20.0, 200.0, 0.0, 0.4),
        decoration: InputDecoration(border: InputBorder.none, hintText: 'Дата рождения'),
        onChanged: (DateTime date) {
          _dateTime = date;
        },
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1940),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2022));
        },
      ),
    ]);
  }

  Widget stopButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QuizPage2(user: new User(surname: _surname.value.text,
            firstname: _name.value.text, date: _dateTime,
            country: _country.value.text, city: _city.value.text)),
        ));
      },
      child: Padding(
          padding:
          EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
          child: SizedBox(
            height: 50.0,
            child: new MaterialButton(
              disabledColor: Colors.blue,
              child: new Text('Далее',
                  style: new TextStyle(fontSize: 18.0, color: Colors.white)),
              onPressed: null,
            ),
          )),
    );
  }

  void finishlog() {
    setState(){islogended = true;}
  }



}

/*class BasicDateField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Дата'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    ]);
  }
}*/