import 'dart:io';
import 'dart:typed_data';

import 'package:covid_app/generate.dart';
import 'package:covid_app/scan.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/rendering.dart';

import 'package:http/http.dart' as http;

final FirebaseAuth _auth = FirebaseAuth.instance;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var imageURL = "";
  var token = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR коды'),
        actions: [
          MaterialButton(
              onPressed: upload,
              child: Icon(Icons.upload_outlined, color: Colors.white))
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: imageURL != ""
                  ? Image.network(imageURL,
                      height: 300,
                      headers: {'Authorization': 'Bearer ' + token})
                  : Container()),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                splashColor: Colors.blueGrey,
                onPressed: () {
                  generate();
                },
                child: const Text('Генерировать QR код')),
          ),
        ],
      )),
    );
  }

  Future<bool> uploadSheet(Uint8List fileBytes) async {}

  void generate() {
    setState(() {
      _auth.currentUser.getIdToken(false).then((value) => token = value);
      imageURL = "https://covid-app-back.herokuapp.com/api/qr/generate";
    });
  }

  Future<void> upload() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    ;

    if (result != null) {
      File file = File(result.files.single.path);
      Uint8List fileBytes = file.readAsBytesSync();
      print(fileBytes.length);

      // Upload file
      final auth = await _auth.currentUser.getIdToken(false);
      token = auth;

      final http.Response response = await http.post(
        Uri.https("covid-app-back.herokuapp.com", "/api/sheets"),
        headers: <String, String>{
          'Authorization': 'Bearer ' + auth,
          'Content-Type': 'application/pdf'
        },
        body: fileBytes,
      );
      if (response.statusCode == 200) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        print(response.statusCode);
        print(response.body);
        return true;
      } else {
        // If the server did no
        //t return a 201 CREATED response,
        // then throw an exception
        print(response.statusCode);
        print(response.body);
        throw Exception('Failed to upload');
      }
    }
  }
}
