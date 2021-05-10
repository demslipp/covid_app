import 'dart:ui';
import 'package:covid_app/User.dart';
import 'package:covid_app/home_screen.dart';
import 'package:covid_app/tabs.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';



class QuizPage2 extends StatefulWidget {

  QuizPage2({
    this.user,
  });

  User user;

  @override
  _QuizPage2State createState() => _QuizPage2State();
}

enum Question_1 {yes, no}
enum Question_2 {yes, no}
enum Question_3 {yes, no}
enum Question_4 {yes, no}

class _QuizPage2State extends State<QuizPage2> {
  Question_1 _question_1 = Question_1.yes;
  Question_2 _question_2 = Question_2.yes;
  Question_3 _question_3 = Question_3.yes;
  Question_4 _question_4 = Question_4.yes;

  bool isQuizEnded = false;
  bool isQuizSuccess = true;

  @override
  Widget build(BuildContext context) {
    int flag = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz"),
      ),
      body: Stack (
        children: [
          SafeArea (
              child: Stack(
                children: <Widget> [ListView(
                  children: <Widget>[
                    ListTile(
                      title: Text('Были ли Вы за границей в течение последних 14 дней?',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    RadioListTile<Question_1>(
                      title: const Text('Да'),
                      value: Question_1.yes,
                      groupValue: _question_1,
                      onChanged:(Question_1 value) { setState(() { _question_1 = value; });
                      if (value!=null) {flag=flag+2;}
                      print(EnumToString.convertToString(_question_1));
                      },
                    ),
                    RadioListTile<Question_1>(
                      title: const Text('нет'),
                      value: Question_1.no,
                      groupValue: _question_1,
                      onChanged: (Question_1 value) { setState(() { _question_1 = value; });
                      print(EnumToString.convertToString(_question_1));
                      },
                    ),
                    ListTile(
                      title: Text('Контактировали с больными коронавирусом?',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    RadioListTile<Question_2>(
                      title: const Text('Да'),
                      value: Question_2.yes,
                      groupValue: _question_2,
                      onChanged: (Question_2 value) { setState(() { _question_2 = value; });
                      if (value!=null) {flag=flag+3;}
                      print(EnumToString.convertToString(_question_2));
                      },
                    ),
                    RadioListTile<Question_2>(
                      title: const Text('нет'),
                      value: Question_2.no,
                      groupValue: _question_2,
                      onChanged: (Question_2 value) { setState(() { _question_2 = value; });
                      print(EnumToString.convertToString(_question_2));
                      },
                    ),
                    ListTile(
                      title: Text('Повышена ли температура?',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    RadioListTile<Question_3>(
                      title: const Text('Да'),
                      value: Question_3.yes,
                      groupValue: _question_3,
                      onChanged: (Question_3 value) { setState(() { _question_3 = value; });
                      if (value!=null) {flag=flag+1;}
                      print(flag);
                      print(EnumToString.convertToString(_question_3));
                      },
                    ),
                    RadioListTile<Question_3>(
                      title: const Text('нет'),
                      value: Question_3.no,
                      groupValue: _question_3,
                      onChanged: (Question_3 value) { setState(() { _question_3 = value; });
                      print(EnumToString.convertToString(_question_3));
                      },
                    ),
                    ListTile(
                      title: Text('Имеются ли у Вас другие симптомы (кашель, боль в горле)?',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    RadioListTile<Question_4>(
                      title: const Text('Да'),
                      value: Question_4.yes,
                      groupValue: _question_4,
                      onChanged: (Question_4 value) { setState(() { _question_4 = value; });
                      if (value!=null) {flag=flag+4;};
                      print(flag);
                      print(EnumToString.convertToString(_question_4));
                      },
                    ),
                    RadioListTile<Question_4>(
                      title: const Text('нет'),
                      value: Question_4.no,
                      groupValue: _question_4,
                      onChanged: (Question_4 value) { setState(() { _question_4 = value; });
                      print(EnumToString.convertToString(_question_4));
                      },
                    ),
                    MaterialButton(
                        child: new Text(
                            'Готово',
                            style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
                        onPressed: () {finishQuiz();})
                  ],
                ),
                ],
              )
          ),
    isQuizEnded ?
    Opacity(opacity: 1,
    child: Container(
      color: Colors.black38,
    child: Center(
      child: Container(
          margin: new EdgeInsets.symmetric(horizontal: 40.0),
          color: Colors.white,
          height: 180,
          width: double.infinity,
          child:
          Column (
              mainAxisAlignment: MainAxisAlignment.center,
    children: [isQuizSuccess ? Text(
    "Красный", textAlign: TextAlign.center, style: new TextStyle(fontSize: 30.0)
    ) : Text(
    "Зеленый",
    textAlign: TextAlign.center,style: new TextStyle(fontSize: 30.0)
    ),
    GestureDetector(
    onTap: () {
    Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => TabPage(user: widget.user)),
    (Route<dynamic> route) => false
    );
    },
    child: Padding(
    padding:
    EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
    child: SizedBox(
    height: 50.0,
    child: new MaterialButton(
    disabledColor: Colors.blue,
    child: new Text(
        'Home screen',
        style: new TextStyle(fontSize: 24.0, color: Colors.white)),
    onPressed: null,
    ),
    )),
    )])),
    ),
    ) ): Container()
        ],
      )
    );
  }

  void finishQuiz() {
    setState(() {
      isQuizEnded = true;
      if (
        _question_4 == Question_4.no || _question_3 == Question_3.no || _question_2 == Question_2.no || _question_1 ==Question_1.no
      ) {
        isQuizSuccess = false;
      }
    });
  }
}
