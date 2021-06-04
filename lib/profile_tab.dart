import 'dart:ui';

import 'package:covid_app/local_user.dart';
import 'package:covid_app/models/temperatur.dart';
import 'package:covid_app/quiz_page.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseDatabase _database = FirebaseDatabase.instance;

class ProfileTab extends StatefulWidget {
  ProfileTab({this.logoutCallback});

  VoidCallback logoutCallback;

  @override
  State<StatefulWidget> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  TextEditingController _surname = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _country = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _temperature = TextEditingController();
  DateTime _dateTime;
  bool _isLoading = false;
  bool _isEditable = false;

  final format = DateFormat("dd-MM-yyyy");
  bool islogended = false;
  LocalUser _user;

  @override
  void initState() {
    super.initState();
  }

  void updateState() {
    _surname.text = _user.surname;
    _name.text = _user.firstname;
    _city.text = _user.city;
    _country.text = _user.country;
    _dateTime = _user.date;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Профиль'),
        actions: [
          // GestureDetector(
          //     child: Icon(Icons.logout),
          //     onTap: () => logout())
          MaterialButton(
              onPressed: logout, child: Icon(Icons.logout, color: Colors.white))
        ],
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
    child:
    return FutureBuilder(
        future: _localUser(),
        builder: (ctx, snapshot) {
          final size = 280.0;
          if (!snapshot.hasData) {
            return Container(width: size, height: size);
          }
          _user = snapshot.data;
          updateState();
          return Container(
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
                    showTemperatureInput(),
                    showTemperaturesList()
                  ],
                ),
              ));
        });
  }

  Widget showSurnameInput() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(10.0, 00.0, 0.0, 0.4),
      child: new TextField(
        maxLines: 1,
        keyboardType: TextInputType.name,
        autofocus: true,
        enabled: _isEditable,
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
        enabled: _isEditable,
        decoration: InputDecoration(border: InputBorder.none, hintText: 'Имя'),
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
        enabled: _isEditable,
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
        enabled: _isEditable,
        autofocus: true,
        controller: _city,
        decoration:
            InputDecoration(border: InputBorder.none, hintText: 'Город'),
        showCursor: true,
        autocorrect: false,
      ),
    );
  }

  Widget showDateInput() {
    return Column(children: <Widget>[
      DateTimeField(
        format: format,
        scrollPadding: EdgeInsets.fromLTRB(20.0, 200.0, 0.0, 0.4),
        decoration: InputDecoration(
            border: InputBorder.none, hintText: 'Дата рождения'),
        initialValue: _dateTime,
        enabled: _isEditable,
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
            MaterialPageRoute(
              builder: (context) => QuizPage2(
                  user: new LocalUser(
                      surname: _surname.value.text,
                      firstname: _name.value.text,
                      date: _dateTime,
                      country: _country.value.text,
                      city: _city.value.text)),
            ));
      },
      child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
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

  Widget showTemperatureInput() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(10.0, 00.0, 0.0, 0.4),
        child: new Column(
          children: [
            TextField(
              maxLines: 1,
              keyboardType: TextInputType.number,
              enabled: true,
              autofocus: true,
              controller: _temperature,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Температура'),
              showCursor: true,
              autocorrect: false,
            ),
            MaterialButton(
                onPressed: _addTemperature,
                child: Icon(Icons.plus_one, color: Colors.black))
          ],
        ));
  }

  Widget showTemperaturesList() {
    child:
    return FutureBuilder(
        future: _temperatureList(),
        builder: (ctx, snapshot) {
          if (snapshot.data == null) {
            return Container();
          }
          print(snapshot.data.length);

          List<Widget> temperatueList = [];
          for (Temperature temperature in snapshot.data) {
            temperatueList.add(ListTile(title: Text(temperature.value)));
          }
          return Column(
            children: temperatueList,
          );
          // return ListView.builder(
          //   itemCount: snapshot.data.length,
          //   itemBuilder: (context, index) =>
          //       ListTile(title: Text(snapshot.data[index].value)),
          // );
        });
  }

  void logout() {
    widget.logoutCallback();
  }

  Future<void> info() async {
    var token = await _auth.currentUser.getIdToken(false);
    print("Bearer " + token);
  }

  void _addTemperature() {
    var id = _auth.currentUser.uid;
    _database
        .reference()
        .child('temperatures')
        .child(id)
        .push()
        .set(<String, String>{
      "value": _temperature.text,
      "date": DateTime.now().toIso8601String()
    }).then((value) {
      setState(() {});
    });
  }

  Future<List<Temperature>> _temperatureList() async {
    return await _database
        .reference()
        .child('temperatures')
        .child(_auth.currentUser.uid)
        .once()
        .then((DataSnapshot snapshot) {
      List<Temperature> _temperatureList = [];
      snapshot.value.forEach((_, value) {
        print(value['value']);
        _temperatureList.add(Temperature(
            value: value['value'], date: DateTime.parse(value['date'])));
      });

      return _temperatureList;
    });
  }

  Future<LocalUser> _localUser() async {
    return await _database
        .reference()
        .child('users')
        .child(_auth.currentUser.uid)
        .once()
        .then((DataSnapshot snapshot) {
      print(snapshot.value);
      print(snapshot.value['surname']);
      print(snapshot.value['firstname']);
      print(snapshot.value['country']);
      print(snapshot.value['city']);
      print(snapshot.value['date']);

      return LocalUser(
          firstname: snapshot.value['firstname'],
          surname: snapshot.value['surname'],
          date: DateTime.parse(snapshot.value['date']),
          country: snapshot.value['country'],
          city: snapshot.value['city']);
    });
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
