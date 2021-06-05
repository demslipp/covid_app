import 'dart:io';
import 'dart:typed_data';

import 'package:covid_app/generate.dart';
import 'package:covid_app/models/restriction.dart';
import 'package:covid_app/scan.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:http/http.dart' as http;

final FirebaseAuth _auth = FirebaseAuth.instance;

class RestrictionsTab extends StatefulWidget {
  @override
  _RestrictionsTabState createState() => _RestrictionsTabState();
}

class _RestrictionsTabState extends State<RestrictionsTab> {
  String _chosenValue = "Британия";
  var imageURL = "";
  var token = "";
  Restriction _restriction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Доступность'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text("Выбор страны:",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12))),
          Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: DropdownButton<String>(
                focusColor: Colors.white,
                value: _chosenValue,
                style: TextStyle(color: Colors.white),
                iconEnabledColor: Colors.black,
                items: <String>[
                  'Британия',
                  'Канада',
                  'Китай',
                  'Египет',
                  'Франция',
                  'Греция',
                  'Япония',
                  'Мексика',
                  'Турция',
                  'США'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                hint: Text(
                  "Пожалуйста, выберете страну",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                onChanged: (String value) {
                  setState(() {
                    _chosenValue = value;
                    updateState();
                  });
                },
              )),
          Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: _restriction != null
                  ? Text("Доступная информация:",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 12))
                  : Container()),
          Padding(
              padding: EdgeInsets.all(16.0),
              child: _restriction != null
                  ? Container(
                      child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                child: Text(
                                    convertFetchedCountryToCountry(
                                        _restriction.name),
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold)),
                                width: 150),
                            Container(
                                child: Center(
                                    child: Text(
                                  restrictionStatusToHint(_restriction.status),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: restrictionStatusToColor(
                                          _restriction.status)),
                                )),
                                width: 200,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: restrictionStatusToColor(
                                            _restriction.status),
                                        spreadRadius: 1),
                                  ],
                                ))
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Divider()),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(child: SvgPicture.asset("assets/to.svg")),
                            Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    convertFetchedCountryToCountry(
                                            _restriction.name) +
                                        ": по прибытии",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    restrictionPossibilityToQuarantine(
                                        _restriction.quarantineIn),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 16)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                child: SvgPicture.asset("assets/back.svg")),
                            Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Россия" + ": по прибытии",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    restrictionPossibilityToQuarantine(
                                        _restriction.quarantineOut),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 16)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                child: SvgPicture.asset("assets/corona.svg")),
                            Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Восприятие российских вакцин",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    child: Text(
                                      restrictionVaccineAcceptanceToHint(
                                          _restriction.vaccineAcceptance),
                                      maxLines: 2,
                                      softWrap: true,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ))
                  : Container())
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getRestrictionInfo();
  }

  void updateState() {
    setState(() {
      getRestrictionInfo();
    });
  }

  void generate() {
    setState(() {
      _auth.currentUser.getIdToken(false).then((value) => token = value);
      imageURL = "https://covid-app-back.herokuapp.com/api/qr/generate";
    });
  }

  Future<void> getRestrictionInfo() async {
    String country = convertCountryToFetch();
    final http.Response response = await http.get(
        Uri.https(
            "covid-app-back.herokuapp.com", "/api/country/$country/status"),
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print(response.statusCode);
      print(response.body);

      final _json = json.decode(response.body);
      setState(() {
        _restriction = Restriction.fromJson(_json);
      });
    } else {
      // If the server did no
      //t return a 201 CREATED response,
      // then throw an exception
      print(response.statusCode);
      print(response.body);
      throw Exception('Failed to get restriction data');
    }
  }

  String convertCountryToFetch() {
    switch (_chosenValue) {
      case 'Британия':
        return 'Britain';
      case 'Канада':
        return 'Canada';
      case 'Китай':
        return 'China';
      case 'Египет':
        return 'Egypt';
      case 'Франция':
        return 'France';
      case 'Греция':
        return 'Greece';
      case 'Япония':
        return 'Japan';
      case 'Мексика':
        return 'Mexico';
      case 'Турция':
        return 'Turkey';
      case 'США':
        return 'USA';
      default:
        return 'Britain';
    }
  }

  String convertFetchedCountryToCountry(String country) {
    switch (country) {
      case 'Britain':
        return 'Британия';
      case 'Canada':
        return 'Канада';
      case 'China':
        return 'Китай';
      case 'Egypt':
        return 'Египет';
      case 'France':
        return 'Франция';
      case 'Greece':
        return 'Греция';
      case 'Japan':
        return 'Япония';
      case 'Mexico':
        return 'Мексика';
      case 'Turkey':
        return 'Турция';
      case 'USA':
        return 'США';
      default:
        return 'Британия';
    }
  }

  String restrictionStatusToHint(Status status) {
    switch (status) {
      case Status.HIGH:
        return "Максимальные ограничения";
      case Status.MIDDLE:
        return "Средние ограничения";
      default:
        return "Минимальные ограничения";
    }
  }

  String restrictionPossibilityToQuarantine(Possibility possibility) {
    switch (possibility) {
      case Possibility.YES:
        return "Требуется карантин";
      case Possibility.MAYBE:
        return "Может потребоваться карантин";
      default:
        return "Карантина нет";
    }
  }

  String restrictionVaccineAcceptanceToHint(bool vaccineAcceptance) {
    switch (vaccineAcceptance) {
      case true:
        return "Российские вакцины принимаются";
      default:
        return "Российские вакцины не принимаются, необходим ПЦР тест";
    }
  }

  Color restrictionStatusToColor(Status status) {
    switch (status) {
      case Status.HIGH:
        return Colors.red;
      case Status.MIDDLE:
        return Colors.orange;
      default:
        return Colors.green;
    }
  }
}
